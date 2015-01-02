
#define BUFF_SIZE 4 	//size of Buffer
#define MEM_SIZE 4	//size of memory
#define flag0 1
#define flag1 2
#define turn 3
#include "x86_tso_buffer.pml"


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};




inline p0() 
{
byte locf1, lturn, v6;

entry:
  write(flag0, 1);
  write(turn,1);
  mfence();
  
whilecond:   
  read(flag1, locf1);
  if :: locf1 == 1 -> goto  landrhs;
     :: else -> v6 = false; goto landend;
  fi;

landrhs:           
  read(turn, lturn);
  v6 = (lturn == 1);

landend:           
  if :: v6 -> goto  whilecond;
     :: else -> goto crit0;
  fi;
  
crit0: skip;

whileend:        
  write(flag0, 0);
}


inline p0_sb()
{
byte locf1, lturn, v6;
L0: skip;
L1: if 	:: true -> memory[flag0] = 1; goto L2;
		:: true -> goto L3;
	fi;
L2: goto L4;
L3: memory[flag0] = 1;
L4: memory[turn] = 1;
L5: skip;
L6: locf1 = memory[flag1];
L7: if	:: locf1 == 1 -> goto L8;
		:: else -> goto L10;
	fi;
L8: lturn = memory[turn];
L9: v6 = (lturn == 1); goto L11;
L10: v6 = false; 
L11: if	:: v6 -> goto L6;
		:: else goto crit0;
	fi;
crit0: skip;
L12: memory[flag0] = 0;
}

inline p0_sb_unfenced()
{
byte locf1, lturn, v6;
L0: skip;
L1: if 	:: true -> memory[flag0] = 1; goto L2;
		:: true -> goto L3;
	fi;
L2: goto L4;
L3: if 	:: true -> memory[flag0] = 1; goto L4;
		:: true -> read(flag1, locf1); goto L19;
	fi;
L4: if  :: true -> memory[turn] = 1; goto L6;
		:: true -> read(flag1, locf1); goto L13;
	fi;
L6: locf1 = memory[flag1];
L7: if	:: locf1 == 1 -> goto L8;
		:: else -> goto L10;
	fi;
L8: lturn = memory[turn];
L9: v6 = (lturn == 1); goto L11;
L10: v6 = false; 
L11: if	:: v6 -> goto L6;
		:: else goto crit01;
	fi;
crit01: skip;
L12: memory[flag0] = 0;  goto end;
//----------------
L13: if	:: true -> memory[turn] = 1; goto L7;
		:: locf1 == 1 -> goto L14;
		:: locf1 != 1 -> goto L15;
	fi;
L14: if	:: true -> lturn = 1; goto L16;
		:: true -> memory[turn] = 1; goto L8;
	fi;
L15: if	:: true -> v6 = false; goto L17;
		:: true -> memory[turn] = 1; goto L10;
	fi;
L16: if	:: true -> v6 = (lturn == 1); goto L17;
		:: true -> memory[turn] = 1;  goto L9;
	fi;
L17: if	:: v6 -> goto L4;
		:: !v6 -> goto crit02;
		:: true -> memory[turn] = 1; goto L11;
	fi;
crit02: if :: true -> goto L18;
		   :: true -> memory[turn] = 1; goto crit01;
		fi;
L18: memory[turn] = 1; goto L12;
//---------------------------------------
L19: if	:: true -> memory[flag0] = 1; goto L13;
		:: locf1 == 1 -> goto L20;
		:: locf1 != 1 -> goto L21;
	fi;
L20: if	:: true -> lturn = 1; goto L22;
		:: true -> memory[flag0] = 1; goto L14;
	fi;
L21: if	:: true -> v6 = false; goto L23;
		:: true -> memory[flag0] = 1; goto L15;
	fi;
L22: if	:: true -> v6 = (lturn == 1); goto L23;
		:: true -> memory[flag0] = 1;  goto L16;
	fi;
L23: if	:: v6 -> goto L3;
		:: !v6 -> goto crit03;
		:: true -> memory[flag0] = 1; goto L17;
	fi;
crit03: if :: true -> goto L24;
		   :: true -> memory[flag0] = 1; goto crit02;
		fi;
L24: memory[flag0] = 1; goto L18;
end: skip;
}


inline p1_sb_unfenced()
{
byte locf0, lturn, v6;
L0: skip;
L1: if 	:: true -> memory[flag1] = 1; goto L2;
		:: true -> goto L3;
	fi;
L2: goto L4;
L3: if 	:: true -> memory[flag1] = 1; goto L4;
		:: true -> read(flag0, locf0); goto L19;
	fi;
L4: if  :: true -> memory[turn] = 0; goto L6;
		:: true -> read(flag0, locf0); goto L13;
	fi;
L6: locf0 = memory[flag0];
L7: if	:: locf0 == 1 -> goto L8;
		:: else -> goto L10;
	fi;
L8: lturn = memory[turn];
L9: v6 = (lturn == 0); goto L11;
L10: v6 = false; 
L11: if	:: v6 -> goto L6;
		:: else goto crit11;
	fi;
crit11: skip;
L12: memory[flag1] = 0; goto end;
//----------------
L13: if	:: true -> memory[turn] = 0; goto L7;
		:: locf0 == 1 -> goto L14;
		:: locf0 != 1 -> goto L15;
	fi;
L14: if	:: true -> lturn = 0; goto L16;
		:: true -> memory[turn] = 0; goto L8;
	fi;
L15: if	:: true -> v6 = false; goto L17;
		:: true -> memory[turn] = 0; goto L10;
	fi;
L16: if	:: true -> v6 = (lturn == 0); goto L17;
		:: true -> memory[turn] = 0;  goto L9;
	fi;
L17: if	:: v6 -> goto L4;
		:: !v6 -> goto crit12;
		:: true -> memory[turn] = 0; goto L11;
	fi;
crit12: if :: true -> goto L18;
		   :: true -> memory[turn] = 0; goto crit11;
		fi;
L18: memory[turn] = 0; goto L12;
//---------------------------------------
L19: if	:: true -> memory[flag1] = 1; goto L13;
		:: locf0 == 1 -> goto L20;
		:: locf0 != 1 -> goto L21;
	fi;
L20: if	:: true -> lturn = 0; goto L22;
		:: true -> memory[flag1] = 1; goto L14;
	fi;
L21: if	:: true -> v6 = false; goto L23;
		:: true -> memory[flag1] = 1; goto L15;
	fi;
L22: if	:: true -> v6 = (lturn == 1); goto L23;
		:: true -> memory[flag1] = 1;  goto L16;
	fi;
L23: if	:: v6 -> goto L3;
		:: !v6 -> goto crit13;
		:: true -> memory[flag1] = 1; goto L17;
	fi;
crit13: if :: true -> goto L24;
		   :: true -> memory[flag1] = 1; goto crit12;
		fi;
L24: memory[flag1] = 1; goto L18;
end: skip;
}



inline p1_sb()
{
byte locf0, lturn, v6;
L0: skip;
L1: if 	:: true -> memory[flag1] = 1; goto L2;
		:: true -> goto L3;
	fi;
L2: goto L4;
L3: memory[flag1] = 1;
L4: memory[turn] = 0;
L5: skip;
L6: locf0 = memory[flag0];
L7: if	:: locf0 == 1 -> goto L8;
		:: else -> goto L10;
	fi;
L8: lturn = memory[turn];
L9: v6 = (lturn == 0); goto L11;
L10: v6 = false; 
L11: if	:: v6 -> goto L6;
		:: else goto crit1;
	fi;
crit1: skip;
L12: memory[flag1] = 0;
}




inline p1() 
{
byte locf0, lturn, v6;

entry:
  write(flag1, 1);
  write(turn,0);
  mfence();
  
whilecond:   
  read(flag0, locf0);
  if :: locf0 == 1 -> goto  landrhs;
     :: else -> v6 = false; goto landend;
  fi;

landrhs:           
  read(turn, lturn);
  v6 = (lturn == 0);

landend:           
  if :: v6 -> goto  whilecond;
     :: else -> goto crit1;
  fi;
  
crit1: skip;

whileend:        
  write(flag1, 0);
}


//----------------------------------------------------------------------

proctype process1(chan ch){
	//p0();
	//p0_sb();
	p0_sb_unfenced();
}

proctype process2(chan ch){
	//p1();
	//p1_sb();
	p1_sb_unfenced();
}


init 
{
atomic{
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
	//((process1@crit0) && (process2@crit1))
}

//ltl prop{ [] !((process1@crit0) && (process2@crit1))}
ltl prop{ [] !((process1@crit01||process1@crit02||process1@crit03) && (process2@crit11||process2@crit12||process2@crit13))}



#define BUFF_SIZE 4 	//size of Buffer
#define MEM_SIZE 4	//size of memory
#define flag0 1
#define flag1 2
#include "x86_tso_buffer.pml"


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};




inline p0() 
{
byte lflag1;

L1:
  write(flag0, 1);
  mfence();
  
whilecond:   
  read(flag1, lflag1);
  if :: lflag1 > 2 -> goto  whilecond;
     :: else -> goto whileend; 
  fi;

whileend:
  write(flag0,3);
  mfence();
  read(flag1, lflag1);
  if:: lflag1 == 1 -> goto ifthen;
    :: else -> goto ifend;
  fi;

ifthen:                  
  write(flag0, 2);
  goto whilecond2;
  
whilecond2:
  read(flag1,lflag1);
  if :: lflag1 != 4 -> goto whilecond2;
     :: else -> goto ifend;
  fi;
  
ifend: 
  write(flag0,4);
  goto crit;


crit: skip; 
	  goto whilecond6;


whilecond6: 
  read(flag1, lflag1);
  if :: (lflag1 == 2 || lflag1 == 3) -> goto whilecond6;
     :: else -> goto whileend10;
  fi;
  
whileend10:
  write(flag0, 0);
  //  goto L1;
}


inline p1() 
{
byte lflag0;

L1:
  write(flag1, 1);
  //mfence();
  
whilecond:   
  read(flag0, lflag0);
  if :: lflag0 > 2 -> goto  whilecond;
     :: else -> goto whileend; 
  fi;

whileend:
  write(flag1,3);
  mfence();
  read(flag0, lflag0);
  if:: lflag0 == 1 -> goto ifthen;
    :: else -> goto ifend;
  fi;

ifthen:                  
  write(flag1, 2);
  goto whilecond2;
  
whilecond2:
  read(flag0,lflag0);
  if :: lflag0 != 4 -> goto whilecond2;
     :: else -> goto ifend;
  fi;
  
ifend: 
  write(flag1,4);
  goto whilecond6;

whilecond6: 
  read(flag0, lflag0);
  if :: lflag0 > 1 -> goto whilecond6;
     :: else -> goto crit;
  fi;




crit: skip;
  
whileend9:
  write(flag1, 0);
//  goto L1;
}

inline p0_sb(){
byte lflag1;

L0: skip;
L1: memory[flag0] = 1;
L2: skip;
L3: lflag1 = memory[flag1];
L4: if :: lflag1 > 2 -> goto L3;
     :: else -> goto L5;
  fi;
L5: skip;
L6: memory[flag0] = 3;
L7: skip;
L8: lflag1 = memory[flag1];
L9:	if 	:: lflag1 == 1 -> goto L10;
     	:: else -> goto L13;
  fi;
L10: goto L14;
L11: lflag1 = memory[flag1]; 
L12: if :: lflag1 != 4 -> goto L11;
     :: else -> goto L13;
  fi;
L13: goto L17;
L14: if :: true -> lflag1 = memory[flag1]; goto L15;
     	:: true -> memory[flag0] = 2; goto L11;
  	fi;
L15:  if :: lflag1 != 4 -> goto L14;
     	 :: true -> memory[flag0] = 2; goto L12;
     	 :: lflag1 == 4 -> goto L16;
  	fi;
L16: if :: true -> goto L26;
     	:: true -> memory[flag0] = 2; goto L13;
  	fi;
L17: if :: true -> lflag1 = memory[flag1]; goto L23;
     	:: true -> memory[flag0] = 4; goto L18;
  	fi; 
L18: lflag1 = memory[flag1];
L19: if :: (lflag1 == 2 || lflag1 == 3) -> goto L18;
     	:: else -> goto L20;
  fi;
L20: skip;
L21: memory[flag0] = 0;
L22: goto end;
L23: if :: (lflag1 == 2 || lflag1 == 3) -> goto L17
     	 :: true -> memory[flag0] = 4; goto L19;
     	 :: (lflag1 != 2 && lflag1 != 3) -> goto L24;
  	fi;
L24: if :: true -> memory[flag0] = 4; goto L20;
     	:: true -> goto L25;
  fi;
L25: memory[flag0] = 4; goto L21;
L26: if :: true -> lflag1 = memory[flag1]; goto L27;
     	:: true -> memory[flag0] = 2; goto L17;
  	fi; 
L27: if :: (lflag1 == 2 || lflag1 == 3) -> goto L26
     	 :: true -> memory[flag0] = 2; goto L23;
     	 :: (lflag1 != 2 && lflag1 != 3) -> goto L28;
  	fi;
L28: if :: true -> memory[flag0] = 2; goto L24;
     	:: true -> goto L29;
  fi;
L29: memory[flag0] = 2; goto L25;  

end: skip;
}



inline p1_sb(){
byte lflag0;

L0: skip;
L1: if :: true -> memory[flag1] = 1; goto L2;
	:: true -> lflag0 = memory[flag0]; goto L6;
	fi;
L2: lflag0 = memory[flag0];
L3: if :: lflag0 > 2 -> goto L2;
     :: else -> goto L4;
  fi;
L4: skip;
L5: memory[flag1] = 3;  goto L9;
L6: if 	 :: lflag0 > 2 -> goto L1
     	 :: true -> memory[flag1] = 1; goto L3;
     	 :: lflag0 <= 2 -> goto L7;
  	fi;
L7: if  :: true -> memory[flag1] = 1; goto L4;
		:: true -> goto L8;
	fi; 
L8: memory[flag1] = 1; goto L5;
L9: skip;
L10: lflag0 = memory[flag0];
L11: if  :: lflag0 == 1 -> goto L12;
    	 :: else -> goto L16;
  fi;
L12: skip;
L13: if  :: true -> memory[flag1] = 2; goto L14;
		:: true -> lflag0 = memory[flag0]; goto L17;
	fi; 
L14: lflag0 = memory[flag0];
L15: if  :: lflag0 != 4 -> goto L14;
    	 :: else -> goto L16;
  fi;
L16: goto L19;
L17: if  :: lflag0 != 4 -> goto L13
     	 :: true -> memory[flag1] = 2; goto L15;
     	 :: lflag0 == 4 -> goto L18;
  	fi;
L18:  if  :: true -> memory[flag1] = 2; goto L16;
		:: true -> goto L28;
	fi; 
L19: if  :: true -> memory[flag1] = 4; goto L20;
		:: true -> lflag0 = memory[flag0]; goto L25;
	fi; 
L20: lflag0 = memory[flag0];
L21: if :: lflag0 > 1 -> goto L20;
     :: else -> goto L22;
  fi;
L22: skip;
L23: memory[flag1] = 0; goto end;

L25:  if  :: lflag0 > 1 -> goto L19
     	 :: true -> memory[flag1] = 4; goto L21;
     	 :: lflag0 <= 1 -> goto L26;
  	fi;
L26: skip;
L27: memory[flag1] = 4; goto L23;
L28: if  :: true -> memory[flag1] = 2; goto L19;
		:: true -> lflag0 = memory[flag0]; goto L29;
	fi; 
L29: if  :: lflag0 > 1 -> goto L28
     	 :: true -> memory[flag1] = 2; goto L25;
     	 :: lflag0 <= 1 -> goto L30;
  	fi;
L30: skip;
L31: memory[flag1] = 2; goto L27;

end: skip;
}



//----------------------------------------------------------------------

proctype process1(chan ch){
	//p0();
	p0_sb();
}

proctype process2(chan ch){
	//p1();
	p1_sb();
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

ltl prop{ [] !((process1@L18 || process1@L17 || process1@L26 ) && (process2@L22 || process2@L26 || process2@L30 ))}


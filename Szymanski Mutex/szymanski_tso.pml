
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


inline p0_unfenced_sb()
{
byte lflag1;
L0: skip;
L1f1: if	:: true -> memory[flag0] = 1; goto L1;
			:: true -> lflag1 = memory[flag1]; goto L2f1;
	fi; 
L1: lflag1 = memory[flag1]; 
L2: if	:: lflag1 > 2 -> goto L1;
		:: else -> goto L3;
	fi;
L3: skip;
L4: if		:: true -> memory[flag0] = 3; goto L5;
			:: true -> lflag1 = memory[flag1]; goto L6f3;
	fi; 
L5: lflag1 = memory[flag1]; goto L6;

L2f1: if	:: lflag1 > 2 -> goto L1f1;
			:: lflag1 <= 2 -> goto L3f1;
			:: true -> memory[flag0] = 1;
	fi;
L3f1: if	:: true -> goto L4f13;
			:: true -> memory[flag0] = 1; goto L4;
	fi;
L4f13: if	:: true -> lflag1 = memory[flag1]; goto L6f13;
			:: true -> memory[flag0] = 1; goto L4;
	fi; 
//--------------
L6: if	:: lflag1 == 1 -> goto L7;
		:: else -> goto L10;
	fi;
L7: goto L8f2;
L6f3: if	:: lflag1 == 1 -> goto L7f3;
			:: lflag1 != 1 -> goto L10f3;
			:: true -> memory[flag0] = 3; goto L6;
	fi;
L7f3: if	:: true -> memory[flag0] = 3; goto L7;
			:: true -> goto L8f32;
	fi;
L6f13: if	:: lflag1 == 1 -> goto L7f13;
			:: lflag1 != 1 -> goto L10f13;
			:: true -> memory[flag0] = 1; goto L6f3;
	fi;
L7f13: if	:: true -> memory[flag0] = 1; goto L7f3;
			:: true -> goto L8f132;
	fi;
//-------------
L8:  lflag1 = memory[flag1];
L9: if 	:: lflag1 != 4 -> goto L8;
		:: else -> goto L10;
	fi;
L10: goto L11f4;

L8f2: if	:: true -> lflag1 = memory[flag1]; goto L9f2;
			:: true -> memory[flag0] = 2; goto L8;
	fi;
L9f2: if 	:: lflag1 != 4 -> goto L8f2;
			:: lflag1 == 4 -> goto L10f2;
			:: true -> memory[flag0] = 2; goto L9;
	fi;
L10f2: if	:: true -> memory[flag0] = 2; goto L10;
			:: true -> goto L11f24;
	fi;

L8f32: if	:: true -> lflag1 = memory[flag1]; goto L9f32;
			:: true -> memory[flag0] = 3; goto L8f2;
	fi;
L9f32: if 	:: lflag1 != 4 -> goto L8f32;
			:: lflag1 == 4 -> goto L10f32;
			:: true -> memory[flag0] = 3; goto L9f2;
	fi;
L10f32: if	:: true -> memory[flag0] = 3; goto L10f2;
			:: true -> goto L11f324;
	fi;
L10f3: if	:: true -> memory[flag0] = 3; goto L10;
			:: true -> goto L11f34;
	fi;

L8f132: if	:: true -> lflag1 = memory[flag1]; goto L9f132;
			:: true -> memory[flag0] = 1; goto L8f32;
	fi;
L9f132: if 	:: lflag1 != 4 -> goto L8f132;
			:: lflag1 == 4 -> goto L10f132;
			:: true -> memory[flag0] = 1; goto L9f32;
	fi;
L10f132: if	:: true -> memory[flag0] = 1; goto L10f32;
			:: true -> goto L11f1324;
	fi;
L10f13: if	:: true -> memory[flag0] = 3; goto L10f3;
			:: true -> goto L11f324;
	fi;
//--------------------
L11: lflag1 = memory[flag1]; 
L12: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11;
			:: else -> goto L13;
	fi;
L13: goto L14f0;
L14f0: memory[flag0] = 0; goto end;


L11f4: if	:: true -> lflag1 = memory[flag1]; goto L12f4;
			:: true -> memory[flag0] = 4; goto L11;
	fi;
L12f4: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f4;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f4;
			:: true -> memory[flag0] = 4; goto L12;
	fi;
L13f4: if	:: true -> memory[flag0] = 4; goto L13;
			:: true -> goto L14f40;
	fi; 
L14f40: memory[flag0] = 4; goto L14f0;


L11f24: if	:: true -> lflag1 = memory[flag1]; goto L12f24;
			:: true -> memory[flag0] = 2; goto L11f4;
	fi;
L12f24: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f24;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f24;
			:: true -> memory[flag0] = 2; goto L12f4;
	fi;
L13f24: if	:: true -> memory[flag0] = 2; goto L13f4;
			:: true -> goto L14f240;
	fi; 
L14f240: memory[flag0] = 2; goto L14f40;


L11f34: if	:: true -> lflag1 = memory[flag1]; goto L12f34;
			:: true -> memory[flag0] = 3; goto L11f4;
	fi;
L12f34: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f34;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f34;
			:: true -> memory[flag0] = 3; goto L12f4;
	fi;
L13f34: if	:: true -> memory[flag0] = 3; goto L13f4;
			:: true -> goto L14f340;
	fi; 
L14f340: memory[flag0] = 3; goto L14f40;


L11f324: if	:: true -> lflag1 = memory[flag1]; goto L12f324;
			:: true -> memory[flag0] = 3; goto L11f24;
	fi;
L12f324: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f324;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f324;
			:: true -> memory[flag0] = 3; goto L12f24;
	fi;
L13f324: if	:: true -> memory[flag0] = 3; goto L13f24;
			:: true -> goto L14f3240;
	fi; 
L14f3240: memory[flag0] = 3; goto L14f240;


L11f134: if	:: true -> lflag1 = memory[flag1]; goto L12f134;
			:: true -> memory[flag0] = 1; goto L11f34;
	fi;
L12f134: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f134;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f134;
			:: true -> memory[flag0] = 1; goto L12f34;
	fi;
L13f134: if	:: true -> memory[flag0] = 1; goto L13f34;
			:: true -> goto L14f1340;
	fi; 
L14f1340: memory[flag0] = 1; goto L14f340;


L11f1324: if	:: true -> lflag1 = memory[flag1]; goto L12f1324;
			:: true -> memory[flag0] = 1; goto L11f324;
	fi;
L12f1324: if 	:: (lflag1 == 2 || lflag1 == 3) -> goto L11f1324;
			:: !(lflag1 == 2 || lflag1 == 3) -> goto L13f1324;
			:: true -> memory[flag0] = 1; goto L12f324;
	fi;
L13f1324: if	:: true -> memory[flag0] = 1; goto L13f324;
			:: true -> goto L14f13240;
	fi; 
L14f13240: memory[flag0] = 1; goto L14f3240;


end: skip;
}







inline p1_unfenced_sb()
{
byte lflag0;
L0: skip;
L1f1: if	:: true -> memory[flag1] = 1; goto L1;
			:: true -> lflag0 = memory[flag0]; goto L2f1;
	fi; 
L1: lflag0 = memory[flag0]; 
L2: if	:: lflag0 > 2 -> goto L1;
		:: else -> goto L3;
	fi;
L3: skip;
L4: if		:: true -> memory[flag1] = 3; goto L5;
			:: true -> lflag0 = memory[flag0]; goto L6f3;
	fi; 
L5: lflag0 = memory[flag0]; goto L6;

L2f1: if	:: lflag0 > 2 -> goto L1f1;
			:: lflag0 <= 2 -> goto L3f1;
			:: true -> memory[flag1] = 1;
	fi;
L3f1: if	:: true -> goto L4f13;
			:: true -> memory[flag1] = 1; goto L4;
	fi;
L4f13: if	:: true -> lflag0 = memory[flag0]; goto L6f13;
			:: true -> memory[flag1] = 1; goto L4;
	fi; 
//--------------
L6: if	:: lflag0 == 1 -> goto L7;
		:: else -> goto L10;
	fi;
L7: goto L8f2;
L6f3: if	:: lflag0 == 1 -> goto L7f3;
			:: lflag0 != 1 -> goto L10f3;
			:: true -> memory[flag1] = 3; goto L6;
	fi;
L7f3: if	:: true -> memory[flag1] = 3; goto L7;
			:: true -> goto L8f32;
	fi;
L6f13: if	:: lflag0 == 1 -> goto L7f13;
			:: lflag0 != 1 -> goto L10f13;
			:: true -> memory[flag1] = 1; goto L6f3;
	fi;
L7f13: if	:: true -> memory[flag1] = 1; goto L7f3;
			:: true -> goto L8f132;
	fi;
//-------------
L8:  lflag0 = memory[flag0];
L9: if 	:: lflag0 != 4 -> goto L8;
		:: else -> goto L10;
	fi;
L10: goto L11f4;

L8f2: if	:: true -> lflag0 = memory[flag0]; goto L9f2;
			:: true -> memory[flag1] = 2; goto L8;
	fi;
L9f2: if 	:: lflag0 != 4 -> goto L8f2;
			:: lflag0 == 4 -> goto L10f2;
			:: true -> memory[flag1] = 2; goto L9;
	fi;
L10f2: if	:: true -> memory[flag1] = 2; goto L10;
			:: true -> goto L11f24;
	fi;

L8f32: if	:: true -> lflag0 = memory[flag0]; goto L9f32;
			:: true -> memory[flag1] = 3; goto L8f2;
	fi;
L9f32: if 	:: lflag0 != 4 -> goto L8f32;
			:: lflag0 == 4 -> goto L10f32;
			:: true -> memory[flag1] = 3; goto L9f2;
	fi;
L10f32: if	:: true -> memory[flag1] = 3; goto L10f2;
			:: true -> goto L11f324;
	fi;
L10f3: if	:: true -> memory[flag1] = 3; goto L10;
			:: true -> goto L11f34;
	fi;

L8f132: if	:: true -> lflag0 = memory[flag0]; goto L9f132;
			:: true -> memory[flag1] = 1; goto L8f32;
	fi;
L9f132: if 	:: lflag0 != 4 -> goto L8f132;
			:: lflag0 == 4 -> goto L10f132;
			:: true -> memory[flag1] = 1; goto L9f32;
	fi;
L10f132: if	:: true -> memory[flag1] = 1; goto L10f32;
			:: true -> goto L11f1324;
	fi;
L10f13: if	:: true -> memory[flag1] = 3; goto L10f3;
			:: true -> goto L11f324;
	fi;
//--------------------
L11: lflag0 = memory[flag0]; 
L12: if 	:: lflag0 > 1 -> goto L11;
			:: else -> goto L13;
	fi;
L13: goto L14f0;
L14f0: memory[flag1] = 0; goto end;


L11f4: if	:: true -> lflag0 = memory[flag0]; goto L12f4;
			:: true -> memory[flag1] = 4; goto L11;
	fi;
L12f4: if 	:: lflag0 > 1 -> goto L11f4;
			:: lflag0 <= 1 -> goto L13f4;
			:: true -> memory[flag1] = 4; goto L12;
	fi;
L13f4: if	:: true -> memory[flag1] = 4; goto L13;
			:: true -> goto L14f40;
	fi; 
L14f40: memory[flag1] = 4; goto L14f0;


L11f24: if	:: true -> lflag0 = memory[flag0]; goto L12f24;
			:: true -> memory[flag1] = 2; goto L11f4;
	fi;
L12f24: if 	:: lflag0 > 1 -> goto L11f24;
			:: lflag0 <= 1 -> goto L13f24;
			:: true -> memory[flag1] = 2; goto L12f4;
	fi;
L13f24: if	:: true -> memory[flag1] = 2; goto L13f4;
			:: true -> goto L14f240;
	fi; 
L14f240: memory[flag1] = 2; goto L14f40;


L11f34: if	:: true -> lflag0 = memory[flag0]; goto L12f34;
			:: true -> memory[flag1] = 3; goto L11f4;
	fi;
L12f34: if 	:: lflag0 > 1-> goto L11f34;
			:: lflag0 <= 1 -> goto L13f34;
			:: true -> memory[flag1] = 3; goto L12f4;
	fi;
L13f34: if	:: true -> memory[flag1] = 3; goto L13f4;
			:: true -> goto L14f340;
	fi; 
L14f340: memory[flag1] = 3; goto L14f40;


L11f324: if	:: true -> lflag0 = memory[flag0]; goto L12f324;
			:: true -> memory[flag1] = 3; goto L11f24;
	fi;
L12f324: if :: lflag0 > 1 -> goto L11f324;
			:: lflag0 <= 1 -> goto L13f324;
			:: true -> memory[flag1] = 3; goto L12f24;
	fi;
L13f324: if	:: true -> memory[flag1] = 3; goto L13f24;
			:: true -> goto L14f3240;
	fi; 
L14f3240: memory[flag1] = 3; goto L14f240;


L11f134: if	:: true -> lflag0 = memory[flag0]; goto L12f134;
			:: true -> memory[flag1] = 1; goto L11f34;
	fi;
L12f134: if :: lflag0 > 1 -> goto L11f134;
			:: lflag0 <= 1 -> goto L13f134;
			:: true -> memory[flag1] = 1; goto L12f34;
	fi;
L13f134: if	:: true -> memory[flag1] = 1; goto L13f34;
			:: true -> goto L14f1340;
	fi; 
L14f1340: memory[flag1] = 1; goto L14f340;


L11f1324: if	:: true -> lflag0 = memory[flag0]; goto L12f1324;
				:: true -> memory[flag1] = 1; goto L11f324;
	fi;
L12f1324: if 	:: lflag0 > 1 -> goto L11f1324;
				:: lflag0 <= 1 -> goto L13f1324;
				:: true -> memory[flag1] = 1; goto L12f324;
	fi;
L13f1324: if	:: true -> memory[flag1] = 1; goto L13f324;
			:: true -> goto L14f13240;
	fi; 
L14f13240: memory[flag1] = 1; goto L14f3240;


end: skip;
}



//----------------------------------------------------------------------

proctype process1(chan ch){
	//p0();
	//p0_sb();
	p0_unfenced_sb();
}

proctype process2(chan ch){
	//p1();
	//p1_sb();
	p1_unfenced_sb();
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

ltl prop{ [] !((process1@L11 || process1@L11f4 || process1@L11f24 || process1@L11f34 || process1@L11f324 || process1@L11f134 || process1@L11f1324) 
			&& (process2@L11 || process2@L11f4 || process2@L11f24 || process2@L11f34 || process2@L11f324 || process2@L11f134 || process2@L11f1324))}


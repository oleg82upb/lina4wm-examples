/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 05.2013

Burns Mutex SepOps implementation
*/

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
byte locf1, lturn;

entry:
  write(flag0, 1);
  mfence();
  
whilecond:   
  read(flag1, locf1);
  if :: locf1 == 1 -> goto  whilebody;
     :: else -> goto crit0; 	//v5 = locf1;
  fi;

whilebody:
  read(turn,lturn);                              
  if:: lturn != 0 -> goto ifthen;
    :: else -> goto whilecond;
  fi;

ifthen:                  
  write(flag0, 0);
  
whilecond2:
  read(turn,lturn);
  if :: lturn != 0 -> goto whilecond2;
     :: else -> goto whileend1;
  fi;
   
whileend1:
 write(flag0,1);
 goto whilecond;
 
 

//the critical label
crit0: skip;//mfence();

whileend:  
  write(turn, 1); 
  write(flag0, 0);
}


inline p0_sb()
{
byte lflag1, lturn;
L0: memory[flag0] = 1;
L1: lflag1 = memory[flag1];
L2: if 	:: lflag1 == 1 -> goto  L3;
     	:: else -> goto crit0; 	
  	fi;
L3: lturn = memory[turn];
L4: if 	:: lturn != 0 -> goto  L5;
     	:: else -> goto L1; 	
  	fi;
L5: goto L6;
L6: if 	:: true -> memory[flag0] = 0; goto L7;
		:: true -> lturn = memory[turn]; goto L11;
	fi;


L7: lturn = memory[turn];
L8: if 	:: lturn != 0 -> goto L7;
     	:: else -> goto L9; 	
  	fi;
L9: goto L10;
L10: memory[flag0] = 1; goto L1;

L11: if :: lturn != 0 -> goto  L6;
     	:: lturn == 0 -> goto L12;
     	:: true -> memory[flag0] = 0; goto L8; 	
  	 fi;
  	 
L12: if :: true -> goto  L13;
     	:: true -> memory[flag0] = 0; goto L9; 	
  	 fi;
L13: memory[flag0] = 0; goto L10;

crit0:
	memory[turn] = 1;
	memory[flag1] = 0;
}


inline p1_sb()
{
byte lflag0, lturn;
L0: memory[flag1] = 1;
L1: lflag0 = memory[flag0];
L2: if 	:: lflag0 == 1 -> goto  L3;
     	:: else -> goto crit1; 	
  	fi;
L3: lturn = memory[turn];
L4: if 	:: lturn != 1 -> goto  L5;
     	:: else -> goto L1; 	
  	fi;
L5: goto L6;
L6: if 	:: true -> memory[flag1] = 0; goto L7;
		:: true -> lturn = memory[turn]; goto L11;
	fi;


L7: lturn = memory[turn];
L8: if 	:: lturn != 1 -> goto L7;
     	:: else -> goto L9; 	
  	fi;
L9: goto L10;
L10: memory[flag1] = 1; goto L1;

L11: if :: lturn != 1 -> goto  L6;
     	:: lturn == 1 -> goto L12;
     	:: true -> memory[flag1] = 0; goto L8; 	
  	 fi;
  	 
L12: if :: true -> goto  L13;
     	:: true -> memory[flag1] = 0; goto L9; 	
  	 fi;
L13: memory[flag1] = 0; goto L10;

crit1:
	memory[turn] = 0;
	memory[flag1] = 0;
}




inline p1() 
{
byte locf0, lturn;

entry:
  write(flag1, 1);
  mfence();
  
whilecond:   
  read(flag0, locf0);
  if :: locf0 == 1 -> goto  whilebody;
     :: else -> goto crit1; 	//v5 = locf1;
  fi;

whilebody:
  read(turn,lturn);                              
  if:: lturn != 1 -> goto ifthen;
    :: else -> goto whilecond;
  fi;

ifthen:                  
  write(flag1, 0);
  
whilecond2:
  read(turn,lturn);
  if :: lturn != 1 -> goto whilecond2;
     :: else -> goto whileend1;
  fi;

whileend1:
 write(flag1,1);
 goto whilecond;



//the critical label
crit1: skip;//mfence();

whileend:  
  write(turn, 0); 
  write(flag1, 0);
}


//----------------------------------------------------------------------

proctype process1(chan ch){
	p0();
	//p0_sb();
}

proctype process2(chan ch){
	p1();
	//p1_sb();
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

ltl prop{ [] !((process1@crit0) && (process2@crit1))}



#define BUFF_SIZE 4 	//size of Buffer
#define MEM_SIZE 4	//size of memory
#define flag0 1
#define flag1 2
#include "x86_tso_buffer.pml"


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};




inline p0() 
{
byte lflag1, phi;

L1:
  write(flag0, 1);
  //mfence();
  
whilecond:   
  read(flag1, lflag1);
  if :: lflag1 > 2 -> goto  whilecond;
     :: else -> goto whileend; 
  fi;

whileend:
  write(flag0,3);
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
}


inline p1() 
{
byte lflag0;

L1:
  write(flag1, 1);
  
whilecond:   
  read(flag0, lflag0);
  if :: lflag0 > 2 -> goto  whilecond;
     :: else -> goto whileend; 
  fi;

whileend:
  write(flag1,3);
  //mfence();
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

ltl prop{ [] !((process1@crit) && (process2@crit))}


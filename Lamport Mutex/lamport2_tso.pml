
#define BUFF_SIZE 4 	//size of Buffer
#define MEM_SIZE 5	//size of memory
#define choosing 1
#define ch0 1
#define ch1 1
#define number 3
#define num0 3
#define num1 4
#include "x86_tso_buffer.pml"


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};




inline p(i) 
{
int n0, n1, nj, ni, n7, j, jn, jc, w1, add;
int mych  = choosing + i;
int mynum = number + i;

L1:                                            
  write(mych, 1);
  mfence();
  read(num0, n0);
  read(num1, n1);
  if :: n0 < n1 -> goto ifthen;
  	 :: else -> goto ifelse;
  fi;

ifthen:
  add = n1 + 1;
  write(mynum, add);
  goto ifend;

ifelse:
  add = n0 + 1;
  write(mynum, add);
  goto ifend;

ifend:                                          
write(mych, 0);
mfence();
atomic{
j = 0;
jn = num0 + j;
jc = ch0 + j;}
//mfence(); 

forcond:
if	:: j < 2 -> goto forbody;
	:: else -> goto crit;
fi;

forbody:
if 	:: j != i -> goto whilecond;
	:: else -> goto forinc;
fi; 

whilecond:
read(jc, w1);
if	:: w1 -> goto whilecond;
	:: else -> goto whilecond2;
fi;


whilecond2:
read(jn, nj);
read(mynum, ni);

if	:: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto whilecond2;
	:: else -> goto forinc;
fi;

forinc:
atomic{
j = j + 1;
jn = num0 + j;
jc = ch0 + j;}
goto forcond;


crit: skip;


forend: 
write(mynum, 0);
//mfence();
//goto L1;

}

inline p_sb(i)
{
int n0, n1, nj, ni, n7, j, jn, jc, w1, add;
int ch_i  = choosing + i;
int num_i = number + i;

L0: skip;
L1: memory[ch_i] = 1;
L2: skip;
L3: n0 = memory[num0];
L4: n1 = memory[num1];
L5: if	:: n0 < n1 -> goto L6;
		:: else -> goto L10;
	fi;
L6: goto L7;
L7: if 	:: true -> goto L9;
		:: true -> memory[num_i] = n1 + 1; goto L8;
	fi;
L8: goto L13;
L9: memory[num_i] = n1 + 1; goto L13;
L10: goto L11;
L11: if	:: true -> goto L12;
		:: true -> memory[num_i] = n0 + 1; goto L8;
	fi;
L12: memory[num_i] = n0 + 1; goto L13;
L13: memory[ch_i] = 0;
L14: skip;
L15: j = 0;
L16: if	:: j < 2 -> goto L17;
		:: else -> goto crit;
	fi;
L17: if	:: j != i -> goto L18;
		:: else -> goto L23;
	fi;

L18: w1 = memory[choosing + j];
L19: if	:: w1 -> goto L18;
		:: else -> goto L19;
	fi;
L20: nj = memory[number + j];
L21: ni = memory[num_i + i];
L22: if	:: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L20;
		:: else -> goto L23;
	 fi;
L23: j = j + 1; goto L16;
	
crit: skip;

memory[num_i] = 0;
}

//----------------------------------------------------------------------

proctype process1(chan ch){
	//p(0);
	p_sb(0);
}

proctype process2(chan ch){
	//p(1);
	p_sb(1);
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



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


inline p_unfenced_sb(i){
int n0, n1, nj, ni, n7, j, jn, jc, w1, add;
int ch_i  = choosing + i;
int num_i = number + i;
L0: skip;
L1: if :: true -> memory[ch_i] = 1; goto L2;
		:: true -> n0 = memory[num0]; goto L5;
	fi;
L2:  n0 = memory[n0];
L3:  n1 = memory[n1];
L4: if :: n0 < n1 -> goto L7;
		:: else -> goto L10;
	fi;
L5: if :: true -> memory[ch_i] = 1; goto L3;
		:: true -> n1 = memory[num1]; goto L6;
	fi;
L6: if :: n0 < n1 -> goto L13;
		:: n0 >= n1 -> goto L16;
		:: true -> memory[ch_i] = 1; goto L4;
	fi;
L7: skip; 
L8: if :: true -> memory[num_i] = n1 + 1; goto L9;
		:: true -> goto L19;
	fi;
L9: goto L20;
L10: skip;
L11:  if :: true -> memory[num_i] = n0 + 1; goto L9;
		:: true -> goto L12;
	fi;
L12: if :: true -> memory[num_i] = n0 + 1; goto L20;
		:: true -> j = 0; goto L22n0ch;
	fi;
L13: if :: true -> memory[ch_i] = 1; goto L7;
		:: true -> goto L14;
	fi;
L14: if :: true -> memory[ch_i] = 1; goto L8;
		:: true -> goto L15;
	fi;
L15: if :: true -> memory[ch_i] = 1; goto L19;
		:: true -> j=0; goto L22chn1ch;
	fi;
L16: if :: true -> memory[ch_i] = 1; goto L10;
		:: true -> goto L17;
	fi;
L17: if :: true -> memory[ch_i] = 1; goto L11;
		:: true -> goto L18;
	fi;
L18: if :: true -> memory[ch_i] = 1; goto L12;
		:: true -> j=0; goto L22chn0ch;
	fi;
L19: if :: true -> memory[num_i] =  n1+ 1; goto L20;
		:: true -> j=0; goto L22n1ch;
	fi;
L20: if :: true -> memory[ch_i] =  0; goto L21;
		:: true -> j=0; goto L22ch;
	fi; 
//SC run from 28 to end
L21: j = 0;
L22: if :: j<2 -> goto L28;
		:: else -> goto crit;
	fi;
L28: if :: j!=i -> goto L29;
		:: else -> goto L34;
	fi;
L29: w1 = memory[choosing + j];
L30: if :: w1 -> goto L29;
		:: else -> goto L31;
	fi;
L31: nj = memory[number + j];
L32: ni = memory[num_i];
L33: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31;
		:: else -> goto L34;
	 fi;
L34: j = j +1; goto L22;
crit: goto end;

//ch_i must be flushed
L22ch: if :: j<2 -> goto L28ch;
		:: j>=2 -> goto critch;
		:: true -> memory[ch_i] = 0; goto L22;
	fi;
L28ch: if :: j!=i -> goto L29ch;
		:: j==i -> goto L34ch;
		:: true -> memory[ch_i] = 0; goto L28;
	fi;
L29ch: if :: true -> w1 = memory[choosing + j]; goto L30ch;
		  :: true -> memory[ch_i] = 0; goto L29;
	fi;
	
L30ch: if :: w1 -> goto L29ch;
		:: !w1 -> goto L31ch;
		:: true -> memory[ch_i] = 0; goto L30;
	fi;
	
L31ch: if :: true -> nj = memory[number + j]; goto L32ch;
		  :: true -> memory[ch_i] = 0; goto L31;
	fi; 
L32ch:  if  :: true -> ni = memory[num_i]; goto L33ch;
			:: true -> memory[ch_i] = 0; goto L32;
		fi;
L33ch: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31ch;
		  :: !(nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L34ch;
		  :: true -> memory[ch_i] = 0; goto L33;
	 fi;
L34ch: if :: true -> j = j +1; goto L22ch;
		  :: true -> memory[ch_i] = 0; goto L34;
	 fi;
critch: memory[ch_i] = 0; goto crit;

//memory[num_i] = n1+1  must be flushed before ch_i
L22n1ch: if :: j<2 -> goto L28n1ch;
		:: j>=2 -> goto critn1ch;
		:: true -> memory[num_i] = n1+1; goto L22ch;
	fi;
L28n1ch: if :: j!=i -> goto L29n1ch;
		:: j==i -> goto L34n1ch;
		:: true -> memory[num_i] = n1+1; goto L28ch;
	fi;
L29n1ch: if :: true -> w1 = memory[choosing + j]; goto L30n1ch;
		  :: true -> memory[num_i] = n1+1; goto L29ch;
	fi;
	
L30n1ch: if :: w1 -> goto L29n1ch;
		:: !w1 -> goto L31n1ch;
		:: true -> memory[num_i] = n1+1; goto L30ch;
	fi;
	
L31n1ch: if :: true -> nj = memory[number + j]; goto L32n1ch;
		  :: true -> memory[num_i] = n1+1; goto L31ch;
	fi; 
L32n1ch:  if  :: true -> ni = memory[num_i]; goto L33n1ch;
			:: true -> memory[num_i] = n1+1; goto L32ch;
		fi;
L33n1ch: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31n1ch;
		  :: !(nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L34n1ch;
		  :: true -> memory[num_i] = n1+1; goto L33ch;
	 fi;
L34n1ch: if :: true -> j = j +1; goto L22n1ch;
		  :: true -> memory[num_i] = n1+1; goto L34ch;
	 fi;
critn1ch: memory[num_i] = n1+1; goto critch;

//memory[num_i] = n0+1  must be flushed before ch_i
L22n0ch: if :: j<2 -> goto L28n0ch;
		:: j>=2 -> goto critn0ch;
		:: true -> memory[num_i] = n0+1; goto L22ch;
	fi;
L28n0ch: if :: j!=i -> goto L29n0ch;
		:: j==i -> goto L34n0ch;
		:: true -> memory[num_i] = n0+1; goto L28ch;
	fi;
L29n0ch: if :: true -> w1 = memory[choosing + j]; goto L30n0ch;
		  :: true -> memory[num_i] = n0+1; goto L29ch;
	fi;
	
L30n0ch: if :: w1 -> goto L29n0ch;
		:: !w1 -> goto L31n0ch;
		:: true -> memory[num_i] = n0+1; goto L30ch;
	fi;
	
L31n0ch: if :: true -> nj = memory[number + j]; goto L32n0ch;
		  :: true -> memory[num_i] = n0+1; goto L31ch;
	fi; 
L32n0ch:  if  :: true -> ni = memory[num_i]; goto L33n0ch;
			:: true -> memory[num_i] = n0+1; goto L32ch;
		fi;
L33n0ch: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31n0ch;
		  :: !(nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L34n0ch;
		  :: true -> memory[num_i] = n0+1; goto L33ch;
	 fi;
L34n0ch: if :: true -> j = j +1; goto L22n0ch;
		  :: true -> memory[num_i] = n0+1; goto L34ch;
	 fi;
critn0ch: memory[num_i] = n0+1; goto critch;



//ch_i,1 before memory[num_i] = n1+1  before ch_i,0
L22chn1ch: if :: j<2 -> goto L28chn1ch;
		:: j>=2 -> goto critchn1ch;
		:: true -> memory[ch_i] = 1; goto L22n1ch;
	fi;
L28chn1ch: if :: j!=i -> goto L29chn1ch;
		:: j==i -> goto L34chn1ch;
		:: true -> memory[ch_i] = 1; goto L28n1ch;
	fi;
L29chn1ch: if :: true -> w1 = memory[choosing + j]; goto L30chn1ch;
		  :: true -> memory[ch_i] = 1; goto L29n1ch;
	fi;
	
L30chn1ch: if :: w1 -> goto L29chn1ch;
		:: !w1 -> goto L31chn1ch;
		:: true -> memory[ch_i] = 1; goto L30n1ch;
	fi;
	
L31chn1ch: if :: true -> nj = memory[number + j]; goto L32chn1ch;
		  :: true -> memory[ch_i] = 1; goto L31n1ch;
	fi; 
L32chn1ch:  if  :: true -> ni = memory[num_i]; goto L33chn1ch;
			:: true -> memory[ch_i] = 1; goto L32n1ch;
		fi;
L33chn1ch: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31chn1ch;
		  :: !(nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L34chn1ch;
		  :: true -> memory[ch_i] = 1; goto L33n1ch;
	 fi;
L34chn1ch: if :: true -> j = j +1; goto L22chn1ch;
		  :: true -> memory[ch_i] = 1; goto L34n1ch;
	 fi;
critchn1ch: memory[ch_i] = 1; goto critn1ch;


//ch_i, 1 before  memory[num_i] = n0+1   before ch_i
L22chn0ch: if :: j<2 -> goto L28chn0ch;
		:: j>=2 -> goto critchn0ch;
		:: true -> memory[ch_i] = 1; goto L22n0ch;
	fi;
L28chn0ch: if :: j!=i -> goto L29chn0ch;
		:: j==i -> goto L34chn0ch;
		:: true -> memory[ch_i] = 1; goto L28n0ch;
	fi;
L29chn0ch: if :: true -> w1 = memory[choosing + j]; goto L30chn0ch;
		  :: true -> memory[ch_i] = 1; goto L29n0ch;
	fi;
	
L30chn0ch: if :: w1 -> goto L29chn0ch;
		:: !w1 -> goto L31chn0ch;
		:: true -> memory[ch_i] = 1; goto L30n0ch;
	fi;
	
L31chn0ch: if :: true -> nj = memory[number + j]; goto L32chn0ch;
		  :: true -> memory[ch_i] = 1; goto L31n0ch;
	fi; 
L32chn0ch:  if  :: true -> ni = memory[num_i]; goto L33chn0ch;
			:: true -> memory[ch_i] = 1; goto L32n0ch;
		fi;
L33chn0ch: if :: (nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L31chn0ch;
		  :: !(nj != 0 && (nj < ni || (nj == ni && j < i))) -> goto L34chn0ch;
		  :: true -> memory[ch_i] = 1; goto L33n0ch;
	 fi;
L34chn0ch: if :: true -> j = j +1; goto L22chn0ch;
		  :: true -> memory[ch_i] = 1; goto L34n0ch;
	 fi;
critchn0ch: memory[ch_i] = 1; goto critn0ch;

end: skip;
}


//----------------------------------------------------------------------

proctype process1(chan ch){
	//p(0);
	//p_sb(0);
	p_unfenced_sb(0);
}

proctype process2(chan ch){
	//p(1);
	//p_sb(1);
	p_unfenced_sb(1);
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

ltl prop{ [] !((process1@crit || process1@critch || process1@critn1ch || process1@critn0ch  || process1@critchn1ch || process1@critchn0ch ) 
     && (process2@crit || process2@critch || process2@critn1ch || process2@critn0ch  || process2@critchn1ch || process2@critchn0ch ))}


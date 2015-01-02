
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
/* ***********
inline p0() 
{
int n0, n1, w1;

L1:                                            
  write(ch0, 1);
  mfence();
  read(num1, n1);
  if :: n1 == 2 -> goto ifthen;
  	 :: else -> goto ifelse;
  fi;

ifthen:
  write(ch0, 0);
  goto L1; //re-choose???

ifelse:
  n0 = n1 + 1;
  write(num0, n0);
  mfence();//potential fence
  goto ifend;

ifend:                                          
write(ch0, 0);
mfence();
//potential fence


whilecond:
read(ch1, w1);
if	:: w1 != 0 -> goto whilecond;
	:: else -> goto whilecond2;
fi;


whilecond2:
read(num1, n1);

if	:: (n1 != 0 && (n1 < n0 || n1 == n0 )) -> goto whilecond2;
	:: else -> goto crit;
fi;


crit: skip;


forend: 
write(num0, 0);
goto L1;

}
inline p0sc() 
{
int n0, n1, w1;

L1:                                            
  memory[ch0] = 1;
  n1 = memory[num1];
  if :: n1 == 2 -> goto ifthen;
  	 :: else -> goto ifelse;
  fi;

ifthen:
  memory[ch0] = 0;
  goto L1; //re-choose???

ifelse:
  n0 = n1 + 1;
  memory[num0] = n0;
  //mfence();//potential fence
  goto ifend;

ifend:                                          
memory[ch0] = 0;
//potential fence


whilecond:
w1 = memory[ch1];
if	:: w1 != 0 -> goto whilecond;
	:: else -> goto whilecond2;
fi;


whilecond2:
n1 = memory[num1]; 

if	:: (n1 != 0 && (n1 < n0 || n1 == n0 )) -> goto whilecond2;
	:: else -> goto crit0;
fi;


crit0: skip;


forend: 
memory[num0] = 0; 
goto L1;

}


inline p1() 
{
int n0, n1, w1;

L1:                                            
  write(ch1, 1);
  //mfence();
  read(num0, n0);
  if :: n0 == 2 -> goto ifthen;
  	 :: else -> goto ifelse;
  fi;

ifthen:
  write(ch1, 0);
  goto L1; //re-choose???

ifelse:
  n1 = n0 + 1;
  write(num1, n1);
  mfence();//potential fence
  goto ifend;

ifend:                                          
write(ch1, 0);
mfence();
//potential fence


whilecond:
read(ch0, w1);
if	:: w1 != 0 -> goto whilecond;
	:: else -> goto whilecond2;
fi;


whilecond2:
read(num0, n0);

if	:: (n0 != 0 && n0 < n1) -> goto whilecond2;
	:: else -> goto crit;
fi;


crit: skip;


forend: 
write(num1, 0);
goto L1;
}


inline p1sc() 
{
int n0, n1, w1;

L1:                                            
  memory[ch1] = 1;
  n0 = memory[num0];
  if :: n0 == 2 -> goto ifthen;
  	 :: else -> goto ifelse;
  fi;

ifthen:
  memory[ch0] = 0;
  goto L1; //re-choose???

ifelse:
  n1 = n0 + 1;
  memory[num1] = n1; 
                           
  memory[ch1] = 0; 
  //potential fence


whilecond:
w1 = memory[ch0];
if	:: w1 != 0 -> goto whilecond;
	:: else -> goto whilecond2;
fi;


whilecond2:
n0 = memory[num0];

if	:: (n0 != 0 && n0 < n1) -> goto whilecond2;
	:: else -> goto crit1;
fi;


crit1: skip;


forend: 
memory[num1] = 0;
goto L1;
}
************ */
//----------------------------------------------------------------------

proctype process1(chan ch){
	p(0);
}

proctype process2(chan ch){
	p(1);
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


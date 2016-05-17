#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 6 	//size of Buffer 
#define null 0
#define I32  1
#define PTR 1
short memUse = 1; 	//shows to the next free cell in memory

//#include "sc.pml"
//#include "tso.pml"
#include "pso.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
short latch1 = 1;
short flag1 = 1;
short latch2 = 0;
short flag2 = 0;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}





//------------- functions ------------------

inline worker_1(){
short v0, v1, tobool;
skip;
entry: 
   goto forcond;
 

forcond: 
 //assert(!memory[latch1] || memory[flag1]);
 read(flag1, v0); 
 v1 = v0 & 1; 
 tobool = (v1 == 0); 
 if 
 	:: tobool ->  goto forcond;
 	:: !tobool ->  goto ifthen;
 fi;
 

ifthen: 
 write(latch1, 0);
 write(flag1, 0);
 write(flag2, 1);
 mfence();
 write(latch2, 1);
   goto forcond;
 


ret: skip;
}


inline worker_2(){
short v0, v1, tobool;
skip;
entry: 
   goto forcond;
 

forcond: 
 //assert(!memory[latch2] || memory[flag2]);
 read(flag2, v0);
 v1 = v0 & 1; 
 tobool = (v1 == 0); 
 if 
 	:: tobool ->  goto forcond;
 	:: !tobool ->  goto ifthen;
 fi;
 

ifthen: 
 write(latch2, 0);
 write(flag2, 0);
 write(flag1, 1);
 mfence();
 write(latch1, 1);
   goto forcond;
 


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	worker_1();
}

proctype process2(chan ch){
	worker_2();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, latch1);
	alloca(1, flag1);
	alloca(1, latch2);
	alloca(1, flag2);
	memory[latch1] = 1;
	memory[flag1] = 1;
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

ltl prop{ [] !((process1@ifthen) && (process2@ifthen))}
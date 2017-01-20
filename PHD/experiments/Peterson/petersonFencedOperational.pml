#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 3 	//size of Buffer 
#define null 0
#define I32  1
#define PTR 1
short memUse = 1; 	//shows to the next free cell in memory

//#include "sc.pml"
//#include "tso.pml"
#include "pso.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
short flag0 = null;
short flag1 = null;
short turn = null;
short mtxOwner = 0;

inline acquire(id)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = id;
	 }
}

inline release(id)
{
	atomic{
	 assert(mtxOwner == id);
	 mtxOwner = 0;
	 }
}

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

inline p0(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
skip;
entry: 
 read(flag0, v0); 
 write(v0, 1);
 read(turn, v1); 
 mfence();
 write(v1, 1);
 mfence();
   goto whilecond;
 

whilecond: 
 read(flag1, v2); 
 read(v2, v3); 
 tobool = v3; 
 conv = tobool; 
 cmp = (conv == 1); 
 if 
 	:: cmp ->  goto landrhs;
 	:: !cmp -> 	v6 = false;
 	 goto landend;
 fi;
 

landrhs: 
 read(turn, v4); 
 read(v4, v5); 
 tobool2 = v5; 
 conv3 = tobool2; 
 cmp4 = (conv3 == 1); 
 	v6 = cmp4;
   goto landend;
 

landend: 
 // phi instruction replaced by assignments before  the goto to this block 
 if 
 	:: v6 ->  goto whilebody;
 	:: !v6 ->  acquire(_pid); goto whileend;
 fi;
 

whilebody: 
   goto whilecond;
 

whileend: 
 release(_pid); 
 read(flag0, v7); 
 write(v7, 0);
 goto ret;


ret: skip;
}


inline p1(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
skip;
entry: 
 read(flag1, v0); 
 write(v0, 1);
 read(turn, v1); 
 mfence();
 write(v1, 0);
 mfence();
   goto whilecond;
 

whilecond: 
 read(flag0, v2); 
 read(v2, v3); 
 tobool = v3; 
 conv = tobool; 
 cmp = (conv == 1); 
 if 
 	:: cmp ->  goto landrhs;
 	:: !cmp -> 	v6 = false;
 	 goto landend;
 fi;
 

landrhs: 
 read(turn, v4); 
 read(v4, v5); 
 tobool2 = v5; 
 conv3 = tobool2; 
 cmp4 = (conv3 == 0); 
 	v6 = cmp4;
   goto landend;
 

landend: 
 // phi instruction replaced by assignments before  the goto to this block 
 if 
 	:: v6 ->  goto whilebody;
 	:: !v6 ->  acquire(_pid); goto whileend;
 fi;
 

whilebody: 
   goto whilecond;
 

whileend: 
 release(_pid); 
 read(flag1, v7); 
 write(v7, 0);
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	p0();
}

proctype process2(chan ch){
	p1();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	alloca(1, turn);
	//two layers of pointers need initialization
	memory[flag0] = 4;
	memory[flag1] = 5;
	memory[turn] = 6;
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

//ltl prop{ [] !((process1@whileend) && (process2@whileend))}
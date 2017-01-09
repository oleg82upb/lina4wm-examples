#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 5 	//size of Buffer 
#define null 0
#define I32  1
#define PTR 1
short memUse = 1; 	//shows to the next free cell in memory

//#include "sc.pml"
#include "tso.pml"
//#include "pso.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
short choosing = 0; //Array: please, check initialization in the init process
short number = 0; //Array: please, check initialization in the init process


//pointer computation 
inline getelementptr(type, instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
	assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
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

inline proci(i){
short arrayidx, v0, v1, cmp, v2, v3, add, add2, arrayidx1, arrayidx3, arrayidx11, j_023, inc, arrayidx6, v4, v5, tobool, arrayidx8, cmp17, v6, cmp9, v7, exitcond, v8, cmp12, arrayidx21, v9, v10, cmp15, or_cond;
skip;
entry: 
 getelementptr(2, choosing, i, arrayidx); 
 write(arrayidx, 1);
 read(number + 0, v0); 
 read(number + 1, v1); 
 cmp = (v0 < v1); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto ifelse;
 fi;
 

ifthen: 
 read(number + 1, v2); 
 add = v2 + 1; 
 getelementptr(2, number, i, arrayidx1); 
 write(arrayidx1, add);
   goto ifend;
 

ifelse: 
 read(number + 0, v3); 
 add2 = v3 + 1; 
 getelementptr(2, number, i, arrayidx3); 
 write(arrayidx3, add2);
   goto ifend;
 

ifend: 
 write(arrayidx, 0);
 getelementptr(2, number, i, arrayidx11); 
 	j_023 = 0;
   goto whilecondpreheader;
 

whilecondpreheader: 
 // phi instruction replaced by assignments before  the goto to this block 
 getelementptr(2, choosing, j_023, arrayidx6); 
   goto whilecond;
 

whilecond: 
 read(arrayidx6, v4); 
 v5 = v4 & 1; 
 tobool = (v5 == 0); 
 if 
 	:: tobool ->  goto whilecond7loopexit;
 	:: !tobool ->  goto whilecond;
 fi;
 

whilecond7loopexit: 
 getelementptr(2, number, j_023, arrayidx8); 
 cmp17 = (j_023 < i); 
   goto whilecond7;
 

whilecond7: 
 read(arrayidx8, v6); 
 cmp9 = (v6 == 0); 
 if 
 	:: cmp9 ->  goto forinc;
 	:: !cmp9 ->  goto landrhs;
 fi;
 

landrhs: 
 read(arrayidx8, v7); 
 read(arrayidx11, v8); 
 cmp12 = (v7 < v8); 
 if 
 	:: cmp12 ->  goto whilecond7;
 	:: !cmp12 ->  goto lorrhs;
 fi;
 

lorrhs: 
 read(arrayidx8, v9); 
 read(arrayidx11, v10); 
 cmp15 = (v9 == v10); 
 or_cond = cmp15 & cmp17; 
 if 
 	:: or_cond ->  goto whilecond7;
 	:: !or_cond ->  goto forinc;
 fi;
 

forinc: 
 inc = j_023 + 1; 
 exitcond = (inc == 2); 
 if 
 	:: exitcond ->  goto forend;
 	:: !exitcond -> 	j_023 = inc;
 	 goto whilecondpreheader;
 fi;
 

forend: 
 getelementptr(2, number, i, arrayidx21); 
 write(arrayidx21, 0);
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	proci(0);
}

proctype process2(chan ch){
	proci(1);
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(2, choosing);
	alloca(2, number);
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}
ltl prop{ [] !((process1@forend) && (process2@forend))}
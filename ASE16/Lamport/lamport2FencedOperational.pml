#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 3 	//size of Buffer 
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
short arrayidx, v0, v1, v2, v3, v4, cmp, add, add2, arrayidx1, arrayidx3, v5, v6, v7, arrayidx11, j_023, inc, arrayidx6, v8, v9, v10, tobool, arrayidx8, v11, v12, cmp9, cmp17, v13, exitcond, v14, cmp12, arrayidx21, cmp15, v15, or_cond, or_cond24;
skip;
entry: 
 getelementptr(2, choosing, i, arrayidx); 
 read(arrayidx, v0); 
 write(v0, 1);
 mfence();
 read(number + 0, v1); 
 read(v1, v2); 
 read(number + 1, v3); 
 read(v3, v4); 
 cmp = (v2 < v4); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto ifelse;
 fi;
 

ifthen: 
 add = v4 + 1; 
 getelementptr(2, number, i, arrayidx1); 
 read(arrayidx1, v5); 
 write(v5, add);
   goto ifend;
 

ifelse: 
 add2 = v2 + 1; 
 getelementptr(2, number, i, arrayidx3); 
 read(arrayidx3, v6); 
 write(v6, add2);
   goto ifend;
 

ifend: 
 read(arrayidx, v7); 
 write(v7, 0);
 getelementptr(2, number, i, arrayidx11); 
 mfence();
 	j_023 = 0;
   goto whilecondpreheader;
 

whilecondpreheader: 
 // phi instruction replaced by assignments before  the goto to this block 
 getelementptr(2, choosing, j_023, arrayidx6); 
 read(arrayidx6, v8); 
 read(v8, v9); 
 v10 = v9 & 1; 
 tobool = (v10 == 0); 
 if 
 	:: tobool ->  goto whilecond7loopexitsplit;
 	:: !tobool ->  goto whilecond;
 fi;
 

whilecond: 
   goto whilecond;
 

whilecond7loopexitsplit: 
 getelementptr(2, number, j_023, arrayidx8); 
 read(arrayidx8, v11); 
 read(v11, v12); 
 cmp9 = (v12 == 0); 
 cmp17 = (j_023 < i); 
 if 
 	:: cmp9 ->  goto forincsplit;
 	:: !cmp9 ->  goto landrhs;
 fi;
 

landrhs: 
 read(arrayidx11, v13); 
 read(v13, v14); 
 cmp12 = (v12 < v14); 
 cmp15 = (v12 == v14); 
 or_cond = cmp15 & cmp17; 
 or_cond24 = cmp12 | or_cond; 
 if 
 	:: or_cond24 ->  goto landrhs;
 	:: !or_cond24 ->  goto forincsplit;
 fi;
 

forincsplit: 
 inc = j_023 + 1; 
 exitcond = (inc == 2); 
 if 
 	:: exitcond ->  goto forend;
 	:: !exitcond -> 	j_023 = inc;
 	 goto whilecondpreheader;
 fi;
 

forend: 
 getelementptr(2, number, i, arrayidx21); 
 read(arrayidx21, v15); 
 write(v15, 0);
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	//TODO: empty stub
}

proctype process2(chan ch){
	//TODO: empty stub
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

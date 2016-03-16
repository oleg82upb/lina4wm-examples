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
//atomic compare and swap instruction 
inline cas(adr, old, new, result)
{
	atomic{
	//in LLVM result is usually a tuple (memory[adr], successFlag)
	//we assume it to be just a loaded value
	result = memory[adr];
	if 	:: memory[adr] == old -> memory[adr] = new; 
		:: else -> skip;
	fi;
	}
}

//------------- functions ------------------
//function was renamed from: @_ZN5Stack4pushEi
inline push(this, v){
short call, val, head, next, v0, v1, v2, v3, v4, v5, v6;
skip;
invokecont: 
 Znwj(8, call); 
 val = call; 
 write(val, v);
 getelementptr(1, this, 0, head); 
 getelementptr(1, call, 1, next); /*Needs attention due to different types of first index and aggregate.*/
 v0 = next; 
 v1 = this; 
 v2 = call; 
   goto dobody;
 

dobody: 
 read(head, v3); 
 write(v0, v3);
 v4 = v3; 
 cas(v1, v4, v2, v5); 
 v6 = (v5 == v4); 
 if 
 	:: v6 ->  goto doend;
 	:: !v6 ->  goto dobody;
 fi;
 

doend: 
 goto ret;


ret: skip;
}

//function was renamed from: @_ZN5Stack3popEv
inline pop(this, returnvalue){
short head, v0, v1, cmp, retval_0, next, v2, v3, v4, v5, v6;
skip;
entry: 
 getelementptr(1, this, 0, head); 
 v0 = this; 
   goto dobody;
 

dobody: 
 read(head, v1); 
 cmp = (v1 == null); 
 if 
 	:: cmp -> 	retval_0 = null;
 	 goto return;
 	:: !cmp ->  goto ifend;
 fi;
 

ifend: 
 getelementptr(2, v1, 1, next); 
 read(next, v2); 
 v3 = v1; 
 v4 = v2; 
 cas(v0, v3, v4, v5); 
 v6 = (v5 == v3); 
 if 
 	:: v6 -> 	retval_0 = v1;
 	 goto return;
 	:: !v6 ->  goto dobody;
 fi;
 

return: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
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
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

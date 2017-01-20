#define MEM_SIZE 15	//size of memory
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

//abstract Stack implemented as array----------------------
#define ASSIZE 7
short asStack[ASSIZE];
short asTop = 0;

//asValue the value we expect to be on top of the stack
inline asPop(asValue) //can leave out the returnValue????????????????????????????????
{
	atomic
	{
		asTop--;										//decrement top 
		assert (asStack[asTop] == memory[asValue]);  	//asValue must be top element
		asStack[asTop] = 0;								//remove element from stack
	}
}

inline asPopFail()
{
	assert (asTop == 0)
}

inline asPush(asValue)
{
	atomic
	{
		assert(asTop < ASSIZE); //make sure, stack array is never full
		asStack[asTop] = asValue;
		asTop++;
	}
	//should we return something?
}

inline readLPPopFail(adr, target)
{
	atomic{
	//short readValue;
	read(adr, target)
	//target = readValue;
	if 
		:: target == NULL -> asPopFail();
		:: else -> skip;
	fi
	}
}

inline casLPPop(adr, oldValue, newValue, success) 
{
	// 2 steps for the executing process, but atomic on memory
	//bit success;
	atomic{
	cas(adr, oldValue, newValue, success);
	//returnValue = success;
	if 
		:: success == oldValue -> asPop(oldValue); //if successfull, then the popped value is the oldValue
		:: else -> skip;
	fi
	}
}

inline casLPPush(adr, oldValue, newValue, success, controlValue) 
{
	// 2 steps for the executing process, but atomic on memory
	//bit success;
	atomic{
	cas(adr, oldValue, newValue, success);
	//returnValue = success;
	if 	:: oldValue == success -> asPush(controlValue);
		:: else -> skip;
	fi
	}
}

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
//function was renamed from: @_ZN5Stack4pushEi
inline push(this, v){
short call, val, head, next, v0, v1, v2, v3, v4, v5, v6;
skip;
invokecont: 
 alloca(2, call); 
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
 //cas(v1, v4, v2, v5); //compiler returns the old value in success bit in case of success. we return only success bit
 casLPPush(v1, v4, v2, v5, v) 
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
 //read(head, v1); 
 readLPPopFail(head, v1);
 cmp = (v1 == null); 
 if 
 	:: cmp -> 	retval_0 = null;
 	 goto return1;
 	:: !cmp ->  goto ifend;
 fi;
 

ifend: 
 getelementptr(2, v1, 1, next); 
 read(next, v2); 
 v3 = v1; 
 v4 = v2; 
 //cas(v0, v3, v4, v5); 
 casLPPop(v0, v3, v4, v5);
 v6 = (v5 == v3); 
 if 
 	:: v6 -> 	retval_0 = v1;
 	 goto return1;
 	:: !v6 ->  goto dobody;
 fi;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


//------------- process template -------------
byte this; 
//Stubs
proctype process1(chan ch){
	short returnvalue;
	push(this, 111);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 222 || memory[returnvalue] == 223 || memory[returnvalue] == null);
	push(this, 112);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222  || memory[returnvalue] == 223 || memory[returnvalue] == null);
}

proctype process2(chan ch){
	short returnvalue;
	push(this, 222);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222 || memory[returnvalue] == null);
	push(this, 223);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222 || memory[returnvalue] == 223 || memory[returnvalue] == null);
}

proctype process3(chan ch){
	short returnvalue;
	push(this, 111);
	push(this, 112);
	push(this, 113);
	pop(this, returnvalue);
	pop(this, returnvalue);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 113 || memory[returnvalue] == null 
	//|| memory[returnvalue] == 222  || memory[returnvalue] == 223   || memory[returnvalue] == 224);
}

proctype process4(chan ch){
	short returnvalue;
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 113 || memory[returnvalue] == null);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 113 || memory[returnvalue] == null);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 113 || memory[returnvalue] == null);
	push(this, 222);
	push(this, 223);
	push(this, 224);
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(PTR, this)//create share "this" pointers
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process3(channelT1);
	run process4(channelT2);
	}
}

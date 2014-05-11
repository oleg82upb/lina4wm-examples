/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 01.2013

abstract Treiber Stack implementation based on a LLVM optimized version
*/


#define BUFF_SIZE 10 	//size of Buffer
#define MEM_SIZE 40	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "../x86_tso_buffer.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
// ----standard stack implementation-------------

//abstract Stack implemented as array----------------------
#define ASSIZE 4
short asStack[ASSIZE];
hidden byte asTop = 0;

//asValue the value we expect to be on top of the stack
inline asPop(asValue, asReturn)
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
	atomic{
	assert(asTop < ASSIZE); //make sure, stack array is never full
	asStack[asTop] = asValue;
	asTop++;
	}
	//should we return something?
}


inline casLPPop(adr, oldValue, newValue, returnValue) 
{
	// 2 steps for the executing process, but atomic on memory
	bit success;
	ch ! iCas, adr, oldValue, newValue;
	atomic{
	ch ? iCas, adr, success, _; 
	returnValue = success;
	if 
		:: success -> asPop(oldValue, success); //if successfull, then the popped value is the oldValue
		:: else -> skip;
	fi
	 
	}
}


inline casLPPush(adr, oldValue, newValue, returnValue, controlValue) 
{
	// 2 steps for the executing process, but atomic on memory
	bit success;
	ch ! iCas, adr, oldValue, newValue;
	atomic{
	ch ? iCas, adr, success, _; 
	returnValue = success;
	if 	:: success -> asPush(controlValue);
		:: else -> skip;
	fi
	}
}



//Types for LLVM, actually their length in size of pointers and values
#define Stack  0 	//= {0};
#define Node  1	//= {0,1};
#define I32  0 		// = {0};
#define Ptr  0
short memUse = 1; 	//shows to the next free cell in memory
byte this; 		//Stack instance pointer

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

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

inline alloca(type, targetRegister)
{
	atomic{
	//need c_Code here, but for now we could use this to statically define used addresses
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}
//-----------------------------------------------------------------------------------------------------------
//------push-optimized--------
inline push(this, v){

short this_addr,v_addr, n, ss, v0, v1, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v16, v18, v19, v21;

entry: 
atomic{
	alloca(Ptr, this_addr);
	alloca(I32, v_addr);
	alloca(Ptr, v0);
	alloca(Ptr, n);
	alloca(Ptr, ss);
	
}
	write(this_addr, this);
	write(v_addr, v);
	
	alloca(Node, v1)
	// %1 = call i8* @_Znwj(i32 8)                     ; <i8*> [#uses=1]
  	// %2 = bitcast i8* %1 to %struct.Node*            ; <%struct.Node*> [#uses=1]
  	// store %struct.Node* %2, %struct.Node** %0, align 4
  	write (v0, v1);
  
	read(v0, v3);
	
	read(v0, v4);
	write(n, v4);
	read(n, v5);
	getelementptr(Node,v5,0,v6);
	read(v_addr, v7);
	write(v6,v7)
	->
bb:
	read(this_addr, v8);
	getelementptr(Stack, v8, 0, v9);
	read(v9, v10);				
	write(ss, v10);
	read(n, v11);
	getelementptr(Node, v11, 1, v12)
	read(ss, v13)
	write(v12, v13);
	read(n, v14);
	read(ss, v16);
	read(this_addr, v18);
	getelementptr(Stack, v18, 0, v19);
	casLPPush(v19, v16, v14, v21, v);		// v21= CAS(this_addr,ss, n) 
	
	if 
		:: v21 == false -> goto bb;
		:: else -> skip;
	fi;
}



//-----------------------------------------------------------------------------------------------------------
//------pop-optimized--------
inline pop (returnvalue){

short this_addr, retval, ss, ssn, v0, v1, v2, v3, v4, v6, v7, v8, v9, v11, v13, v14, v16, v20, v21;

entry:
atomic{
	alloca(Ptr, this_addr);
	alloca(Ptr, retval);
	alloca(Ptr, v0);
	alloca(Ptr, ss);
	alloca(Ptr, ssn);
}
	write(this_addr, this);
	
bb:
	read(this_addr, v1);
	getelementptr(Stack, v1, 0, v2);
	read(v2, v3);
	write(ss, v3);
	read(ss, v4);
	if
	:: v4 == NULL -> write(v0, NULL); goto bb6;
	:: else -> goto bb2;
	fi;
	
bb2:
	read(ss, v6);
	getelementptr(Node, v6, 1, v7);
	read(v7, v8);
	write(ssn, v8);
	read(ssn, v9);
	read(ss, v11);
	read(this_addr, v13);
	getelementptr(Stack, v13, 0, v14);
	casLPPop (v14, v11, v9, v16);
	if
	:: v16 == false -> goto bb;
	:: else skip;
	fi
	->

bb5:
	read(ss, v20);
	write(v0, v20)
	->

bb6:
	read(v0, v21);
	write(retval, v21)
	->
	
retLabel:
	read(retval, returnvalue);

}
//-----------------------------------------------------------------------------------------------------------


proctype process1(chan ch){
	short returnvalue;
	//pop(returnvalue);
	push(this, 666);
	push(this, 444);
	pop(returnvalue);
}

proctype process2(chan ch){
	//push(this, 555);

	//push(this, 111);
	skip;
}

init{
atomic{
	alloca(Stack, this)
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
}
	
	
	
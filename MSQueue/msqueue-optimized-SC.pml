
#define MEM_SIZE 40	//size of memory
#define NULL 0
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "sc-model.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------


//Types for LLVM, actually their length in size of pointers and values
#define MSQueue  1 	//= {0};
#define Node  1	//= {0,1};
short memUse = 1; 	//shows to the next free cell in memory
byte this; 		//Queue instance pointer

inline casNoRet(adr, oldValue, newValue) {
	atomic{
		if 	:: memory[adr] == oldValue
				-> {
					memory[adr] = newValue;
					}
			:: else -> skip;
		fi;
	}
}


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

//--------------------------------------------------------------------------------------------------------------
//------------ enqueue optimized ----------------
inline enqueue (this, value){	// enqueue element v at the end of the queue

short tail, node, v0, v1, v3, v4, v5, v6, v7, v11, v13, next3, next2;
invoke_content:


	alloca(Node, node);
	write(node, value);
	atomic{	
	getelementptr(Node, node, 1, next2);
	write(next2, NULL);
	getelementptr(MSQueue, this, 1, tail);
	}

doBody:
	atomic{
	read(tail, v3);
	getelementptr(Node, v3, 1, next3);
	}
	read(next3, v4);
	read(tail, v5);
	if
	:: v3 == v5 -> goto if_then;
	:: else -> goto doBody;
	fi;
	
if_then:
	if
	::v4 == NULL -> goto if_then6;
	:: else -> goto if_else;
	fi;
	
if_then6:
	// %7 = cmpxchg i32* %6, i32 0, i32 %1 seq_cst
	cas(next3, v4, node, v7)				//v4???? because cpp code:CAS(&localTail->next, next, node)
	if
		:: v7 	-> goto do_end;
		::else 	-> goto doBody;
	fi;
	
if_else:
	cas(tail, v3, v4, v11);
	goto doBody;
	
do_end:
	cas(tail, v3, v1, v13);
	
}

//--------------------------------------------------------------------------------------------------------------
// ---------- dequeue optimized --------------

inline dequeue(this, val, retvalue){			// dequeues first element in queue
short head, tail, next2, v2, v3, v4, v12;

entry: 
	atomic{
	getelementptr(MSQueue, this, 0, head);		
	getelementptr(MSQueue, this, 1, tail);
	}
	
doBody:
	read(head, v2);
	read(tail, v3);
	atomic{
	getelementptr(Node, v2, 1, next2);
	read(next2, v4);
	}
	//read(head, v5);								
	if
		:: v2 == v3 -> goto ifThen5;
		:: else -> goto ifElse;
	fi;
	
ifThen5:
	if
		:: v4 == NULL -> retvalue = false; goto ret;
		:: else -> 	casNoRet(tail, v2, v4);
				goto doBody;
	fi;
			
ifElse:	
	atomic{
	getelementptr(Node, v4, 0, val);
	read(val, val);
	}
	//write(v, v9);
	cas(this, v2, v4, v12);
	if
		:: v12 -> retvalue = true; goto ret;
		:: else -> goto doBody;
	fi;



ret: skip;

}	

//------------------------------------------------------------------------------
	
proctype process1(){
	short returnvalue;
	bit success;
	enqueue(this, 222);
}

proctype process2(){
	short returnvalue;
	bit success;
	dequeue(this, returnvalue, success);
	
}

init{
atomic{
	alloca(MSQueue, this)
	alloca(Node, memory[1]);
	memory[2] = memory[1];
	run process1();
	run process2();
	}
}
	
	
	
	
	
	
	
	
	
	
	
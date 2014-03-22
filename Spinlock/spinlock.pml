
#define BUFF_SIZE 2 	//size of Buffer
#define MEM_SIZE 5	//size of memory

//have to define this abstract stuff up here, since buffer-spec has to use it 
short asOwner = -1;
inline asRel() 
{
	atomic
	{
		assert (asOwner == _pid - 1);  //bufferProc is always program proc + 1 and this is checked by buffer proc only
		asOwner = -1;
	}
}

inline asTryAq(result)
{
	atomic{
	if
		:: result -> assert(asOwner == -1); asOwner = _pid;
		:: else -> assert(asOwner != _pid);
	fi;
	}
}

inline asAq()
{
	atomic
	{
		assert(asOwner == -1); 
		asOwner = _pid;
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "spinlock-instrumented-TSO.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------




//Types for LLVM, actually their length in size of pointers and values
#define Ptr  0
#define X 1
short memUse = 1; 	//shows to the next free cell in memory
short crit = 0;


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







inline casAqSucc(adr, oldValue, newValue, returnValue) 
{
	// 2 steps for the executing process, but atomic on memory
	bit success;
	ch ! iCas, adr, oldValue, newValue;
	atomic{
	ch ? iCas, adr, success, _; 
	returnValue = success;
	if 
		:: success -> asAq(); 
		:: else -> skip;
	fi
	 
	}
}

inline casTryAqSucc(adr, oldValue, newValue, returnValue) 
{
	// 2 steps for the executing process, but atomic on memory
	bit success;
	ch ! iCas, adr, oldValue, newValue;
	atomic{
	ch ? iCas, adr, success, _; 
	returnValue = success;
	if 
		:: success -> asTryAq(success); 
		:: else -> skip;
	fi
	 
	}
}

inline aquire()
{
	bit succ;
	whileBegin: casAqSucc(X, 1, 0, succ);
	if
		:: !succ -> goto whileBegin;
		:: else -> skip;
	fi
}

inline release()
{
	writeLP(X,1,1);   //third param is indicating that it is an LP
}

inline tryaquire(result)
{
	bit succ;
	casTryAqSucc(X, 1, 0, succ);
	result = succ;
}

init{
atomic{
	memory[X] = 1;
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
}

short sharedX = 2, sharedY = 3;
short a,b;


proctype process1(chan ch){
	aquire();
	write(sharedX, 1)
	release();
	read(sharedY, b);
end: skip;
}

proctype process2(chan ch){
	//memory[sharedY] = 1; //atomic write
	write(sharedY, 1);
	aquire();
	read(sharedX,a);
	release();
end: skip;
}

ltl C1 { [] ((process1 @ end && process2 @ end) -> (a!=0 || b!=0))}

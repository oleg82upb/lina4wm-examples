#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory

//abstract Stack implemented as array----------------------
#define ASSIZE 7
short asStack[ASSIZE];
hidden byte asTop = 0;

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
	target = memory[adr];
	//target = readValue;
	if 
		:: target == null -> asPopFail();
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
		:: success == oldValue-> asPop(oldValue); //if successfull, then the popped value is the oldValue
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
	if 	:: success == oldValue -> asPush(controlValue);
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


//function was renamed from: @_ZN5Stack4pushEi
inline push(this, v){
short call, val, head, next, v0, v1, v2, v3, v4, v5, v6;
AStart: goto A00;
A00: alloca(2, call); goto A01; 
A01: val = call; goto A02; 
A02: goto A03val; 
A03val: 
	if 
	:: getelementptr(1, this, 0, head); goto A04val; 
	:: memory[val] = v; goto A03; 
	fi;
A04val: 
	if 
	:: getelementptr(1, call, 1, next);  /*Needs attention due to different types of first index and aggregate.*/ goto A05val; 
	:: memory[val] = v; goto A04; 
	fi;
A03: getelementptr(1, this, 0, head); goto A04; 
A05val: 
	if 
	:: v0 = next; goto A06val; 
	:: memory[val] = v; goto A05; 
	fi;
A04: getelementptr(1, call, 1, next);  /*Needs attention due to different types of first index and aggregate.*/ goto A05; 
A06val: 
	if 
	:: v1 = this; goto A07val; 
	:: memory[val] = v; goto A06; 
	fi;
A05: v0 = next; goto A06; 
A07val: 
	if 
	:: v2 = call; goto A08val; 
	:: memory[val] = v; goto A07; 
	fi;
A06: v1 = this; goto A07; 
A08val: 
	if 
	:: goto A09val; 
	:: memory[val] = v; goto A08; 
	fi;
A07: v2 = call; goto A08; 
A09val: 
	if 
	:: v3 = memory[head]; goto A10val; 
	:: memory[val] = v; goto A09; 
	fi;
A08: goto A09; 
A10val: 
	if 
	:: goto A11valv0; 
	:: memory[val] = v; goto A10; 
	fi;
A09: v3 = memory[head]; goto A10; 
A11valv0: 
	if 
	:: v4 = v3; goto A12valv0; 
	:: memory[val] = v; goto A11v0; 
	fi;
A10: goto A11v0; 
A12valv0: memory[val] = v; goto A12v0; 
A11v0: 
	if 
	:: v4 = v3; goto A12v0; 
	:: memory[v0] = v3; goto A11; 
	fi;
A12v0: memory[v0] = v3; goto A12; 
A11: v4 = v3; goto A12; 
A12: casLPPush(v1, v4, v2, v5, v)  goto A13; 		//LP
A13: v6 = (v5 == v4); goto A14; 
A14: 
	if 
	::v6 -> goto A15; 
	::!v6 -> goto A09; 
	fi;
A15: goto AEnd;
AEnd: skip;

}

//function was renamed from: @_ZN5Stack3popEv
inline pop(this, returnvalue){
short head, v0, v1, cmp, retval_0, next, v2, v3, v4, v5, v6;
BStart: goto B00;
B00: getelementptr(1, this, 0, head); goto B01; 
B01: v0 = this; goto B02; 
B02: goto B03; 
B03: readLPPopFail(head, v1); goto B04; 				//LP if failing
B04: cmp = (v1 == null); goto B05; 
B05: 
	if 
	::cmp -> retval_0 = null; goto B13; 
	::!cmp -> goto B06; 
	fi;
B13: goto B14; 
B06: getelementptr(2, v1, 1, next); goto B07; 
B14: returnvalue = retval_0; goto BEnd;
B07: v2 = memory[next]; goto B08; 
B08: v3 = v1; goto B09; 
B09: v4 = v2; goto B10; 
B10: casLPPop(v0, v3, v4, v5); goto B11; 			//LP success
B11: v6 = (v5 == v3); goto B12; 
B12: 
	if 
	::v6 -> retval_0 = v1; goto B13; 
	::!v6 -> goto B03; 
	fi;
BEnd: skip;

}


byte this;
//Stubs
proctype process1(){
	short returnvalue;
	push(this, 111);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 222 || memory[returnvalue] == 223);
	push(this, 112);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222  || memory[returnvalue] == 223);
}

proctype process2(){
	short returnvalue;
	push(this, 222);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222);
	push(this, 223);
	pop(this, returnvalue);
	//assert(memory[returnvalue] == 111 || memory[returnvalue] == 112 || memory[returnvalue] == 222 || memory[returnvalue] == 223);
}

 
proctype process3(){
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

proctype process4(){
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
	
	alloca(PTR, this)//create share pointer "this" 
	run process3();
	run process4();
	}
}

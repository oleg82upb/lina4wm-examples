#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory




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
//Note, LLVM returns a tuple (i32, i1), the value read and a success bit.
//Sometimes the follow up code uses the succes bit but usually the read value. 
//Adjust CAS semantics, if necessary.
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



inline ZN5StackC2Ev(this){
short head;
AStart: goto A0;
A0: getelementptr(1, this, 0, head); goto A1; 
A1: goto A2; 
A2: goto AEnd;
AEnd: skip;

}


inline ZN5Stack4pushEi(this, v){
short call, val, head, next, v0, v1, v2, v3, v4, v5, v6;
BStart: goto B00;
B00: Znwj(8, call); goto B01; 
B01: val = call; goto B02; 
B02: goto B03; 
B03: getelementptr(1, this, 0, head); goto B04; 
B04: getelementptr(1, call, 1, next);  /*Needs attention as first index is not 0!*/ goto B05; 
B05: v0 = next; goto B06; 
B06: v1 = this; goto B07; 
B07: v2 = call; goto B08; 
B08: goto B09; 
B09: v3 = memory[head]; goto B10; 
B10: goto B11; 
B11: v4 = v3; goto B12; 
B12: cas(v1, v4, v2, v5); goto B13; 
B13: v6 = (v5 == v4); goto B14; 
B14: 
	if 
	::v6 -> goto B15; 
	::!v6 -> goto B09; 
	fi;
B15: goto BEnd;
BEnd: skip;

}


inline ZN5Stack3popEv(this, returnvalue){
short head, v0, v1, cmp, retval_0, next, v2, v3, v4, v5, v6;
CStart: goto C00;
C00: getelementptr(1, this, 0, head); goto C01; 
C01: v0 = this; goto C02; 
C02: goto C03; 
C03: v1 = memory[head]; goto C04; 
C04: cmp = (v1 == null); goto C05; 
C05: 
	if 
	::cmp -> retval_0 = null; goto C13; 
	::!cmp -> goto C06; 
	fi;
C13: goto C14; 
C06: getelementptr(2, v1, 1, next); goto C07; 
C14: returnvalue = retval_0; goto CEnd;
C07: v2 = memory[next]; goto C08; 
C08: v3 = v1; goto C09; 
C09: v4 = v2; goto C10; 
C10: cas(v0, v3, v4, v5); goto C11; 
C11: v6 = (v5 == v3); goto C12; 
C12: 
	if 
	::v6 -> retval_0 = v1; goto C13; 
	::!v6 -> goto C03; 
	fi;
CEnd: skip;

}


//Stubs
proctype process1(){
	//TODO: empty stub
}

proctype process2(){
	//TODO: empty stub
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	

	run process1();
	run process2();
	}
}

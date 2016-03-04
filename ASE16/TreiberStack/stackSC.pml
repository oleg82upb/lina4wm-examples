#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory




//standard stuff
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
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}
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
A00: Znwj(8, call); goto A01; 
A01: val = call; goto A02; 
A02: goto A03; 
A03: getelementptr(0, this, 0, head); goto A04; 
A04: getelementptr(0, call, 1, next);  /*Needs attention due to different types of first index and aggregate.*/ goto A05; 
A05: v0 = next; goto A06; 
A06: v1 = this; goto A07; 
A07: v2 = call; goto A08; 
A08: goto A09; 
A09: v3 = memory[head]; goto A10; 
A10: goto A11; 
A11: v4 = v3; goto A12; 
A12: cas(v1, v4, v2, v5); goto A13; 
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
B00: getelementptr(0, this, 0, head); goto B01; 
B01: v0 = this; goto B02; 
B02: goto B03; 
B03: v1 = memory[head]; goto B04; 
B04: cmp = (v1 == null); goto B05; 
B05: 
	if 
	::cmp -> retval_0 = null; goto B13; 
	::!cmp -> goto B06; 
	fi;
B13: goto B14; 
B06: getelementptr(1, v1, 1, next); goto B07; 
B14: returnvalue = retval_0; goto BEnd;
B07: v2 = memory[next]; goto B08; 
B08: v3 = v1; goto B09; 
B09: v4 = v2; goto B10; 
B10: cas(v0, v3, v4, v5); goto B11; 
B11: v6 = (v5 == v3); goto B12; 
B12: 
	if 
	::v6 -> retval_0 = v1; goto B13; 
	::!v6 -> goto B03; 
	fi;
BEnd: skip;

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
	//TODO: empty stub

	run process1();
	run process2();
	}
}

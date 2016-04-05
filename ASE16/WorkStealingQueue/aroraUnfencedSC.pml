#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short bot = null;
short deq = null;
short age = null;
short top = null;


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



inline push(elem){
short v0, v1, v2, arrayidx, inc;
AStart: goto A0;
A0: v0 = memory[bot]; goto A1; 
A1: v1 = memory[v0]; goto A2; 
A2: v2 = memory[deq]; goto A3; 
A3: getelementptr(1, v2, v1, arrayidx); goto A4; 
A4: goto A5; 
A5: inc = v1 + 1; goto A6; 
A6: goto A7; 
A7: goto AEnd;
AEnd: skip;

}


inline dequeue(returnvalue){
short v0, v1, v2, v3, shr, cmp, v4, retval_0, _, arrayidx, v5, add5, v6, v7;
BStart: goto B00;
B00: v0 = memory[age]; goto B01; 
B01: v1 = memory[v0]; goto B02; 
B02: v2 = memory[bot]; goto B03; 
B03: v3 = memory[v2]; goto B04; 
B04: shr = v1 >> 16; goto B05; 
B05: cmp = (v3 > shr); goto B06; 
B06: 
	if 
	::cmp -> goto B07; 
	::!cmp -> retval_0 = -1; goto B15; 
	fi;
B07: v4 = memory[deq]; goto B08; 
B15: goto B16; 
B08: getelementptr(1, v4, shr, arrayidx); goto B09; 
B16: returnvalue = retval_0; goto BEnd;
B09: v5 = memory[arrayidx]; goto B10; 
B10: add5 = v1 + 65536; goto B11; 
B11: cas(v0, v1, add5, v6); goto B12; 
B12: v7 = (v6 == v1); goto B13; 
B13: _ = (v7 -> v5 : -2); goto B14; 
B14: retval_0 = _; goto B15; 
BEnd: skip;

}


inline pop(returnvalue){
short v0, v1, cmp, retval_0, v3, dec, v2, arrayidx, v4, v5, shr, cmp1, and, add, cmp5, v6, v8, _pre, v7;
CStart: goto C00;
C00: v0 = memory[bot]; goto C01; 
C01: v1 = memory[v0]; goto C02; 
C02: cmp = (v1 == 0); goto C03; 
C03: 
	if 
	::cmp -> retval_0 = -1; goto C27; 
	::!cmp -> goto C04; 
	fi;
C27: goto C28; 
C04: dec = v1 + -1; goto C05; 
C28: returnvalue = retval_0; goto CEnd;
C05: goto C06; 
C06: v2 = memory[deq]; goto C07; 
C07: getelementptr(1, v2, dec, arrayidx); goto C08; 
C08: v3 = memory[arrayidx]; goto C09; 
C09: v4 = memory[age]; goto C10; 
C10: v5 = memory[v4]; goto C11; 
C11: shr = v5 >> 16; goto C12; 
C12: cmp1 = (dec > shr); goto C13; 
C13: 
	if 
	::cmp1 -> retval_0 = v3; goto C27; 
	::!cmp1 -> goto C14; 
	fi;
C14: goto C15; 
C15: and = v5 & 65535; goto C16; 
C16: add = and + 1; goto C17; 
C17: cmp5 = (dec == shr); goto C18; 
C18: 
	if 
	::cmp5 -> goto C19; 
	::!cmp5 -> v8 = v4; goto C24; 
	fi;
C19: cas(v4, v5, add, v6); goto C20; 
C24: goto C25; 
C20: v7 = (v6 == v5); goto C21; 
C25: goto C26; 
C21: 
	if 
	::v7 -> retval_0 = v3; goto C27; 
	::!v7 -> goto C22; 
	fi;
C26: retval_0 = -1; goto C27; 
C22: _pre = memory[age]; goto C23; 
C23: v8 = _pre; goto C24; 
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
	alloca(1, bot);
	alloca(1, deq);
	alloca(1, age);
	alloca(1, top);
	

	run process1();
	run process2();
	}
}

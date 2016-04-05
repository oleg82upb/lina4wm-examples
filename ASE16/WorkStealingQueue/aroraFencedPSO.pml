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
AStart: goto A00;
A00: v0 = memory[bot]; goto A01; 
A01: v1 = memory[v0]; goto A02; 
A02: v2 = memory[deq]; goto A03; 
A03: getelementptr(1, v2, v1, arrayidx); goto A04; 
A04: goto A05arrayidx; 
A05arrayidx: 
	if 
	:: inc = v1 + 1; goto A06arrayidx; 
	:: memory[arrayidx] = elem; goto A05; 
	fi;
A06arrayidx: 
	if 
	:: goto A07arrayidxv0; 
	:: memory[arrayidx] = elem; goto A06; 
	fi;
A05: inc = v1 + 1; goto A06; 
A07arrayidxv0: 
	if 
	:: memory[arrayidx] = elem; goto A07v0; 
	:: memory[v0] = inc; goto A07arrayidx; 
	fi;
A06: goto A07v0; 
A07v0: memory[v0] = inc; goto A07; 
A07arrayidx: memory[arrayidx] = elem; goto A07; 
A07: goto AEnd;
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
short v0, v1, cmp, retval_0, v3, dec, v2, arrayidx, v4, v5, shr, cmp1, and, add, cmp5, v8, _pre, v6, v7;
CStart: goto C00;
C00: v0 = memory[bot]; goto C01; 
C01: v1 = memory[v0]; goto C02; 
C02: cmp = (v1 == 0); goto C03; 
C03: 
	if 
	::cmp -> retval_0 = -1; goto C28; 
	::!cmp -> goto C04; 
	fi;
C28: goto C29; 
C04: dec = v1 + -1; goto C05; 
C29: returnvalue = retval_0; goto CEnd;
C05: goto C06v0; 
C06v0: 
	if 
	:: v2 = memory[deq]; goto C07v0; 
	:: memory[v0] = dec; goto C06; 
	fi;
C07v0: 
	if 
	:: getelementptr(1, v2, dec, arrayidx); goto C08v0; 
	:: memory[v0] = dec; goto C07; 
	fi;
C06: v2 = memory[deq]; goto C07; 
C08v0: 
	if 
	:: v3 = memory[arrayidx]; goto C09v0; 
	:: memory[v0] = dec; goto C08; 
	fi;
C07: getelementptr(1, v2, dec, arrayidx); goto C08; 
C09v0: 
	if 
	:: v4 = memory[age]; goto C10v0; 
	:: memory[v0] = dec; goto C09; 
	fi;
C08: v3 = memory[arrayidx]; goto C09; 
C10v0: memory[v0] = dec; goto C10; 
C09: v4 = memory[age]; goto C10; 
C10: goto C11; 
C11: v5 = memory[v4]; goto C12; 
C12: shr = v5 >> 16; goto C13; 
C13: cmp1 = (dec > shr); goto C14; 
C14: 
	if 
	::cmp1 -> retval_0 = v3; goto C28; 
	::!cmp1 -> goto C15; 
	fi;
C15: goto C16v0; 
C16v0: 
	if 
	:: and = v5 & 65535; goto C17v0; 
	:: memory[v0] = 0; goto C16; 
	fi;
C17v0: 
	if 
	:: add = and + 1; goto C18v0; 
	:: memory[v0] = 0; goto C17; 
	fi;
C16: and = v5 & 65535; goto C17; 
C18v0: 
	if 
	:: cmp5 = (dec == shr); goto C19v0; 
	:: memory[v0] = 0; goto C18; 
	fi;
C17: add = and + 1; goto C18; 
C19v0: 
	if 
	::cmp5 -> goto C20v0; 
	::!cmp5 -> v8 = v4; goto C25v0; 
	:: memory[v0] = 0; goto C19; 
	fi;
C18: cmp5 = (dec == shr); goto C19; 
C20v0: memory[v0] = 0; goto C20; 
C25v0: 
	if 
	:: goto C26v0; 
	:: memory[v0] = 0; goto C25; 
	fi;
C19: 
	if 
	::cmp5 -> goto C20; 
	::!cmp5 -> v8 = v4; goto C25; 
	fi;
C20: cas(v4, v5, add, v6); goto C21; 
C26v0: 
	if 
	:: goto C27v0v8; 
	:: memory[v0] = 0; goto C26; 
	fi;
C25: goto C26; 
C21: v7 = (v6 == v5); goto C22; 
C27v0v8: 
	if 
	:: retval_0 = -1; goto C28v0v8; 
	:: memory[v0] = 0; goto C27v8; 
	:: memory[v8] = add; goto C27v0; 
	fi;
C26: goto C27v8; 
C22: 
	if 
	::v7 -> retval_0 = v3; goto C28; 
	::!v7 -> goto C23; 
	fi;
C28v0v8: 
	if 
	:: goto C29v0v8; 
	:: memory[v0] = 0; goto C28v8; 
	:: memory[v8] = add; goto C28v0; 
	fi;
C27v8: 
	if 
	:: retval_0 = -1; goto C28v8; 
	:: memory[v8] = add; goto C27; 
	fi;
C27v0: 
	if 
	:: retval_0 = -1; goto C28v0; 
	:: memory[v0] = 0; goto C27; 
	fi;
C23: _pre = memory[age]; goto C24; 
C29v0v8: 
	if 
	:: memory[v0] = 0; goto C29v8; 
	:: memory[v8] = add; goto C29v0; 
	fi;
C28v8: 
	if 
	:: goto C29v8; 
	:: memory[v8] = add; goto C28; 
	fi;
C28v0: 
	if 
	:: goto C29v0; 
	:: memory[v0] = 0; goto C28; 
	fi;
C27: retval_0 = -1; goto C28; 
C24: v8 = _pre; goto C25; 
C29v8: memory[v8] = add; goto C29; 
C29v0: memory[v0] = 0; goto C29; 
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

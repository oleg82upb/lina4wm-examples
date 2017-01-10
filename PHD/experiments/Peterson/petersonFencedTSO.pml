#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short turn = null;
short mtxOwner = 0;

inline acquire(pid)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = pid;
	 }
}

inline release(pid)
{
	atomic{
	 assert(mtxOwner == pid);
	 mtxOwner = 0;
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



inline p0(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02v0; 
A02v0: 
	if 
	:: v1 = memory[turn]; goto A03v0; 
	:: memory[v0] = 1; goto A02; 
	fi;
A03v0: memory[v0] = 1; goto A03; 
A02: v1 = memory[turn]; goto A03; 
A03: goto A04; 
A04: goto A05v1; 
A05v1: memory[v1] = 1; goto A05; 
A05: goto A06; 
A06: goto A07; 
A07: v2 = memory[flag1]; goto A08; 
A08: v3 = memory[v2]; goto A09; 
A09: tobool = v3; goto A10; 
A10: conv = tobool; goto A11; 
A11: cmp = (conv == 1); goto A12; 
A12: 
	if 
	::cmp -> goto A13; 
	::!cmp -> v6 = false; goto A19; 
	fi;
A13: v4 = memory[turn]; goto A14; 
A19: goto A20; 
A14: v5 = memory[v4]; goto A15; 
A20: 
	if 
	::v6 -> acquire(_pid); goto A21; 
	::!v6 -> goto A22; 
	fi;
A15: tobool2 = v5; goto A16; 
A21: release(_pid); goto A07; 
A22: v7 = memory[flag0]; goto A23; 
A16: conv3 = tobool2; goto A17; 
A23: goto A24v7; 
A17: cmp4 = (conv3 == 1); goto A18; 
A24v7: memory[v7] = 0; goto A24; 
A18: v6 = cmp4; goto A19; 
A24: goto AEnd;
AEnd: skip;

}


inline p1(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02v0; 
B02v0: 
	if 
	:: v1 = memory[turn]; goto B03v0; 
	:: memory[v0] = 1; goto B02; 
	fi;
B03v0: memory[v0] = 1; goto B03; 
B02: v1 = memory[turn]; goto B03; 
B03: goto B04; 
B04: goto B05v1; 
B05v1: memory[v1] = 0; goto B05; 
B05: goto B06; 
B06: goto B07; 
B07: v2 = memory[flag0]; goto B08; 
B08: v3 = memory[v2]; goto B09; 
B09: tobool = v3; goto B10; 
B10: conv = tobool; goto B11; 
B11: cmp = (conv == 1); goto B12; 
B12: 
	if 
	::cmp -> goto B13; 
	::!cmp -> v6 = false; goto B19; 
	fi;
B13: v4 = memory[turn]; goto B14; 
B19: goto B20; 
B14: v5 = memory[v4]; goto B15; 
B20: 
	if 
	::v6 -> acquire(_pid); goto B21; 
	::!v6 -> goto B22; 
	fi;
B15: tobool2 = v5; goto B16; 
B21: release(_pid); goto B07; 
B22: v7 = memory[flag1]; goto B23; 
B16: conv3 = tobool2; goto B17; 
B23: goto B24v7; 
B17: cmp4 = (conv3 == 0); goto B18; 
B24v7: memory[v7] = 0; goto B24; 
B18: v6 = cmp4; goto B19; 
B24: goto BEnd;
BEnd: skip;

}


//Stubs
proctype process1(){
	p0();
}

proctype process2(){
	p1();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	alloca(1, turn);
	//two layers of pointers need initialization
	memory[flag0] = 4;
	memory[flag1] = 5;
	memory[turn] = 6;
	run process1();
	run process2();
	}
}
ltl prop{ [] !((process1@A21) && (process2@B21))}
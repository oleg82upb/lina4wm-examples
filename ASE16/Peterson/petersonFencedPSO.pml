#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short turn = null;


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
A03v0: 
	if 
	:: goto A04v0v1; 
	:: memory[v0] = 1; goto A03; 
	fi;
A02: v1 = memory[turn]; goto A03; 
A04v0v1: 
	if 
	:: memory[v0] = 1; goto A04v1; 
	:: memory[v1] = 1; goto A04v0; 
	fi;
A03: goto A04v1; 
A04v1: memory[v1] = 1; goto A04; 
A04v0: memory[v0] = 1; goto A04; 
A04: goto A05; 
A05: goto A06; 
A06: v2 = memory[flag1]; goto A07; 
A07: v3 = memory[v2]; goto A08; 
A08: tobool = v3; goto A09; 
A09: conv = tobool; goto A10; 
A10: cmp = (conv == 1); goto A11; 
A11: 
	if 
	::cmp -> goto A12; 
	::!cmp -> v6 = false; goto A18; 
	fi;
A12: v4 = memory[turn]; goto A13; 
A18: goto A19; 
A13: v5 = memory[v4]; goto A14; 
A19: 
	if 
	::v6 -> goto A20; 
	::!v6 -> goto A21; 
	fi;
A14: tobool2 = v5; goto A15; 
A20: goto A06; 
A21: v7 = memory[flag0]; goto A22; 
A15: conv3 = tobool2; goto A16; 
A22: goto A23v7; 
A16: cmp4 = (conv3 == 1); goto A17; 
A23v7: memory[v7] = 0; goto A23; 
A17: v6 = cmp4; goto A18; 
A23: goto AEnd;
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
B03v0: 
	if 
	:: goto B04v0v1; 
	:: memory[v0] = 1; goto B03; 
	fi;
B02: v1 = memory[turn]; goto B03; 
B04v0v1: 
	if 
	:: memory[v0] = 1; goto B04v1; 
	:: memory[v1] = 0; goto B04v0; 
	fi;
B03: goto B04v1; 
B04v1: memory[v1] = 0; goto B04; 
B04v0: memory[v0] = 1; goto B04; 
B04: goto B05; 
B05: goto B06; 
B06: v2 = memory[flag0]; goto B07; 
B07: v3 = memory[v2]; goto B08; 
B08: tobool = v3; goto B09; 
B09: conv = tobool; goto B10; 
B10: cmp = (conv == 1); goto B11; 
B11: 
	if 
	::cmp -> goto B12; 
	::!cmp -> v6 = false; goto B18; 
	fi;
B12: v4 = memory[turn]; goto B13; 
B18: goto B19; 
B13: v5 = memory[v4]; goto B14; 
B19: 
	if 
	::v6 -> goto B20; 
	::!v6 -> goto B21; 
	fi;
B14: tobool2 = v5; goto B15; 
B20: goto B06; 
B21: v7 = memory[flag1]; goto B22; 
B15: conv3 = tobool2; goto B16; 
B22: goto B23v7; 
B16: cmp4 = (conv3 == 0); goto B17; 
B23v7: memory[v7] = 0; goto B23; 
B17: v6 = cmp4; goto B18; 
B23: goto BEnd;
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
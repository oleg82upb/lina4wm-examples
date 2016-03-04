#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short turn = null;


//standard stuff
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline p0(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02; 
A02: v1 = memory[turn]; goto A03; 
A03: goto A04; 
A04: goto A05; 
A05: v2 = memory[flag1]; goto A06; 
A06: v3 = memory[v2]; goto A07; 
A07: tobool = v3; goto A08; 
A08: conv = tobool; goto A09; 
A09: cmp = (conv == 1); goto A10; 
A10: 
	if 
	::cmp -> goto A11; 
	::!cmp -> v6 = false; goto A17; 
	fi;
A11: v4 = memory[turn]; goto A12; 
A17: goto A18; 
A12: v5 = memory[v4]; goto A13; 
A18: 
	if 
	::v6 -> goto A19; 
	::!v6 -> goto A20; 
	fi;
A13: tobool2 = v5; goto A14; 
A19: goto A05; 
A20: v7 = memory[flag0]; goto A21; 
A14: conv3 = tobool2; goto A15; 
A21: goto A22; 
A15: cmp4 = (conv3 == 1); goto A16; 
A22: goto AEnd;
A16: v6 = cmp4; goto A17; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: v1 = memory[turn]; goto B03; 
B03: goto B04; 
B04: goto B05; 
B05: v2 = memory[flag0]; goto B06; 
B06: v3 = memory[v2]; goto B07; 
B07: tobool = v3; goto B08; 
B08: conv = tobool; goto B09; 
B09: cmp = (conv == 1); goto B10; 
B10: 
	if 
	::cmp -> goto B11; 
	::!cmp -> v6 = false; goto B17; 
	fi;
B11: v4 = memory[turn]; goto B12; 
B17: goto B18; 
B12: v5 = memory[v4]; goto B13; 
B18: 
	if 
	::v6 -> goto B19; 
	::!v6 -> goto B20; 
	fi;
B13: tobool2 = v5; goto B14; 
B19: goto B05; 
B20: v7 = memory[flag1]; goto B21; 
B14: conv3 = tobool2; goto B15; 
B21: goto B22; 
B15: cmp4 = (conv3 == 0); goto B16; 
B22: goto BEnd;
B16: v6 = cmp4; goto B17; 
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

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
short v0, v1, v2, tobool, v3, v9, v4, tobool1, v10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02; 
A02: goto A03; 
A03: v1 = memory[flag1]; goto A04; 
A04: v2 = memory[v1]; goto A05; 
A05: tobool = v2; goto A06; 
A06: 
	if 
	::tobool -> goto A07; 
	::!tobool -> goto A27; 
	fi;
A07: v3 = memory[turn]; goto A08; 
A27: v9 = memory[turn]; goto A28; 
A08: v4 = memory[v3]; goto A09; 
A28: goto A29; 
A09: tobool1 = v4; goto A10; 
A29: v10 = memory[flag0]; goto A30; 
A10: conv = tobool1; goto A11; 
A30: goto A31; 
A11: cmp = (conv != 0); goto A12; 
A31: goto AEnd;
A12: 
	if 
	::cmp -> goto A13; 
	::!cmp -> goto A26; 
	fi;
A13: v5 = memory[flag0]; goto A14; 
A26: goto A03; 
A14: goto A15; 
A15: goto A16; 
A16: v6 = memory[turn]; goto A17; 
A17: v7 = memory[v6]; goto A18; 
A18: tobool4 = v7; goto A19; 
A19: conv5 = tobool4; goto A20; 
A20: cmp6 = (conv5 != 0); goto A21; 
A21: 
	if 
	::cmp6 -> goto A22; 
	::!cmp6 -> goto A23; 
	fi;
A22: goto A16; 
A23: v8 = memory[flag0]; goto A24; 
A24: goto A25; 
A25: goto A26; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, v10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: goto B03; 
B03: v1 = memory[flag0]; goto B04; 
B04: v2 = memory[v1]; goto B05; 
B05: tobool = v2; goto B06; 
B06: 
	if 
	::tobool -> goto B07; 
	::!tobool -> goto B27; 
	fi;
B07: v3 = memory[turn]; goto B08; 
B27: v9 = memory[turn]; goto B28; 
B08: v4 = memory[v3]; goto B09; 
B28: goto B29; 
B09: tobool1 = v4; goto B10; 
B29: v10 = memory[flag1]; goto B30; 
B10: conv = tobool1; goto B11; 
B30: goto B31; 
B11: cmp = (conv != 1); goto B12; 
B31: goto BEnd;
B12: 
	if 
	::cmp -> goto B13; 
	::!cmp -> goto B26; 
	fi;
B13: v5 = memory[flag1]; goto B14; 
B26: goto B03; 
B14: goto B15; 
B15: goto B16; 
B16: v6 = memory[turn]; goto B17; 
B17: v7 = memory[v6]; goto B18; 
B18: tobool4 = v7; goto B19; 
B19: conv5 = tobool4; goto B20; 
B20: cmp6 = (conv5 != 1); goto B21; 
B21: 
	if 
	::cmp6 -> goto B22; 
	::!cmp6 -> goto B23; 
	fi;
B22: goto B16; 
B23: v8 = memory[flag1]; goto B24; 
B24: goto B25; 
B25: goto B26; 
BEnd: skip;

}


//Stubs
proctype process1(chan ch){
	p0();
}

proctype process2(chan ch){
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

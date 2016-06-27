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
short v0, v1, v2, tobool, v3, v9, v4, tobool1, 10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02; 
A02: goto A03; 
A03: goto A04; 
A04: v1 = memory[flag1]; goto A05; 
A05: v2 = memory[v1]; goto A06; 
A06: tobool = v2; goto A07; 
A07: 
	if 
	::tobool -> goto A08; 
	::!tobool -> goto A28; 
	fi;
A08: v3 = memory[turn]; goto A09; 
A28: v9 = memory[turn]; goto A29; 
A09: v4 = memory[v3]; goto A10; 
A29: goto A30; 
A10: tobool1 = v4; goto A11; 
A30: 10 = memory[flag0]; goto A31; 
A11: conv = tobool1; goto A12; 
A31: goto A32; 
A12: cmp = (conv != 0); goto A13; 
A32: goto AEnd;
A13: 
	if 
	::cmp -> goto A14; 
	::!cmp -> goto A27; 
	fi;
A14: v5 = memory[flag0]; goto A15; 
A27: goto A03; 
A15: goto A16; 
A16: goto A17; 
A17: v6 = memory[turn]; goto A18; 
A18: v7 = memory[v6]; goto A19; 
A19: tobool4 = v7; goto A20; 
A20: conv5 = tobool4; goto A21; 
A21: cmp6 = (conv5 != 0); goto A22; 
A22: 
	if 
	::cmp6 -> goto A23; 
	::!cmp6 -> goto A24; 
	fi;
A23: goto A17; 
A24: v8 = memory[flag0]; goto A25; 
A25: goto A26; 
A26: goto A27; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, 10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: goto B03; 
B03: goto B04; 
B04: v1 = memory[flag0]; goto B05; 
B05: v2 = memory[v1]; goto B06; 
B06: tobool = v2; goto B07; 
B07: 
	if 
	::tobool -> goto B08; 
	::!tobool -> goto B28; 
	fi;
B08: v3 = memory[turn]; goto B09; 
B28: v9 = memory[turn]; goto B29; 
B09: v4 = memory[v3]; goto B10; 
B29: goto B30; 
B10: tobool1 = v4; goto B11; 
B30: 10 = memory[flag1]; goto B31; 
B11: conv = tobool1; goto B12; 
B31: goto B32; 
B12: cmp = (conv != 1); goto B13; 
B32: goto BEnd;
B13: 
	if 
	::cmp -> goto B14; 
	::!cmp -> goto B27; 
	fi;
B14: v5 = memory[flag1]; goto B15; 
B27: goto B03; 
B15: goto B16; 
B16: goto B17; 
B17: v6 = memory[turn]; goto B18; 
B18: v7 = memory[v6]; goto B19; 
B19: tobool4 = v7; goto B20; 
B20: conv5 = tobool4; goto B21; 
B21: cmp6 = (conv5 != 1); goto B22; 
B22: 
	if 
	::cmp6 -> goto B23; 
	::!cmp6 -> goto B24; 
	fi;
B23: goto B17; 
B24: v8 = memory[flag1]; goto B25; 
B25: goto B26; 
B26: goto B27; 
BEnd: skip;

}


inline main(returnvalue){

CStart: goto C0;
C0: returnvalue = 0; goto CEnd;
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
	alloca(1, flag0);
	alloca(1, flag1);
	alloca(1, turn);
	

	run process1();
	run process2();
	}
}

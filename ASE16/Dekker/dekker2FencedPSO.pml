#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

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
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline p0(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, v10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02v0; 
A02v0: 
	if 
	:: goto A03v0; 
	:: memory[v0] = 1; goto A02; 
	fi;
A03v0: memory[v0] = 1; goto A03; 
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
A29: goto A30v9; 
A10: tobool1 = v4; goto A11; 
A30v9: 
	if 
	:: v10 = memory[flag0]; goto A31v9; 
	:: memory[v9] = 1; goto A30; 
	fi;
A11: conv = tobool1; goto A12; 
A31v9: 
	if 
	:: goto A32v9v10; 
	:: memory[v9] = 1; goto A31; 
	fi;
A30: v10 = memory[flag0]; goto A31; 
A12: cmp = (conv != 0); goto A13; 
A32v9v10: 
	if 
	:: memory[v9] = 1; goto A32v10; 
	:: memory[v10] = 0; goto A32v9; 
	fi;
A31: goto A32v10; 
A13: 
	if 
	::cmp -> goto A14; 
	::!cmp -> goto A27; 
	fi;
A32v10: memory[v10] = 0; goto A32; 
A32v9: memory[v9] = 1; goto A32; 
A14: v5 = memory[flag0]; goto A15; 
A27: goto A03; 
A32: goto AEnd;
A15: goto A16v5; 
A16v5: 
	if 
	:: goto A17v5; 
	:: memory[v5] = 0; goto A16; 
	fi;
A17v5: 
	if 
	:: v6 = memory[turn]; goto A18v5; 
	:: memory[v5] = 0; goto A17; 
	fi;
A16: goto A17; 
A18v5: 
	if 
	:: v7 = memory[v6]; goto A19v5; 
	:: memory[v5] = 0; goto A18; 
	fi;
A17: v6 = memory[turn]; goto A18; 
A19v5: 
	if 
	:: tobool4 = v7; goto A20v5; 
	:: memory[v5] = 0; goto A19; 
	fi;
A18: v7 = memory[v6]; goto A19; 
A20v5: 
	if 
	:: conv5 = tobool4; goto A21v5; 
	:: memory[v5] = 0; goto A20; 
	fi;
A19: tobool4 = v7; goto A20; 
A21v5: 
	if 
	:: cmp6 = (conv5 != 0); goto A22v5; 
	:: memory[v5] = 0; goto A21; 
	fi;
A20: conv5 = tobool4; goto A21; 
A22v5: 
	if 
	::cmp6 -> goto A23v5; 
	::!cmp6 -> goto A24v5; 
	:: memory[v5] = 0; goto A22; 
	fi;
A21: cmp6 = (conv5 != 0); goto A22; 
A23v5: 
	if 
	:: goto A17v5; 
	:: memory[v5] = 0; goto A23; 
	fi;
A24v5: 
	if 
	:: v8 = memory[flag0]; goto A25v5; 
	:: memory[v5] = 0; goto A24; 
	fi;
A22: 
	if 
	::cmp6 -> goto A23; 
	::!cmp6 -> goto A24; 
	fi;
A23: goto A17; 
A25v5: 
	if 
	:: goto A26v5v8; 
	:: memory[v5] = 0; goto A25; 
	fi;
A24: v8 = memory[flag0]; goto A25; 
A26v5v8: 
	if 
	:: goto A27v5v8; 
	:: memory[v5] = 0; goto A26v8; 
	:: memory[v8] = 1; goto A26v5; 
	fi;
A25: goto A26v8; 
A27v5v8: 
	if 
	:: goto A03v5v8; 
	:: memory[v5] = 0; goto A27v8; 
	:: memory[v8] = 1; goto A27v5; 
	fi;
A26v8: 
	if 
	:: goto A27v8; 
	:: memory[v8] = 1; goto A26; 
	fi;
A26v5: 
	if 
	:: goto A27v5; 
	:: memory[v5] = 0; goto A26; 
	fi;
A03v5v8: 
	if 
	:: memory[v5] = 0; goto A03v8; 
	:: memory[v8] = 1; goto A03v5; 
	fi;
A27v8: 
	if 
	:: goto A03v8; 
	:: memory[v8] = 1; goto A27; 
	fi;
A27v5: 
	if 
	:: goto A03v5; 
	:: memory[v5] = 0; goto A27; 
	fi;
A26: goto A27; 
A03v8: memory[v8] = 1; goto A03; 
A03v5: memory[v5] = 0; goto A03; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, v10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02v0; 
B02v0: 
	if 
	:: goto B03v0; 
	:: memory[v0] = 1; goto B02; 
	fi;
B03v0: memory[v0] = 1; goto B03; 
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
B29: goto B30v9; 
B10: tobool1 = v4; goto B11; 
B30v9: 
	if 
	:: v10 = memory[flag1]; goto B31v9; 
	:: memory[v9] = 0; goto B30; 
	fi;
B11: conv = tobool1; goto B12; 
B31v9: 
	if 
	:: goto B32v9v10; 
	:: memory[v9] = 0; goto B31; 
	fi;
B30: v10 = memory[flag1]; goto B31; 
B12: cmp = (conv != 1); goto B13; 
B32v9v10: 
	if 
	:: memory[v9] = 0; goto B32v10; 
	:: memory[v10] = 0; goto B32v9; 
	fi;
B31: goto B32v10; 
B13: 
	if 
	::cmp -> goto B14; 
	::!cmp -> goto B27; 
	fi;
B32v10: memory[v10] = 0; goto B32; 
B32v9: memory[v9] = 0; goto B32; 
B14: v5 = memory[flag1]; goto B15; 
B27: goto B03; 
B32: goto BEnd;
B15: goto B16v5; 
B16v5: 
	if 
	:: goto B17v5; 
	:: memory[v5] = 0; goto B16; 
	fi;
B17v5: 
	if 
	:: v6 = memory[turn]; goto B18v5; 
	:: memory[v5] = 0; goto B17; 
	fi;
B16: goto B17; 
B18v5: 
	if 
	:: v7 = memory[v6]; goto B19v5; 
	:: memory[v5] = 0; goto B18; 
	fi;
B17: v6 = memory[turn]; goto B18; 
B19v5: 
	if 
	:: tobool4 = v7; goto B20v5; 
	:: memory[v5] = 0; goto B19; 
	fi;
B18: v7 = memory[v6]; goto B19; 
B20v5: 
	if 
	:: conv5 = tobool4; goto B21v5; 
	:: memory[v5] = 0; goto B20; 
	fi;
B19: tobool4 = v7; goto B20; 
B21v5: 
	if 
	:: cmp6 = (conv5 != 1); goto B22v5; 
	:: memory[v5] = 0; goto B21; 
	fi;
B20: conv5 = tobool4; goto B21; 
B22v5: 
	if 
	::cmp6 -> goto B23v5; 
	::!cmp6 -> goto B24v5; 
	:: memory[v5] = 0; goto B22; 
	fi;
B21: cmp6 = (conv5 != 1); goto B22; 
B23v5: 
	if 
	:: goto B17v5; 
	:: memory[v5] = 0; goto B23; 
	fi;
B24v5: 
	if 
	:: v8 = memory[flag1]; goto B25v5; 
	:: memory[v5] = 0; goto B24; 
	fi;
B22: 
	if 
	::cmp6 -> goto B23; 
	::!cmp6 -> goto B24; 
	fi;
B23: goto B17; 
B25v5: 
	if 
	:: goto B26v5v8; 
	:: memory[v5] = 0; goto B25; 
	fi;
B24: v8 = memory[flag1]; goto B25; 
B26v5v8: 
	if 
	:: goto B27v5v8; 
	:: memory[v5] = 0; goto B26v8; 
	:: memory[v8] = 1; goto B26v5; 
	fi;
B25: goto B26v8; 
B27v5v8: 
	if 
	:: goto B03v5v8; 
	:: memory[v5] = 0; goto B27v8; 
	:: memory[v8] = 1; goto B27v5; 
	fi;
B26v8: 
	if 
	:: goto B27v8; 
	:: memory[v8] = 1; goto B26; 
	fi;
B26v5: 
	if 
	:: goto B27v5; 
	:: memory[v5] = 0; goto B26; 
	fi;
B03v5v8: 
	if 
	:: memory[v5] = 0; goto B03v8; 
	:: memory[v8] = 1; goto B03v5; 
	fi;
B27v8: 
	if 
	:: goto B03v8; 
	:: memory[v8] = 1; goto B27; 
	fi;
B27v5: 
	if 
	:: goto B03v5; 
	:: memory[v5] = 0; goto B27; 
	fi;
B26: goto B27; 
B03v8: memory[v8] = 1; goto B03; 
B03v5: memory[v5] = 0; goto B03; 
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
ltl prop{ [] !((process1@A28) && (process2@B28))}
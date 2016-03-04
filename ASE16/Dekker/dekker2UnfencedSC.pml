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
short v2, v4, v7, v8;
AStart: goto A00;
A00: goto A01; 
A01: goto A02; 
A02: v2 = memory[flag1]; goto A03; 
A03: 
	if 
	::v2 -> goto A04; 
	::!v2 -> goto A13; 
	fi;
A04: v4 = memory[turn]; goto A05; 
A13: goto A14; 
A05: 
	if 
	::v4 -> goto A02; 
	::!v4 -> goto A06; 
	fi;
A14: goto A15; 
A06: goto A07; 
A15: goto AEnd;
A07: goto A08; 
A08: v7 = memory[turn]; goto A09; 
A09: 
	if 
	::v7 -> goto A10; 
	::!v7 -> goto A08; 
	fi;
A10: v8 = memory[flag0]; goto A11; 
A11: goto A12; 
A12: goto A02; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, tobool, conv, cmp, v3, v9, v4, tobool2, v10, conv3, cmp4, v5, v6, v7, tobool7, conv8, cmp9, v8;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: goto B03; 
B03: v1 = memory[flag0]; goto B04; 
B04: v2 = memory[v1]; goto B05; 
B05: tobool = v2; goto B06; 
B06: conv = tobool; goto B07; 
B07: cmp = (conv == 1); goto B08; 
B08: 
	if 
	::cmp -> goto B09; 
	::!cmp -> goto B29; 
	fi;
B09: v3 = memory[turn]; goto B10; 
B29: v9 = memory[turn]; goto B30; 
B10: v4 = memory[v3]; goto B11; 
B30: goto B31; 
B11: tobool2 = v4; goto B12; 
B31: v10 = memory[flag1]; goto B32; 
B12: conv3 = tobool2; goto B13; 
B32: goto B33; 
B13: cmp4 = (conv3 != 1); goto B14; 
B33: goto BEnd;
B14: 
	if 
	::cmp4 -> goto B15; 
	::!cmp4 -> goto B28; 
	fi;
B15: v5 = memory[flag1]; goto B16; 
B28: goto B03; 
B16: goto B17; 
B17: goto B18; 
B18: v6 = memory[turn]; goto B19; 
B19: v7 = memory[v6]; goto B20; 
B20: tobool7 = v7; goto B21; 
B21: conv8 = tobool7; goto B22; 
B22: cmp9 = (conv8 != 1); goto B23; 
B23: 
	if 
	::cmp9 -> goto B24; 
	::!cmp9 -> goto B25; 
	fi;
B24: goto B18; 
B25: v8 = memory[flag1]; goto B26; 
B26: goto B27; 
B27: goto B28; 
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

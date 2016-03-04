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
A02: goto A03; 
A03: v2 = memory[flag1]; goto A04; 
A04: 
	if 
	::v2 -> goto A05; 
	::!v2 -> goto A14; 
	fi;
A05: v4 = memory[turn]; goto A06; 
A14: goto A15; 
A06: 
	if 
	::v4 -> goto A02; 
	::!v4 -> goto A07; 
	fi;
A15: goto A16; 
A07: goto A08; 
A16: goto AEnd;
A08: goto A09; 
A09: v7 = memory[turn]; goto A10; 
A10: 
	if 
	::v7 -> goto A11; 
	::!v7 -> goto A09; 
	fi;
A11: v8 = memory[flag0]; goto A12; 
A12: goto A13; 
A13: goto A02; 
AEnd: skip;

}


inline p1(){
short v0, v1, v2, tobool, conv, cmp, v3, v9, v4, tobool2, v10, conv3, cmp4, v5, v6, v7, tobool7, conv8, cmp9, v8;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: goto B03; 
B03: goto B04; 
B04: v1 = memory[flag0]; goto B05; 
B05: v2 = memory[v1]; goto B06; 
B06: tobool = v2; goto B07; 
B07: conv = tobool; goto B08; 
B08: cmp = (conv == 1); goto B09; 
B09: 
	if 
	::cmp -> goto B10; 
	::!cmp -> goto B30; 
	fi;
B10: v3 = memory[turn]; goto B11; 
B30: v9 = memory[turn]; goto B31; 
B11: v4 = memory[v3]; goto B12; 
B31: goto B32; 
B12: tobool2 = v4; goto B13; 
B32: v10 = memory[flag1]; goto B33; 
B13: conv3 = tobool2; goto B14; 
B33: goto B34; 
B14: cmp4 = (conv3 != 1); goto B15; 
B34: goto BEnd;
B15: 
	if 
	::cmp4 -> goto B16; 
	::!cmp4 -> goto B29; 
	fi;
B16: v5 = memory[flag1]; goto B17; 
B29: goto B03; 
B17: goto B18; 
B18: goto B19; 
B19: v6 = memory[turn]; goto B20; 
B20: v7 = memory[v6]; goto B21; 
B21: tobool7 = v7; goto B22; 
B22: conv8 = tobool7; goto B23; 
B23: cmp9 = (conv8 != 1); goto B24; 
B24: 
	if 
	::cmp9 -> goto B25; 
	::!cmp9 -> goto B26; 
	fi;
B25: goto B19; 
B26: v8 = memory[flag1]; goto B27; 
B27: goto B28; 
B28: goto B29; 
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

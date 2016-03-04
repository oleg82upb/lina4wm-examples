#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag = zeroinitializer;
short flag0 = null;
short flag1 = null;


//standard stuff
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline proc0(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v14, cmp8, v12, v13, v15;
AStart: goto A00;
A00: goto A01; 
A01: v0 = memory[flag0]; goto A02; 
A02: goto A03; 
A03: goto A04; 
A04: v1 = memory[flag1]; goto A05; 
A05: v2 = memory[v1]; goto A06; 
A06: cmp = (v2 > 2); goto A07; 
A07: 
	if 
	::cmp -> goto A08; 
	::!cmp -> goto A09; 
	fi;
A08: goto A04; 
A09: v3 = memory[flag0]; goto A10; 
A10: goto A11; 
A11: v4 = memory[flag1]; goto A12; 
A12: v5 = memory[v4]; goto A13; 
A13: cmp1 = (v5 == 1); goto A14; 
A14: 
	if 
	::cmp1 -> goto A15; 
	::!cmp1 -> goto A24; 
	fi;
A15: v6 = memory[flag0]; goto A16; 
A24: v9 = memory[flag0]; goto A25; 
A16: goto A17; 
A25: goto A26; 
A17: goto A18; 
A26: goto A27; 
A18: v7 = memory[flag1]; goto A19; 
A27: v10 = memory[flag1]; goto A28; 
A19: v8 = memory[v7]; goto A20; 
A28: v11 = memory[v10]; goto A29; 
A20: cmp3 = (v8 == 4); goto A21; 
A29: cmp7 = (v11 == 2); goto A30; 
A21: 
	if 
	::cmp3 -> goto A22; 
	::!cmp3 -> goto A23; 
	fi;
A30: 
	if 
	::cmp7 -> v14 = true; goto A35; 
	::!cmp7 -> goto A31; 
	fi;
A22: goto A18; 
A23: goto A24; 
A35: goto A36; 
A31: v12 = memory[flag1]; goto A32; 
A36: 
	if 
	::v14 -> goto A37; 
	::!v14 -> goto A38; 
	fi;
A32: v13 = memory[v12]; goto A33; 
A37: goto A27; 
A38: v15 = memory[flag0]; goto A39; 
A33: cmp8 = (v13 == 3); goto A34; 
A39: goto A40; 
A34: v14 = cmp8; goto A35; 
A40: goto AEnd;
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B00;
B00: goto B01; 
B01: v0 = memory[flag1]; goto B02; 
B02: goto B03; 
B03: goto B04; 
B04: v1 = memory[flag0]; goto B05; 
B05: v2 = memory[v1]; goto B06; 
B06: cmp = (v2 > 2); goto B07; 
B07: 
	if 
	::cmp -> goto B08; 
	::!cmp -> goto B09; 
	fi;
B08: goto B04; 
B09: v3 = memory[flag1]; goto B10; 
B10: goto B11; 
B11: v4 = memory[flag0]; goto B12; 
B12: v5 = memory[v4]; goto B13; 
B13: cmp1 = (v5 == 1); goto B14; 
B14: 
	if 
	::cmp1 -> goto B15; 
	::!cmp1 -> goto B24; 
	fi;
B15: v6 = memory[flag1]; goto B16; 
B24: v9 = memory[flag1]; goto B25; 
B16: goto B17; 
B25: goto B26; 
B17: goto B18; 
B26: goto B27; 
B18: v7 = memory[flag0]; goto B19; 
B27: v10 = memory[flag0]; goto B28; 
B19: v8 = memory[v7]; goto B20; 
B28: v11 = memory[v10]; goto B29; 
B20: cmp3 = (v8 == 4); goto B21; 
B29: cmp7 = (v11 > 1); goto B30; 
B21: 
	if 
	::cmp3 -> goto B22; 
	::!cmp3 -> goto B23; 
	fi;
B30: 
	if 
	::cmp7 -> goto B31; 
	::!cmp7 -> goto B32; 
	fi;
B22: goto B18; 
B23: goto B24; 
B31: goto B27; 
B32: v12 = memory[flag1]; goto B33; 
B33: goto B34; 
B34: goto BEnd;
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

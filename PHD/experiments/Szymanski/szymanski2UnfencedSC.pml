#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline proc0(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12, cmp8, v13;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02; 
A02: v1 = memory[flag1]; goto A03; 
A03: goto A04; 
A04: v2 = memory[v1]; goto A05; 
A05: cmp = (v2 > 2); goto A06; 
A06: 
	if 
	::cmp -> goto A04; 
	::!cmp -> goto A07; 
	fi;
A07: v3 = memory[flag0]; goto A08; 
A08: goto A09; 
A09: v4 = memory[flag1]; goto A10; 
A10: v5 = memory[v4]; goto A11; 
A11: cmp1 = (v5 == 1); goto A12; 
A12: 
	if 
	::cmp1 -> goto A13; 
	::!cmp1 -> goto A20; 
	fi;
A13: v6 = memory[flag0]; goto A14; 
A20: v9 = memory[flag0]; goto A21; 
A14: goto A15; 
A21: goto A22; 
A15: v7 = memory[flag1]; goto A16; 
A22: v10 = memory[flag1]; goto A23; 
A16: goto A17; 
A23: goto A24; 
A17: v8 = memory[v7]; goto A18; 
A24: v11 = memory[v10]; goto A25; 
A18: cmp3 = (v8 == 4); goto A19; 
A25: cmp7 = (v11 == 2); goto A26; 
A19: 
	if 
	::cmp3 -> goto A20; 
	::!cmp3 -> goto A17; 
	fi;
A26: 
	if 
	::cmp7 -> goto A24; 
	::!cmp7 -> goto A27; 
	fi;
A27: v12 = memory[v10]; goto A28; 
A28: cmp8 = (v12 == 3); goto A29; 
A29: 
	if 
	::cmp8 -> goto A24; 
	::!cmp8 -> goto A30; 
	fi;
A30: v13 = memory[flag0]; goto A31; 
A31: goto A32; 
A32: goto AEnd;
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: v1 = memory[flag0]; goto B03; 
B03: goto B04; 
B04: v2 = memory[v1]; goto B05; 
B05: cmp = (v2 > 2); goto B06; 
B06: 
	if 
	::cmp -> goto B04; 
	::!cmp -> goto B07; 
	fi;
B07: v3 = memory[flag1]; goto B08; 
B08: goto B09; 
B09: v4 = memory[flag0]; goto B10; 
B10: v5 = memory[v4]; goto B11; 
B11: cmp1 = (v5 == 1); goto B12; 
B12: 
	if 
	::cmp1 -> goto B13; 
	::!cmp1 -> goto B20; 
	fi;
B13: v6 = memory[flag1]; goto B14; 
B20: v9 = memory[flag1]; goto B21; 
B14: goto B15; 
B21: goto B22; 
B15: v7 = memory[flag0]; goto B16; 
B22: v10 = memory[flag0]; goto B23; 
B16: goto B17; 
B23: goto B24; 
B17: v8 = memory[v7]; goto B18; 
B24: v11 = memory[v10]; goto B25; 
B18: cmp3 = (v8 == 4); goto B19; 
B25: cmp7 = (v11 > 1); goto B26; 
B19: 
	if 
	::cmp3 -> goto B20; 
	::!cmp3 -> goto B17; 
	fi;
B26: 
	if 
	::cmp7 -> goto B24; 
	::!cmp7 -> goto B27; 
	fi;
B27: v12 = memory[flag1]; goto B28; 
B28: goto B29; 
B29: goto BEnd;
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
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	

	run process1();
	run process2();
	}
}

#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag = 0; //Array: please, check initialization in the init process
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
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v14, cmp8, v12, v13, v15;
AStart: goto A00;
A00: goto A01; 
A01: v0 = memory[flag0]; goto A02; 
A02: goto A03; 
A03: goto A04; 
A04: goto A05; 
A05: v1 = memory[flag1]; goto A06; 
A06: v2 = memory[v1]; goto A07; 
A07: cmp = (v2 > 2); goto A08; 
A08: 
	if 
	::cmp -> goto A09; 
	::!cmp -> goto A10; 
	fi;
A09: goto A05; 
A10: v3 = memory[flag0]; goto A11; 
A11: goto A12; 
A12: goto A13; 
A13: v4 = memory[flag1]; goto A14; 
A14: v5 = memory[v4]; goto A15; 
A15: cmp1 = (v5 == 1); goto A16; 
A16: 
	if 
	::cmp1 -> goto A17; 
	::!cmp1 -> goto A26; 
	fi;
A17: v6 = memory[flag0]; goto A18; 
A26: v9 = memory[flag0]; goto A27; 
A18: goto A19; 
A27: goto A28; 
A19: goto A20; 
A28: goto A29; 
A20: v7 = memory[flag1]; goto A21; 
A29: v10 = memory[flag1]; goto A30; 
A21: v8 = memory[v7]; goto A22; 
A30: v11 = memory[v10]; goto A31; 
A22: cmp3 = (v8 == 4); goto A23; 
A31: cmp7 = (v11 == 2); goto A32; 
A23: 
	if 
	::cmp3 -> goto A24; 
	::!cmp3 -> goto A25; 
	fi;
A32: 
	if 
	::cmp7 -> v14 = true; goto A37; 
	::!cmp7 -> goto A33; 
	fi;
A24: goto A20; 
A25: goto A26; 
A37: goto A38; 
A33: v12 = memory[flag1]; goto A34; 
A38: 
	if 
	::v14 -> goto A39; 
	::!v14 -> goto A40; 
	fi;
A34: v13 = memory[v12]; goto A35; 
A39: goto A29; 
A40: v15 = memory[flag0]; goto A41; 
A35: cmp8 = (v13 == 3); goto A36; 
A41: goto A42; 
A36: v14 = cmp8; goto A37; 
A42: goto AEnd;
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B00;
B00: goto B01; 
B01: v0 = memory[flag1]; goto B02; 
B02: goto B03; 
B03: goto B04; 
B04: goto B05; 
B05: v1 = memory[flag0]; goto B06; 
B06: v2 = memory[v1]; goto B07; 
B07: cmp = (v2 > 2); goto B08; 
B08: 
	if 
	::cmp -> goto B09; 
	::!cmp -> goto B10; 
	fi;
B09: goto B05; 
B10: v3 = memory[flag1]; goto B11; 
B11: goto B12; 
B12: goto B13; 
B13: v4 = memory[flag0]; goto B14; 
B14: v5 = memory[v4]; goto B15; 
B15: cmp1 = (v5 == 1); goto B16; 
B16: 
	if 
	::cmp1 -> goto B17; 
	::!cmp1 -> goto B26; 
	fi;
B17: v6 = memory[flag1]; goto B18; 
B26: v9 = memory[flag1]; goto B27; 
B18: goto B19; 
B27: goto B28; 
B19: goto B20; 
B28: goto B29; 
B20: v7 = memory[flag0]; goto B21; 
B29: v10 = memory[flag0]; goto B30; 
B21: v8 = memory[v7]; goto B22; 
B30: v11 = memory[v10]; goto B31; 
B22: cmp3 = (v8 == 4); goto B23; 
B31: cmp7 = (v11 > 1); goto B32; 
B23: 
	if 
	::cmp3 -> goto B24; 
	::!cmp3 -> goto B25; 
	fi;
B32: 
	if 
	::cmp7 -> goto B33; 
	::!cmp7 -> goto B34; 
	fi;
B24: goto B20; 
B25: goto B26; 
B33: goto B29; 
B34: v12 = memory[flag1]; goto B35; 
B35: goto B36; 
B36: goto BEnd;
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
	alloca(2, flag);
	alloca(1, flag0);
	alloca(1, flag1);
	

	run process1();
	run process2();
	}
}

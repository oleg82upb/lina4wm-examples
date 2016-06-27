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
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, 10, v8, 11, cmp3, cmp7, 12, cmp8, 13;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02; 
A02: goto A03; 
A03: v1 = memory[flag1]; goto A04; 
A04: goto A05; 
A05: v2 = memory[v1]; goto A06; 
A06: cmp = (v2 > 2); goto A07; 
A07: 
	if 
	::cmp -> goto A05; 
	::!cmp -> goto A08; 
	fi;
A08: v3 = memory[flag0]; goto A09; 
A09: goto A10; 
A10: goto A11; 
A11: v4 = memory[flag1]; goto A12; 
A12: v5 = memory[v4]; goto A13; 
A13: cmp1 = (v5 == 1); goto A14; 
A14: 
	if 
	::cmp1 -> goto A15; 
	::!cmp1 -> goto A22; 
	fi;
A15: v6 = memory[flag0]; goto A16; 
A22: v9 = memory[flag0]; goto A23; 
A16: goto A17; 
A23: goto A24; 
A17: v7 = memory[flag1]; goto A18; 
A24: 10 = memory[flag1]; goto A25; 
A18: goto A19; 
A25: goto A26; 
A19: v8 = memory[v7]; goto A20; 
A26: 11 = memory[10]; goto A27; 
A20: cmp3 = (v8 == 4); goto A21; 
A27: cmp7 = (11 == 2); goto A28; 
A21: 
	if 
	::cmp3 -> goto A22; 
	::!cmp3 -> goto A19; 
	fi;
A28: 
	if 
	::cmp7 -> goto A26; 
	::!cmp7 -> goto A29; 
	fi;
A29: 12 = memory[10]; goto A30; 
A30: cmp8 = (12 == 3); goto A31; 
A31: 
	if 
	::cmp8 -> goto A26; 
	::!cmp8 -> goto A32; 
	fi;
A32: 13 = memory[flag0]; goto A33; 
A33: goto A34; 
A34: goto AEnd;
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, 10, v8, 11, cmp3, cmp7, 12;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02; 
B02: goto B03; 
B03: v1 = memory[flag0]; goto B04; 
B04: goto B05; 
B05: v2 = memory[v1]; goto B06; 
B06: cmp = (v2 > 2); goto B07; 
B07: 
	if 
	::cmp -> goto B05; 
	::!cmp -> goto B08; 
	fi;
B08: v3 = memory[flag1]; goto B09; 
B09: goto B10; 
B10: goto B11; 
B11: v4 = memory[flag0]; goto B12; 
B12: v5 = memory[v4]; goto B13; 
B13: cmp1 = (v5 == 1); goto B14; 
B14: 
	if 
	::cmp1 -> goto B15; 
	::!cmp1 -> goto B22; 
	fi;
B15: v6 = memory[flag1]; goto B16; 
B22: v9 = memory[flag1]; goto B23; 
B16: goto B17; 
B23: goto B24; 
B17: v7 = memory[flag0]; goto B18; 
B24: 10 = memory[flag0]; goto B25; 
B18: goto B19; 
B25: goto B26; 
B19: v8 = memory[v7]; goto B20; 
B26: 11 = memory[10]; goto B27; 
B20: cmp3 = (v8 == 4); goto B21; 
B27: cmp7 = (11 > 1); goto B28; 
B21: 
	if 
	::cmp3 -> goto B22; 
	::!cmp3 -> goto B19; 
	fi;
B28: 
	if 
	::cmp7 -> goto B26; 
	::!cmp7 -> goto B29; 
	fi;
B29: 12 = memory[flag1]; goto B30; 
B30: goto B31; 
B31: goto BEnd;
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
	

	run process1();
	run process2();
	}
}

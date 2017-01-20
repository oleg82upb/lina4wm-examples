#define MEM_SIZE 10	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short mtxOwner = 0;

inline acquire(id)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = id;
	 }
}

inline release(id)
{
	atomic{
	 assert(mtxOwner == id);
	 mtxOwner = 0;
	 }
}

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
A01: goto A02v0; 
A02v0: memory[v0] = 1; goto A02; 
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
A09: goto A10v3; 
A10v3: memory[v3] = 3; goto A10; 
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
A16: goto A17v6; 
A23: goto A24v9; 
A17v6: 
	if 
	:: v7 = memory[flag1]; goto A18v6; 
	:: memory[v6] = 2; goto A17; 
	fi;
A24v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A25v9; 
	:: memory[v9] = 4; goto A24; 
	fi;
A18v6: 
	if 
	:: goto A19v6; 
	:: memory[v6] = 2; goto A18; 
	fi;
A17: v7 = memory[flag1]; goto A18; 
A25v9: 
	if 
	:: release(_pid); goto A26v9; 
	:: memory[v9] = 4; goto A25; 
	fi;
A24: acquire(_pid); v10 = memory[flag1]; goto A25; 
A19v6: 
	if 
	:: v8 = memory[v7]; goto A20v6; 
	:: memory[v6] = 2; goto A19; 
	fi;
A18: goto A19; 
A26v9: 
	if 
	:: v11 = memory[v10]; goto A27v9; 
	:: memory[v9] = 4; goto A26; 
	fi;
A25: release(_pid); goto A26; 
A20v6: 
	if 
	:: cmp3 = (v8 == 4); goto A21v6; 
	:: memory[v6] = 2; goto A20; 
	fi;
A19: v8 = memory[v7]; goto A20; 
A27v9: 
	if 
	:: cmp7 = (v11 == 2); goto A28v9; 
	:: memory[v9] = 4; goto A27; 
	fi;
A26: v11 = memory[v10]; goto A27; 
A21v6: 
	if 
	::cmp3 -> goto A22v6; 
	::!cmp3 -> goto A19v6; 
	:: memory[v6] = 2; goto A21; 
	fi;
A20: cmp3 = (v8 == 4); goto A21; 
A28v9: 
	if 
	::cmp7 -> goto A26v9; 
	::!cmp7 -> goto A29v9; 
	:: memory[v9] = 4; goto A28; 
	fi;
A27: cmp7 = (v11 == 2); goto A28; 
A22v6: 
	if 
	:: v9 = memory[flag0]; goto A23v6; 
	:: memory[v6] = 2; goto A22; 
	fi;
A21: 
	if 
	::cmp3 -> goto A22; 
	::!cmp3 -> goto A19; 
	fi;
A29v9: 
	if 
	:: v12 = memory[v10]; goto A30v9; 
	:: memory[v9] = 4; goto A29; 
	fi;
A28: 
	if 
	::cmp7 -> goto A26; 
	::!cmp7 -> goto A29; 
	fi;
A23v6: 
	if 
	:: goto A24v6v9; 
	:: memory[v6] = 2; goto A23; 
	fi;
A30v9: 
	if 
	:: cmp8 = (v12 == 3); goto A31v9; 
	:: memory[v9] = 4; goto A30; 
	fi;
A29: v12 = memory[v10]; goto A30; 
A24v6v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A25v6v9; 
	:: memory[v6] = 2; goto A24v9; 
	fi;
A31v9: 
	if 
	::cmp8 -> goto A26v9; 
	::!cmp8 -> goto A32v9; 
	:: memory[v9] = 4; goto A31; 
	fi;
A30: cmp8 = (v12 == 3); goto A31; 
A25v6v9: 
	if 
	:: release(_pid); goto A26v6v9; 
	:: memory[v6] = 2; goto A25v9; 
	fi;
A32v9: 
	if 
	:: v13 = memory[flag0]; goto A33v9; 
	:: memory[v9] = 4; goto A32; 
	fi;
A31: 
	if 
	::cmp8 -> goto A26; 
	::!cmp8 -> goto A32; 
	fi;
A26v6v9: 
	if 
	:: v11 = memory[v10]; goto A27v6v9; 
	:: memory[v6] = 2; goto A26v9; 
	fi;
A33v9: 
	if 
	:: goto A34v9v13; 
	:: memory[v9] = 4; goto A33; 
	fi;
A32: v13 = memory[flag0]; goto A33; 
A27v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A28v6v9; 
	:: memory[v6] = 2; goto A27v9; 
	fi;
A34v9v13: memory[v9] = 4; goto A34v13; 
A33: goto A34v13; 
A28v6v9: 
	if 
	::cmp7 -> goto A26v6v9; 
	::!cmp7 -> goto A29v6v9; 
	:: memory[v6] = 2; goto A28v9; 
	fi;
A34v13: memory[v13] = 0; goto A34; 
A29v6v9: 
	if 
	:: v12 = memory[v10]; goto A30v6v9; 
	:: memory[v6] = 2; goto A29v9; 
	fi;
A34: goto AEnd;
A30v6v9: 
	if 
	:: cmp8 = (v12 == 3); goto A31v6v9; 
	:: memory[v6] = 2; goto A30v9; 
	fi;
A31v6v9: 
	if 
	::cmp8 -> goto A26v6v9; 
	::!cmp8 -> goto A32v6v9; 
	:: memory[v6] = 2; goto A31v9; 
	fi;
A32v6v9: 
	if 
	:: v13 = memory[flag0]; goto A33v6v9; 
	:: memory[v6] = 2; goto A32v9; 
	fi;
A33v6v9: 
	if 
	:: goto A34v6v9v13; 
	:: memory[v6] = 2; goto A33v9; 
	fi;
A34v6v9v13: memory[v6] = 2; goto A34v9v13; 
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02v0; 
B02v0: memory[v0] = 1; goto B02; 
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
B09: goto B10v3; 
B10v3: memory[v3] = 3; goto B10; 
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
B16: goto B17v6; 
B23: goto B24v9; 
B17v6: 
	if 
	:: v7 = memory[flag0]; goto B18v6; 
	:: memory[v6] = 2; goto B17; 
	fi;
B24v9: 
	if 
	:: v10 = memory[flag0]; goto B25v9; 
	:: memory[v9] = 4; goto B24; 
	fi;
B18v6: 
	if 
	:: goto B19v6; 
	:: memory[v6] = 2; goto B18; 
	fi;
B17: v7 = memory[flag0]; goto B18; 
B25v9: 
	if 
	:: goto B26v9; 
	:: memory[v9] = 4; goto B25; 
	fi;
B24: v10 = memory[flag0]; goto B25; 
B19v6: 
	if 
	:: v8 = memory[v7]; goto B20v6; 
	:: memory[v6] = 2; goto B19; 
	fi;
B18: goto B19; 
B26v9: 
	if 
	:: v11 = memory[v10]; goto B27v9; 
	:: memory[v9] = 4; goto B26; 
	fi;
B25: goto B26; 
B20v6: 
	if 
	:: cmp3 = (v8 == 4); goto B21v6; 
	:: memory[v6] = 2; goto B20; 
	fi;
B19: v8 = memory[v7]; goto B20; 
B27v9: 
	if 
	:: cmp7 = (v11 > 1); goto B28v9; 
	:: memory[v9] = 4; goto B27; 
	fi;
B26: v11 = memory[v10]; goto B27; 
B21v6: 
	if 
	::cmp3 -> goto B22v6; 
	::!cmp3 -> goto B19v6; 
	:: memory[v6] = 2; goto B21; 
	fi;
B20: cmp3 = (v8 == 4); goto B21; 
B28v9: 
	if 
	::cmp7 -> goto B26v9; 
	::!cmp7 -> acquire(_pid); goto B29v9; 
	:: memory[v9] = 4; goto B28; 
	fi;
B27: cmp7 = (v11 > 1); goto B28; 
B22v6: 
	if 
	:: v9 = memory[flag1]; goto B23v6; 
	:: memory[v6] = 2; goto B22; 
	fi;
B21: 
	if 
	::cmp3 -> goto B22; 
	::!cmp3 -> goto B19; 
	fi;
B29v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B30v9; 
	:: memory[v9] = 4; goto B29; 
	fi;
B28: 
	if 
	::cmp7 -> goto B26; 
	::!cmp7 -> acquire(_pid); goto B29; 
	fi;
B23v6: 
	if 
	:: goto B24v6v9; 
	:: memory[v6] = 2; goto B23; 
	fi;
B30v9: 
	if 
	:: goto B31v9v12; 
	:: memory[v9] = 4; goto B30; 
	fi;
B29: release(_pid); v12 = memory[flag1]; goto B30; 
B24v6v9: 
	if 
	:: v10 = memory[flag0]; goto B25v6v9; 
	:: memory[v6] = 2; goto B24v9; 
	fi;
B31v9v12: memory[v9] = 4; goto B31v12; 
B30: goto B31v12; 
B25v6v9: 
	if 
	:: goto B26v6v9; 
	:: memory[v6] = 2; goto B25v9; 
	fi;
B31v12: memory[v12] = 0; goto B31; 
B26v6v9: 
	if 
	:: v11 = memory[v10]; goto B27v6v9; 
	:: memory[v6] = 2; goto B26v9; 
	fi;
B31: goto BEnd;
B27v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B28v6v9; 
	:: memory[v6] = 2; goto B27v9; 
	fi;
B28v6v9: 
	if 
	::cmp7 -> goto B26v6v9; 
	::!cmp7 -> acquire(_pid); goto B29v6v9; 
	:: memory[v6] = 2; goto B28v9; 
	fi;
B29v6v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B30v6v9; 
	:: memory[v6] = 2; goto B29v9; 
	fi;
B30v6v9: 
	if 
	:: goto B31v6v9v12; 
	:: memory[v6] = 2; goto B30v9; 
	fi;
B31v6v9v12: memory[v6] = 2; goto B31v9v12; 
BEnd: skip;

}


//Stubs
proctype process1(){
	proc0();
}

proctype process2(){
	proc1();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	//two layers of pointers need initialization
	memory[flag0] = 3;
	memory[flag1] = 4;

	run process1();
	run process2();
	}
}
//ltl prop{ [] !((process1@A25v6v9 || process1@A25v9 || process1@A25) 
//	&& (process2@B29v6v9 || process2@B29v9 || process2@B29))}
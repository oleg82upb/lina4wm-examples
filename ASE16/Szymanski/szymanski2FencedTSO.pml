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
A02: goto A03v0; 
A03v0: memory[v0] = 1; goto A03; 
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
A11: goto A12v3; 
A12v3: memory[v3] = 3; goto A12; 
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
A18: goto A19v6; 
A27: goto A28v9; 
A19v6: 
	if 
	:: goto A20v6; 
	:: memory[v6] = 2; goto A19; 
	fi;
A28v9: 
	if 
	:: goto A29v9; 
	:: memory[v9] = 4; goto A28; 
	fi;
A20v6: 
	if 
	:: v7 = memory[flag1]; goto A21v6; 
	:: memory[v6] = 2; goto A20; 
	fi;
A19: goto A20; 
A29v9: 
	if 
	:: v10 = memory[flag1]; goto A30v9; 
	:: memory[v9] = 4; goto A29; 
	fi;
A28: goto A29; 
A21v6: 
	if 
	:: v8 = memory[v7]; goto A22v6; 
	:: memory[v6] = 2; goto A21; 
	fi;
A20: v7 = memory[flag1]; goto A21; 
A30v9: 
	if 
	:: v11 = memory[v10]; goto A31v9; 
	:: memory[v9] = 4; goto A30; 
	fi;
A29: v10 = memory[flag1]; goto A30; 
A22v6: 
	if 
	:: cmp3 = (v8 == 4); goto A23v6; 
	:: memory[v6] = 2; goto A22; 
	fi;
A21: v8 = memory[v7]; goto A22; 
A31v9: 
	if 
	:: cmp7 = (v11 == 2); goto A32v9; 
	:: memory[v9] = 4; goto A31; 
	fi;
A30: v11 = memory[v10]; goto A31; 
A23v6: 
	if 
	::cmp3 -> goto A24v6; 
	::!cmp3 -> goto A25v6; 
	:: memory[v6] = 2; goto A23; 
	fi;
A22: cmp3 = (v8 == 4); goto A23; 
A32v9: 
	if 
	::cmp7 -> v14 = true; goto A37v9; 
	::!cmp7 -> goto A33v9; 
	:: memory[v9] = 4; goto A32; 
	fi;
A31: cmp7 = (v11 == 2); goto A32; 
A24v6: 
	if 
	:: goto A20v6; 
	:: memory[v6] = 2; goto A24; 
	fi;
A25v6: 
	if 
	:: goto A26v6; 
	:: memory[v6] = 2; goto A25; 
	fi;
A23: 
	if 
	::cmp3 -> goto A24; 
	::!cmp3 -> goto A25; 
	fi;
A37v9: 
	if 
	:: goto A38v9; 
	:: memory[v9] = 4; goto A37; 
	fi;
A33v9: 
	if 
	:: v12 = memory[flag1]; goto A34v9; 
	:: memory[v9] = 4; goto A33; 
	fi;
A32: 
	if 
	::cmp7 -> v14 = true; goto A37; 
	::!cmp7 -> goto A33; 
	fi;
A24: goto A20; 
A26v6: 
	if 
	:: v9 = memory[flag0]; goto A27v6; 
	:: memory[v6] = 2; goto A26; 
	fi;
A25: goto A26; 
A38v9: 
	if 
	::v14 -> goto A39v9; 
	::!v14 -> goto A40v9; 
	:: memory[v9] = 4; goto A38; 
	fi;
A37: goto A38; 
A34v9: 
	if 
	:: v13 = memory[v12]; goto A35v9; 
	:: memory[v9] = 4; goto A34; 
	fi;
A33: v12 = memory[flag1]; goto A34; 
A27v6: 
	if 
	:: goto A28v6v9; 
	:: memory[v6] = 2; goto A27; 
	fi;
A39v9: 
	if 
	:: goto A29v9; 
	:: memory[v9] = 4; goto A39; 
	fi;
A40v9: 
	if 
	:: v15 = memory[flag0]; goto A41v9; 
	:: memory[v9] = 4; goto A40; 
	fi;
A38: 
	if 
	::v14 -> goto A39; 
	::!v14 -> goto A40; 
	fi;
A35v9: 
	if 
	:: cmp8 = (v13 == 3); goto A36v9; 
	:: memory[v9] = 4; goto A35; 
	fi;
A34: v13 = memory[v12]; goto A35; 
A28v6v9: 
	if 
	:: goto A29v6v9; 
	:: memory[v6] = 2; goto A28v9; 
	fi;
A39: goto A29; 
A41v9: 
	if 
	:: goto A42v9v15; 
	:: memory[v9] = 4; goto A41; 
	fi;
A40: v15 = memory[flag0]; goto A41; 
A36v9: 
	if 
	:: v14 = cmp8; goto A37v9; 
	:: memory[v9] = 4; goto A36; 
	fi;
A35: cmp8 = (v13 == 3); goto A36; 
A29v6v9: 
	if 
	:: v10 = memory[flag1]; goto A30v6v9; 
	:: memory[v6] = 2; goto A29v9; 
	fi;
A42v9v15: memory[v9] = 4; goto A42v15; 
A41: goto A42v15; 
A36: v14 = cmp8; goto A37; 
A30v6v9: 
	if 
	:: v11 = memory[v10]; goto A31v6v9; 
	:: memory[v6] = 2; goto A30v9; 
	fi;
A42v15: memory[v15] = 0; goto A42; 
A31v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A32v6v9; 
	:: memory[v6] = 2; goto A31v9; 
	fi;
A42: goto AEnd;
A32v6v9: 
	if 
	::cmp7 -> v14 = true; goto A37v6v9; 
	::!cmp7 -> goto A33v6v9; 
	:: memory[v6] = 2; goto A32v9; 
	fi;
A37v6v9: 
	if 
	:: goto A38v6v9; 
	:: memory[v6] = 2; goto A37v9; 
	fi;
A33v6v9: 
	if 
	:: v12 = memory[flag1]; goto A34v6v9; 
	:: memory[v6] = 2; goto A33v9; 
	fi;
A38v6v9: 
	if 
	::v14 -> goto A39v6v9; 
	::!v14 -> goto A40v6v9; 
	:: memory[v6] = 2; goto A38v9; 
	fi;
A34v6v9: 
	if 
	:: v13 = memory[v12]; goto A35v6v9; 
	:: memory[v6] = 2; goto A34v9; 
	fi;
A39v6v9: 
	if 
	:: goto A29v6v9; 
	:: memory[v6] = 2; goto A39v9; 
	fi;
A40v6v9: 
	if 
	:: v15 = memory[flag0]; goto A41v6v9; 
	:: memory[v6] = 2; goto A40v9; 
	fi;
A35v6v9: 
	if 
	:: cmp8 = (v13 == 3); goto A36v6v9; 
	:: memory[v6] = 2; goto A35v9; 
	fi;
A41v6v9: 
	if 
	:: goto A42v6v9v15; 
	:: memory[v6] = 2; goto A41v9; 
	fi;
A36v6v9: 
	if 
	:: v14 = cmp8; goto A37v6v9; 
	:: memory[v6] = 2; goto A36v9; 
	fi;
A42v6v9v15: memory[v6] = 2; goto A42v9v15; 
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B00;
B00: goto B01; 
B01: v0 = memory[flag1]; goto B02; 
B02: goto B03v0; 
B03v0: memory[v0] = 1; goto B03; 
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
B11: goto B12v3; 
B12v3: memory[v3] = 3; goto B12; 
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
B18: goto B19v6; 
B27: goto B28v9; 
B19v6: 
	if 
	:: goto B20v6; 
	:: memory[v6] = 2; goto B19; 
	fi;
B28v9: 
	if 
	:: goto B29v9; 
	:: memory[v9] = 4; goto B28; 
	fi;
B20v6: 
	if 
	:: v7 = memory[flag0]; goto B21v6; 
	:: memory[v6] = 2; goto B20; 
	fi;
B19: goto B20; 
B29v9: 
	if 
	:: v10 = memory[flag0]; goto B30v9; 
	:: memory[v9] = 4; goto B29; 
	fi;
B28: goto B29; 
B21v6: 
	if 
	:: v8 = memory[v7]; goto B22v6; 
	:: memory[v6] = 2; goto B21; 
	fi;
B20: v7 = memory[flag0]; goto B21; 
B30v9: 
	if 
	:: v11 = memory[v10]; goto B31v9; 
	:: memory[v9] = 4; goto B30; 
	fi;
B29: v10 = memory[flag0]; goto B30; 
B22v6: 
	if 
	:: cmp3 = (v8 == 4); goto B23v6; 
	:: memory[v6] = 2; goto B22; 
	fi;
B21: v8 = memory[v7]; goto B22; 
B31v9: 
	if 
	:: cmp7 = (v11 > 1); goto B32v9; 
	:: memory[v9] = 4; goto B31; 
	fi;
B30: v11 = memory[v10]; goto B31; 
B23v6: 
	if 
	::cmp3 -> goto B24v6; 
	::!cmp3 -> goto B25v6; 
	:: memory[v6] = 2; goto B23; 
	fi;
B22: cmp3 = (v8 == 4); goto B23; 
B32v9: 
	if 
	::cmp7 -> goto B33v9; 
	::!cmp7 -> goto B34v9; 
	:: memory[v9] = 4; goto B32; 
	fi;
B31: cmp7 = (v11 > 1); goto B32; 
B24v6: 
	if 
	:: goto B20v6; 
	:: memory[v6] = 2; goto B24; 
	fi;
B25v6: 
	if 
	:: goto B26v6; 
	:: memory[v6] = 2; goto B25; 
	fi;
B23: 
	if 
	::cmp3 -> goto B24; 
	::!cmp3 -> goto B25; 
	fi;
B33v9: 
	if 
	:: goto B29v9; 
	:: memory[v9] = 4; goto B33; 
	fi;
B34v9: 
	if 
	:: v12 = memory[flag1]; goto B35v9; 
	:: memory[v9] = 4; goto B34; 
	fi;
B32: 
	if 
	::cmp7 -> goto B33; 
	::!cmp7 -> goto B34; 
	fi;
B24: goto B20; 
B26v6: 
	if 
	:: v9 = memory[flag1]; goto B27v6; 
	:: memory[v6] = 2; goto B26; 
	fi;
B25: goto B26; 
B33: goto B29; 
B35v9: 
	if 
	:: goto B36v9v12; 
	:: memory[v9] = 4; goto B35; 
	fi;
B34: v12 = memory[flag1]; goto B35; 
B27v6: 
	if 
	:: goto B28v6v9; 
	:: memory[v6] = 2; goto B27; 
	fi;
B36v9v12: memory[v9] = 4; goto B36v12; 
B35: goto B36v12; 
B28v6v9: 
	if 
	:: goto B29v6v9; 
	:: memory[v6] = 2; goto B28v9; 
	fi;
B36v12: memory[v12] = 0; goto B36; 
B29v6v9: 
	if 
	:: v10 = memory[flag0]; goto B30v6v9; 
	:: memory[v6] = 2; goto B29v9; 
	fi;
B36: goto BEnd;
B30v6v9: 
	if 
	:: v11 = memory[v10]; goto B31v6v9; 
	:: memory[v6] = 2; goto B30v9; 
	fi;
B31v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B32v6v9; 
	:: memory[v6] = 2; goto B31v9; 
	fi;
B32v6v9: 
	if 
	::cmp7 -> goto B33v6v9; 
	::!cmp7 -> goto B34v6v9; 
	:: memory[v6] = 2; goto B32v9; 
	fi;
B33v6v9: 
	if 
	:: goto B29v6v9; 
	:: memory[v6] = 2; goto B33v9; 
	fi;
B34v6v9: 
	if 
	:: v12 = memory[flag1]; goto B35v6v9; 
	:: memory[v6] = 2; goto B34v9; 
	fi;
B35v6v9: 
	if 
	:: goto B36v6v9v12; 
	:: memory[v6] = 2; goto B35v9; 
	fi;
B36v6v9v12: memory[v6] = 2; goto B36v9v12; 
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

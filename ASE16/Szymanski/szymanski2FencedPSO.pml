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
AStart: goto A000;
A000: goto A001; 
A001: v0 = memory[flag0]; goto A002; 
A002: goto A003v0; 
A003v0: memory[v0] = 1; goto A003; 
A003: goto A004; 
A004: goto A005; 
A005: v1 = memory[flag1]; goto A006; 
A006: v2 = memory[v1]; goto A007; 
A007: cmp = (v2 > 2); goto A008; 
A008: 
	if 
	::cmp -> goto A009; 
	::!cmp -> goto A010; 
	fi;
A009: goto A005; 
A010: v3 = memory[flag0]; goto A011; 
A011: goto A012v3; 
A012v3: memory[v3] = 3; goto A012; 
A012: goto A013; 
A013: v4 = memory[flag1]; goto A014; 
A014: v5 = memory[v4]; goto A015; 
A015: cmp1 = (v5 == 1); goto A016; 
A016: 
	if 
	::cmp1 -> goto A017; 
	::!cmp1 -> goto A026; 
	fi;
A017: v6 = memory[flag0]; goto A018; 
A026: v9 = memory[flag0]; goto A027; 
A018: goto A019v6; 
A027: goto A028v9; 
A019v6: 
	if 
	:: goto A020v6; 
	:: memory[v6] = 2; goto A019; 
	fi;
A028v9: 
	if 
	:: goto A029v9; 
	:: memory[v9] = 4; goto A028; 
	fi;
A020v6: 
	if 
	:: v7 = memory[flag1]; goto A021v6; 
	:: memory[v6] = 2; goto A020; 
	fi;
A019: goto A020; 
A029v9: 
	if 
	:: v10 = memory[flag1]; goto A030v9; 
	:: memory[v9] = 4; goto A029; 
	fi;
A028: goto A029; 
A021v6: 
	if 
	:: v8 = memory[v7]; goto A022v6; 
	:: memory[v6] = 2; goto A021; 
	fi;
A020: v7 = memory[flag1]; goto A021; 
A030v9: 
	if 
	:: v11 = memory[v10]; goto A031v9; 
	:: memory[v9] = 4; goto A030; 
	fi;
A029: v10 = memory[flag1]; goto A030; 
A022v6: 
	if 
	:: cmp3 = (v8 == 4); goto A023v6; 
	:: memory[v6] = 2; goto A022; 
	fi;
A021: v8 = memory[v7]; goto A022; 
A031v9: 
	if 
	:: cmp7 = (v11 == 2); goto A032v9; 
	:: memory[v9] = 4; goto A031; 
	fi;
A030: v11 = memory[v10]; goto A031; 
A023v6: 
	if 
	::cmp3 -> goto A024v6; 
	::!cmp3 -> goto A025v6; 
	:: memory[v6] = 2; goto A023; 
	fi;
A022: cmp3 = (v8 == 4); goto A023; 
A032v9: 
	if 
	::cmp7 -> v14 = true; goto A037v9; 
	::!cmp7 -> goto A033v9; 
	:: memory[v9] = 4; goto A032; 
	fi;
A031: cmp7 = (v11 == 2); goto A032; 
A024v6: 
	if 
	:: goto A020v6; 
	:: memory[v6] = 2; goto A024; 
	fi;
A025v6: 
	if 
	:: goto A026v6; 
	:: memory[v6] = 2; goto A025; 
	fi;
A023: 
	if 
	::cmp3 -> goto A024; 
	::!cmp3 -> goto A025; 
	fi;
A037v9: 
	if 
	:: goto A038v9; 
	:: memory[v9] = 4; goto A037; 
	fi;
A033v9: 
	if 
	:: v12 = memory[flag1]; goto A034v9; 
	:: memory[v9] = 4; goto A033; 
	fi;
A032: 
	if 
	::cmp7 -> v14 = true; goto A037; 
	::!cmp7 -> goto A033; 
	fi;
A024: goto A020; 
A026v6: 
	if 
	:: v9 = memory[flag0]; goto A027v6; 
	:: memory[v6] = 2; goto A026; 
	fi;
A025: goto A026; 
A038v9: 
	if 
	::v14 -> goto A039v9; 
	::!v14 -> goto A040v9; 
	:: memory[v9] = 4; goto A038; 
	fi;
A037: goto A038; 
A034v9: 
	if 
	:: v13 = memory[v12]; goto A035v9; 
	:: memory[v9] = 4; goto A034; 
	fi;
A033: v12 = memory[flag1]; goto A034; 
A027v6: 
	if 
	:: goto A028v6v9; 
	:: memory[v6] = 2; goto A027; 
	fi;
A039v9: 
	if 
	:: goto A029v9; 
	:: memory[v9] = 4; goto A039; 
	fi;
A040v9: 
	if 
	:: v15 = memory[flag0]; goto A041v9; 
	:: memory[v9] = 4; goto A040; 
	fi;
A038: 
	if 
	::v14 -> goto A039; 
	::!v14 -> goto A040; 
	fi;
A035v9: 
	if 
	:: cmp8 = (v13 == 3); goto A036v9; 
	:: memory[v9] = 4; goto A035; 
	fi;
A034: v13 = memory[v12]; goto A035; 
A028v6v9: 
	if 
	:: goto A029v6v9; 
	:: memory[v6] = 2; goto A028v9; 
	:: memory[v9] = 4; goto A028v6; 
	fi;
A039: goto A029; 
A041v9: 
	if 
	:: goto A042v9v15; 
	:: memory[v9] = 4; goto A041; 
	fi;
A040: v15 = memory[flag0]; goto A041; 
A036v9: 
	if 
	:: v14 = cmp8; goto A037v9; 
	:: memory[v9] = 4; goto A036; 
	fi;
A035: cmp8 = (v13 == 3); goto A036; 
A029v6v9: 
	if 
	:: v10 = memory[flag1]; goto A030v6v9; 
	:: memory[v6] = 2; goto A029v9; 
	:: memory[v9] = 4; goto A029v6; 
	fi;
A028v6: 
	if 
	:: goto A029v6; 
	:: memory[v6] = 2; goto A028; 
	fi;
A042v9v15: 
	if 
	:: memory[v9] = 4; goto A042v15; 
	:: memory[v15] = 0; goto A042v9; 
	fi;
A041: goto A042v15; 
A036: v14 = cmp8; goto A037; 
A030v6v9: 
	if 
	:: v11 = memory[v10]; goto A031v6v9; 
	:: memory[v6] = 2; goto A030v9; 
	:: memory[v9] = 4; goto A030v6; 
	fi;
A029v6: 
	if 
	:: v10 = memory[flag1]; goto A030v6; 
	:: memory[v6] = 2; goto A029; 
	fi;
A042v15: memory[v15] = 0; goto A042; 
A042v9: memory[v9] = 4; goto A042; 
A031v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A032v6v9; 
	:: memory[v6] = 2; goto A031v9; 
	:: memory[v9] = 4; goto A031v6; 
	fi;
A030v6: 
	if 
	:: v11 = memory[v10]; goto A031v6; 
	:: memory[v6] = 2; goto A030; 
	fi;
A042: goto AEnd;
A032v6v9: 
	if 
	::cmp7 -> v14 = true; goto A037v6v9; 
	::!cmp7 -> goto A033v6v9; 
	:: memory[v6] = 2; goto A032v9; 
	:: memory[v9] = 4; goto A032v6; 
	fi;
A031v6: 
	if 
	:: cmp7 = (v11 == 2); goto A032v6; 
	:: memory[v6] = 2; goto A031; 
	fi;
A037v6v9: 
	if 
	:: goto A038v6v9; 
	:: memory[v6] = 2; goto A037v9; 
	:: memory[v9] = 4; goto A037v6; 
	fi;
A033v6v9: 
	if 
	:: v12 = memory[flag1]; goto A034v6v9; 
	:: memory[v6] = 2; goto A033v9; 
	:: memory[v9] = 4; goto A033v6; 
	fi;
A032v6: 
	if 
	::cmp7 -> v14 = true; goto A037v6; 
	::!cmp7 -> goto A033v6; 
	:: memory[v6] = 2; goto A032; 
	fi;
A038v6v9: 
	if 
	::v14 -> goto A039v6v9; 
	::!v14 -> goto A040v6v9; 
	:: memory[v6] = 2; goto A038v9; 
	:: memory[v9] = 4; goto A038v6; 
	fi;
A037v6: 
	if 
	:: goto A038v6; 
	:: memory[v6] = 2; goto A037; 
	fi;
A034v6v9: 
	if 
	:: v13 = memory[v12]; goto A035v6v9; 
	:: memory[v6] = 2; goto A034v9; 
	:: memory[v9] = 4; goto A034v6; 
	fi;
A033v6: 
	if 
	:: v12 = memory[flag1]; goto A034v6; 
	:: memory[v6] = 2; goto A033; 
	fi;
A039v6v9: 
	if 
	:: goto A029v6v9; 
	:: memory[v6] = 2; goto A039v9; 
	:: memory[v9] = 4; goto A039v6; 
	fi;
A040v6v9: 
	if 
	:: v15 = memory[flag0]; goto A041v6v9; 
	:: memory[v6] = 2; goto A040v9; 
	:: memory[v9] = 4; goto A040v6; 
	fi;
A038v6: 
	if 
	::v14 -> goto A039v6; 
	::!v14 -> goto A040v6; 
	:: memory[v6] = 2; goto A038; 
	fi;
A035v6v9: 
	if 
	:: cmp8 = (v13 == 3); goto A036v6v9; 
	:: memory[v6] = 2; goto A035v9; 
	:: memory[v9] = 4; goto A035v6; 
	fi;
A034v6: 
	if 
	:: v13 = memory[v12]; goto A035v6; 
	:: memory[v6] = 2; goto A034; 
	fi;
A039v6: 
	if 
	:: goto A029v6; 
	:: memory[v6] = 2; goto A039; 
	fi;
A041v6v9: 
	if 
	:: goto A042v6v9v15; 
	:: memory[v6] = 2; goto A041v9; 
	:: memory[v9] = 4; goto A041v6; 
	fi;
A040v6: 
	if 
	:: v15 = memory[flag0]; goto A041v6; 
	:: memory[v6] = 2; goto A040; 
	fi;
A036v6v9: 
	if 
	:: v14 = cmp8; goto A037v6v9; 
	:: memory[v6] = 2; goto A036v9; 
	:: memory[v9] = 4; goto A036v6; 
	fi;
A035v6: 
	if 
	:: cmp8 = (v13 == 3); goto A036v6; 
	:: memory[v6] = 2; goto A035; 
	fi;
A042v6v9v15: 
	if 
	:: memory[v6] = 2; goto A042v9v15; 
	:: memory[v9] = 4; goto A042v6v15; 
	:: memory[v15] = 0; goto A042v6v9; 
	fi;
A041v6: 
	if 
	:: goto A042v6v15; 
	:: memory[v6] = 2; goto A041; 
	fi;
A036v6: 
	if 
	:: v14 = cmp8; goto A037v6; 
	:: memory[v6] = 2; goto A036; 
	fi;
A042v6v15: 
	if 
	:: memory[v6] = 2; goto A042v15; 
	:: memory[v15] = 0; goto A042v6; 
	fi;
A042v6v9: 
	if 
	:: memory[v6] = 2; goto A042v9; 
	:: memory[v9] = 4; goto A042v6; 
	fi;
A042v6: memory[v6] = 2; goto A042; 
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
B36v9v12: 
	if 
	:: memory[v9] = 4; goto B36v12; 
	:: memory[v12] = 0; goto B36v9; 
	fi;
B35: goto B36v12; 
B28v6v9: 
	if 
	:: goto B29v6v9; 
	:: memory[v6] = 2; goto B28v9; 
	:: memory[v9] = 4; goto B28v6; 
	fi;
B36v12: memory[v12] = 0; goto B36; 
B36v9: memory[v9] = 4; goto B36; 
B29v6v9: 
	if 
	:: v10 = memory[flag0]; goto B30v6v9; 
	:: memory[v6] = 2; goto B29v9; 
	:: memory[v9] = 4; goto B29v6; 
	fi;
B28v6: 
	if 
	:: goto B29v6; 
	:: memory[v6] = 2; goto B28; 
	fi;
B36: goto BEnd;
B30v6v9: 
	if 
	:: v11 = memory[v10]; goto B31v6v9; 
	:: memory[v6] = 2; goto B30v9; 
	:: memory[v9] = 4; goto B30v6; 
	fi;
B29v6: 
	if 
	:: v10 = memory[flag0]; goto B30v6; 
	:: memory[v6] = 2; goto B29; 
	fi;
B31v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B32v6v9; 
	:: memory[v6] = 2; goto B31v9; 
	:: memory[v9] = 4; goto B31v6; 
	fi;
B30v6: 
	if 
	:: v11 = memory[v10]; goto B31v6; 
	:: memory[v6] = 2; goto B30; 
	fi;
B32v6v9: 
	if 
	::cmp7 -> goto B33v6v9; 
	::!cmp7 -> goto B34v6v9; 
	:: memory[v6] = 2; goto B32v9; 
	:: memory[v9] = 4; goto B32v6; 
	fi;
B31v6: 
	if 
	:: cmp7 = (v11 > 1); goto B32v6; 
	:: memory[v6] = 2; goto B31; 
	fi;
B33v6v9: 
	if 
	:: goto B29v6v9; 
	:: memory[v6] = 2; goto B33v9; 
	:: memory[v9] = 4; goto B33v6; 
	fi;
B34v6v9: 
	if 
	:: v12 = memory[flag1]; goto B35v6v9; 
	:: memory[v6] = 2; goto B34v9; 
	:: memory[v9] = 4; goto B34v6; 
	fi;
B32v6: 
	if 
	::cmp7 -> goto B33v6; 
	::!cmp7 -> goto B34v6; 
	:: memory[v6] = 2; goto B32; 
	fi;
B33v6: 
	if 
	:: goto B29v6; 
	:: memory[v6] = 2; goto B33; 
	fi;
B35v6v9: 
	if 
	:: goto B36v6v9v12; 
	:: memory[v6] = 2; goto B35v9; 
	:: memory[v9] = 4; goto B35v6; 
	fi;
B34v6: 
	if 
	:: v12 = memory[flag1]; goto B35v6; 
	:: memory[v6] = 2; goto B34; 
	fi;
B36v6v9v12: 
	if 
	:: memory[v6] = 2; goto B36v9v12; 
	:: memory[v9] = 4; goto B36v6v12; 
	:: memory[v12] = 0; goto B36v6v9; 
	fi;
B35v6: 
	if 
	:: goto B36v6v12; 
	:: memory[v6] = 2; goto B35; 
	fi;
B36v6v12: 
	if 
	:: memory[v6] = 2; goto B36v12; 
	:: memory[v12] = 0; goto B36v6; 
	fi;
B36v6v9: 
	if 
	:: memory[v6] = 2; goto B36v9; 
	:: memory[v9] = 4; goto B36v6; 
	fi;
B36v6: memory[v6] = 2; goto B36; 
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

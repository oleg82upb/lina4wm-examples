#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short i = 1;
short j = 1;

//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline t1(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
AStart: goto A00;
A00: v0 = memory[j]; goto A01; 
A01: v1 = memory[i]; goto A02; 
A02: add = v1 + v0; goto A03; 
A03: goto A04i; 
A04i: 
	if 
	:: v2 = memory[j]; goto A05i; 
	:: memory[i] = add; goto A04; 
	fi;
A05i: 
	if 
	:: v3 = memory[i]; goto A06i; 
	:: memory[i] = add; goto A05; 
	fi;
A04: v2 = memory[j]; goto A05; 
A06i: 
	if 
	:: add_1 = v3 + v2; goto A07i; 
	:: memory[i] = add; goto A06; 
	fi;
A05: v3 = memory[i]; goto A06; 
A07i: 
	if 
	:: goto A08i; 
	:: memory[i] = add; goto A07; 
	fi;
A06: add_1 = v3 + v2; goto A07; 
A08i: 
	if 
	:: v4 = memory[j]; goto A09i; 
	:: memory[i] = add; goto A08iadd_1; 
	fi;
A07: goto A08iadd_1; 
A09i: 
	if 
	:: v5 = memory[i]; goto A10i; 
	:: memory[i] = add; goto A09iadd_1; 
	fi;
A08iadd_1: 
	if 
	:: v4 = memory[j]; goto A09iadd_1; 
	:: memory[i] = add_1; goto A08; 
	fi;
A10i: 
	if 
	:: add_2 = v5 + v4; goto A11i; 
	:: memory[i] = add; goto A10iadd_1; 
	fi;
A09iadd_1: 
	if 
	:: v5 = memory[i]; goto A10iadd_1; 
	:: memory[i] = add_1; goto A09; 
	fi;
A08: v4 = memory[j]; goto A09; 
A11i: 
	if 
	:: goto A12i; 
	:: memory[i] = add; goto A11iadd_1; 
	fi;
A10iadd_1: 
	if 
	:: add_2 = v5 + v4; goto A11iadd_1; 
	:: memory[i] = add_1; goto A10; 
	fi;
A09: v5 = memory[i]; goto A10; 
A12i: 
	if 
	:: v6 = memory[j]; goto A13i; 
	:: memory[i] = add; goto A12iadd_1add_2; 
	fi;
A11iadd_1: 
	if 
	:: goto A12iadd_1add_2; 
	:: memory[i] = add_1; goto A11; 
	fi;
A10: add_2 = v5 + v4; goto A11; 
A13i: 
	if 
	:: v7 = memory[i]; goto A14i; 
	:: memory[i] = add; goto A13iadd_1add_2; 
	fi;
A12iadd_1add_2: 
	if 
	:: v6 = memory[j]; goto A13iadd_1add_2; 
	:: memory[i] = add_1; goto A12iadd_2; 
	fi;
A11: goto A12iadd_2; 
A14i: 
	if 
	:: add_3 = v7 + v6; goto A15i; 
	:: memory[i] = add; goto A14iadd_1add_2; 
	fi;
A13iadd_1add_2: 
	if 
	:: v7 = memory[i]; goto A14iadd_1add_2; 
	:: memory[i] = add_1; goto A13iadd_2; 
	fi;
A12iadd_2: 
	if 
	:: v6 = memory[j]; goto A13iadd_2; 
	:: memory[i] = add_2; goto A12; 
	fi;
A15i: 
	if 
	:: goto A16i; 
	:: memory[i] = add; goto A15iadd_1add_2; 
	fi;
A14iadd_1add_2: 
	if 
	:: add_3 = v7 + v6; goto A15iadd_1add_2; 
	:: memory[i] = add_1; goto A14iadd_2; 
	fi;
A13iadd_2: 
	if 
	:: v7 = memory[i]; goto A14iadd_2; 
	:: memory[i] = add_2; goto A13; 
	fi;
A12: v6 = memory[j]; goto A13; 
A16i: 
	if 
	:: v8 = memory[j]; goto A17i; 
	:: memory[i] = add; goto A16iadd_1add_2add_3; 
	fi;
A15iadd_1add_2: 
	if 
	:: goto A16iadd_1add_2add_3; 
	:: memory[i] = add_1; goto A15iadd_2; 
	fi;
A14iadd_2: 
	if 
	:: add_3 = v7 + v6; goto A15iadd_2; 
	:: memory[i] = add_2; goto A14; 
	fi;
A13: v7 = memory[i]; goto A14; 
A17i: 
	if 
	:: v9 = memory[i]; goto A18i; 
	:: memory[i] = add; goto A17iadd_1add_2add_3; 
	fi;
A16iadd_1add_2add_3: 
	if 
	:: v8 = memory[j]; goto A17iadd_1add_2add_3; 
	:: memory[i] = add_1; goto A16iadd_2add_3; 
	fi;
A15iadd_2: 
	if 
	:: goto A16iadd_2add_3; 
	:: memory[i] = add_2; goto A15; 
	fi;
A14: add_3 = v7 + v6; goto A15; 
A18i: 
	if 
	:: add_4 = v9 + v8; goto A19i; 
	:: memory[i] = add; goto A18iadd_1add_2add_3; 
	fi;
A17iadd_1add_2add_3: 
	if 
	:: v9 = memory[i]; goto A18iadd_1add_2add_3; 
	:: memory[i] = add_1; goto A17iadd_2add_3; 
	fi;
A16iadd_2add_3: 
	if 
	:: v8 = memory[j]; goto A17iadd_2add_3; 
	:: memory[i] = add_2; goto A16iadd_3; 
	fi;
A15: goto A16iadd_3; 
A19i: 
	if 
	:: goto A20i; 
	:: memory[i] = add; goto A19iadd_1add_2add_3; 
	fi;
A18iadd_1add_2add_3: 
	if 
	:: add_4 = v9 + v8; goto A19iadd_1add_2add_3; 
	:: memory[i] = add_1; goto A18iadd_2add_3; 
	fi;
A17iadd_2add_3: 
	if 
	:: v9 = memory[i]; goto A18iadd_2add_3; 
	:: memory[i] = add_2; goto A17iadd_3; 
	fi;
A16iadd_3: 
	if 
	:: v8 = memory[j]; goto A17iadd_3; 
	:: memory[i] = add_3; goto A16; 
	fi;
A20i: memory[i] = add; goto A20iadd_1add_2add_3add_4; 
A19iadd_1add_2add_3: 
	if 
	:: goto A20iadd_1add_2add_3add_4; 
	:: memory[i] = add_1; goto A19iadd_2add_3; 
	fi;
A18iadd_2add_3: 
	if 
	:: add_4 = v9 + v8; goto A19iadd_2add_3; 
	:: memory[i] = add_2; goto A18iadd_3; 
	fi;
A17iadd_3: 
	if 
	:: v9 = memory[i]; goto A18iadd_3; 
	:: memory[i] = add_3; goto A17; 
	fi;
A16: v8 = memory[j]; goto A17; 
A20iadd_1add_2add_3add_4: memory[i] = add_1; goto A20iadd_2add_3add_4; 
A19iadd_2add_3: 
	if 
	:: goto A20iadd_2add_3add_4; 
	:: memory[i] = add_2; goto A19iadd_3; 
	fi;
A18iadd_3: 
	if 
	:: add_4 = v9 + v8; goto A19iadd_3; 
	:: memory[i] = add_3; goto A18; 
	fi;
A17: v9 = memory[i]; goto A18; 
A20iadd_2add_3add_4: memory[i] = add_2; goto A20iadd_3add_4; 
A19iadd_3: 
	if 
	:: goto A20iadd_3add_4; 
	:: memory[i] = add_3; goto A19; 
	fi;
A18: add_4 = v9 + v8; goto A19; 
A20iadd_3add_4: memory[i] = add_3; goto A20iadd_4; 
A19: goto A20iadd_4; 
A20iadd_4: memory[i] = add_4; goto A20; 
A20: returnvalue = null; goto AEnd;
AEnd: skip;

}


inline t2(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
BStart: goto B00;
B00: v0 = memory[i]; goto B01; 
B01: v1 = memory[j]; goto B02; 
B02: add = v1 + v0; goto B03; 
B03: goto B04j; 
B04j: 
	if 
	:: v2 = memory[i]; goto B05j; 
	:: memory[j] = add; goto B04; 
	fi;
B05j: 
	if 
	:: v3 = memory[j]; goto B06j; 
	:: memory[j] = add; goto B05; 
	fi;
B04: v2 = memory[i]; goto B05; 
B06j: 
	if 
	:: add_1 = v3 + v2; goto B07j; 
	:: memory[j] = add; goto B06; 
	fi;
B05: v3 = memory[j]; goto B06; 
B07j: 
	if 
	:: goto B08j; 
	:: memory[j] = add; goto B07; 
	fi;
B06: add_1 = v3 + v2; goto B07; 
B08j: 
	if 
	:: v4 = memory[i]; goto B09j; 
	:: memory[j] = add; goto B08jadd_1; 
	fi;
B07: goto B08jadd_1; 
B09j: 
	if 
	:: v5 = memory[j]; goto B10j; 
	:: memory[j] = add; goto B09jadd_1; 
	fi;
B08jadd_1: 
	if 
	:: v4 = memory[i]; goto B09jadd_1; 
	:: memory[j] = add_1; goto B08; 
	fi;
B10j: 
	if 
	:: add_2 = v5 + v4; goto B11j; 
	:: memory[j] = add; goto B10jadd_1; 
	fi;
B09jadd_1: 
	if 
	:: v5 = memory[j]; goto B10jadd_1; 
	:: memory[j] = add_1; goto B09; 
	fi;
B08: v4 = memory[i]; goto B09; 
B11j: 
	if 
	:: goto B12j; 
	:: memory[j] = add; goto B11jadd_1; 
	fi;
B10jadd_1: 
	if 
	:: add_2 = v5 + v4; goto B11jadd_1; 
	:: memory[j] = add_1; goto B10; 
	fi;
B09: v5 = memory[j]; goto B10; 
B12j: 
	if 
	:: v6 = memory[i]; goto B13j; 
	:: memory[j] = add; goto B12jadd_1add_2; 
	fi;
B11jadd_1: 
	if 
	:: goto B12jadd_1add_2; 
	:: memory[j] = add_1; goto B11; 
	fi;
B10: add_2 = v5 + v4; goto B11; 
B13j: 
	if 
	:: v7 = memory[j]; goto B14j; 
	:: memory[j] = add; goto B13jadd_1add_2; 
	fi;
B12jadd_1add_2: 
	if 
	:: v6 = memory[i]; goto B13jadd_1add_2; 
	:: memory[j] = add_1; goto B12jadd_2; 
	fi;
B11: goto B12jadd_2; 
B14j: 
	if 
	:: add_3 = v7 + v6; goto B15j; 
	:: memory[j] = add; goto B14jadd_1add_2; 
	fi;
B13jadd_1add_2: 
	if 
	:: v7 = memory[j]; goto B14jadd_1add_2; 
	:: memory[j] = add_1; goto B13jadd_2; 
	fi;
B12jadd_2: 
	if 
	:: v6 = memory[i]; goto B13jadd_2; 
	:: memory[j] = add_2; goto B12; 
	fi;
B15j: 
	if 
	:: goto B16j; 
	:: memory[j] = add; goto B15jadd_1add_2; 
	fi;
B14jadd_1add_2: 
	if 
	:: add_3 = v7 + v6; goto B15jadd_1add_2; 
	:: memory[j] = add_1; goto B14jadd_2; 
	fi;
B13jadd_2: 
	if 
	:: v7 = memory[j]; goto B14jadd_2; 
	:: memory[j] = add_2; goto B13; 
	fi;
B12: v6 = memory[i]; goto B13; 
B16j: 
	if 
	:: v8 = memory[i]; goto B17j; 
	:: memory[j] = add; goto B16jadd_1add_2add_3; 
	fi;
B15jadd_1add_2: 
	if 
	:: goto B16jadd_1add_2add_3; 
	:: memory[j] = add_1; goto B15jadd_2; 
	fi;
B14jadd_2: 
	if 
	:: add_3 = v7 + v6; goto B15jadd_2; 
	:: memory[j] = add_2; goto B14; 
	fi;
B13: v7 = memory[j]; goto B14; 
B17j: 
	if 
	:: v9 = memory[j]; goto B18j; 
	:: memory[j] = add; goto B17jadd_1add_2add_3; 
	fi;
B16jadd_1add_2add_3: 
	if 
	:: v8 = memory[i]; goto B17jadd_1add_2add_3; 
	:: memory[j] = add_1; goto B16jadd_2add_3; 
	fi;
B15jadd_2: 
	if 
	:: goto B16jadd_2add_3; 
	:: memory[j] = add_2; goto B15; 
	fi;
B14: add_3 = v7 + v6; goto B15; 
B18j: 
	if 
	:: add_4 = v9 + v8; goto B19j; 
	:: memory[j] = add; goto B18jadd_1add_2add_3; 
	fi;
B17jadd_1add_2add_3: 
	if 
	:: v9 = memory[j]; goto B18jadd_1add_2add_3; 
	:: memory[j] = add_1; goto B17jadd_2add_3; 
	fi;
B16jadd_2add_3: 
	if 
	:: v8 = memory[i]; goto B17jadd_2add_3; 
	:: memory[j] = add_2; goto B16jadd_3; 
	fi;
B15: goto B16jadd_3; 
B19j: 
	if 
	:: goto B20j; 
	:: memory[j] = add; goto B19jadd_1add_2add_3; 
	fi;
B18jadd_1add_2add_3: 
	if 
	:: add_4 = v9 + v8; goto B19jadd_1add_2add_3; 
	:: memory[j] = add_1; goto B18jadd_2add_3; 
	fi;
B17jadd_2add_3: 
	if 
	:: v9 = memory[j]; goto B18jadd_2add_3; 
	:: memory[j] = add_2; goto B17jadd_3; 
	fi;
B16jadd_3: 
	if 
	:: v8 = memory[i]; goto B17jadd_3; 
	:: memory[j] = add_3; goto B16; 
	fi;
B20j: memory[j] = add; goto B20jadd_1add_2add_3add_4; 
B19jadd_1add_2add_3: 
	if 
	:: goto B20jadd_1add_2add_3add_4; 
	:: memory[j] = add_1; goto B19jadd_2add_3; 
	fi;
B18jadd_2add_3: 
	if 
	:: add_4 = v9 + v8; goto B19jadd_2add_3; 
	:: memory[j] = add_2; goto B18jadd_3; 
	fi;
B17jadd_3: 
	if 
	:: v9 = memory[j]; goto B18jadd_3; 
	:: memory[j] = add_3; goto B17; 
	fi;
B16: v8 = memory[i]; goto B17; 
B20jadd_1add_2add_3add_4: memory[j] = add_1; goto B20jadd_2add_3add_4; 
B19jadd_2add_3: 
	if 
	:: goto B20jadd_2add_3add_4; 
	:: memory[j] = add_2; goto B19jadd_3; 
	fi;
B18jadd_3: 
	if 
	:: add_4 = v9 + v8; goto B19jadd_3; 
	:: memory[j] = add_3; goto B18; 
	fi;
B17: v9 = memory[j]; goto B18; 
B20jadd_2add_3add_4: memory[j] = add_2; goto B20jadd_3add_4; 
B19jadd_3: 
	if 
	:: goto B20jadd_3add_4; 
	:: memory[j] = add_3; goto B19; 
	fi;
B18: add_4 = v9 + v8; goto B19; 
B20jadd_3add_4: memory[j] = add_3; goto B20jadd_4; 
B19: goto B20jadd_4; 
B20jadd_4: memory[j] = add_4; goto B20; 
B20: returnvalue = null; goto BEnd;
BEnd: skip;

}


//Stubs
proctype process1(){
	short arg, returnvalue;
	t1(arg, returnvalue);
	end: skip;
}

proctype process2(){
	short arg, returnvalue;
	t2(arg, returnvalue);
	end: skip;
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, i);
	alloca(1, j);
	

	run process1();
	run process2();
	}
}


ltl prop{ [] !((process1@end) && (process2@end) && (i> 144 || j > 144))}
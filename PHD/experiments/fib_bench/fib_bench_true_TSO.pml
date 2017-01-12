#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short i = 1;
short j = 2;



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
	:: v3 = add; goto A06i; 
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
	:: goto A08ii; 
	:: memory[i] = add; goto A07; 
	fi;
A06: add_1 = v3 + v2; goto A07; 
A08ii: 
	if 
	:: v4 = memory[j]; goto A09ii; 
	:: memory[i] = add; goto A08i; 
	fi;
A07: goto A08i; 
A09ii: 
	if 
	:: v5 = add_1; goto A10ii; 
	:: memory[i] = add; goto A09i; 
	fi;
A08i: 
	if 
	:: v4 = memory[j]; goto A09i; 
	:: memory[i] = add_1; goto A08; 
	fi;
A10ii: 
	if 
	:: add_2 = v5 + v4; goto A11ii; 
	:: memory[i] = add; goto A10i; 
	fi;
A09i: 
	if 
	:: v5 = add_1; goto A10i; 
	:: memory[i] = add_1; goto A09; 
	fi;
A08: v4 = memory[j]; goto A09; 
A11ii: 
	if 
	:: goto A12iii; 
	:: memory[i] = add; goto A11i; 
	fi;
A10i: 
	if 
	:: add_2 = v5 + v4; goto A11i; 
	:: memory[i] = add_1; goto A10; 
	fi;
A09: v5 = memory[i]; goto A10; 
A12iii: 
	if 
	:: v6 = memory[j]; goto A13iii; 
	:: memory[i] = add; goto A12ii; 
	fi;
A11i: 
	if 
	:: goto A12ii; 
	:: memory[i] = add_1; goto A11; 
	fi;
A10: add_2 = v5 + v4; goto A11; 
A13iii: 
	if 
	:: v7 = add_2; goto A14iii; 
	:: memory[i] = add; goto A13ii; 
	fi;
A12ii: 
	if 
	:: v6 = memory[j]; goto A13ii; 
	:: memory[i] = add_1; goto A12i; 
	fi;
A11: goto A12i; 
A14iii: 
	if 
	:: add_3 = v7 + v6; goto A15iii; 
	:: memory[i] = add; goto A14ii; 
	fi;
A13ii: 
	if 
	:: v7 = add_2; goto A14ii; 
	:: memory[i] = add_1; goto A13i; 
	fi;
A12i: 
	if 
	:: v6 = memory[j]; goto A13i; 
	:: memory[i] = add_2; goto A12; 
	fi;
A15iii: 
	if 
	:: goto A16iiii; 
	:: memory[i] = add; goto A15ii; 
	fi;
A14ii: 
	if 
	:: add_3 = v7 + v6; goto A15ii; 
	:: memory[i] = add_1; goto A14i; 
	fi;
A13i: 
	if 
	:: v7 = add_2; goto A14i; 
	:: memory[i] = add_2; goto A13; 
	fi;
A12: v6 = memory[j]; goto A13; 
A16iiii: 
	if 
	:: v8 = memory[j]; goto A17iiii; 
	:: memory[i] = add; goto A16iii; 
	fi;
A15ii: 
	if 
	:: goto A16iii; 
	:: memory[i] = add_1; goto A15i; 
	fi;
A14i: 
	if 
	:: add_3 = v7 + v6; goto A15i; 
	:: memory[i] = add_2; goto A14; 
	fi;
A13: v7 = memory[i]; goto A14; 
A17iiii: 
	if 
	:: v9 = add_3; goto A18iiii; 
	:: memory[i] = add; goto A17iii; 
	fi;
A16iii: 
	if 
	:: v8 = memory[j]; goto A17iii; 
	:: memory[i] = add_1; goto A16ii; 
	fi;
A15i: 
	if 
	:: goto A16ii; 
	:: memory[i] = add_2; goto A15; 
	fi;
A14: add_3 = v7 + v6; goto A15; 
A18iiii: 
	if 
	:: add_4 = v9 + v8; goto A19iiii; 
	:: memory[i] = add; goto A18iii; 
	fi;
A17iii: 
	if 
	:: v9 = add_3; goto A18iii; 
	:: memory[i] = add_1; goto A17ii; 
	fi;
A16ii: 
	if 
	:: v8 = memory[j]; goto A17ii; 
	:: memory[i] = add_2; goto A16i; 
	fi;
A15: goto A16i; 
A19iiii: 
	if 
	:: goto A20iiiii; 
	:: memory[i] = add; goto A19iii; 
	fi;
A18iii: 
	if 
	:: add_4 = v9 + v8; goto A19iii; 
	:: memory[i] = add_1; goto A18ii; 
	fi;
A17ii: 
	if 
	:: v9 = add_3; goto A18ii; 
	:: memory[i] = add_2; goto A17i; 
	fi;
A16i: 
	if 
	:: v8 = memory[j]; goto A17i; 
	:: memory[i] = add_3; goto A16; 
	fi;
A20iiiii: memory[i] = add; goto A20iiii; 
A19iii: 
	if 
	:: goto A20iiii; 
	:: memory[i] = add_1; goto A19ii; 
	fi;
A18ii: 
	if 
	:: add_4 = v9 + v8; goto A19ii; 
	:: memory[i] = add_2; goto A18i; 
	fi;
A17i: 
	if 
	:: v9 = add_3; goto A18i; 
	:: memory[i] = add_3; goto A17; 
	fi;
A16: v8 = memory[j]; goto A17; 
A20iiii: memory[i] = add_1; goto A20iii; 
A19ii: 
	if 
	:: goto A20iii; 
	:: memory[i] = add_2; goto A19i; 
	fi;
A18i: 
	if 
	:: add_4 = v9 + v8; goto A19i; 
	:: memory[i] = add_3; goto A18; 
	fi;
A17: v9 = memory[i]; goto A18; 
A20iii: memory[i] = add_2; goto A20ii; 
A19i: 
	if 
	:: goto A20ii; 
	:: memory[i] = add_3; goto A19; 
	fi;
A18: add_4 = v9 + v8; goto A19; 
A20ii: memory[i] = add_3; goto A20i; 
A19: goto A20i; 
A20i: memory[i] = add_4; goto A20; 
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
	:: v3 = add; goto B06j; 
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
	:: goto B08jj; 
	:: memory[j] = add; goto B07; 
	fi;
B06: add_1 = v3 + v2; goto B07; 
B08jj: 
	if 
	:: v4 = memory[i]; goto B09jj; 
	:: memory[j] = add; goto B08j; 
	fi;
B07: goto B08j; 
B09jj: 
	if 
	:: v5 = add_1; goto B10jj; 
	:: memory[j] = add; goto B09j; 
	fi;
B08j: 
	if 
	:: v4 = memory[i]; goto B09j; 
	:: memory[j] = add_1; goto B08; 
	fi;
B10jj: 
	if 
	:: add_2 = v5 + v4; goto B11jj; 
	:: memory[j] = add; goto B10j; 
	fi;
B09j: 
	if 
	:: v5 = add_1; goto B10j; 
	:: memory[j] = add_1; goto B09; 
	fi;
B08: v4 = memory[i]; goto B09; 
B11jj: 
	if 
	:: goto B12jjj; 
	:: memory[j] = add; goto B11j; 
	fi;
B10j: 
	if 
	:: add_2 = v5 + v4; goto B11j; 
	:: memory[j] = add_1; goto B10; 
	fi;
B09: v5 = memory[j]; goto B10; 
B12jjj: 
	if 
	:: v6 = memory[i]; goto B13jjj; 
	:: memory[j] = add; goto B12jj; 
	fi;
B11j: 
	if 
	:: goto B12jj; 
	:: memory[j] = add_1; goto B11; 
	fi;
B10: add_2 = v5 + v4; goto B11; 
B13jjj: 
	if 
	:: v7 = add_2; goto B14jjj; 
	:: memory[j] = add; goto B13jj; 
	fi;
B12jj: 
	if 
	:: v6 = memory[i]; goto B13jj; 
	:: memory[j] = add_1; goto B12j; 
	fi;
B11: goto B12j; 
B14jjj: 
	if 
	:: add_3 = v7 + v6; goto B15jjj; 
	:: memory[j] = add; goto B14jj; 
	fi;
B13jj: 
	if 
	:: v7 = add_2; goto B14jj; 
	:: memory[j] = add_1; goto B13j; 
	fi;
B12j: 
	if 
	:: v6 = memory[i]; goto B13j; 
	:: memory[j] = add_2; goto B12; 
	fi;
B15jjj: 
	if 
	:: goto B16jjjj; 
	:: memory[j] = add; goto B15jj; 
	fi;
B14jj: 
	if 
	:: add_3 = v7 + v6; goto B15jj; 
	:: memory[j] = add_1; goto B14j; 
	fi;
B13j: 
	if 
	:: v7 = add_2; goto B14j; 
	:: memory[j] = add_2; goto B13; 
	fi;
B12: v6 = memory[i]; goto B13; 
B16jjjj: 
	if 
	:: v8 = memory[i]; goto B17jjjj; 
	:: memory[j] = add; goto B16jjj; 
	fi;
B15jj: 
	if 
	:: goto B16jjj; 
	:: memory[j] = add_1; goto B15j; 
	fi;
B14j: 
	if 
	:: add_3 = v7 + v6; goto B15j; 
	:: memory[j] = add_2; goto B14; 
	fi;
B13: v7 = memory[j]; goto B14; 
B17jjjj: 
	if 
	:: v9 = add_3; goto B18jjjj; 
	:: memory[j] = add; goto B17jjj; 
	fi;
B16jjj: 
	if 
	:: v8 = memory[i]; goto B17jjj; 
	:: memory[j] = add_1; goto B16jj; 
	fi;
B15j: 
	if 
	:: goto B16jj; 
	:: memory[j] = add_2; goto B15; 
	fi;
B14: add_3 = v7 + v6; goto B15; 
B18jjjj: 
	if 
	:: add_4 = v9 + v8; goto B19jjjj; 
	:: memory[j] = add; goto B18jjj; 
	fi;
B17jjj: 
	if 
	:: v9 = add_3; goto B18jjj; 
	:: memory[j] = add_1; goto B17jj; 
	fi;
B16jj: 
	if 
	:: v8 = memory[i]; goto B17jj; 
	:: memory[j] = add_2; goto B16j; 
	fi;
B15: goto B16j; 
B19jjjj: 
	if 
	:: goto B20jjjjj; 
	:: memory[j] = add; goto B19jjj; 
	fi;
B18jjj: 
	if 
	:: add_4 = v9 + v8; goto B19jjj; 
	:: memory[j] = add_1; goto B18jj; 
	fi;
B17jj: 
	if 
	:: v9 = add_3; goto B18jj; 
	:: memory[j] = add_2; goto B17j; 
	fi;
B16j: 
	if 
	:: v8 = memory[i]; goto B17j; 
	:: memory[j] = add_3; goto B16; 
	fi;
B20jjjjj: memory[j] = add; goto B20jjjj; 
B19jjj: 
	if 
	:: goto B20jjjj; 
	:: memory[j] = add_1; goto B19jj; 
	fi;
B18jj: 
	if 
	:: add_4 = v9 + v8; goto B19jj; 
	:: memory[j] = add_2; goto B18j; 
	fi;
B17j: 
	if 
	:: v9 = add_3; goto B18j; 
	:: memory[j] = add_3; goto B17; 
	fi;
B16: v8 = memory[i]; goto B17; 
B20jjjj: memory[j] = add_1; goto B20jjj; 
B19jj: 
	if 
	:: goto B20jjj; 
	:: memory[j] = add_2; goto B19j; 
	fi;
B18j: 
	if 
	:: add_4 = v9 + v8; goto B19j; 
	:: memory[j] = add_3; goto B18; 
	fi;
B17: v9 = memory[j]; goto B18; 
B20jjj: memory[j] = add_2; goto B20jj; 
B19j: 
	if 
	:: goto B20jj; 
	:: memory[j] = add_3; goto B19; 
	fi;
B18: add_4 = v9 + v8; goto B19; 
B20jj: memory[j] = add_3; goto B20j; 
B19: goto B20j; 
B20j: memory[j] = add_4; goto B20; 
B20: returnvalue = null; goto BEnd;

BEnd: skip; 
}




//Stubs
proctype process1(){
	short arg, returnvalue;
	t1(arg, returnvalue);
	assert(!(i> 144 || j > 144));
}

proctype process2(){
	short arg, returnvalue;
	t2(arg, returnvalue);
	assert(!(i> 144 || j > 144));
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

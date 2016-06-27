#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short i = 1;
short j = 1;
short _str = 0; //Array: please, check initialization in the init process
short _str1 = 0; //Array: please, check initialization in the init process
short _PRETTY_FUNCTION___main = 0; //Array: please, check initialization in the init process


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
A03: goto A04; 
A04: v2 = memory[j]; goto A05; 
A05: v3 = memory[i]; goto A06; 
A06: add_1 = v3 + v2; goto A07; 
A07: goto A08; 
A08: v4 = memory[j]; goto A09; 
A09: v5 = memory[i]; goto A10; 
A10: add_2 = v5 + v4; goto A11; 
A11: goto A12; 
A12: v6 = memory[j]; goto A13; 
A13: v7 = memory[i]; goto A14; 
A14: add_3 = v7 + v6; goto A15; 
A15: goto A16; 
A16: v8 = memory[j]; goto A17; 
A17: v9 = memory[i]; goto A18; 
A18: add_4 = v9 + v8; goto A19; 
A19: goto A20; 
A20: returnvalue = null; goto AEnd;
AEnd: skip;

}


inline t2(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
BStart: goto B00;
B00: v0 = memory[i]; goto B01; 
B01: v1 = memory[j]; goto B02; 
B02: add = v1 + v0; goto B03; 
B03: goto B04; 
B04: v2 = memory[i]; goto B05; 
B05: v3 = memory[j]; goto B06; 
B06: add_1 = v3 + v2; goto B07; 
B07: goto B08; 
B08: v4 = memory[i]; goto B09; 
B09: v5 = memory[j]; goto B10; 
B10: add_2 = v5 + v4; goto B11; 
B11: goto B12; 
B12: v6 = memory[i]; goto B13; 
B13: v7 = memory[j]; goto B14; 
B14: add_3 = v7 + v6; goto B15; 
B15: goto B16; 
B16: v8 = memory[i]; goto B17; 
B17: v9 = memory[j]; goto B18; 
B18: add_4 = v9 + v8; goto B19; 
B19: goto B20; 
B20: returnvalue = null; goto BEnd;
BEnd: skip;

}


inline main(argc, argv, returnvalue){
short id1, id2, call, call1, v0, cmp, v1, cmp2;
CStart: goto C00;
C00: alloca(1, id1); goto C01; 
C01: alloca(1, id2); goto C02; 
C02: pthread_create(id1, null, , null, call); goto C03; 
C03: pthread_create(id2, null, , null, call1); goto C04; 
C04: v0 = memory[i]; goto C05; 
C05: cmp = (v0 > 144); goto C06; 
C06: 
	if 
	::cmp -> goto C10; 
	::!cmp -> goto C07; 
	fi;
C10: _assert_fail(_str + 0, _str1 + 0, 47, _PRETTY_FUNCTION___main + 0); goto C11; 
C07: v1 = memory[j]; goto C08; 
C11: goto C12; 
C08: cmp2 = (v1 > 144); goto C09; 
C12: returnvalue = 0; goto CEnd;
C09: 
	if 
	::cmp2 -> goto C10; 
	::!cmp2 -> goto C12; 
	fi;
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
	alloca(1, i);
	alloca(1, j);
	alloca(2, _str);
	alloca(17, _str1);
	alloca(23, _PRETTY_FUNCTION___main);
	

	run process1();
	run process2();
	}
}

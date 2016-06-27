#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short latch1 = 1;
short flag1 = 1;
short latch2 = 0;
short flag2 = 0;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline worker_1(){
short v0, v1, tobool;
AStart: goto A00;
A00: goto A01; 
A01: v0 = memory[flag1]; goto A02; 
A02: v1 = v0 & 1; goto A03; 
A03: tobool = (v1 == 0); goto A04; 
A04: 
	if 
	::tobool -> goto A01; 
	::!tobool -> goto A05; 
	fi;
A05: goto A06; 
A06: goto A07; 
A07: goto A08; 
A08: goto A09; 
A09: goto A10; 
A10: goto A01; 
AEnd: skip;

}


inline worker_2(){
short v0, v1, tobool;
BStart: goto B00;
B00: goto B01; 
B01: v0 = memory[flag2]; goto B02; 
B02: v1 = v0 & 1; goto B03; 
B03: tobool = (v1 == 0); goto B04; 
B04: 
	if 
	::tobool -> goto B01; 
	::!tobool -> goto B05; 
	fi;
B05: goto B06; 
B06: goto B07; 
B07: goto B08; 
B08: goto B09; 
B09: goto B10; 
B10: goto B01; 
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
	alloca(1, latch1);
	alloca(1, flag1);
	alloca(1, latch2);
	alloca(1, flag2);
	

	run process1();
	run process2();
	}
}

#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short y = null;
short x = null;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline p0(){
short v1;
AStart: goto A00;
A00: goto A01x; 
A01x: 
	if 
	:: goto A02xy; 
	:: memory[x] = 1; goto A01; 
	fi;
A02xy: 
	if 
	:: memory[x] = 1; goto A02y; 
	:: memory[y] = 1; goto A02x; 
	fi;
A01: goto A02y; 
A02y: memory[y] = 1; goto A02; 
A02x: memory[x] = 1; goto A02; 
A02: goto A03; 
A03: v1 = memory[y]; goto A04; 
A04: goto AEnd;
AEnd: skip;

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
	alloca(1, y);
	alloca(1, x);
	

	run process1();
	run process2();
	}
}

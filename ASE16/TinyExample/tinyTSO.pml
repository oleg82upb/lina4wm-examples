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


//function was renamed from: @p0
inline p0schlagmichtot(){
short v0;
AStart: goto A0;
A0: goto A1x; 
A1x: 
	if 
	:: v0 = memory[y]; goto A2x; 
	:: memory[x] = 1; goto A1; 
	fi;
A2x: memory[x] = 1; goto A2; 
A1: v0 = memory[y]; goto A2; 
A2: goto AEnd;
AEnd: skip;

}


inline p1(){
short v0;
BStart: goto B0;
B0: goto B1y; 
B1y: 
	if 
	:: v0 = memory[x]; goto B2y; 
	:: memory[y] = 1; goto B1; 
	fi;
B2y: memory[y] = 1; goto B2; 
B1: v0 = memory[x]; goto B2; 
B2: goto BEnd;
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
	alloca(1, y);
	alloca(1, x);
	

	run process1();
	run process2();
	}
}

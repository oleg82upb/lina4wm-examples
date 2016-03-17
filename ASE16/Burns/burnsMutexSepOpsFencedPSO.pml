#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short f0 = 0;
short f1 = 0;
short i = 0;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}


//function was renamed from: @_Z5p1_aqv
inline p1_acq(){
short v0, tobool, conv, cmp;
AStart: goto A00;
A00: goto A01f0; 
A01f0: memory[f0] = 1; goto A01; 
A01: goto A02; 
A02: goto A03; 
A03: v0 = memory[f1]; goto A04; 
A04: tobool = v0; goto A05; 
A05: conv = tobool; goto A06; 
A06: cmp = (conv != 0); goto A07; 
A07: 
	if 
	::cmp -> goto A08; 
	::!cmp -> goto A09; 
	fi;
A08: goto A03; 
A09: goto AEnd;
AEnd: skip;

}

//function was renamed from: @_Z6p1_relv
inline p1_rel(){

BStart: goto B0;
B0: goto B1f0; 
B1f0: memory[f0] = 0; goto B1; 
B1: goto BEnd;
BEnd: skip;

}

//function was renamed from: @_Z5p2_aqv
inline p2_acq(){
short v0, tobool, conv, cmp, v1, tobool1, conv2, cmp3;
CStart: goto C00;
C00: goto C01; 
C01: goto C02; 
C02: v0 = memory[f0]; goto C03; 
C03: tobool = v0; goto C04; 
C04: conv = tobool; goto C05; 
C05: cmp = (conv != 0); goto C06; 
C06: 
	if 
	::cmp -> goto C07; 
	::!cmp -> goto C08; 
	fi;
C07: goto C02; 
C08: goto C09f1; 
C09f1: memory[f1] = 1; goto C09; 
C09: goto C10; 
C10: v1 = memory[f0]; goto C11; 
C11: tobool1 = v1; goto C12; 
C12: conv2 = tobool1; goto C13; 
C13: cmp3 = (conv2 != 0); goto C14; 
C14: 
	if 
	::cmp3 -> goto C15; 
	::!cmp3 -> goto C17; 
	fi;
C15: goto C16f1; 
C17: goto CEnd;
C16f1: 
	if 
	:: goto C01f1; 
	:: memory[f1] = 0; goto C16; 
	fi;
C01f1: 
	if 
	:: goto C02f1; 
	:: memory[f1] = 0; goto C01; 
	fi;
C16: goto C01; 
C02f1: 
	if 
	:: v0 = memory[f0]; goto C03f1; 
	:: memory[f1] = 0; goto C02; 
	fi;
C03f1: 
	if 
	:: tobool = v0; goto C04f1; 
	:: memory[f1] = 0; goto C03; 
	fi;
C04f1: 
	if 
	:: conv = tobool; goto C05f1; 
	:: memory[f1] = 0; goto C04; 
	fi;
C05f1: 
	if 
	:: cmp = (conv != 0); goto C06f1; 
	:: memory[f1] = 0; goto C05; 
	fi;
C06f1: 
	if 
	::cmp -> goto C07f1; 
	::!cmp -> goto C08f1; 
	:: memory[f1] = 0; goto C06; 
	fi;
C07f1: 
	if 
	:: goto C02f1; 
	:: memory[f1] = 0; goto C07; 
	fi;
C08f1: 
	if 
	:: goto C09f1f1; 
	:: memory[f1] = 0; goto C08; 
	fi;
C09f1f1: 
	if 
	:: memory[f1] = 0; goto C09f1; 
	:: memory[f1] = 1; goto C09f10; 
	fi;
C09f10: memory[f1] = 0; goto C09; 
CEnd: skip;

}

//function was renamed from: @_Z6p2_relv
inline p2_rel(){

DStart: goto D0;
D0: goto D1f1; 
D1f1: memory[f1] = 0; goto D1; 
D1: goto DEnd;
DEnd: skip;

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
	alloca(1, f0);
	alloca(1, f1);
	alloca(1, i);
	

	run process1();
	run process2();
	}
}

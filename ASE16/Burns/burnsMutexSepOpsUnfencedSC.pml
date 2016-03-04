#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short f0 = 0;
short f1 = 0;
short i = 0;


//standard stuff
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}


//function was renamed from: @_Z5p1_aqv
inline p1_acq(){
short v0, tobool, conv, cmp;
AStart: goto A00;
A00: goto A01; 
A01: goto A02; 
A02: v0 = memory[f1]; goto A03; 
A03: tobool = v0; goto A04; 
A04: conv = tobool; goto A05; 
A05: cmp = (conv != 0); goto A06; 
A06: 
	if 
	::cmp -> goto A07; 
	::!cmp -> goto A08; 
	fi;
A07: goto A02; 
A08: goto AEnd;
AEnd: skip;

}

//function was renamed from: @_Z6p1_relv
inline p1_rel(){

BStart: goto B0;
B0: goto B1; 
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
C08: goto C09; 
C09: v1 = memory[f0]; goto C10; 
C10: tobool1 = v1; goto C11; 
C11: conv2 = tobool1; goto C12; 
C12: cmp3 = (conv2 != 0); goto C13; 
C13: 
	if 
	::cmp3 -> goto C14; 
	::!cmp3 -> goto C16; 
	fi;
C14: goto C15; 
C16: goto CEnd;
C15: goto C01; 
CEnd: skip;

}

//function was renamed from: @_Z6p2_relv
inline p2_rel(){

DStart: goto D0;
D0: goto D1; 
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
	//TODO: empty stub

	run process1();
	run process2();
	}
}

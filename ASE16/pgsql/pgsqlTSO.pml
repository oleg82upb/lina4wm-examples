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
A05: goto A06latch1; 
A06latch1: 
	if 
	:: goto A07latch1flag1; 
	:: memory[latch1] = 0; goto A06; 
	fi;
A07latch1flag1: 
	if 
	:: goto A08latch1flag1flag2; 
	:: memory[latch1] = 0; goto A07flag1; 
	fi;
A06: goto A07flag1; 
A08latch1flag1flag2: memory[latch1] = 0; goto A08flag1flag2; 
A07flag1: 
	if 
	:: goto A08flag1flag2; 
	:: memory[flag1] = 0; goto A07; 
	fi;
A08flag1flag2: memory[flag1] = 0; goto A08flag2; 
A07: goto A08flag2; 
A08flag2: memory[flag2] = 1; goto A08; 
A08: goto A09; 
A09: goto A10latch2; 
A10latch2: 
	if 
	:: goto A01latch2; 
	:: memory[latch2] = 1; goto A10; 
	fi;
A01latch2: 
	if 
	:: v0 = memory[flag1]; goto A02latch2; 
	:: memory[latch2] = 1; goto A01; 
	fi;
A10: goto A01; 
A02latch2: 
	if 
	:: v1 = v0 & 1; goto A03latch2; 
	:: memory[latch2] = 1; goto A02; 
	fi;
A03latch2: 
	if 
	:: tobool = (v1 == 0); goto A04latch2; 
	:: memory[latch2] = 1; goto A03; 
	fi;
A04latch2: 
	if 
	::tobool -> goto A01latch2; 
	::!tobool -> goto A05latch2; 
	:: memory[latch2] = 1; goto A04; 
	fi;
A05latch2: 
	if 
	:: goto A06latch2latch1; 
	:: memory[latch2] = 1; goto A05; 
	fi;
A06latch2latch1: 
	if 
	:: goto A07latch2latch1flag1; 
	:: memory[latch2] = 1; goto A06latch1; 
	fi;
A07latch2latch1flag1: 
	if 
	:: goto A08latch2latch1flag1flag2; 
	:: memory[latch2] = 1; goto A07latch1flag1; 
	fi;
A08latch2latch1flag1flag2: memory[latch2] = 1; goto A08latch1flag1flag2; 
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
B05: goto B06latch2; 
B06latch2: 
	if 
	:: goto B07latch2flag2; 
	:: memory[latch2] = 0; goto B06; 
	fi;
B07latch2flag2: 
	if 
	:: goto B08latch2flag2flag1; 
	:: memory[latch2] = 0; goto B07flag2; 
	fi;
B06: goto B07flag2; 
B08latch2flag2flag1: memory[latch2] = 0; goto B08flag2flag1; 
B07flag2: 
	if 
	:: goto B08flag2flag1; 
	:: memory[flag2] = 0; goto B07; 
	fi;
B08flag2flag1: memory[flag2] = 0; goto B08flag1; 
B07: goto B08flag1; 
B08flag1: memory[flag1] = 1; goto B08; 
B08: goto B09; 
B09: goto B10latch1; 
B10latch1: 
	if 
	:: goto B01latch1; 
	:: memory[latch1] = 1; goto B10; 
	fi;
B01latch1: 
	if 
	:: v0 = memory[flag2]; goto B02latch1; 
	:: memory[latch1] = 1; goto B01; 
	fi;
B10: goto B01; 
B02latch1: 
	if 
	:: v1 = v0 & 1; goto B03latch1; 
	:: memory[latch1] = 1; goto B02; 
	fi;
B03latch1: 
	if 
	:: tobool = (v1 == 0); goto B04latch1; 
	:: memory[latch1] = 1; goto B03; 
	fi;
B04latch1: 
	if 
	::tobool -> goto B01latch1; 
	::!tobool -> goto B05latch1; 
	:: memory[latch1] = 1; goto B04; 
	fi;
B05latch1: 
	if 
	:: goto B06latch1latch2; 
	:: memory[latch1] = 1; goto B05; 
	fi;
B06latch1latch2: 
	if 
	:: goto B07latch1latch2flag2; 
	:: memory[latch1] = 1; goto B06latch2; 
	fi;
B07latch1latch2flag2: 
	if 
	:: goto B08latch1latch2flag2flag1; 
	:: memory[latch1] = 1; goto B07latch2flag2; 
	fi;
B08latch1latch2flag2flag1: memory[latch1] = 1; goto B08latch2flag2flag1; 
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
	alloca(1, latch1);
	alloca(1, flag1);
	alloca(1, latch2);
	alloca(1, flag2);
	memory[latch1] = 1;
	memory[flag1] = 1;

	run process1();
	run process2();
	}
}

ltl prop{ [] ((process1@A01 -> memory[latch1] = 0 || memory[flag1] = 1) && (process2@B01 -> memory[latch2] = 0 || memory[flag2] = 1))}

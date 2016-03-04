#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short turn = null;


//standard stuff
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline p0(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
AStart: goto A00;
A00: v0 = memory[flag0]; goto A01; 
A01: goto A02v0; 
A02v0: 
	if 
	:: v1 = memory[turn]; goto A03v0; 
	:: memory[v0] = 1; goto A02; 
	fi;
A03v0: 
	if 
	:: goto A04v0v1; 
	:: memory[v0] = 1; goto A03; 
	fi;
A02: v1 = memory[turn]; goto A03; 
A04v0v1: 
	if 
	:: goto A05v0v1; 
	:: memory[v0] = 1; goto A04v1; 
	fi;
A03: goto A04v1; 
A05v0v1: 
	if 
	:: v2 = memory[flag1]; goto A06v0v1; 
	:: memory[v0] = 1; goto A05v1; 
	fi;
A04v1: 
	if 
	:: goto A05v1; 
	:: memory[v1] = 1; goto A04; 
	fi;
A06v0v1: 
	if 
	:: v3 = memory[v2]; goto A07v0v1; 
	:: memory[v0] = 1; goto A06v1; 
	fi;
A05v1: 
	if 
	:: v2 = memory[flag1]; goto A06v1; 
	:: memory[v1] = 1; goto A05; 
	fi;
A04: goto A05; 
A07v0v1: 
	if 
	:: tobool = v3; goto A08v0v1; 
	:: memory[v0] = 1; goto A07v1; 
	fi;
A06v1: 
	if 
	:: v3 = memory[v2]; goto A07v1; 
	:: memory[v1] = 1; goto A06; 
	fi;
A05: v2 = memory[flag1]; goto A06; 
A08v0v1: 
	if 
	:: conv = tobool; goto A09v0v1; 
	:: memory[v0] = 1; goto A08v1; 
	fi;
A07v1: 
	if 
	:: tobool = v3; goto A08v1; 
	:: memory[v1] = 1; goto A07; 
	fi;
A06: v3 = memory[v2]; goto A07; 
A09v0v1: 
	if 
	:: cmp = (conv == 1); goto A10v0v1; 
	:: memory[v0] = 1; goto A09v1; 
	fi;
A08v1: 
	if 
	:: conv = tobool; goto A09v1; 
	:: memory[v1] = 1; goto A08; 
	fi;
A07: tobool = v3; goto A08; 
A10v0v1: 
	if 
	::cmp -> goto A11v0v1; 
	::!cmp -> v6 = false; goto A17v0v1; 
	:: memory[v0] = 1; goto A10v1; 
	fi;
A09v1: 
	if 
	:: cmp = (conv == 1); goto A10v1; 
	:: memory[v1] = 1; goto A09; 
	fi;
A08: conv = tobool; goto A09; 
A11v0v1: 
	if 
	:: v4 = memory[turn]; goto A12v0v1; 
	:: memory[v0] = 1; goto A11v1; 
	fi;
A17v0v1: 
	if 
	:: goto A18v0v1; 
	:: memory[v0] = 1; goto A17v1; 
	fi;
A10v1: 
	if 
	::cmp -> goto A11v1; 
	::!cmp -> v6 = false; goto A17v1; 
	:: memory[v1] = 1; goto A10; 
	fi;
A09: cmp = (conv == 1); goto A10; 
A12v0v1: 
	if 
	:: v5 = memory[v4]; goto A13v0v1; 
	:: memory[v0] = 1; goto A12v1; 
	fi;
A11v1: 
	if 
	:: v4 = memory[turn]; goto A12v1; 
	:: memory[v1] = 1; goto A11; 
	fi;
A18v0v1: 
	if 
	::v6 -> goto A19v0v1; 
	::!v6 -> goto A20v0v1; 
	:: memory[v0] = 1; goto A18v1; 
	fi;
A17v1: 
	if 
	:: goto A18v1; 
	:: memory[v1] = 1; goto A17; 
	fi;
A10: 
	if 
	::cmp -> goto A11; 
	::!cmp -> v6 = false; goto A17; 
	fi;
A13v0v1: 
	if 
	:: tobool2 = v5; goto A14v0v1; 
	:: memory[v0] = 1; goto A13v1; 
	fi;
A12v1: 
	if 
	:: v5 = memory[v4]; goto A13v1; 
	:: memory[v1] = 1; goto A12; 
	fi;
A11: v4 = memory[turn]; goto A12; 
A19v0v1: 
	if 
	:: goto A05v0v1; 
	:: memory[v0] = 1; goto A19v1; 
	fi;
A20v0v1: 
	if 
	:: v7 = memory[flag0]; goto A21v0v1; 
	:: memory[v0] = 1; goto A20v1; 
	fi;
A18v1: 
	if 
	::v6 -> goto A19v1; 
	::!v6 -> goto A20v1; 
	:: memory[v1] = 1; goto A18; 
	fi;
A17: goto A18; 
A14v0v1: 
	if 
	:: conv3 = tobool2; goto A15v0v1; 
	:: memory[v0] = 1; goto A14v1; 
	fi;
A13v1: 
	if 
	:: tobool2 = v5; goto A14v1; 
	:: memory[v1] = 1; goto A13; 
	fi;
A12: v5 = memory[v4]; goto A13; 
A19v1: 
	if 
	:: goto A05v1; 
	:: memory[v1] = 1; goto A19; 
	fi;
A21v0v1: 
	if 
	:: goto A22v0v1v7; 
	:: memory[v0] = 1; goto A21v1; 
	fi;
A20v1: 
	if 
	:: v7 = memory[flag0]; goto A21v1; 
	:: memory[v1] = 1; goto A20; 
	fi;
A18: 
	if 
	::v6 -> goto A19; 
	::!v6 -> goto A20; 
	fi;
A15v0v1: 
	if 
	:: cmp4 = (conv3 == 1); goto A16v0v1; 
	:: memory[v0] = 1; goto A15v1; 
	fi;
A14v1: 
	if 
	:: conv3 = tobool2; goto A15v1; 
	:: memory[v1] = 1; goto A14; 
	fi;
A13: tobool2 = v5; goto A14; 
A19: goto A05; 
A22v0v1v7: memory[v0] = 1; goto A22v1v7; 
A21v1: 
	if 
	:: goto A22v1v7; 
	:: memory[v1] = 1; goto A21; 
	fi;
A20: v7 = memory[flag0]; goto A21; 
A16v0v1: 
	if 
	:: v6 = cmp4; goto A17v0v1; 
	:: memory[v0] = 1; goto A16v1; 
	fi;
A15v1: 
	if 
	:: cmp4 = (conv3 == 1); goto A16v1; 
	:: memory[v1] = 1; goto A15; 
	fi;
A14: conv3 = tobool2; goto A15; 
A22v1v7: memory[v1] = 1; goto A22v7; 
A21: goto A22v7; 
A16v1: 
	if 
	:: v6 = cmp4; goto A17v1; 
	:: memory[v1] = 1; goto A16; 
	fi;
A15: cmp4 = (conv3 == 1); goto A16; 
A22v7: memory[v7] = 0; goto A22; 
A16: v6 = cmp4; goto A17; 
A22: goto AEnd;
AEnd: skip;

}


inline p1(){
short v0, v1, v2, v3, tobool, conv, cmp, v4, v6, cmp4, v5, tobool2, v7, conv3;
BStart: goto B00;
B00: v0 = memory[flag1]; goto B01; 
B01: goto B02v0; 
B02v0: 
	if 
	:: v1 = memory[turn]; goto B03v0; 
	:: memory[v0] = 1; goto B02; 
	fi;
B03v0: 
	if 
	:: goto B04v0v1; 
	:: memory[v0] = 1; goto B03; 
	fi;
B02: v1 = memory[turn]; goto B03; 
B04v0v1: 
	if 
	:: goto B05v0v1; 
	:: memory[v0] = 1; goto B04v1; 
	fi;
B03: goto B04v1; 
B05v0v1: 
	if 
	:: v2 = memory[flag0]; goto B06v0v1; 
	:: memory[v0] = 1; goto B05v1; 
	fi;
B04v1: 
	if 
	:: goto B05v1; 
	:: memory[v1] = 0; goto B04; 
	fi;
B06v0v1: 
	if 
	:: v3 = memory[v2]; goto B07v0v1; 
	:: memory[v0] = 1; goto B06v1; 
	fi;
B05v1: 
	if 
	:: v2 = memory[flag0]; goto B06v1; 
	:: memory[v1] = 0; goto B05; 
	fi;
B04: goto B05; 
B07v0v1: 
	if 
	:: tobool = v3; goto B08v0v1; 
	:: memory[v0] = 1; goto B07v1; 
	fi;
B06v1: 
	if 
	:: v3 = memory[v2]; goto B07v1; 
	:: memory[v1] = 0; goto B06; 
	fi;
B05: v2 = memory[flag0]; goto B06; 
B08v0v1: 
	if 
	:: conv = tobool; goto B09v0v1; 
	:: memory[v0] = 1; goto B08v1; 
	fi;
B07v1: 
	if 
	:: tobool = v3; goto B08v1; 
	:: memory[v1] = 0; goto B07; 
	fi;
B06: v3 = memory[v2]; goto B07; 
B09v0v1: 
	if 
	:: cmp = (conv == 1); goto B10v0v1; 
	:: memory[v0] = 1; goto B09v1; 
	fi;
B08v1: 
	if 
	:: conv = tobool; goto B09v1; 
	:: memory[v1] = 0; goto B08; 
	fi;
B07: tobool = v3; goto B08; 
B10v0v1: 
	if 
	::cmp -> goto B11v0v1; 
	::!cmp -> v6 = false; goto B17v0v1; 
	:: memory[v0] = 1; goto B10v1; 
	fi;
B09v1: 
	if 
	:: cmp = (conv == 1); goto B10v1; 
	:: memory[v1] = 0; goto B09; 
	fi;
B08: conv = tobool; goto B09; 
B11v0v1: 
	if 
	:: v4 = memory[turn]; goto B12v0v1; 
	:: memory[v0] = 1; goto B11v1; 
	fi;
B17v0v1: 
	if 
	:: goto B18v0v1; 
	:: memory[v0] = 1; goto B17v1; 
	fi;
B10v1: 
	if 
	::cmp -> goto B11v1; 
	::!cmp -> v6 = false; goto B17v1; 
	:: memory[v1] = 0; goto B10; 
	fi;
B09: cmp = (conv == 1); goto B10; 
B12v0v1: 
	if 
	:: v5 = memory[v4]; goto B13v0v1; 
	:: memory[v0] = 1; goto B12v1; 
	fi;
B11v1: 
	if 
	:: v4 = memory[turn]; goto B12v1; 
	:: memory[v1] = 0; goto B11; 
	fi;
B18v0v1: 
	if 
	::v6 -> goto B19v0v1; 
	::!v6 -> goto B20v0v1; 
	:: memory[v0] = 1; goto B18v1; 
	fi;
B17v1: 
	if 
	:: goto B18v1; 
	:: memory[v1] = 0; goto B17; 
	fi;
B10: 
	if 
	::cmp -> goto B11; 
	::!cmp -> v6 = false; goto B17; 
	fi;
B13v0v1: 
	if 
	:: tobool2 = v5; goto B14v0v1; 
	:: memory[v0] = 1; goto B13v1; 
	fi;
B12v1: 
	if 
	:: v5 = memory[v4]; goto B13v1; 
	:: memory[v1] = 0; goto B12; 
	fi;
B11: v4 = memory[turn]; goto B12; 
B19v0v1: 
	if 
	:: goto B05v0v1; 
	:: memory[v0] = 1; goto B19v1; 
	fi;
B20v0v1: 
	if 
	:: v7 = memory[flag1]; goto B21v0v1; 
	:: memory[v0] = 1; goto B20v1; 
	fi;
B18v1: 
	if 
	::v6 -> goto B19v1; 
	::!v6 -> goto B20v1; 
	:: memory[v1] = 0; goto B18; 
	fi;
B17: goto B18; 
B14v0v1: 
	if 
	:: conv3 = tobool2; goto B15v0v1; 
	:: memory[v0] = 1; goto B14v1; 
	fi;
B13v1: 
	if 
	:: tobool2 = v5; goto B14v1; 
	:: memory[v1] = 0; goto B13; 
	fi;
B12: v5 = memory[v4]; goto B13; 
B19v1: 
	if 
	:: goto B05v1; 
	:: memory[v1] = 0; goto B19; 
	fi;
B21v0v1: 
	if 
	:: goto B22v0v1v7; 
	:: memory[v0] = 1; goto B21v1; 
	fi;
B20v1: 
	if 
	:: v7 = memory[flag1]; goto B21v1; 
	:: memory[v1] = 0; goto B20; 
	fi;
B18: 
	if 
	::v6 -> goto B19; 
	::!v6 -> goto B20; 
	fi;
B15v0v1: 
	if 
	:: cmp4 = (conv3 == 0); goto B16v0v1; 
	:: memory[v0] = 1; goto B15v1; 
	fi;
B14v1: 
	if 
	:: conv3 = tobool2; goto B15v1; 
	:: memory[v1] = 0; goto B14; 
	fi;
B13: tobool2 = v5; goto B14; 
B19: goto B05; 
B22v0v1v7: memory[v0] = 1; goto B22v1v7; 
B21v1: 
	if 
	:: goto B22v1v7; 
	:: memory[v1] = 0; goto B21; 
	fi;
B20: v7 = memory[flag1]; goto B21; 
B16v0v1: 
	if 
	:: v6 = cmp4; goto B17v0v1; 
	:: memory[v0] = 1; goto B16v1; 
	fi;
B15v1: 
	if 
	:: cmp4 = (conv3 == 0); goto B16v1; 
	:: memory[v1] = 0; goto B15; 
	fi;
B14: conv3 = tobool2; goto B15; 
B22v1v7: memory[v1] = 0; goto B22v7; 
B21: goto B22v7; 
B16v1: 
	if 
	:: v6 = cmp4; goto B17v1; 
	:: memory[v1] = 0; goto B16; 
	fi;
B15: cmp4 = (conv3 == 0); goto B16; 
B22v7: memory[v7] = 0; goto B22; 
B16: v6 = cmp4; goto B17; 
B22: goto BEnd;
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
	//TODO: empty stub

	run process1();
	run process2();
	}
}

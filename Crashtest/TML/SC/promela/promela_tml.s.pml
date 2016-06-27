#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short glb = null;
short x = null;
short y = null;
short lx1 = 0;
short ly1 = 0;
short lx2 = 0;
short ly2 = 0;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}
//atomic compare and swap instruction 
//Note, LLVM returns a tuple (i32, i1), the value read and a success bit.
//Sometimes the follow up code uses the succes bit but usually the read value. 
//Adjust CAS semantics, if necessary.
inline cas(adr, old, new, result)
{
	atomic{
	//in LLVM result is usually a tuple (memory[adr], successFlag)
	//we assume it to be just a loaded value
	result = memory[adr];
	if 	:: memory[adr] == old -> memory[adr] = new; 
		:: else -> skip;
	fi;
	}
}



inline proc11(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, 10, inc10;
AStart: goto A00;
A00: v0 = memory[glb]; goto A01; 
A01: goto A02; 
A02: v1 = memory[v0]; goto A03; 
A03: and = v1 & 1; goto A04; 
A04: tobool = (and == 0); goto A05; 
A05: 
	if 
	::tobool -> goto A06; 
	::!tobool -> goto A02; 
	fi;
A06: add = v1 + 1; goto A07; 
A07: cas(v0, v1, add, v2); goto A08; 
A08: v3 = (v2 == v1); goto A09; 
A09: 
	if 
	::v3 -> goto A10; 
	::!v3 -> retval_0 = -1; goto A28; 
	fi;
A10: v4 = memory[x]; goto A11; 
A28: goto A29; 
A11: goto A12; 
A29: returnvalue = retval_0; goto AEnd;
A12: v5 = memory[y]; goto A13; 
A13: v6 = memory[v5]; goto A14; 
A14: v7 = memory[glb]; goto A15; 
A15: v8 = memory[v7]; goto A16; 
A16: cmp = (v8 == add); goto A17; 
A17: 
	if 
	::cmp -> goto A18; 
	::!cmp -> retval_0 = -1; goto A28; 
	fi;
A18: goto A19; 
A19: and7 = add & 1; goto A20; 
A20: tobool8 = (and7 == 0); goto A21; 
A21: 
	if 
	::tobool8 -> retval_0 = 1; goto A28; 
	::!tobool8 -> goto A22; 
	fi;
A22: goto A23; 
A23: v9 = memory[glb]; goto A24; 
A24: 10 = memory[v9]; goto A25; 
A25: inc10 = 10 + 1; goto A26; 
A26: goto A27; 
A27: retval_0 = 1; goto A28; 
AEnd: skip;

}


inline proc21(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, 10, inc10;
BStart: goto B00;
B00: v0 = memory[glb]; goto B01; 
B01: goto B02; 
B02: v1 = memory[v0]; goto B03; 
B03: and = v1 & 1; goto B04; 
B04: tobool = (and == 0); goto B05; 
B05: 
	if 
	::tobool -> goto B06; 
	::!tobool -> goto B02; 
	fi;
B06: add = v1 + 1; goto B07; 
B07: cas(v0, v1, add, v2); goto B08; 
B08: v3 = (v2 == v1); goto B09; 
B09: 
	if 
	::v3 -> goto B10; 
	::!v3 -> retval_0 = -1; goto B28; 
	fi;
B10: v4 = memory[y]; goto B11; 
B28: goto B29; 
B11: goto B12; 
B29: returnvalue = retval_0; goto BEnd;
B12: v5 = memory[x]; goto B13; 
B13: v6 = memory[v5]; goto B14; 
B14: v7 = memory[glb]; goto B15; 
B15: v8 = memory[v7]; goto B16; 
B16: cmp = (v8 == add); goto B17; 
B17: 
	if 
	::cmp -> goto B18; 
	::!cmp -> retval_0 = -1; goto B28; 
	fi;
B18: goto B19; 
B19: and7 = add & 1; goto B20; 
B20: tobool8 = (and7 == 0); goto B21; 
B21: 
	if 
	::tobool8 -> retval_0 = 1; goto B28; 
	::!tobool8 -> goto B22; 
	fi;
B22: goto B23; 
B23: v9 = memory[glb]; goto B24; 
B24: 10 = memory[v9]; goto B25; 
B25: inc10 = 10 + 1; goto B26; 
B26: goto B27; 
B27: retval_0 = 1; goto B28; 
BEnd: skip;

}


inline proc12(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, 10, 11, 12, cmp7, and10, tobool11, 13, 14, inc13;
CStart: goto C00;
C00: v0 = memory[glb]; goto C01; 
C01: goto C02; 
C02: v1 = memory[v0]; goto C03; 
C03: and = v1 & 1; goto C04; 
C04: tobool = (and == 0); goto C05; 
C05: 
	if 
	::tobool -> goto C06; 
	::!tobool -> goto C02; 
	fi;
C06: add = v1 + 1; goto C07; 
C07: cas(v0, v1, add, v2); goto C08; 
C08: v3 = (v2 == v1); goto C09; 
C09: 
	if 
	::v3 -> goto C10; 
	::!v3 -> retval_0 = -1; goto C35; 
	fi;
C10: v4 = memory[x]; goto C11; 
C35: goto C36; 
C11: goto C12; 
C36: returnvalue = retval_0; goto CEnd;
C12: v5 = memory[x]; goto C13; 
C13: v6 = memory[v5]; goto C14; 
C14: v7 = memory[glb]; goto C15; 
C15: v8 = memory[v7]; goto C16; 
C16: cmp = (v8 == add); goto C17; 
C17: 
	if 
	::cmp -> goto C18; 
	::!cmp -> retval_0 = -1; goto C35; 
	fi;
C18: goto C19; 
C19: v9 = memory[y]; goto C20; 
C20: 10 = memory[v9]; goto C21; 
C21: 11 = memory[glb]; goto C22; 
C22: 12 = memory[11]; goto C23; 
C23: cmp7 = (12 == add); goto C24; 
C24: 
	if 
	::cmp7 -> goto C25; 
	::!cmp7 -> retval_0 = -1; goto C35; 
	fi;
C25: goto C26; 
C26: and10 = add & 1; goto C27; 
C27: tobool11 = (and10 == 0); goto C28; 
C28: 
	if 
	::tobool11 -> retval_0 = 1; goto C35; 
	::!tobool11 -> goto C29; 
	fi;
C29: goto C30; 
C30: 13 = memory[glb]; goto C31; 
C31: 14 = memory[13]; goto C32; 
C32: inc13 = 14 + 1; goto C33; 
C33: goto C34; 
C34: retval_0 = 1; goto C35; 
CEnd: skip;

}


inline proc22(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, 10, 11, 12, cmp7, and10, tobool11, 13, 14, inc13;
DStart: goto D00;
D00: v0 = memory[glb]; goto D01; 
D01: goto D02; 
D02: v1 = memory[v0]; goto D03; 
D03: and = v1 & 1; goto D04; 
D04: tobool = (and == 0); goto D05; 
D05: 
	if 
	::tobool -> goto D06; 
	::!tobool -> goto D02; 
	fi;
D06: add = v1 + 1; goto D07; 
D07: cas(v0, v1, add, v2); goto D08; 
D08: v3 = (v2 == v1); goto D09; 
D09: 
	if 
	::v3 -> goto D10; 
	::!v3 -> retval_0 = -1; goto D35; 
	fi;
D10: v4 = memory[y]; goto D11; 
D35: goto D36; 
D11: goto D12; 
D36: returnvalue = retval_0; goto DEnd;
D12: v5 = memory[y]; goto D13; 
D13: v6 = memory[v5]; goto D14; 
D14: v7 = memory[glb]; goto D15; 
D15: v8 = memory[v7]; goto D16; 
D16: cmp = (v8 == add); goto D17; 
D17: 
	if 
	::cmp -> goto D18; 
	::!cmp -> retval_0 = -1; goto D35; 
	fi;
D18: goto D19; 
D19: v9 = memory[x]; goto D20; 
D20: 10 = memory[v9]; goto D21; 
D21: 11 = memory[glb]; goto D22; 
D22: 12 = memory[11]; goto D23; 
D23: cmp7 = (12 == add); goto D24; 
D24: 
	if 
	::cmp7 -> goto D25; 
	::!cmp7 -> retval_0 = -1; goto D35; 
	fi;
D25: goto D26; 
D26: and10 = add & 1; goto D27; 
D27: tobool11 = (and10 == 0); goto D28; 
D28: 
	if 
	::tobool11 -> retval_0 = 1; goto D35; 
	::!tobool11 -> goto D29; 
	fi;
D29: goto D30; 
D30: 13 = memory[glb]; goto D31; 
D31: 14 = memory[13]; goto D32; 
D32: inc13 = 14 + 1; goto D33; 
D33: goto D34; 
D34: retval_0 = 1; goto D35; 
DEnd: skip;

}


inline proc13(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, and5, tobool6, v5, v6, inc8;
EStart: goto E00;
E00: v0 = memory[glb]; goto E01; 
E01: goto E02; 
E02: v1 = memory[v0]; goto E03; 
E03: and = v1 & 1; goto E04; 
E04: tobool = (and == 0); goto E05; 
E05: 
	if 
	::tobool -> goto E06; 
	::!tobool -> goto E02; 
	fi;
E06: add = v1 + 1; goto E07; 
E07: cas(v0, v1, add, v2); goto E08; 
E08: v3 = (v2 == v1); goto E09; 
E09: 
	if 
	::v3 -> goto E10; 
	::!v3 -> retval_0 = -1; goto E21; 
	fi;
E10: v4 = memory[x]; goto E11; 
E21: goto E22; 
E11: goto E12; 
E22: returnvalue = retval_0; goto EEnd;
E12: and5 = add & 1; goto E13; 
E13: tobool6 = (and5 == 0); goto E14; 
E14: 
	if 
	::tobool6 -> retval_0 = 1; goto E21; 
	::!tobool6 -> goto E15; 
	fi;
E15: goto E16; 
E16: v5 = memory[glb]; goto E17; 
E17: v6 = memory[v5]; goto E18; 
E18: inc8 = v6 + 1; goto E19; 
E19: goto E20; 
E20: retval_0 = 1; goto E21; 
EEnd: skip;

}


inline proc23(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, and5, tobool6, v5, v6, inc8;
FStart: goto F00;
F00: v0 = memory[glb]; goto F01; 
F01: goto F02; 
F02: v1 = memory[v0]; goto F03; 
F03: and = v1 & 1; goto F04; 
F04: tobool = (and == 0); goto F05; 
F05: 
	if 
	::tobool -> goto F06; 
	::!tobool -> goto F02; 
	fi;
F06: add = v1 + 1; goto F07; 
F07: cas(v0, v1, add, v2); goto F08; 
F08: v3 = (v2 == v1); goto F09; 
F09: 
	if 
	::v3 -> goto F10; 
	::!v3 -> retval_0 = -1; goto F21; 
	fi;
F10: v4 = memory[y]; goto F11; 
F21: goto F22; 
F11: goto F12; 
F22: returnvalue = retval_0; goto FEnd;
F12: and5 = add & 1; goto F13; 
F13: tobool6 = (and5 == 0); goto F14; 
F14: 
	if 
	::tobool6 -> retval_0 = 1; goto F21; 
	::!tobool6 -> goto F15; 
	fi;
F15: goto F16; 
F16: v5 = memory[glb]; goto F17; 
F17: v6 = memory[v5]; goto F18; 
F18: inc8 = v6 + 1; goto F19; 
F19: goto F20; 
F20: retval_0 = 1; goto F21; 
FEnd: skip;

}


inline proc33(returnvalue){
short v0, v1, and, tobool, v2, v3, v4, cmp, retval_0, v5, v6, v7, v8, cmp1;
GStart: goto G00;
G00: v0 = memory[glb]; goto G01; 
G01: goto G02; 
G02: v1 = memory[v0]; goto G03; 
G03: and = v1 & 1; goto G04; 
G04: tobool = (and == 0); goto G05; 
G05: 
	if 
	::tobool -> goto G06; 
	::!tobool -> goto G02; 
	fi;
G06: v2 = memory[x]; goto G07; 
G07: v3 = memory[v2]; goto G08; 
G08: v4 = memory[v0]; goto G09; 
G09: cmp = (v4 == v1); goto G10; 
G10: 
	if 
	::cmp -> goto G11; 
	::!cmp -> retval_0 = -1; goto G20; 
	fi;
G11: goto G12; 
G20: goto G21; 
G12: v5 = memory[y]; goto G13; 
G21: returnvalue = retval_0; goto GEnd;
G13: v6 = memory[v5]; goto G14; 
G14: v7 = memory[glb]; goto G15; 
G15: v8 = memory[v7]; goto G16; 
G16: cmp1 = (v8 == v1); goto G17; 
G17: 
	if 
	::cmp1 -> goto G18; 
	::!cmp1 -> retval_0 = -1; goto G20; 
	fi;
G18: goto G19; 
G19: retval_0 = 1; goto G20; 
GEnd: skip;

}


inline proc43(returnvalue){
short v0, v1, and, tobool, v2, v3, v4, cmp, retval_0, v5, v6, v7, v8, cmp1;
HStart: goto H00;
H00: v0 = memory[glb]; goto H01; 
H01: goto H02; 
H02: v1 = memory[v0]; goto H03; 
H03: and = v1 & 1; goto H04; 
H04: tobool = (and == 0); goto H05; 
H05: 
	if 
	::tobool -> goto H06; 
	::!tobool -> goto H02; 
	fi;
H06: v2 = memory[y]; goto H07; 
H07: v3 = memory[v2]; goto H08; 
H08: v4 = memory[v0]; goto H09; 
H09: cmp = (v4 == v1); goto H10; 
H10: 
	if 
	::cmp -> goto H11; 
	::!cmp -> retval_0 = -1; goto H20; 
	fi;
H11: goto H12; 
H20: goto H21; 
H12: v5 = memory[x]; goto H13; 
H21: returnvalue = retval_0; goto HEnd;
H13: v6 = memory[v5]; goto H14; 
H14: v7 = memory[glb]; goto H15; 
H15: v8 = memory[v7]; goto H16; 
H16: cmp1 = (v8 == v1); goto H17; 
H17: 
	if 
	::cmp1 -> goto H18; 
	::!cmp1 -> retval_0 = -1; goto H20; 
	fi;
H18: goto H19; 
H19: retval_0 = 1; goto H20; 
HEnd: skip;

}


inline main(argc, argv, returnvalue){

IStart: goto I0;
I0: returnvalue = 0; goto IEnd;
IEnd: skip;

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
	alloca(1, glb);
	alloca(1, x);
	alloca(1, y);
	alloca(1, lx1);
	alloca(1, ly1);
	alloca(1, lx2);
	alloca(1, ly2);
	

	run process1();
	run process2();
	}
}

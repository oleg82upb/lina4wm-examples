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
A11: goto A12v4; 
A29: returnvalue = retval_0; goto AEnd;
A12v4: 
	if 
	:: v5 = memory[y]; goto A13v4; 
	:: memory[v4] = 1; goto A12; 
	fi;
A13v4: 
	if 
	:: v6 = memory[v5]; goto A14v4; 
	:: memory[v4] = 1; goto A13; 
	fi;
A12: v5 = memory[y]; goto A13; 
A14v4: 
	if 
	:: v7 = memory[glb]; goto A15v4; 
	:: memory[v4] = 1; goto A14; 
	fi;
A13: v6 = memory[v5]; goto A14; 
A15v4: 
	if 
	:: v8 = memory[v7]; goto A16v4; 
	:: memory[v4] = 1; goto A15; 
	fi;
A14: v7 = memory[glb]; goto A15; 
A16v4: 
	if 
	:: cmp = (v8 == add); goto A17v4; 
	:: memory[v4] = 1; goto A16; 
	fi;
A15: v8 = memory[v7]; goto A16; 
A17v4: 
	if 
	::cmp -> goto A18v4; 
	::!cmp -> retval_0 = -1; goto A28v4; 
	:: memory[v4] = 1; goto A17; 
	fi;
A16: cmp = (v8 == add); goto A17; 
A18v4: 
	if 
	:: goto A19v4ly1; 
	:: memory[v4] = 1; goto A18; 
	fi;
A28v4: 
	if 
	:: goto A29v4; 
	:: memory[v4] = 1; goto A28; 
	fi;
A17: 
	if 
	::cmp -> goto A18; 
	::!cmp -> retval_0 = -1; goto A28; 
	fi;
A19v4ly1: 
	if 
	:: and7 = add & 1; goto A20v4ly1; 
	:: memory[v4] = 1; goto A19ly1; 
	fi;
A18: goto A19ly1; 
A29v4: memory[v4] = 1; goto A29; 
A20v4ly1: 
	if 
	:: tobool8 = (and7 == 0); goto A21v4ly1; 
	:: memory[v4] = 1; goto A20ly1; 
	fi;
A19ly1: 
	if 
	:: and7 = add & 1; goto A20ly1; 
	:: memory[ly1] = v6; goto A19; 
	fi;
A21v4ly1: 
	if 
	::tobool8 -> retval_0 = 1; goto A28v4ly1; 
	::!tobool8 -> goto A22v4ly1; 
	:: memory[v4] = 1; goto A21ly1; 
	fi;
A20ly1: 
	if 
	:: tobool8 = (and7 == 0); goto A21ly1; 
	:: memory[ly1] = v6; goto A20; 
	fi;
A19: and7 = add & 1; goto A20; 
A28v4ly1: 
	if 
	:: goto A29v4ly1; 
	:: memory[v4] = 1; goto A28ly1; 
	fi;
A22v4ly1: memory[v4] = 1; goto A22ly1; 
A21ly1: 
	if 
	::tobool8 -> retval_0 = 1; goto A28ly1; 
	::!tobool8 -> goto A22ly1; 
	:: memory[ly1] = v6; goto A21; 
	fi;
A20: tobool8 = (and7 == 0); goto A21; 
A29v4ly1: memory[v4] = 1; goto A29ly1; 
A28ly1: 
	if 
	:: goto A29ly1; 
	:: memory[ly1] = v6; goto A28; 
	fi;
A22ly1: memory[ly1] = v6; goto A22; 
A21: 
	if 
	::tobool8 -> retval_0 = 1; goto A28; 
	::!tobool8 -> goto A22; 
	fi;
A29ly1: memory[ly1] = v6; goto A29; 
A22: goto A23; 
A23: v9 = memory[glb]; goto A24; 
A24: 10 = memory[v9]; goto A25; 
A25: inc10 = 10 + 1; goto A26; 
A26: goto A27v9; 
A27v9: 
	if 
	:: retval_0 = 1; goto A28v9; 
	:: memory[v9] = inc10; goto A27; 
	fi;
A28v9: 
	if 
	:: goto A29v9; 
	:: memory[v9] = inc10; goto A28; 
	fi;
A27: retval_0 = 1; goto A28; 
A29v9: memory[v9] = inc10; goto A29; 
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
B11: goto B12v4; 
B29: returnvalue = retval_0; goto BEnd;
B12v4: 
	if 
	:: v5 = memory[x]; goto B13v4; 
	:: memory[v4] = 1; goto B12; 
	fi;
B13v4: 
	if 
	:: v6 = memory[v5]; goto B14v4; 
	:: memory[v4] = 1; goto B13; 
	fi;
B12: v5 = memory[x]; goto B13; 
B14v4: 
	if 
	:: v7 = memory[glb]; goto B15v4; 
	:: memory[v4] = 1; goto B14; 
	fi;
B13: v6 = memory[v5]; goto B14; 
B15v4: 
	if 
	:: v8 = memory[v7]; goto B16v4; 
	:: memory[v4] = 1; goto B15; 
	fi;
B14: v7 = memory[glb]; goto B15; 
B16v4: 
	if 
	:: cmp = (v8 == add); goto B17v4; 
	:: memory[v4] = 1; goto B16; 
	fi;
B15: v8 = memory[v7]; goto B16; 
B17v4: 
	if 
	::cmp -> goto B18v4; 
	::!cmp -> retval_0 = -1; goto B28v4; 
	:: memory[v4] = 1; goto B17; 
	fi;
B16: cmp = (v8 == add); goto B17; 
B18v4: 
	if 
	:: goto B19v4lx2; 
	:: memory[v4] = 1; goto B18; 
	fi;
B28v4: 
	if 
	:: goto B29v4; 
	:: memory[v4] = 1; goto B28; 
	fi;
B17: 
	if 
	::cmp -> goto B18; 
	::!cmp -> retval_0 = -1; goto B28; 
	fi;
B19v4lx2: 
	if 
	:: and7 = add & 1; goto B20v4lx2; 
	:: memory[v4] = 1; goto B19lx2; 
	fi;
B18: goto B19lx2; 
B29v4: memory[v4] = 1; goto B29; 
B20v4lx2: 
	if 
	:: tobool8 = (and7 == 0); goto B21v4lx2; 
	:: memory[v4] = 1; goto B20lx2; 
	fi;
B19lx2: 
	if 
	:: and7 = add & 1; goto B20lx2; 
	:: memory[lx2] = v6; goto B19; 
	fi;
B21v4lx2: 
	if 
	::tobool8 -> retval_0 = 1; goto B28v4lx2; 
	::!tobool8 -> goto B22v4lx2; 
	:: memory[v4] = 1; goto B21lx2; 
	fi;
B20lx2: 
	if 
	:: tobool8 = (and7 == 0); goto B21lx2; 
	:: memory[lx2] = v6; goto B20; 
	fi;
B19: and7 = add & 1; goto B20; 
B28v4lx2: 
	if 
	:: goto B29v4lx2; 
	:: memory[v4] = 1; goto B28lx2; 
	fi;
B22v4lx2: memory[v4] = 1; goto B22lx2; 
B21lx2: 
	if 
	::tobool8 -> retval_0 = 1; goto B28lx2; 
	::!tobool8 -> goto B22lx2; 
	:: memory[lx2] = v6; goto B21; 
	fi;
B20: tobool8 = (and7 == 0); goto B21; 
B29v4lx2: memory[v4] = 1; goto B29lx2; 
B28lx2: 
	if 
	:: goto B29lx2; 
	:: memory[lx2] = v6; goto B28; 
	fi;
B22lx2: memory[lx2] = v6; goto B22; 
B21: 
	if 
	::tobool8 -> retval_0 = 1; goto B28; 
	::!tobool8 -> goto B22; 
	fi;
B29lx2: memory[lx2] = v6; goto B29; 
B22: goto B23; 
B23: v9 = memory[glb]; goto B24; 
B24: 10 = memory[v9]; goto B25; 
B25: inc10 = 10 + 1; goto B26; 
B26: goto B27v9; 
B27v9: 
	if 
	:: retval_0 = 1; goto B28v9; 
	:: memory[v9] = inc10; goto B27; 
	fi;
B28v9: 
	if 
	:: goto B29v9; 
	:: memory[v9] = inc10; goto B28; 
	fi;
B27: retval_0 = 1; goto B28; 
B29v9: memory[v9] = inc10; goto B29; 
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
C11: goto C12v4; 
C36: returnvalue = retval_0; goto CEnd;
C12v4: 
	if 
	:: v5 = memory[x]; goto C13v4; 
	:: memory[v4] = 1; goto C12; 
	fi;
C13v4: 
	if 
	:: v6 = memory[v5]; goto C14v4; 
	:: memory[v4] = 1; goto C13; 
	fi;
C12: v5 = memory[x]; goto C13; 
C14v4: 
	if 
	:: v7 = memory[glb]; goto C15v4; 
	:: memory[v4] = 1; goto C14; 
	fi;
C13: v6 = memory[v5]; goto C14; 
C15v4: 
	if 
	:: v8 = memory[v7]; goto C16v4; 
	:: memory[v4] = 1; goto C15; 
	fi;
C14: v7 = memory[glb]; goto C15; 
C16v4: 
	if 
	:: cmp = (v8 == add); goto C17v4; 
	:: memory[v4] = 1; goto C16; 
	fi;
C15: v8 = memory[v7]; goto C16; 
C17v4: 
	if 
	::cmp -> goto C18v4; 
	::!cmp -> retval_0 = -1; goto C35v4; 
	:: memory[v4] = 1; goto C17; 
	fi;
C16: cmp = (v8 == add); goto C17; 
C18v4: 
	if 
	:: goto C19v4lx1; 
	:: memory[v4] = 1; goto C18; 
	fi;
C35v4: 
	if 
	:: goto C36v4; 
	:: memory[v4] = 1; goto C35; 
	fi;
C17: 
	if 
	::cmp -> goto C18; 
	::!cmp -> retval_0 = -1; goto C35; 
	fi;
C19v4lx1: 
	if 
	:: v9 = memory[y]; goto C20v4lx1; 
	:: memory[v4] = 1; goto C19lx1; 
	fi;
C18: goto C19lx1; 
C36v4: memory[v4] = 1; goto C36; 
C20v4lx1: 
	if 
	:: 10 = memory[v9]; goto C21v4lx1; 
	:: memory[v4] = 1; goto C20lx1; 
	fi;
C19lx1: 
	if 
	:: v9 = memory[y]; goto C20lx1; 
	:: memory[lx1] = v6; goto C19; 
	fi;
C21v4lx1: 
	if 
	:: 11 = memory[glb]; goto C22v4lx1; 
	:: memory[v4] = 1; goto C21lx1; 
	fi;
C20lx1: 
	if 
	:: 10 = memory[v9]; goto C21lx1; 
	:: memory[lx1] = v6; goto C20; 
	fi;
C19: v9 = memory[y]; goto C20; 
C22v4lx1: 
	if 
	:: 12 = memory[11]; goto C23v4lx1; 
	:: memory[v4] = 1; goto C22lx1; 
	fi;
C21lx1: 
	if 
	:: 11 = memory[glb]; goto C22lx1; 
	:: memory[lx1] = v6; goto C21; 
	fi;
C20: 10 = memory[v9]; goto C21; 
C23v4lx1: 
	if 
	:: cmp7 = (12 == add); goto C24v4lx1; 
	:: memory[v4] = 1; goto C23lx1; 
	fi;
C22lx1: 
	if 
	:: 12 = memory[11]; goto C23lx1; 
	:: memory[lx1] = v6; goto C22; 
	fi;
C21: 11 = memory[glb]; goto C22; 
C24v4lx1: 
	if 
	::cmp7 -> goto C25v4lx1; 
	::!cmp7 -> retval_0 = -1; goto C35v4lx1; 
	:: memory[v4] = 1; goto C24lx1; 
	fi;
C23lx1: 
	if 
	:: cmp7 = (12 == add); goto C24lx1; 
	:: memory[lx1] = v6; goto C23; 
	fi;
C22: 12 = memory[11]; goto C23; 
C25v4lx1: 
	if 
	:: goto C26v4lx1ly1; 
	:: memory[v4] = 1; goto C25lx1; 
	fi;
C35v4lx1: 
	if 
	:: goto C36v4lx1; 
	:: memory[v4] = 1; goto C35lx1; 
	fi;
C24lx1: 
	if 
	::cmp7 -> goto C25lx1; 
	::!cmp7 -> retval_0 = -1; goto C35lx1; 
	:: memory[lx1] = v6; goto C24; 
	fi;
C23: cmp7 = (12 == add); goto C24; 
C26v4lx1ly1: 
	if 
	:: and10 = add & 1; goto C27v4lx1ly1; 
	:: memory[v4] = 1; goto C26lx1ly1; 
	fi;
C25lx1: 
	if 
	:: goto C26lx1ly1; 
	:: memory[lx1] = v6; goto C25; 
	fi;
C36v4lx1: memory[v4] = 1; goto C36lx1; 
C35lx1: 
	if 
	:: goto C36lx1; 
	:: memory[lx1] = v6; goto C35; 
	fi;
C24: 
	if 
	::cmp7 -> goto C25; 
	::!cmp7 -> retval_0 = -1; goto C35; 
	fi;
C27v4lx1ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C28v4lx1ly1; 
	:: memory[v4] = 1; goto C27lx1ly1; 
	fi;
C26lx1ly1: 
	if 
	:: and10 = add & 1; goto C27lx1ly1; 
	:: memory[lx1] = v6; goto C26ly1; 
	fi;
C25: goto C26ly1; 
C36lx1: memory[lx1] = v6; goto C36; 
C28v4lx1ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C35v4lx1ly1; 
	::!tobool11 -> goto C29v4lx1ly1; 
	:: memory[v4] = 1; goto C28lx1ly1; 
	fi;
C27lx1ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C28lx1ly1; 
	:: memory[lx1] = v6; goto C27ly1; 
	fi;
C26ly1: 
	if 
	:: and10 = add & 1; goto C27ly1; 
	:: memory[ly1] = 10; goto C26; 
	fi;
C35v4lx1ly1: 
	if 
	:: goto C36v4lx1ly1; 
	:: memory[v4] = 1; goto C35lx1ly1; 
	fi;
C29v4lx1ly1: memory[v4] = 1; goto C29lx1ly1; 
C28lx1ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C35lx1ly1; 
	::!tobool11 -> goto C29lx1ly1; 
	:: memory[lx1] = v6; goto C28ly1; 
	fi;
C27ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C28ly1; 
	:: memory[ly1] = 10; goto C27; 
	fi;
C26: and10 = add & 1; goto C27; 
C36v4lx1ly1: memory[v4] = 1; goto C36lx1ly1; 
C35lx1ly1: 
	if 
	:: goto C36lx1ly1; 
	:: memory[lx1] = v6; goto C35ly1; 
	fi;
C29lx1ly1: memory[lx1] = v6; goto C29ly1; 
C28ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C35ly1; 
	::!tobool11 -> goto C29ly1; 
	:: memory[ly1] = 10; goto C28; 
	fi;
C27: tobool11 = (and10 == 0); goto C28; 
C36lx1ly1: memory[lx1] = v6; goto C36ly1; 
C35ly1: 
	if 
	:: goto C36ly1; 
	:: memory[ly1] = 10; goto C35; 
	fi;
C29ly1: memory[ly1] = 10; goto C29; 
C28: 
	if 
	::tobool11 -> retval_0 = 1; goto C35; 
	::!tobool11 -> goto C29; 
	fi;
C36ly1: memory[ly1] = 10; goto C36; 
C29: goto C30; 
C30: 13 = memory[glb]; goto C31; 
C31: 14 = memory[13]; goto C32; 
C32: inc13 = 14 + 1; goto C33; 
C33: goto C3413; 
C3413: 
	if 
	:: retval_0 = 1; goto C3513; 
	:: memory[13] = inc13; goto C34; 
	fi;
C3513: 
	if 
	:: goto C3613; 
	:: memory[13] = inc13; goto C35; 
	fi;
C34: retval_0 = 1; goto C35; 
C3613: memory[13] = inc13; goto C36; 
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
D11: goto D12v4; 
D36: returnvalue = retval_0; goto DEnd;
D12v4: 
	if 
	:: v5 = memory[y]; goto D13v4; 
	:: memory[v4] = 1; goto D12; 
	fi;
D13v4: 
	if 
	:: v6 = memory[v5]; goto D14v4; 
	:: memory[v4] = 1; goto D13; 
	fi;
D12: v5 = memory[y]; goto D13; 
D14v4: 
	if 
	:: v7 = memory[glb]; goto D15v4; 
	:: memory[v4] = 1; goto D14; 
	fi;
D13: v6 = memory[v5]; goto D14; 
D15v4: 
	if 
	:: v8 = memory[v7]; goto D16v4; 
	:: memory[v4] = 1; goto D15; 
	fi;
D14: v7 = memory[glb]; goto D15; 
D16v4: 
	if 
	:: cmp = (v8 == add); goto D17v4; 
	:: memory[v4] = 1; goto D16; 
	fi;
D15: v8 = memory[v7]; goto D16; 
D17v4: 
	if 
	::cmp -> goto D18v4; 
	::!cmp -> retval_0 = -1; goto D35v4; 
	:: memory[v4] = 1; goto D17; 
	fi;
D16: cmp = (v8 == add); goto D17; 
D18v4: 
	if 
	:: goto D19v4ly2; 
	:: memory[v4] = 1; goto D18; 
	fi;
D35v4: 
	if 
	:: goto D36v4; 
	:: memory[v4] = 1; goto D35; 
	fi;
D17: 
	if 
	::cmp -> goto D18; 
	::!cmp -> retval_0 = -1; goto D35; 
	fi;
D19v4ly2: 
	if 
	:: v9 = memory[x]; goto D20v4ly2; 
	:: memory[v4] = 1; goto D19ly2; 
	fi;
D18: goto D19ly2; 
D36v4: memory[v4] = 1; goto D36; 
D20v4ly2: 
	if 
	:: 10 = memory[v9]; goto D21v4ly2; 
	:: memory[v4] = 1; goto D20ly2; 
	fi;
D19ly2: 
	if 
	:: v9 = memory[x]; goto D20ly2; 
	:: memory[ly2] = v6; goto D19; 
	fi;
D21v4ly2: 
	if 
	:: 11 = memory[glb]; goto D22v4ly2; 
	:: memory[v4] = 1; goto D21ly2; 
	fi;
D20ly2: 
	if 
	:: 10 = memory[v9]; goto D21ly2; 
	:: memory[ly2] = v6; goto D20; 
	fi;
D19: v9 = memory[x]; goto D20; 
D22v4ly2: 
	if 
	:: 12 = memory[11]; goto D23v4ly2; 
	:: memory[v4] = 1; goto D22ly2; 
	fi;
D21ly2: 
	if 
	:: 11 = memory[glb]; goto D22ly2; 
	:: memory[ly2] = v6; goto D21; 
	fi;
D20: 10 = memory[v9]; goto D21; 
D23v4ly2: 
	if 
	:: cmp7 = (12 == add); goto D24v4ly2; 
	:: memory[v4] = 1; goto D23ly2; 
	fi;
D22ly2: 
	if 
	:: 12 = memory[11]; goto D23ly2; 
	:: memory[ly2] = v6; goto D22; 
	fi;
D21: 11 = memory[glb]; goto D22; 
D24v4ly2: 
	if 
	::cmp7 -> goto D25v4ly2; 
	::!cmp7 -> retval_0 = -1; goto D35v4ly2; 
	:: memory[v4] = 1; goto D24ly2; 
	fi;
D23ly2: 
	if 
	:: cmp7 = (12 == add); goto D24ly2; 
	:: memory[ly2] = v6; goto D23; 
	fi;
D22: 12 = memory[11]; goto D23; 
D25v4ly2: 
	if 
	:: goto D26v4ly2lx2; 
	:: memory[v4] = 1; goto D25ly2; 
	fi;
D35v4ly2: 
	if 
	:: goto D36v4ly2; 
	:: memory[v4] = 1; goto D35ly2; 
	fi;
D24ly2: 
	if 
	::cmp7 -> goto D25ly2; 
	::!cmp7 -> retval_0 = -1; goto D35ly2; 
	:: memory[ly2] = v6; goto D24; 
	fi;
D23: cmp7 = (12 == add); goto D24; 
D26v4ly2lx2: 
	if 
	:: and10 = add & 1; goto D27v4ly2lx2; 
	:: memory[v4] = 1; goto D26ly2lx2; 
	fi;
D25ly2: 
	if 
	:: goto D26ly2lx2; 
	:: memory[ly2] = v6; goto D25; 
	fi;
D36v4ly2: memory[v4] = 1; goto D36ly2; 
D35ly2: 
	if 
	:: goto D36ly2; 
	:: memory[ly2] = v6; goto D35; 
	fi;
D24: 
	if 
	::cmp7 -> goto D25; 
	::!cmp7 -> retval_0 = -1; goto D35; 
	fi;
D27v4ly2lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D28v4ly2lx2; 
	:: memory[v4] = 1; goto D27ly2lx2; 
	fi;
D26ly2lx2: 
	if 
	:: and10 = add & 1; goto D27ly2lx2; 
	:: memory[ly2] = v6; goto D26lx2; 
	fi;
D25: goto D26lx2; 
D36ly2: memory[ly2] = v6; goto D36; 
D28v4ly2lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D35v4ly2lx2; 
	::!tobool11 -> goto D29v4ly2lx2; 
	:: memory[v4] = 1; goto D28ly2lx2; 
	fi;
D27ly2lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D28ly2lx2; 
	:: memory[ly2] = v6; goto D27lx2; 
	fi;
D26lx2: 
	if 
	:: and10 = add & 1; goto D27lx2; 
	:: memory[lx2] = 10; goto D26; 
	fi;
D35v4ly2lx2: 
	if 
	:: goto D36v4ly2lx2; 
	:: memory[v4] = 1; goto D35ly2lx2; 
	fi;
D29v4ly2lx2: memory[v4] = 1; goto D29ly2lx2; 
D28ly2lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D35ly2lx2; 
	::!tobool11 -> goto D29ly2lx2; 
	:: memory[ly2] = v6; goto D28lx2; 
	fi;
D27lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D28lx2; 
	:: memory[lx2] = 10; goto D27; 
	fi;
D26: and10 = add & 1; goto D27; 
D36v4ly2lx2: memory[v4] = 1; goto D36ly2lx2; 
D35ly2lx2: 
	if 
	:: goto D36ly2lx2; 
	:: memory[ly2] = v6; goto D35lx2; 
	fi;
D29ly2lx2: memory[ly2] = v6; goto D29lx2; 
D28lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D35lx2; 
	::!tobool11 -> goto D29lx2; 
	:: memory[lx2] = 10; goto D28; 
	fi;
D27: tobool11 = (and10 == 0); goto D28; 
D36ly2lx2: memory[ly2] = v6; goto D36lx2; 
D35lx2: 
	if 
	:: goto D36lx2; 
	:: memory[lx2] = 10; goto D35; 
	fi;
D29lx2: memory[lx2] = 10; goto D29; 
D28: 
	if 
	::tobool11 -> retval_0 = 1; goto D35; 
	::!tobool11 -> goto D29; 
	fi;
D36lx2: memory[lx2] = 10; goto D36; 
D29: goto D30; 
D30: 13 = memory[glb]; goto D31; 
D31: 14 = memory[13]; goto D32; 
D32: inc13 = 14 + 1; goto D33; 
D33: goto D3413; 
D3413: 
	if 
	:: retval_0 = 1; goto D3513; 
	:: memory[13] = inc13; goto D34; 
	fi;
D3513: 
	if 
	:: goto D3613; 
	:: memory[13] = inc13; goto D35; 
	fi;
D34: retval_0 = 1; goto D35; 
D3613: memory[13] = inc13; goto D36; 
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
E11: goto E12v4; 
E22: returnvalue = retval_0; goto EEnd;
E12v4: 
	if 
	:: and5 = add & 1; goto E13v4; 
	:: memory[v4] = 1; goto E12; 
	fi;
E13v4: 
	if 
	:: tobool6 = (and5 == 0); goto E14v4; 
	:: memory[v4] = 1; goto E13; 
	fi;
E12: and5 = add & 1; goto E13; 
E14v4: 
	if 
	::tobool6 -> retval_0 = 1; goto E21v4; 
	::!tobool6 -> goto E15v4; 
	:: memory[v4] = 1; goto E14; 
	fi;
E13: tobool6 = (and5 == 0); goto E14; 
E21v4: 
	if 
	:: goto E22v4; 
	:: memory[v4] = 1; goto E21; 
	fi;
E15v4: memory[v4] = 1; goto E15; 
E14: 
	if 
	::tobool6 -> retval_0 = 1; goto E21; 
	::!tobool6 -> goto E15; 
	fi;
E22v4: memory[v4] = 1; goto E22; 
E15: goto E16; 
E16: v5 = memory[glb]; goto E17; 
E17: v6 = memory[v5]; goto E18; 
E18: inc8 = v6 + 1; goto E19; 
E19: goto E20v5; 
E20v5: 
	if 
	:: retval_0 = 1; goto E21v5; 
	:: memory[v5] = inc8; goto E20; 
	fi;
E21v5: 
	if 
	:: goto E22v5; 
	:: memory[v5] = inc8; goto E21; 
	fi;
E20: retval_0 = 1; goto E21; 
E22v5: memory[v5] = inc8; goto E22; 
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
F11: goto F12v4; 
F22: returnvalue = retval_0; goto FEnd;
F12v4: 
	if 
	:: and5 = add & 1; goto F13v4; 
	:: memory[v4] = 1; goto F12; 
	fi;
F13v4: 
	if 
	:: tobool6 = (and5 == 0); goto F14v4; 
	:: memory[v4] = 1; goto F13; 
	fi;
F12: and5 = add & 1; goto F13; 
F14v4: 
	if 
	::tobool6 -> retval_0 = 1; goto F21v4; 
	::!tobool6 -> goto F15v4; 
	:: memory[v4] = 1; goto F14; 
	fi;
F13: tobool6 = (and5 == 0); goto F14; 
F21v4: 
	if 
	:: goto F22v4; 
	:: memory[v4] = 1; goto F21; 
	fi;
F15v4: memory[v4] = 1; goto F15; 
F14: 
	if 
	::tobool6 -> retval_0 = 1; goto F21; 
	::!tobool6 -> goto F15; 
	fi;
F22v4: memory[v4] = 1; goto F22; 
F15: goto F16; 
F16: v5 = memory[glb]; goto F17; 
F17: v6 = memory[v5]; goto F18; 
F18: inc8 = v6 + 1; goto F19; 
F19: goto F20v5; 
F20v5: 
	if 
	:: retval_0 = 1; goto F21v5; 
	:: memory[v5] = inc8; goto F20; 
	fi;
F21v5: 
	if 
	:: goto F22v5; 
	:: memory[v5] = inc8; goto F21; 
	fi;
F20: retval_0 = 1; goto F21; 
F22v5: memory[v5] = inc8; goto F22; 
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
G11: goto G12lx1; 
G20: goto G21; 
G12lx1: 
	if 
	:: v5 = memory[y]; goto G13lx1; 
	:: memory[lx1] = v3; goto G12; 
	fi;
G21: returnvalue = retval_0; goto GEnd;
G13lx1: 
	if 
	:: v6 = memory[v5]; goto G14lx1; 
	:: memory[lx1] = v3; goto G13; 
	fi;
G12: v5 = memory[y]; goto G13; 
G14lx1: 
	if 
	:: v7 = memory[glb]; goto G15lx1; 
	:: memory[lx1] = v3; goto G14; 
	fi;
G13: v6 = memory[v5]; goto G14; 
G15lx1: 
	if 
	:: v8 = memory[v7]; goto G16lx1; 
	:: memory[lx1] = v3; goto G15; 
	fi;
G14: v7 = memory[glb]; goto G15; 
G16lx1: 
	if 
	:: cmp1 = (v8 == v1); goto G17lx1; 
	:: memory[lx1] = v3; goto G16; 
	fi;
G15: v8 = memory[v7]; goto G16; 
G17lx1: 
	if 
	::cmp1 -> goto G18lx1; 
	::!cmp1 -> retval_0 = -1; goto G20lx1; 
	:: memory[lx1] = v3; goto G17; 
	fi;
G16: cmp1 = (v8 == v1); goto G17; 
G18lx1: 
	if 
	:: goto G19lx1ly1; 
	:: memory[lx1] = v3; goto G18; 
	fi;
G20lx1: 
	if 
	:: goto G21lx1; 
	:: memory[lx1] = v3; goto G20; 
	fi;
G17: 
	if 
	::cmp1 -> goto G18; 
	::!cmp1 -> retval_0 = -1; goto G20; 
	fi;
G19lx1ly1: 
	if 
	:: retval_0 = 1; goto G20lx1ly1; 
	:: memory[lx1] = v3; goto G19ly1; 
	fi;
G18: goto G19ly1; 
G21lx1: memory[lx1] = v3; goto G21; 
G20lx1ly1: 
	if 
	:: goto G21lx1ly1; 
	:: memory[lx1] = v3; goto G20ly1; 
	fi;
G19ly1: 
	if 
	:: retval_0 = 1; goto G20ly1; 
	:: memory[ly1] = v6; goto G19; 
	fi;
G21lx1ly1: memory[lx1] = v3; goto G21ly1; 
G20ly1: 
	if 
	:: goto G21ly1; 
	:: memory[ly1] = v6; goto G20; 
	fi;
G19: retval_0 = 1; goto G20; 
G21ly1: memory[ly1] = v6; goto G21; 
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
H11: goto H12ly2; 
H20: goto H21; 
H12ly2: 
	if 
	:: v5 = memory[x]; goto H13ly2; 
	:: memory[ly2] = v3; goto H12; 
	fi;
H21: returnvalue = retval_0; goto HEnd;
H13ly2: 
	if 
	:: v6 = memory[v5]; goto H14ly2; 
	:: memory[ly2] = v3; goto H13; 
	fi;
H12: v5 = memory[x]; goto H13; 
H14ly2: 
	if 
	:: v7 = memory[glb]; goto H15ly2; 
	:: memory[ly2] = v3; goto H14; 
	fi;
H13: v6 = memory[v5]; goto H14; 
H15ly2: 
	if 
	:: v8 = memory[v7]; goto H16ly2; 
	:: memory[ly2] = v3; goto H15; 
	fi;
H14: v7 = memory[glb]; goto H15; 
H16ly2: 
	if 
	:: cmp1 = (v8 == v1); goto H17ly2; 
	:: memory[ly2] = v3; goto H16; 
	fi;
H15: v8 = memory[v7]; goto H16; 
H17ly2: 
	if 
	::cmp1 -> goto H18ly2; 
	::!cmp1 -> retval_0 = -1; goto H20ly2; 
	:: memory[ly2] = v3; goto H17; 
	fi;
H16: cmp1 = (v8 == v1); goto H17; 
H18ly2: 
	if 
	:: goto H19ly2lx2; 
	:: memory[ly2] = v3; goto H18; 
	fi;
H20ly2: 
	if 
	:: goto H21ly2; 
	:: memory[ly2] = v3; goto H20; 
	fi;
H17: 
	if 
	::cmp1 -> goto H18; 
	::!cmp1 -> retval_0 = -1; goto H20; 
	fi;
H19ly2lx2: 
	if 
	:: retval_0 = 1; goto H20ly2lx2; 
	:: memory[ly2] = v3; goto H19lx2; 
	fi;
H18: goto H19lx2; 
H21ly2: memory[ly2] = v3; goto H21; 
H20ly2lx2: 
	if 
	:: goto H21ly2lx2; 
	:: memory[ly2] = v3; goto H20lx2; 
	fi;
H19lx2: 
	if 
	:: retval_0 = 1; goto H20lx2; 
	:: memory[lx2] = v6; goto H19; 
	fi;
H21ly2lx2: memory[ly2] = v3; goto H21lx2; 
H20lx2: 
	if 
	:: goto H21lx2; 
	:: memory[lx2] = v6; goto H20; 
	fi;
H19: retval_0 = 1; goto H20; 
H21lx2: memory[lx2] = v6; goto H21; 
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

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
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, v10, inc10;
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
	:: memory[ly1] = v6; goto A19v4; 
	fi;
A18: goto A19ly1; 
A29v4: memory[v4] = 1; goto A29; 
A20v4ly1: 
	if 
	:: tobool8 = (and7 == 0); goto A21v4ly1; 
	:: memory[v4] = 1; goto A20ly1; 
	:: memory[ly1] = v6; goto A20v4; 
	fi;
A19ly1: 
	if 
	:: and7 = add & 1; goto A20ly1; 
	:: memory[ly1] = v6; goto A19; 
	fi;
A19v4: 
	if 
	:: and7 = add & 1; goto A20v4; 
	:: memory[v4] = 1; goto A19; 
	fi;
A21v4ly1: 
	if 
	::tobool8 -> retval_0 = 1; goto A28v4ly1; 
	::!tobool8 -> goto A22v4ly1; 
	:: memory[v4] = 1; goto A21ly1; 
	:: memory[ly1] = v6; goto A21v4; 
	fi;
A20ly1: 
	if 
	:: tobool8 = (and7 == 0); goto A21ly1; 
	:: memory[ly1] = v6; goto A20; 
	fi;
A20v4: 
	if 
	:: tobool8 = (and7 == 0); goto A21v4; 
	:: memory[v4] = 1; goto A20; 
	fi;
A19: and7 = add & 1; goto A20; 
A28v4ly1: 
	if 
	:: goto A29v4ly1; 
	:: memory[v4] = 1; goto A28ly1; 
	:: memory[ly1] = v6; goto A28v4; 
	fi;
A22v4ly1: 
	if 
	:: memory[v4] = 1; goto A22ly1; 
	:: memory[ly1] = v6; goto A22v4; 
	fi;
A21ly1: 
	if 
	::tobool8 -> retval_0 = 1; goto A28ly1; 
	::!tobool8 -> goto A22ly1; 
	:: memory[ly1] = v6; goto A21; 
	fi;
A21v4: 
	if 
	::tobool8 -> retval_0 = 1; goto A28v4; 
	::!tobool8 -> goto A22v4; 
	:: memory[v4] = 1; goto A21; 
	fi;
A20: tobool8 = (and7 == 0); goto A21; 
A29v4ly1: 
	if 
	:: memory[v4] = 1; goto A29ly1; 
	:: memory[ly1] = v6; goto A29v4; 
	fi;
A28ly1: 
	if 
	:: goto A29ly1; 
	:: memory[ly1] = v6; goto A28; 
	fi;
A22ly1: memory[ly1] = v6; goto A22; 
A22v4: memory[v4] = 1; goto A22; 
A21: 
	if 
	::tobool8 -> retval_0 = 1; goto A28; 
	::!tobool8 -> goto A22; 
	fi;
A29ly1: memory[ly1] = v6; goto A29; 
A22: goto A23; 
A23: v9 = memory[glb]; goto A24; 
A24: v10 = memory[v9]; goto A25; 
A25: inc10 = v10 + 1; goto A26; 
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
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, v10, inc10;
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
	:: memory[lx2] = v6; goto B19v4; 
	fi;
B18: goto B19lx2; 
B29v4: memory[v4] = 1; goto B29; 
B20v4lx2: 
	if 
	:: tobool8 = (and7 == 0); goto B21v4lx2; 
	:: memory[v4] = 1; goto B20lx2; 
	:: memory[lx2] = v6; goto B20v4; 
	fi;
B19lx2: 
	if 
	:: and7 = add & 1; goto B20lx2; 
	:: memory[lx2] = v6; goto B19; 
	fi;
B19v4: 
	if 
	:: and7 = add & 1; goto B20v4; 
	:: memory[v4] = 1; goto B19; 
	fi;
B21v4lx2: 
	if 
	::tobool8 -> retval_0 = 1; goto B28v4lx2; 
	::!tobool8 -> goto B22v4lx2; 
	:: memory[v4] = 1; goto B21lx2; 
	:: memory[lx2] = v6; goto B21v4; 
	fi;
B20lx2: 
	if 
	:: tobool8 = (and7 == 0); goto B21lx2; 
	:: memory[lx2] = v6; goto B20; 
	fi;
B20v4: 
	if 
	:: tobool8 = (and7 == 0); goto B21v4; 
	:: memory[v4] = 1; goto B20; 
	fi;
B19: and7 = add & 1; goto B20; 
B28v4lx2: 
	if 
	:: goto B29v4lx2; 
	:: memory[v4] = 1; goto B28lx2; 
	:: memory[lx2] = v6; goto B28v4; 
	fi;
B22v4lx2: 
	if 
	:: memory[v4] = 1; goto B22lx2; 
	:: memory[lx2] = v6; goto B22v4; 
	fi;
B21lx2: 
	if 
	::tobool8 -> retval_0 = 1; goto B28lx2; 
	::!tobool8 -> goto B22lx2; 
	:: memory[lx2] = v6; goto B21; 
	fi;
B21v4: 
	if 
	::tobool8 -> retval_0 = 1; goto B28v4; 
	::!tobool8 -> goto B22v4; 
	:: memory[v4] = 1; goto B21; 
	fi;
B20: tobool8 = (and7 == 0); goto B21; 
B29v4lx2: 
	if 
	:: memory[v4] = 1; goto B29lx2; 
	:: memory[lx2] = v6; goto B29v4; 
	fi;
B28lx2: 
	if 
	:: goto B29lx2; 
	:: memory[lx2] = v6; goto B28; 
	fi;
B22lx2: memory[lx2] = v6; goto B22; 
B22v4: memory[v4] = 1; goto B22; 
B21: 
	if 
	::tobool8 -> retval_0 = 1; goto B28; 
	::!tobool8 -> goto B22; 
	fi;
B29lx2: memory[lx2] = v6; goto B29; 
B22: goto B23; 
B23: v9 = memory[glb]; goto B24; 
B24: v10 = memory[v9]; goto B25; 
B25: inc10 = v10 + 1; goto B26; 
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
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, v10, v11, v12, cmp7, and10, tobool11, v13, v14, inc13;
CStart: goto C000;
C000: v0 = memory[glb]; goto C001; 
C001: goto C002; 
C002: v1 = memory[v0]; goto C003; 
C003: and = v1 & 1; goto C004; 
C004: tobool = (and == 0); goto C005; 
C005: 
	if 
	::tobool -> goto C006; 
	::!tobool -> goto C002; 
	fi;
C006: add = v1 + 1; goto C007; 
C007: cas(v0, v1, add, v2); goto C008; 
C008: v3 = (v2 == v1); goto C009; 
C009: 
	if 
	::v3 -> goto C010; 
	::!v3 -> retval_0 = -1; goto C035; 
	fi;
C010: v4 = memory[x]; goto C011; 
C035: goto C036; 
C011: goto C012v4; 
C036: returnvalue = retval_0; goto CEnd;
C012v4: 
	if 
	:: v5 = memory[x]; goto C013v4; 
	:: memory[v4] = 1; goto C012; 
	fi;
C013v4: 
	if 
	:: v6 = memory[v5]; goto C014v4; 
	:: memory[v4] = 1; goto C013; 
	fi;
C012: v5 = memory[x]; goto C013; 
C014v4: 
	if 
	:: v7 = memory[glb]; goto C015v4; 
	:: memory[v4] = 1; goto C014; 
	fi;
C013: v6 = memory[v5]; goto C014; 
C015v4: 
	if 
	:: v8 = memory[v7]; goto C016v4; 
	:: memory[v4] = 1; goto C015; 
	fi;
C014: v7 = memory[glb]; goto C015; 
C016v4: 
	if 
	:: cmp = (v8 == add); goto C017v4; 
	:: memory[v4] = 1; goto C016; 
	fi;
C015: v8 = memory[v7]; goto C016; 
C017v4: 
	if 
	::cmp -> goto C018v4; 
	::!cmp -> retval_0 = -1; goto C035v4; 
	:: memory[v4] = 1; goto C017; 
	fi;
C016: cmp = (v8 == add); goto C017; 
C018v4: 
	if 
	:: goto C019v4lx1; 
	:: memory[v4] = 1; goto C018; 
	fi;
C035v4: 
	if 
	:: goto C036v4; 
	:: memory[v4] = 1; goto C035; 
	fi;
C017: 
	if 
	::cmp -> goto C018; 
	::!cmp -> retval_0 = -1; goto C035; 
	fi;
C019v4lx1: 
	if 
	:: v9 = memory[y]; goto C020v4lx1; 
	:: memory[v4] = 1; goto C019lx1; 
	:: memory[lx1] = v6; goto C019v4; 
	fi;
C018: goto C019lx1; 
C036v4: memory[v4] = 1; goto C036; 
C020v4lx1: 
	if 
	:: v10 = memory[v9]; goto C021v4lx1; 
	:: memory[v4] = 1; goto C020lx1; 
	:: memory[lx1] = v6; goto C020v4; 
	fi;
C019lx1: 
	if 
	:: v9 = memory[y]; goto C020lx1; 
	:: memory[lx1] = v6; goto C019; 
	fi;
C019v4: 
	if 
	:: v9 = memory[y]; goto C020v4; 
	:: memory[v4] = 1; goto C019; 
	fi;
C021v4lx1: 
	if 
	:: v11 = memory[glb]; goto C022v4lx1; 
	:: memory[v4] = 1; goto C021lx1; 
	:: memory[lx1] = v6; goto C021v4; 
	fi;
C020lx1: 
	if 
	:: v10 = memory[v9]; goto C021lx1; 
	:: memory[lx1] = v6; goto C020; 
	fi;
C020v4: 
	if 
	:: v10 = memory[v9]; goto C021v4; 
	:: memory[v4] = 1; goto C020; 
	fi;
C019: v9 = memory[y]; goto C020; 
C022v4lx1: 
	if 
	:: v12 = memory[v11]; goto C023v4lx1; 
	:: memory[v4] = 1; goto C022lx1; 
	:: memory[lx1] = v6; goto C022v4; 
	fi;
C021lx1: 
	if 
	:: v11 = memory[glb]; goto C022lx1; 
	:: memory[lx1] = v6; goto C021; 
	fi;
C021v4: 
	if 
	:: v11 = memory[glb]; goto C022v4; 
	:: memory[v4] = 1; goto C021; 
	fi;
C020: v10 = memory[v9]; goto C021; 
C023v4lx1: 
	if 
	:: cmp7 = (v12 == add); goto C024v4lx1; 
	:: memory[v4] = 1; goto C023lx1; 
	:: memory[lx1] = v6; goto C023v4; 
	fi;
C022lx1: 
	if 
	:: v12 = memory[v11]; goto C023lx1; 
	:: memory[lx1] = v6; goto C022; 
	fi;
C022v4: 
	if 
	:: v12 = memory[v11]; goto C023v4; 
	:: memory[v4] = 1; goto C022; 
	fi;
C021: v11 = memory[glb]; goto C022; 
C024v4lx1: 
	if 
	::cmp7 -> goto C025v4lx1; 
	::!cmp7 -> retval_0 = -1; goto C035v4lx1; 
	:: memory[v4] = 1; goto C024lx1; 
	:: memory[lx1] = v6; goto C024v4; 
	fi;
C023lx1: 
	if 
	:: cmp7 = (v12 == add); goto C024lx1; 
	:: memory[lx1] = v6; goto C023; 
	fi;
C023v4: 
	if 
	:: cmp7 = (v12 == add); goto C024v4; 
	:: memory[v4] = 1; goto C023; 
	fi;
C022: v12 = memory[v11]; goto C023; 
C025v4lx1: 
	if 
	:: goto C026v4lx1ly1; 
	:: memory[v4] = 1; goto C025lx1; 
	:: memory[lx1] = v6; goto C025v4; 
	fi;
C035v4lx1: 
	if 
	:: goto C036v4lx1; 
	:: memory[v4] = 1; goto C035lx1; 
	:: memory[lx1] = v6; goto C035v4; 
	fi;
C024lx1: 
	if 
	::cmp7 -> goto C025lx1; 
	::!cmp7 -> retval_0 = -1; goto C035lx1; 
	:: memory[lx1] = v6; goto C024; 
	fi;
C024v4: 
	if 
	::cmp7 -> goto C025v4; 
	::!cmp7 -> retval_0 = -1; goto C035v4; 
	:: memory[v4] = 1; goto C024; 
	fi;
C023: cmp7 = (v12 == add); goto C024; 
C026v4lx1ly1: 
	if 
	:: and10 = add & 1; goto C027v4lx1ly1; 
	:: memory[v4] = 1; goto C026lx1ly1; 
	:: memory[lx1] = v6; goto C026v4ly1; 
	:: memory[ly1] = v10; goto C026v4lx1; 
	fi;
C025lx1: 
	if 
	:: goto C026lx1ly1; 
	:: memory[lx1] = v6; goto C025; 
	fi;
C025v4: 
	if 
	:: goto C026v4ly1; 
	:: memory[v4] = 1; goto C025; 
	fi;
C036v4lx1: 
	if 
	:: memory[v4] = 1; goto C036lx1; 
	:: memory[lx1] = v6; goto C036v4; 
	fi;
C035lx1: 
	if 
	:: goto C036lx1; 
	:: memory[lx1] = v6; goto C035; 
	fi;
C024: 
	if 
	::cmp7 -> goto C025; 
	::!cmp7 -> retval_0 = -1; goto C035; 
	fi;
C027v4lx1ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C028v4lx1ly1; 
	:: memory[v4] = 1; goto C027lx1ly1; 
	:: memory[lx1] = v6; goto C027v4ly1; 
	:: memory[ly1] = v10; goto C027v4lx1; 
	fi;
C026lx1ly1: 
	if 
	:: and10 = add & 1; goto C027lx1ly1; 
	:: memory[lx1] = v6; goto C026ly1; 
	:: memory[ly1] = v10; goto C026lx1; 
	fi;
C026v4ly1: 
	if 
	:: and10 = add & 1; goto C027v4ly1; 
	:: memory[v4] = 1; goto C026ly1; 
	:: memory[ly1] = v10; goto C026v4; 
	fi;
C026v4lx1: 
	if 
	:: and10 = add & 1; goto C027v4lx1; 
	:: memory[v4] = 1; goto C026lx1; 
	:: memory[lx1] = v6; goto C026v4; 
	fi;
C025: goto C026ly1; 
C036lx1: memory[lx1] = v6; goto C036; 
C028v4lx1ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035v4lx1ly1; 
	::!tobool11 -> goto C029v4lx1ly1; 
	:: memory[v4] = 1; goto C028lx1ly1; 
	:: memory[lx1] = v6; goto C028v4ly1; 
	:: memory[ly1] = v10; goto C028v4lx1; 
	fi;
C027lx1ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C028lx1ly1; 
	:: memory[lx1] = v6; goto C027ly1; 
	:: memory[ly1] = v10; goto C027lx1; 
	fi;
C027v4ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C028v4ly1; 
	:: memory[v4] = 1; goto C027ly1; 
	:: memory[ly1] = v10; goto C027v4; 
	fi;
C027v4lx1: 
	if 
	:: tobool11 = (and10 == 0); goto C028v4lx1; 
	:: memory[v4] = 1; goto C027lx1; 
	:: memory[lx1] = v6; goto C027v4; 
	fi;
C026ly1: 
	if 
	:: and10 = add & 1; goto C027ly1; 
	:: memory[ly1] = v10; goto C026; 
	fi;
C026lx1: 
	if 
	:: and10 = add & 1; goto C027lx1; 
	:: memory[lx1] = v6; goto C026; 
	fi;
C026v4: 
	if 
	:: and10 = add & 1; goto C027v4; 
	:: memory[v4] = 1; goto C026; 
	fi;
C035v4lx1ly1: 
	if 
	:: goto C036v4lx1ly1; 
	:: memory[v4] = 1; goto C035lx1ly1; 
	:: memory[lx1] = v6; goto C035v4ly1; 
	:: memory[ly1] = v10; goto C035v4lx1; 
	fi;
C029v4lx1ly1: 
	if 
	:: memory[v4] = 1; goto C029lx1ly1; 
	:: memory[lx1] = v6; goto C029v4ly1; 
	:: memory[ly1] = v10; goto C029v4lx1; 
	fi;
C028lx1ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035lx1ly1; 
	::!tobool11 -> goto C029lx1ly1; 
	:: memory[lx1] = v6; goto C028ly1; 
	:: memory[ly1] = v10; goto C028lx1; 
	fi;
C028v4ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035v4ly1; 
	::!tobool11 -> goto C029v4ly1; 
	:: memory[v4] = 1; goto C028ly1; 
	:: memory[ly1] = v10; goto C028v4; 
	fi;
C028v4lx1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035v4lx1; 
	::!tobool11 -> goto C029v4lx1; 
	:: memory[v4] = 1; goto C028lx1; 
	:: memory[lx1] = v6; goto C028v4; 
	fi;
C027ly1: 
	if 
	:: tobool11 = (and10 == 0); goto C028ly1; 
	:: memory[ly1] = v10; goto C027; 
	fi;
C027lx1: 
	if 
	:: tobool11 = (and10 == 0); goto C028lx1; 
	:: memory[lx1] = v6; goto C027; 
	fi;
C027v4: 
	if 
	:: tobool11 = (and10 == 0); goto C028v4; 
	:: memory[v4] = 1; goto C027; 
	fi;
C026: and10 = add & 1; goto C027; 
C036v4lx1ly1: 
	if 
	:: memory[v4] = 1; goto C036lx1ly1; 
	:: memory[lx1] = v6; goto C036v4ly1; 
	:: memory[ly1] = v10; goto C036v4lx1; 
	fi;
C035lx1ly1: 
	if 
	:: goto C036lx1ly1; 
	:: memory[lx1] = v6; goto C035ly1; 
	:: memory[ly1] = v10; goto C035lx1; 
	fi;
C035v4ly1: 
	if 
	:: goto C036v4ly1; 
	:: memory[v4] = 1; goto C035ly1; 
	:: memory[ly1] = v10; goto C035v4; 
	fi;
C029lx1ly1: 
	if 
	:: memory[lx1] = v6; goto C029ly1; 
	:: memory[ly1] = v10; goto C029lx1; 
	fi;
C029v4ly1: 
	if 
	:: memory[v4] = 1; goto C029ly1; 
	:: memory[ly1] = v10; goto C029v4; 
	fi;
C029v4lx1: 
	if 
	:: memory[v4] = 1; goto C029lx1; 
	:: memory[lx1] = v6; goto C029v4; 
	fi;
C028ly1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035ly1; 
	::!tobool11 -> goto C029ly1; 
	:: memory[ly1] = v10; goto C028; 
	fi;
C028lx1: 
	if 
	::tobool11 -> retval_0 = 1; goto C035lx1; 
	::!tobool11 -> goto C029lx1; 
	:: memory[lx1] = v6; goto C028; 
	fi;
C028v4: 
	if 
	::tobool11 -> retval_0 = 1; goto C035v4; 
	::!tobool11 -> goto C029v4; 
	:: memory[v4] = 1; goto C028; 
	fi;
C027: tobool11 = (and10 == 0); goto C028; 
C036lx1ly1: 
	if 
	:: memory[lx1] = v6; goto C036ly1; 
	:: memory[ly1] = v10; goto C036lx1; 
	fi;
C036v4ly1: 
	if 
	:: memory[v4] = 1; goto C036ly1; 
	:: memory[ly1] = v10; goto C036v4; 
	fi;
C035ly1: 
	if 
	:: goto C036ly1; 
	:: memory[ly1] = v10; goto C035; 
	fi;
C029ly1: memory[ly1] = v10; goto C029; 
C029lx1: memory[lx1] = v6; goto C029; 
C029v4: memory[v4] = 1; goto C029; 
C028: 
	if 
	::tobool11 -> retval_0 = 1; goto C035; 
	::!tobool11 -> goto C029; 
	fi;
C036ly1: memory[ly1] = v10; goto C036; 
C029: goto C030; 
C030: v13 = memory[glb]; goto C031; 
C031: v14 = memory[v13]; goto C032; 
C032: inc13 = v14 + 1; goto C033; 
C033: goto C034v13; 
C034v13: 
	if 
	:: retval_0 = 1; goto C035v13; 
	:: memory[v13] = inc13; goto C034; 
	fi;
C035v13: 
	if 
	:: goto C036v13; 
	:: memory[v13] = inc13; goto C035; 
	fi;
C034: retval_0 = 1; goto C035; 
C036v13: memory[v13] = inc13; goto C036; 
CEnd: skip;

}


inline proc22(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, v10, v11, v12, cmp7, and10, tobool11, v13, v14, inc13;
DStart: goto D000;
D000: v0 = memory[glb]; goto D001; 
D001: goto D002; 
D002: v1 = memory[v0]; goto D003; 
D003: and = v1 & 1; goto D004; 
D004: tobool = (and == 0); goto D005; 
D005: 
	if 
	::tobool -> goto D006; 
	::!tobool -> goto D002; 
	fi;
D006: add = v1 + 1; goto D007; 
D007: cas(v0, v1, add, v2); goto D008; 
D008: v3 = (v2 == v1); goto D009; 
D009: 
	if 
	::v3 -> goto D010; 
	::!v3 -> retval_0 = -1; goto D035; 
	fi;
D010: v4 = memory[y]; goto D011; 
D035: goto D036; 
D011: goto D012v4; 
D036: returnvalue = retval_0; goto DEnd;
D012v4: 
	if 
	:: v5 = memory[y]; goto D013v4; 
	:: memory[v4] = 1; goto D012; 
	fi;
D013v4: 
	if 
	:: v6 = memory[v5]; goto D014v4; 
	:: memory[v4] = 1; goto D013; 
	fi;
D012: v5 = memory[y]; goto D013; 
D014v4: 
	if 
	:: v7 = memory[glb]; goto D015v4; 
	:: memory[v4] = 1; goto D014; 
	fi;
D013: v6 = memory[v5]; goto D014; 
D015v4: 
	if 
	:: v8 = memory[v7]; goto D016v4; 
	:: memory[v4] = 1; goto D015; 
	fi;
D014: v7 = memory[glb]; goto D015; 
D016v4: 
	if 
	:: cmp = (v8 == add); goto D017v4; 
	:: memory[v4] = 1; goto D016; 
	fi;
D015: v8 = memory[v7]; goto D016; 
D017v4: 
	if 
	::cmp -> goto D018v4; 
	::!cmp -> retval_0 = -1; goto D035v4; 
	:: memory[v4] = 1; goto D017; 
	fi;
D016: cmp = (v8 == add); goto D017; 
D018v4: 
	if 
	:: goto D019v4ly2; 
	:: memory[v4] = 1; goto D018; 
	fi;
D035v4: 
	if 
	:: goto D036v4; 
	:: memory[v4] = 1; goto D035; 
	fi;
D017: 
	if 
	::cmp -> goto D018; 
	::!cmp -> retval_0 = -1; goto D035; 
	fi;
D019v4ly2: 
	if 
	:: v9 = memory[x]; goto D020v4ly2; 
	:: memory[v4] = 1; goto D019ly2; 
	:: memory[ly2] = v6; goto D019v4; 
	fi;
D018: goto D019ly2; 
D036v4: memory[v4] = 1; goto D036; 
D020v4ly2: 
	if 
	:: v10 = memory[v9]; goto D021v4ly2; 
	:: memory[v4] = 1; goto D020ly2; 
	:: memory[ly2] = v6; goto D020v4; 
	fi;
D019ly2: 
	if 
	:: v9 = memory[x]; goto D020ly2; 
	:: memory[ly2] = v6; goto D019; 
	fi;
D019v4: 
	if 
	:: v9 = memory[x]; goto D020v4; 
	:: memory[v4] = 1; goto D019; 
	fi;
D021v4ly2: 
	if 
	:: v11 = memory[glb]; goto D022v4ly2; 
	:: memory[v4] = 1; goto D021ly2; 
	:: memory[ly2] = v6; goto D021v4; 
	fi;
D020ly2: 
	if 
	:: v10 = memory[v9]; goto D021ly2; 
	:: memory[ly2] = v6; goto D020; 
	fi;
D020v4: 
	if 
	:: v10 = memory[v9]; goto D021v4; 
	:: memory[v4] = 1; goto D020; 
	fi;
D019: v9 = memory[x]; goto D020; 
D022v4ly2: 
	if 
	:: v12 = memory[v11]; goto D023v4ly2; 
	:: memory[v4] = 1; goto D022ly2; 
	:: memory[ly2] = v6; goto D022v4; 
	fi;
D021ly2: 
	if 
	:: v11 = memory[glb]; goto D022ly2; 
	:: memory[ly2] = v6; goto D021; 
	fi;
D021v4: 
	if 
	:: v11 = memory[glb]; goto D022v4; 
	:: memory[v4] = 1; goto D021; 
	fi;
D020: v10 = memory[v9]; goto D021; 
D023v4ly2: 
	if 
	:: cmp7 = (v12 == add); goto D024v4ly2; 
	:: memory[v4] = 1; goto D023ly2; 
	:: memory[ly2] = v6; goto D023v4; 
	fi;
D022ly2: 
	if 
	:: v12 = memory[v11]; goto D023ly2; 
	:: memory[ly2] = v6; goto D022; 
	fi;
D022v4: 
	if 
	:: v12 = memory[v11]; goto D023v4; 
	:: memory[v4] = 1; goto D022; 
	fi;
D021: v11 = memory[glb]; goto D022; 
D024v4ly2: 
	if 
	::cmp7 -> goto D025v4ly2; 
	::!cmp7 -> retval_0 = -1; goto D035v4ly2; 
	:: memory[v4] = 1; goto D024ly2; 
	:: memory[ly2] = v6; goto D024v4; 
	fi;
D023ly2: 
	if 
	:: cmp7 = (v12 == add); goto D024ly2; 
	:: memory[ly2] = v6; goto D023; 
	fi;
D023v4: 
	if 
	:: cmp7 = (v12 == add); goto D024v4; 
	:: memory[v4] = 1; goto D023; 
	fi;
D022: v12 = memory[v11]; goto D023; 
D025v4ly2: 
	if 
	:: goto D026v4ly2lx2; 
	:: memory[v4] = 1; goto D025ly2; 
	:: memory[ly2] = v6; goto D025v4; 
	fi;
D035v4ly2: 
	if 
	:: goto D036v4ly2; 
	:: memory[v4] = 1; goto D035ly2; 
	:: memory[ly2] = v6; goto D035v4; 
	fi;
D024ly2: 
	if 
	::cmp7 -> goto D025ly2; 
	::!cmp7 -> retval_0 = -1; goto D035ly2; 
	:: memory[ly2] = v6; goto D024; 
	fi;
D024v4: 
	if 
	::cmp7 -> goto D025v4; 
	::!cmp7 -> retval_0 = -1; goto D035v4; 
	:: memory[v4] = 1; goto D024; 
	fi;
D023: cmp7 = (v12 == add); goto D024; 
D026v4ly2lx2: 
	if 
	:: and10 = add & 1; goto D027v4ly2lx2; 
	:: memory[v4] = 1; goto D026ly2lx2; 
	:: memory[ly2] = v6; goto D026v4lx2; 
	:: memory[lx2] = v10; goto D026v4ly2; 
	fi;
D025ly2: 
	if 
	:: goto D026ly2lx2; 
	:: memory[ly2] = v6; goto D025; 
	fi;
D025v4: 
	if 
	:: goto D026v4lx2; 
	:: memory[v4] = 1; goto D025; 
	fi;
D036v4ly2: 
	if 
	:: memory[v4] = 1; goto D036ly2; 
	:: memory[ly2] = v6; goto D036v4; 
	fi;
D035ly2: 
	if 
	:: goto D036ly2; 
	:: memory[ly2] = v6; goto D035; 
	fi;
D024: 
	if 
	::cmp7 -> goto D025; 
	::!cmp7 -> retval_0 = -1; goto D035; 
	fi;
D027v4ly2lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D028v4ly2lx2; 
	:: memory[v4] = 1; goto D027ly2lx2; 
	:: memory[ly2] = v6; goto D027v4lx2; 
	:: memory[lx2] = v10; goto D027v4ly2; 
	fi;
D026ly2lx2: 
	if 
	:: and10 = add & 1; goto D027ly2lx2; 
	:: memory[ly2] = v6; goto D026lx2; 
	:: memory[lx2] = v10; goto D026ly2; 
	fi;
D026v4lx2: 
	if 
	:: and10 = add & 1; goto D027v4lx2; 
	:: memory[v4] = 1; goto D026lx2; 
	:: memory[lx2] = v10; goto D026v4; 
	fi;
D026v4ly2: 
	if 
	:: and10 = add & 1; goto D027v4ly2; 
	:: memory[v4] = 1; goto D026ly2; 
	:: memory[ly2] = v6; goto D026v4; 
	fi;
D025: goto D026lx2; 
D036ly2: memory[ly2] = v6; goto D036; 
D028v4ly2lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035v4ly2lx2; 
	::!tobool11 -> goto D029v4ly2lx2; 
	:: memory[v4] = 1; goto D028ly2lx2; 
	:: memory[ly2] = v6; goto D028v4lx2; 
	:: memory[lx2] = v10; goto D028v4ly2; 
	fi;
D027ly2lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D028ly2lx2; 
	:: memory[ly2] = v6; goto D027lx2; 
	:: memory[lx2] = v10; goto D027ly2; 
	fi;
D027v4lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D028v4lx2; 
	:: memory[v4] = 1; goto D027lx2; 
	:: memory[lx2] = v10; goto D027v4; 
	fi;
D027v4ly2: 
	if 
	:: tobool11 = (and10 == 0); goto D028v4ly2; 
	:: memory[v4] = 1; goto D027ly2; 
	:: memory[ly2] = v6; goto D027v4; 
	fi;
D026lx2: 
	if 
	:: and10 = add & 1; goto D027lx2; 
	:: memory[lx2] = v10; goto D026; 
	fi;
D026ly2: 
	if 
	:: and10 = add & 1; goto D027ly2; 
	:: memory[ly2] = v6; goto D026; 
	fi;
D026v4: 
	if 
	:: and10 = add & 1; goto D027v4; 
	:: memory[v4] = 1; goto D026; 
	fi;
D035v4ly2lx2: 
	if 
	:: goto D036v4ly2lx2; 
	:: memory[v4] = 1; goto D035ly2lx2; 
	:: memory[ly2] = v6; goto D035v4lx2; 
	:: memory[lx2] = v10; goto D035v4ly2; 
	fi;
D029v4ly2lx2: 
	if 
	:: memory[v4] = 1; goto D029ly2lx2; 
	:: memory[ly2] = v6; goto D029v4lx2; 
	:: memory[lx2] = v10; goto D029v4ly2; 
	fi;
D028ly2lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035ly2lx2; 
	::!tobool11 -> goto D029ly2lx2; 
	:: memory[ly2] = v6; goto D028lx2; 
	:: memory[lx2] = v10; goto D028ly2; 
	fi;
D028v4lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035v4lx2; 
	::!tobool11 -> goto D029v4lx2; 
	:: memory[v4] = 1; goto D028lx2; 
	:: memory[lx2] = v10; goto D028v4; 
	fi;
D028v4ly2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035v4ly2; 
	::!tobool11 -> goto D029v4ly2; 
	:: memory[v4] = 1; goto D028ly2; 
	:: memory[ly2] = v6; goto D028v4; 
	fi;
D027lx2: 
	if 
	:: tobool11 = (and10 == 0); goto D028lx2; 
	:: memory[lx2] = v10; goto D027; 
	fi;
D027ly2: 
	if 
	:: tobool11 = (and10 == 0); goto D028ly2; 
	:: memory[ly2] = v6; goto D027; 
	fi;
D027v4: 
	if 
	:: tobool11 = (and10 == 0); goto D028v4; 
	:: memory[v4] = 1; goto D027; 
	fi;
D026: and10 = add & 1; goto D027; 
D036v4ly2lx2: 
	if 
	:: memory[v4] = 1; goto D036ly2lx2; 
	:: memory[ly2] = v6; goto D036v4lx2; 
	:: memory[lx2] = v10; goto D036v4ly2; 
	fi;
D035ly2lx2: 
	if 
	:: goto D036ly2lx2; 
	:: memory[ly2] = v6; goto D035lx2; 
	:: memory[lx2] = v10; goto D035ly2; 
	fi;
D035v4lx2: 
	if 
	:: goto D036v4lx2; 
	:: memory[v4] = 1; goto D035lx2; 
	:: memory[lx2] = v10; goto D035v4; 
	fi;
D029ly2lx2: 
	if 
	:: memory[ly2] = v6; goto D029lx2; 
	:: memory[lx2] = v10; goto D029ly2; 
	fi;
D029v4lx2: 
	if 
	:: memory[v4] = 1; goto D029lx2; 
	:: memory[lx2] = v10; goto D029v4; 
	fi;
D029v4ly2: 
	if 
	:: memory[v4] = 1; goto D029ly2; 
	:: memory[ly2] = v6; goto D029v4; 
	fi;
D028lx2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035lx2; 
	::!tobool11 -> goto D029lx2; 
	:: memory[lx2] = v10; goto D028; 
	fi;
D028ly2: 
	if 
	::tobool11 -> retval_0 = 1; goto D035ly2; 
	::!tobool11 -> goto D029ly2; 
	:: memory[ly2] = v6; goto D028; 
	fi;
D028v4: 
	if 
	::tobool11 -> retval_0 = 1; goto D035v4; 
	::!tobool11 -> goto D029v4; 
	:: memory[v4] = 1; goto D028; 
	fi;
D027: tobool11 = (and10 == 0); goto D028; 
D036ly2lx2: 
	if 
	:: memory[ly2] = v6; goto D036lx2; 
	:: memory[lx2] = v10; goto D036ly2; 
	fi;
D036v4lx2: 
	if 
	:: memory[v4] = 1; goto D036lx2; 
	:: memory[lx2] = v10; goto D036v4; 
	fi;
D035lx2: 
	if 
	:: goto D036lx2; 
	:: memory[lx2] = v10; goto D035; 
	fi;
D029lx2: memory[lx2] = v10; goto D029; 
D029ly2: memory[ly2] = v6; goto D029; 
D029v4: memory[v4] = 1; goto D029; 
D028: 
	if 
	::tobool11 -> retval_0 = 1; goto D035; 
	::!tobool11 -> goto D029; 
	fi;
D036lx2: memory[lx2] = v10; goto D036; 
D029: goto D030; 
D030: v13 = memory[glb]; goto D031; 
D031: v14 = memory[v13]; goto D032; 
D032: inc13 = v14 + 1; goto D033; 
D033: goto D034v13; 
D034v13: 
	if 
	:: retval_0 = 1; goto D035v13; 
	:: memory[v13] = inc13; goto D034; 
	fi;
D035v13: 
	if 
	:: goto D036v13; 
	:: memory[v13] = inc13; goto D035; 
	fi;
D034: retval_0 = 1; goto D035; 
D036v13: memory[v13] = inc13; goto D036; 
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
	:: memory[ly1] = v6; goto G19lx1; 
	fi;
G18: goto G19ly1; 
G21lx1: memory[lx1] = v3; goto G21; 
G20lx1ly1: 
	if 
	:: goto G21lx1ly1; 
	:: memory[lx1] = v3; goto G20ly1; 
	:: memory[ly1] = v6; goto G20lx1; 
	fi;
G19ly1: 
	if 
	:: retval_0 = 1; goto G20ly1; 
	:: memory[ly1] = v6; goto G19; 
	fi;
G19lx1: 
	if 
	:: retval_0 = 1; goto G20lx1; 
	:: memory[lx1] = v3; goto G19; 
	fi;
G21lx1ly1: 
	if 
	:: memory[lx1] = v3; goto G21ly1; 
	:: memory[ly1] = v6; goto G21lx1; 
	fi;
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
	:: memory[lx2] = v6; goto H19ly2; 
	fi;
H18: goto H19lx2; 
H21ly2: memory[ly2] = v3; goto H21; 
H20ly2lx2: 
	if 
	:: goto H21ly2lx2; 
	:: memory[ly2] = v3; goto H20lx2; 
	:: memory[lx2] = v6; goto H20ly2; 
	fi;
H19lx2: 
	if 
	:: retval_0 = 1; goto H20lx2; 
	:: memory[lx2] = v6; goto H19; 
	fi;
H19ly2: 
	if 
	:: retval_0 = 1; goto H20ly2; 
	:: memory[ly2] = v3; goto H19; 
	fi;
H21ly2lx2: 
	if 
	:: memory[ly2] = v3; goto H21lx2; 
	:: memory[lx2] = v6; goto H21ly2; 
	fi;
H20lx2: 
	if 
	:: goto H21lx2; 
	:: memory[lx2] = v6; goto H20; 
	fi;
H19: retval_0 = 1; goto H20; 
H21lx2: memory[lx2] = v6; goto H21; 
HEnd: skip;

}


//Stubs

//proc11 || proc21: litmus test for write reordering
//proc12 || proc22: litmus test for early reads
//proc13 || proc23 || proc33  || proc43: litmus test IRIW (independent read independent writes)

short result1, result2, result3, result4;

proctype process1(){
	proc11(result1);
end: skip;
}

proctype process2(){
	proc21(result2);
end: skip;
}


//-----------
proctype process12(){
	proc12(result1);
end: skip;
}

proctype process22(){
	proc22(result2);
end: skip;
}

//-----------------------------
proctype process13(){
	proc13(result1);
end: skip;
}

proctype process23(){
	proc23(result2);
end: skip;
}

proctype process33(){
	proc33(result3);
end: skip;
}

proctype process43(){
	proc43(result4);
end: skip;
}

init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, glb);
	alloca(1, memory[glb]);
	alloca(1, x);
	alloca(1, memory[x]);
	alloca(1, y);
	alloca(1, memory[y]);
	alloca(1, lx1);
	alloca(1, ly1);
	alloca(1, lx2);
	alloca(1, ly2);
	

	run process13();
	run process23();
	run process33();
	run process43();
	}
}


//both transactions finished without abort -> only one may observe value 0 
//ltl reorder{ [] ((process1@end && process2@end && result1 == 1 && result2 == 1) -> !(memory[ly1] == 0 && memory[lx2] == 0))}
//ltl early{ [] ((process12@end) && (process22@end) -> !(memory[lx1] == 1 && memory[ly1] == 0 && memory[ly2] == 1 && memory[lx2] == 0))}
ltl iriw{ [] ((process13@end && process23@end && process33@end && process43@end) 
-> !(memory[lx1] == 1 && memory[ly2] == 1 && memory[ly1] == 0 && memory[lx2] == 0))}
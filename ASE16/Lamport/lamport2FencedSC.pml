#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short choosing = zeroinitializer;
short number = zeroinitializer;


//standard stuff
inline getelementptr(type, instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
	assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
	}
}
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline proci(i){
short arrayidx, v0, v1, v2, v3, v4, cmp, add, add2, arrayidx1, arrayidx3, v5, v6, v7, arrayidx11, j_023, inc, arrayidx6, v8, v9, v10, tobool, arrayidx8, v11, v12, cmp9, cmp17, v13, exitcond, v14, cmp12, arrayidx21, cmp15, v15, or_cond, or_cond24;
AStart: goto A00;
A00: getelementptr(1, choosing, -1, arrayidx); goto A01; 
A01: v0 = memory[arrayidx]; goto A02; 
A02: goto A03; 
A03: goto A04; 
A04: v1 = memory[]; goto A05; 
A05: v2 = memory[v1]; goto A06; 
A06: v3 = memory[]; goto A07; 
A07: v4 = memory[v3]; goto A08; 
A08: cmp = (v2 < v4); goto A09; 
A09: 
	if 
	::cmp -> goto A10; 
	::!cmp -> goto A15; 
	fi;
A10: add = v4 + 1; goto A11; 
A15: add2 = v2 + 1; goto A16; 
A11: getelementptr(1, number, -1, arrayidx1); goto A12; 
A16: getelementptr(1, number, -1, arrayidx3); goto A17; 
A12: v5 = memory[arrayidx1]; goto A13; 
A17: v6 = memory[arrayidx3]; goto A18; 
A13: goto A14; 
A18: goto A19; 
A14: goto A20; 
A19: goto A20; 
A20: v7 = memory[arrayidx]; goto A21; 
A21: goto A22; 
A22: getelementptr(1, number, -1, arrayidx11); goto A23; 
A23: goto A24; 
A24: j_023 = 0; goto A25; 
A25: goto A26; 
A26: getelementptr(1, choosing, -1, arrayidx6); goto A27; 
A27: v8 = memory[arrayidx6]; goto A28; 
A28: v9 = memory[v8]; goto A29; 
A29: v10 = v9 & 1; goto A30; 
A30: tobool = (v10 == 0); goto A31; 
A31: 
	if 
	::tobool -> goto A33; 
	::!tobool -> goto A32; 
	fi;
A33: getelementptr(1, number, -1, arrayidx8); goto A34; 
A32: goto A32; 
A34: v11 = memory[arrayidx8]; goto A35; 
A35: v12 = memory[v11]; goto A36; 
A36: cmp9 = (v12 == 0); goto A37; 
A37: cmp17 = (j_023 < i); goto A38; 
A38: 
	if 
	::cmp9 -> goto A46; 
	::!cmp9 -> goto A39; 
	fi;
A46: inc = j_023 + 1; goto A47; 
A39: v13 = memory[arrayidx11]; goto A40; 
A47: exitcond = (inc == 2); goto A48; 
A40: v14 = memory[v13]; goto A41; 
A48: 
	if 
	::exitcond -> goto A49; 
	::!exitcond -> j_023 = inc; goto A25; 
	fi;
A41: cmp12 = (v12 < v14); goto A42; 
A49: getelementptr(1, number, -1, arrayidx21); goto A50; 
A42: cmp15 = (v12 == v14); goto A43; 
A50: v15 = memory[arrayidx21]; goto A51; 
A43: or_cond = cmp15 & cmp17; goto A44; 
A51: goto A52; 
A44: or_cond24 = cmp12 | or_cond; goto A45; 
A52: goto AEnd;
A45: 
	if 
	::or_cond24 -> goto A39; 
	::!or_cond24 -> goto A46; 
	fi;
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
	//TODO: empty stub

	run process1();
	run process2();
	}
}

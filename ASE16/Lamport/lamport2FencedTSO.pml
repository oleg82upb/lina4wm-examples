#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short choosing = 0; //Array: please, check initialization in the init process
short number = 0; //Array: please, check initialization in the init process


//pointer computation 
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
//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline proci(i){
short arrayidx, v0, v1, cmp, v2, v3, add, add2, arrayidx1, arrayidx3, arrayidx11, j_023, inc, arrayidx6, v4, v5, tobool, arrayidx8, cmp17, v6, cmp9, v7, exitcond, v8, cmp12, arrayidx21, v9, v10, cmp15, or_cond;
AStart: goto A00;
A00: getelementptr(2, choosing, 0 + i, arrayidx); goto A01; 
A01: goto A02arrayidx; 
A02arrayidx: memory[arrayidx] = 1; goto A02; 
A02: goto A03; 
A03: v0 = memory[number + 0]; goto A04; 
A04: v1 = memory[number + 1]; goto A05; 
A05: cmp = (v0 < v1); goto A06; 
A06: 
	if 
	::cmp -> goto A07; 
	::!cmp -> goto A12; 
	fi;
A07: v2 = memory[number + 1]; goto A08; 
A12: v3 = memory[number + 0]; goto A13; 
A08: add = v2 + 1; goto A09; 
A13: add2 = v3 + 1; goto A14; 
A09: getelementptr(2, number, 0 + i, arrayidx1); goto A10; 
A14: getelementptr(2, number, 0 + i, arrayidx3); goto A15; 
A10: goto A11arrayidx1; 
A15: goto A16arrayidx3; 
A11arrayidx1: 
	if 
	:: goto A17arrayidx1; 
	:: memory[arrayidx1] = add; goto A11; 
	fi;
A16arrayidx3: 
	if 
	:: goto A17arrayidx3; 
	:: memory[arrayidx3] = add2; goto A16; 
	fi;
A17arrayidx1: memory[arrayidx1] = add; goto A17; 
A11: goto A17; 
A17arrayidx3: memory[arrayidx3] = add2; goto A17; 
A16: goto A17; 
A17: goto A18; 
A18: goto A19arrayidx; 
A19arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A20arrayidx; 
	:: memory[arrayidx] = 0; goto A19; 
	fi;
A20arrayidx: memory[arrayidx] = 0; goto A20; 
A19: getelementptr(2, number, 0 + i, arrayidx11); goto A20; 
A20: goto A21; 
A21: j_023 = 0; goto A22; 
A22: goto A23; 
A23: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A24; 
A24: goto A25; 
A25: v4 = memory[arrayidx6]; goto A26; 
A26: v5 = v4 & 1; goto A27; 
A27: tobool = (v5 == 0); goto A28; 
A28: 
	if 
	::tobool -> goto A29; 
	::!tobool -> goto A25; 
	fi;
A29: getelementptr(2, number, 0 + j_023, arrayidx8); goto A30; 
A30: cmp17 = (j_023 < i); goto A31; 
A31: goto A32; 
A32: v6 = memory[arrayidx8]; goto A33; 
A33: cmp9 = (v6 == 0); goto A34; 
A34: 
	if 
	::cmp9 -> goto A44; 
	::!cmp9 -> goto A35; 
	fi;
A44: inc = j_023 + 1; goto A45; 
A35: v7 = memory[arrayidx8]; goto A36; 
A45: exitcond = (inc == 2); goto A46; 
A36: v8 = memory[arrayidx11]; goto A37; 
A46: 
	if 
	::exitcond -> goto A47; 
	::!exitcond -> j_023 = inc; goto A22; 
	fi;
A37: cmp12 = (v7 < v8); goto A38; 
A47: getelementptr(2, number, 0 + i, arrayidx21); goto A48; 
A38: 
	if 
	::cmp12 -> goto A32; 
	::!cmp12 -> goto A39; 
	fi;
A48: goto A49arrayidx21; 
A39: v9 = memory[arrayidx8]; goto A40; 
A49arrayidx21: memory[arrayidx21] = 0; goto A49; 
A40: v10 = memory[arrayidx11]; goto A41; 
A49: goto AEnd;
A41: cmp15 = (v9 == v10); goto A42; 
A42: or_cond = cmp15 & cmp17; goto A43; 
A43: 
	if 
	::or_cond -> goto A32; 
	::!or_cond -> goto A44; 
	fi;
AEnd: skip;

}

//Stubs
proctype process1(){
	proci(0);
}

proctype process2(){
	proci(1);
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(2, choosing);
	alloca(2, number);
	

	run process1();
	run process2();
	}
}
ltl prop{ [] !((process1@A46) && (process2@A46))}
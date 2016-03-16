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
short arrayidx, v0, v1, v2, v3, v4, cmp, add, add2, arrayidx1, arrayidx3, v5, v6, v7, arrayidx11, j_023, inc, arrayidx6, v8, v9, v10, tobool, arrayidx8, v11, v12, cmp9, cmp17, v13, exitcond, v14, cmp12, arrayidx21, cmp15, v15, or_cond, or_cond24;
AStart: goto A00;
A00: getelementptr(2, choosing, i, arrayidx); goto A01; 
A01: v0 = memory[arrayidx]; goto A02; 
A02: goto A03; 
A03: v1 = memory[number + 0]; goto A04; 
A04: v2 = memory[v1]; goto A05; 
A05: v3 = memory[number + 1]; goto A06; 
A06: v4 = memory[v3]; goto A07; 
A07: cmp = (v2 < v4); goto A08; 
A08: 
	if 
	::cmp -> goto A09; 
	::!cmp -> goto A14; 
	fi;
A09: add = v4 + 1; goto A10; 
A14: add2 = v2 + 1; goto A15; 
A10: getelementptr(2, number, i, arrayidx1); goto A11; 
A15: getelementptr(2, number, i, arrayidx3); goto A16; 
A11: v5 = memory[arrayidx1]; goto A12; 
A16: v6 = memory[arrayidx3]; goto A17; 
A12: goto A13; 
A17: goto A18; 
A13: goto A19; 
A18: goto A19; 
A19: v7 = memory[arrayidx]; goto A20; 
A20: goto A21; 
A21: getelementptr(2, number, i, arrayidx11); goto A22; 
A22: j_023 = 0; goto A23; 
A23: goto A24; 
A24: getelementptr(2, choosing, j_023, arrayidx6); goto A25; 
A25: v8 = memory[arrayidx6]; goto A26; 
A26: v9 = memory[v8]; goto A27; 
A27: v10 = v9 & 1; goto A28; 
A28: tobool = (v10 == 0); goto A29; 
A29: 
	if 
	::tobool -> goto A31; 
	::!tobool -> goto A30; 
	fi;
A31: getelementptr(2, number, j_023, arrayidx8); goto A32; 
A30: goto A30; 
A32: v11 = memory[arrayidx8]; goto A33; 
A33: v12 = memory[v11]; goto A34; 
A34: cmp9 = (v12 == 0); goto A35; 
A35: cmp17 = (j_023 < i); goto A36; 
A36: 
	if 
	::cmp9 -> goto A44; 
	::!cmp9 -> goto A37; 
	fi;
A44: inc = j_023 + 1; goto A45; 
A37: v13 = memory[arrayidx11]; goto A38; 
A45: exitcond = (inc == 2); goto A46; 
A38: v14 = memory[v13]; goto A39; 
A46: 
	if 
	::exitcond -> goto A47; 
	::!exitcond -> j_023 = inc; goto A23; 
	fi;
A39: cmp12 = (v12 < v14); goto A40; 
A47: getelementptr(2, number, i, arrayidx21); goto A48; 
A40: cmp15 = (v12 == v14); goto A41; 
A48: v15 = memory[arrayidx21]; goto A49; 
A41: or_cond = cmp15 & cmp17; goto A42; 
A49: goto A50; 
A42: or_cond24 = cmp12 | or_cond; goto A43; 
A50: goto AEnd;
A43: 
	if 
	::or_cond24 -> goto A37; 
	::!or_cond24 -> goto A44; 
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
	//initialize global variables or allocate memory space here, if necessary
	alloca(2, choosing);
	alloca(2, number);
	

	run process1();
	run process2();
	}
}

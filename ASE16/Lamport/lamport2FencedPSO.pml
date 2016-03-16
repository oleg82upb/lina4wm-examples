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
A02: goto A03v0; 
A03v0: memory[v0] = 1; goto A03; 
A03: goto A04; 
A04: v1 = memory[number + 0]; goto A05; 
A05: v2 = memory[v1]; goto A06; 
A06: v3 = memory[number + 1]; goto A07; 
A07: v4 = memory[v3]; goto A08; 
A08: cmp = (v2 < v4); goto A09; 
A09: 
	if 
	::cmp -> goto A10; 
	::!cmp -> goto A15; 
	fi;
A10: add = v4 + 1; goto A11; 
A15: add2 = v2 + 1; goto A16; 
A11: getelementptr(2, number, i, arrayidx1); goto A12; 
A16: getelementptr(2, number, i, arrayidx3); goto A17; 
A12: v5 = memory[arrayidx1]; goto A13; 
A17: v6 = memory[arrayidx3]; goto A18; 
A13: goto A14v5; 
A18: goto A19v6; 
A14v5: 
	if 
	:: goto A20v5; 
	:: memory[v5] = add; goto A14; 
	fi;
A19v6: 
	if 
	:: goto A20v6; 
	:: memory[v6] = add2; goto A19; 
	fi;
A20v5: 
	if 
	:: v7 = memory[arrayidx]; goto A21v5; 
	:: memory[v5] = add; goto A20; 
	fi;
A14: goto A20; 
A20v6: 
	if 
	:: v7 = memory[arrayidx]; goto A21v6; 
	:: memory[v6] = add2; goto A20; 
	fi;
A19: goto A20; 
A21v5: 
	if 
	:: goto A22v5v7; 
	:: memory[v5] = add; goto A21; 
	fi;
A20: v7 = memory[arrayidx]; goto A21; 
A21v6: 
	if 
	:: goto A22v6v7; 
	:: memory[v6] = add2; goto A21; 
	fi;
A22v5v7: 
	if 
	:: getelementptr(2, number, i, arrayidx11); goto A23v5v7; 
	:: memory[v5] = add; goto A22v7; 
	:: memory[v7] = 0; goto A22v5; 
	fi;
A21: goto A22v7; 
A22v6v7: 
	if 
	:: getelementptr(2, number, i, arrayidx11); goto A23v6v7; 
	:: memory[v6] = add2; goto A22v7; 
	:: memory[v7] = 0; goto A22v6; 
	fi;
A23v5v7: 
	if 
	:: memory[v5] = add; goto A23v7; 
	:: memory[v7] = 0; goto A23v5; 
	fi;
A22v7: 
	if 
	:: getelementptr(2, number, i, arrayidx11); goto A23v7; 
	:: memory[v7] = 0; goto A22; 
	fi;
A22v5: 
	if 
	:: getelementptr(2, number, i, arrayidx11); goto A23v5; 
	:: memory[v5] = add; goto A22; 
	fi;
A23v6v7: 
	if 
	:: memory[v6] = add2; goto A23v7; 
	:: memory[v7] = 0; goto A23v6; 
	fi;
A22v6: 
	if 
	:: getelementptr(2, number, i, arrayidx11); goto A23v6; 
	:: memory[v6] = add2; goto A22; 
	fi;
A23v7: memory[v7] = 0; goto A23; 
A23v5: memory[v5] = add; goto A23; 
A22: getelementptr(2, number, i, arrayidx11); goto A23; 
A23v6: memory[v6] = add2; goto A23; 
A23: goto A24; 
A24: j_023 = 0; goto A25; 
A25: goto A26; 
A26: getelementptr(2, choosing, j_023, arrayidx6); goto A27; 
A27: v8 = memory[arrayidx6]; goto A28; 
A28: v9 = memory[v8]; goto A29; 
A29: v10 = v9 & 1; goto A30; 
A30: tobool = (v10 == 0); goto A31; 
A31: 
	if 
	::tobool -> goto A33; 
	::!tobool -> goto A32; 
	fi;
A33: getelementptr(2, number, j_023, arrayidx8); goto A34; 
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
A49: getelementptr(2, number, i, arrayidx21); goto A50; 
A42: cmp15 = (v12 == v14); goto A43; 
A50: v15 = memory[arrayidx21]; goto A51; 
A43: or_cond = cmp15 & cmp17; goto A44; 
A51: goto A52v15; 
A44: or_cond24 = cmp12 | or_cond; goto A45; 
A52v15: memory[v15] = 0; goto A52; 
A45: 
	if 
	::or_cond24 -> goto A39; 
	::!or_cond24 -> goto A46; 
	fi;
A52: goto AEnd;
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

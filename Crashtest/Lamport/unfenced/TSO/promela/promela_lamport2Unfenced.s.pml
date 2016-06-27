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
short arrayidx, v0, v1, cmp, v2, v3, add, add2, arrayidx1, arrayidx3, arrayidx11, j_023, inc, arrayidx6, v4, v5, tobool, arrayidx8, cmp17, v6, cmp9, v7, exitcond, v8, cmp12, arrayidx21, v9, 10, cmp15, or_cond;
AStart: goto A000;
A000: getelementptr(2, choosing, 0 + i, arrayidx); goto A001; 
A001: goto A002arrayidx; 
A002arrayidx: 
	if 
	:: v0 = memory[number + 0]; goto A003arrayidx; 
	:: memory[arrayidx] = 1; goto A002; 
	fi;
A003arrayidx: 
	if 
	:: v1 = memory[number + 1]; goto A004arrayidx; 
	:: memory[arrayidx] = 1; goto A003; 
	fi;
A002: v0 = memory[number + 0]; goto A003; 
A004arrayidx: 
	if 
	:: cmp = (v0 < v1); goto A005arrayidx; 
	:: memory[arrayidx] = 1; goto A004; 
	fi;
A003: v1 = memory[number + 1]; goto A004; 
A005arrayidx: 
	if 
	::cmp -> goto A006arrayidx; 
	::!cmp -> goto A011arrayidx; 
	:: memory[arrayidx] = 1; goto A005; 
	fi;
A004: cmp = (v0 < v1); goto A005; 
A006arrayidx: 
	if 
	:: v2 = memory[number + 1]; goto A007arrayidx; 
	:: memory[arrayidx] = 1; goto A006; 
	fi;
A011arrayidx: 
	if 
	:: v3 = memory[number + 0]; goto A012arrayidx; 
	:: memory[arrayidx] = 1; goto A011; 
	fi;
A005: 
	if 
	::cmp -> goto A006; 
	::!cmp -> goto A011; 
	fi;
A007arrayidx: 
	if 
	:: add = v2 + 1; goto A008arrayidx; 
	:: memory[arrayidx] = 1; goto A007; 
	fi;
A006: v2 = memory[number + 1]; goto A007; 
A012arrayidx: 
	if 
	:: add2 = v3 + 1; goto A013arrayidx; 
	:: memory[arrayidx] = 1; goto A012; 
	fi;
A011: v3 = memory[number + 0]; goto A012; 
A008arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx1); goto A009arrayidx; 
	:: memory[arrayidx] = 1; goto A008; 
	fi;
A007: add = v2 + 1; goto A008; 
A013arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx3); goto A014arrayidx; 
	:: memory[arrayidx] = 1; goto A013; 
	fi;
A012: add2 = v3 + 1; goto A013; 
A009arrayidx: 
	if 
	:: goto A010arrayidxarrayidx1; 
	:: memory[arrayidx] = 1; goto A009; 
	fi;
A008: getelementptr(2, number, 0 + i, arrayidx1); goto A009; 
A014arrayidx: 
	if 
	:: goto A015arrayidxarrayidx3; 
	:: memory[arrayidx] = 1; goto A014; 
	fi;
A013: getelementptr(2, number, 0 + i, arrayidx3); goto A014; 
A010arrayidxarrayidx1: 
	if 
	:: goto A016arrayidxarrayidx1; 
	:: memory[arrayidx] = 1; goto A010arrayidx1; 
	fi;
A009: goto A010arrayidx1; 
A015arrayidxarrayidx3: 
	if 
	:: goto A016arrayidxarrayidx3; 
	:: memory[arrayidx] = 1; goto A015arrayidx3; 
	fi;
A014: goto A015arrayidx3; 
A016arrayidxarrayidx1: 
	if 
	:: goto A017arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A016arrayidx1; 
	fi;
A010arrayidx1: 
	if 
	:: goto A016arrayidx1; 
	:: memory[arrayidx1] = add; goto A010; 
	fi;
A016arrayidxarrayidx3: 
	if 
	:: goto A017arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A016arrayidx3; 
	fi;
A015arrayidx3: 
	if 
	:: goto A016arrayidx3; 
	:: memory[arrayidx3] = add2; goto A015; 
	fi;
A017arrayidxarrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A018arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A017arrayidx1arrayidx; 
	fi;
A016arrayidx1: 
	if 
	:: goto A017arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A016; 
	fi;
A010: goto A016; 
A017arrayidxarrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A018arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A017arrayidx3arrayidx; 
	fi;
A016arrayidx3: 
	if 
	:: goto A017arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A016; 
	fi;
A015: goto A016; 
A018arrayidxarrayidx1arrayidx: 
	if 
	:: j_023 = 0; goto A019arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A018arrayidx1arrayidx; 
	fi;
A017arrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A018arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A017arrayidx; 
	fi;
A016: goto A017arrayidx; 
A018arrayidxarrayidx3arrayidx: 
	if 
	:: j_023 = 0; goto A019arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A018arrayidx3arrayidx; 
	fi;
A017arrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A018arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A017arrayidx; 
	fi;
A019arrayidxarrayidx1arrayidx: 
	if 
	:: goto A020arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A019arrayidx1arrayidx; 
	fi;
A018arrayidx1arrayidx: 
	if 
	:: j_023 = 0; goto A019arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A018arrayidx; 
	fi;
A017arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx11); goto A018arrayidx; 
	:: memory[arrayidx] = 0; goto A017; 
	fi;
A019arrayidxarrayidx3arrayidx: 
	if 
	:: goto A020arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A019arrayidx3arrayidx; 
	fi;
A018arrayidx3arrayidx: 
	if 
	:: j_023 = 0; goto A019arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A018arrayidx; 
	fi;
A020arrayidxarrayidx1arrayidx: 
	if 
	:: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A020arrayidx1arrayidx; 
	fi;
A019arrayidx1arrayidx: 
	if 
	:: goto A020arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A019arrayidx; 
	fi;
A018arrayidx: 
	if 
	:: j_023 = 0; goto A019arrayidx; 
	:: memory[arrayidx] = 0; goto A018; 
	fi;
A017: getelementptr(2, number, 0 + i, arrayidx11); goto A018; 
A020arrayidxarrayidx3arrayidx: 
	if 
	:: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A020arrayidx3arrayidx; 
	fi;
A019arrayidx3arrayidx: 
	if 
	:: goto A020arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A019arrayidx; 
	fi;
A021arrayidxarrayidx1arrayidx: 
	if 
	:: goto A022arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A021arrayidx1arrayidx; 
	fi;
A020arrayidx1arrayidx: 
	if 
	:: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A020arrayidx; 
	fi;
A019arrayidx: 
	if 
	:: goto A020arrayidx; 
	:: memory[arrayidx] = 0; goto A019; 
	fi;
A018: j_023 = 0; goto A019; 
A021arrayidxarrayidx3arrayidx: 
	if 
	:: goto A022arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A021arrayidx3arrayidx; 
	fi;
A020arrayidx3arrayidx: 
	if 
	:: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A020arrayidx; 
	fi;
A022arrayidxarrayidx1arrayidx: 
	if 
	:: v4 = memory[arrayidx6]; goto A023arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A022arrayidx1arrayidx; 
	fi;
A021arrayidx1arrayidx: 
	if 
	:: goto A022arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A021arrayidx; 
	fi;
A020arrayidx: 
	if 
	:: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021arrayidx; 
	:: memory[arrayidx] = 0; goto A020; 
	fi;
A019: goto A020; 
A022arrayidxarrayidx3arrayidx: 
	if 
	:: v4 = memory[arrayidx6]; goto A023arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A022arrayidx3arrayidx; 
	fi;
A021arrayidx3arrayidx: 
	if 
	:: goto A022arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A021arrayidx; 
	fi;
A023arrayidxarrayidx1arrayidx: 
	if 
	:: v5 = v4 & 1; goto A024arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A023arrayidx1arrayidx; 
	fi;
A022arrayidx1arrayidx: 
	if 
	:: v4 = memory[arrayidx6]; goto A023arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A022arrayidx; 
	fi;
A021arrayidx: 
	if 
	:: goto A022arrayidx; 
	:: memory[arrayidx] = 0; goto A021; 
	fi;
A020: getelementptr(2, choosing, 0 + j_023, arrayidx6); goto A021; 
A023arrayidxarrayidx3arrayidx: 
	if 
	:: v5 = v4 & 1; goto A024arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A023arrayidx3arrayidx; 
	fi;
A022arrayidx3arrayidx: 
	if 
	:: v4 = memory[arrayidx6]; goto A023arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A022arrayidx; 
	fi;
A024arrayidxarrayidx1arrayidx: 
	if 
	:: tobool = (v5 == 0); goto A025arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A024arrayidx1arrayidx; 
	fi;
A023arrayidx1arrayidx: 
	if 
	:: v5 = v4 & 1; goto A024arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A023arrayidx; 
	fi;
A022arrayidx: 
	if 
	:: v4 = memory[arrayidx6]; goto A023arrayidx; 
	:: memory[arrayidx] = 0; goto A022; 
	fi;
A021: goto A022; 
A024arrayidxarrayidx3arrayidx: 
	if 
	:: tobool = (v5 == 0); goto A025arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A024arrayidx3arrayidx; 
	fi;
A023arrayidx3arrayidx: 
	if 
	:: v5 = v4 & 1; goto A024arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A023arrayidx; 
	fi;
A025arrayidxarrayidx1arrayidx: 
	if 
	::tobool -> goto A026arrayidxarrayidx1arrayidx; 
	::!tobool -> goto A022arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A025arrayidx1arrayidx; 
	fi;
A024arrayidx1arrayidx: 
	if 
	:: tobool = (v5 == 0); goto A025arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A024arrayidx; 
	fi;
A023arrayidx: 
	if 
	:: v5 = v4 & 1; goto A024arrayidx; 
	:: memory[arrayidx] = 0; goto A023; 
	fi;
A022: v4 = memory[arrayidx6]; goto A023; 
A025arrayidxarrayidx3arrayidx: 
	if 
	::tobool -> goto A026arrayidxarrayidx3arrayidx; 
	::!tobool -> goto A022arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A025arrayidx3arrayidx; 
	fi;
A024arrayidx3arrayidx: 
	if 
	:: tobool = (v5 == 0); goto A025arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A024arrayidx; 
	fi;
A026arrayidxarrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A026arrayidx1arrayidx; 
	fi;
A025arrayidx1arrayidx: 
	if 
	::tobool -> goto A026arrayidx1arrayidx; 
	::!tobool -> goto A022arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A025arrayidx; 
	fi;
A024arrayidx: 
	if 
	:: tobool = (v5 == 0); goto A025arrayidx; 
	:: memory[arrayidx] = 0; goto A024; 
	fi;
A023: v5 = v4 & 1; goto A024; 
A026arrayidxarrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A026arrayidx3arrayidx; 
	fi;
A025arrayidx3arrayidx: 
	if 
	::tobool -> goto A026arrayidx3arrayidx; 
	::!tobool -> goto A022arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A025arrayidx; 
	fi;
A027arrayidxarrayidx1arrayidx: 
	if 
	:: cmp17 = (j_023 < i); goto A028arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A027arrayidx1arrayidx; 
	fi;
A026arrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A026arrayidx; 
	fi;
A025arrayidx: 
	if 
	::tobool -> goto A026arrayidx; 
	::!tobool -> goto A022arrayidx; 
	:: memory[arrayidx] = 0; goto A025; 
	fi;
A024: tobool = (v5 == 0); goto A025; 
A027arrayidxarrayidx3arrayidx: 
	if 
	:: cmp17 = (j_023 < i); goto A028arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A027arrayidx3arrayidx; 
	fi;
A026arrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A026arrayidx; 
	fi;
A028arrayidxarrayidx1arrayidx: 
	if 
	:: goto A029arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A028arrayidx1arrayidx; 
	fi;
A027arrayidx1arrayidx: 
	if 
	:: cmp17 = (j_023 < i); goto A028arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A027arrayidx; 
	fi;
A026arrayidx: 
	if 
	:: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027arrayidx; 
	:: memory[arrayidx] = 0; goto A026; 
	fi;
A025: 
	if 
	::tobool -> goto A026; 
	::!tobool -> goto A022; 
	fi;
A028arrayidxarrayidx3arrayidx: 
	if 
	:: goto A029arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A028arrayidx3arrayidx; 
	fi;
A027arrayidx3arrayidx: 
	if 
	:: cmp17 = (j_023 < i); goto A028arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A027arrayidx; 
	fi;
A029arrayidxarrayidx1arrayidx: 
	if 
	:: v6 = memory[arrayidx8]; goto A030arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A029arrayidx1arrayidx; 
	fi;
A028arrayidx1arrayidx: 
	if 
	:: goto A029arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A028arrayidx; 
	fi;
A027arrayidx: 
	if 
	:: cmp17 = (j_023 < i); goto A028arrayidx; 
	:: memory[arrayidx] = 0; goto A027; 
	fi;
A026: getelementptr(2, number, 0 + j_023, arrayidx8); goto A027; 
A029arrayidxarrayidx3arrayidx: 
	if 
	:: v6 = memory[arrayidx8]; goto A030arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A029arrayidx3arrayidx; 
	fi;
A028arrayidx3arrayidx: 
	if 
	:: goto A029arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A028arrayidx; 
	fi;
A030arrayidxarrayidx1arrayidx: 
	if 
	:: cmp9 = (v6 == 0); goto A031arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A030arrayidx1arrayidx; 
	fi;
A029arrayidx1arrayidx: 
	if 
	:: v6 = memory[arrayidx8]; goto A030arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A029arrayidx; 
	fi;
A028arrayidx: 
	if 
	:: goto A029arrayidx; 
	:: memory[arrayidx] = 0; goto A028; 
	fi;
A027: cmp17 = (j_023 < i); goto A028; 
A030arrayidxarrayidx3arrayidx: 
	if 
	:: cmp9 = (v6 == 0); goto A031arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A030arrayidx3arrayidx; 
	fi;
A029arrayidx3arrayidx: 
	if 
	:: v6 = memory[arrayidx8]; goto A030arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A029arrayidx; 
	fi;
A031arrayidxarrayidx1arrayidx: 
	if 
	::cmp9 -> goto A041arrayidxarrayidx1arrayidx; 
	::!cmp9 -> goto A032arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A031arrayidx1arrayidx; 
	fi;
A030arrayidx1arrayidx: 
	if 
	:: cmp9 = (v6 == 0); goto A031arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A030arrayidx; 
	fi;
A029arrayidx: 
	if 
	:: v6 = memory[arrayidx8]; goto A030arrayidx; 
	:: memory[arrayidx] = 0; goto A029; 
	fi;
A028: goto A029; 
A031arrayidxarrayidx3arrayidx: 
	if 
	::cmp9 -> goto A041arrayidxarrayidx3arrayidx; 
	::!cmp9 -> goto A032arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A031arrayidx3arrayidx; 
	fi;
A030arrayidx3arrayidx: 
	if 
	:: cmp9 = (v6 == 0); goto A031arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A030arrayidx; 
	fi;
A041arrayidxarrayidx1arrayidx: 
	if 
	:: inc = j_023 + 1; goto A042arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A041arrayidx1arrayidx; 
	fi;
A032arrayidxarrayidx1arrayidx: 
	if 
	:: v7 = memory[arrayidx8]; goto A033arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A032arrayidx1arrayidx; 
	fi;
A031arrayidx1arrayidx: 
	if 
	::cmp9 -> goto A041arrayidx1arrayidx; 
	::!cmp9 -> goto A032arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A031arrayidx; 
	fi;
A030arrayidx: 
	if 
	:: cmp9 = (v6 == 0); goto A031arrayidx; 
	:: memory[arrayidx] = 0; goto A030; 
	fi;
A029: v6 = memory[arrayidx8]; goto A030; 
A041arrayidxarrayidx3arrayidx: 
	if 
	:: inc = j_023 + 1; goto A042arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A041arrayidx3arrayidx; 
	fi;
A032arrayidxarrayidx3arrayidx: 
	if 
	:: v7 = memory[arrayidx8]; goto A033arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A032arrayidx3arrayidx; 
	fi;
A031arrayidx3arrayidx: 
	if 
	::cmp9 -> goto A041arrayidx3arrayidx; 
	::!cmp9 -> goto A032arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A031arrayidx; 
	fi;
A042arrayidxarrayidx1arrayidx: 
	if 
	:: exitcond = (inc == 2); goto A043arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A042arrayidx1arrayidx; 
	fi;
A041arrayidx1arrayidx: 
	if 
	:: inc = j_023 + 1; goto A042arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A041arrayidx; 
	fi;
A033arrayidxarrayidx1arrayidx: 
	if 
	:: v8 = memory[arrayidx11]; goto A034arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A033arrayidx1arrayidx; 
	fi;
A032arrayidx1arrayidx: 
	if 
	:: v7 = memory[arrayidx8]; goto A033arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A032arrayidx; 
	fi;
A031arrayidx: 
	if 
	::cmp9 -> goto A041arrayidx; 
	::!cmp9 -> goto A032arrayidx; 
	:: memory[arrayidx] = 0; goto A031; 
	fi;
A030: cmp9 = (v6 == 0); goto A031; 
A042arrayidxarrayidx3arrayidx: 
	if 
	:: exitcond = (inc == 2); goto A043arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A042arrayidx3arrayidx; 
	fi;
A041arrayidx3arrayidx: 
	if 
	:: inc = j_023 + 1; goto A042arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A041arrayidx; 
	fi;
A033arrayidxarrayidx3arrayidx: 
	if 
	:: v8 = memory[arrayidx11]; goto A034arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A033arrayidx3arrayidx; 
	fi;
A032arrayidx3arrayidx: 
	if 
	:: v7 = memory[arrayidx8]; goto A033arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A032arrayidx; 
	fi;
A043arrayidxarrayidx1arrayidx: 
	if 
	::exitcond -> goto A044arrayidxarrayidx1arrayidx; 
	::!exitcond -> j_023 = inc; goto A019arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A043arrayidx1arrayidx; 
	fi;
A042arrayidx1arrayidx: 
	if 
	:: exitcond = (inc == 2); goto A043arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A042arrayidx; 
	fi;
A041arrayidx: 
	if 
	:: inc = j_023 + 1; goto A042arrayidx; 
	:: memory[arrayidx] = 0; goto A041; 
	fi;
A034arrayidxarrayidx1arrayidx: 
	if 
	:: cmp12 = (v7 < v8); goto A035arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A034arrayidx1arrayidx; 
	fi;
A033arrayidx1arrayidx: 
	if 
	:: v8 = memory[arrayidx11]; goto A034arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A033arrayidx; 
	fi;
A032arrayidx: 
	if 
	:: v7 = memory[arrayidx8]; goto A033arrayidx; 
	:: memory[arrayidx] = 0; goto A032; 
	fi;
A031: 
	if 
	::cmp9 -> goto A041; 
	::!cmp9 -> goto A032; 
	fi;
A043arrayidxarrayidx3arrayidx: 
	if 
	::exitcond -> goto A044arrayidxarrayidx3arrayidx; 
	::!exitcond -> j_023 = inc; goto A019arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A043arrayidx3arrayidx; 
	fi;
A042arrayidx3arrayidx: 
	if 
	:: exitcond = (inc == 2); goto A043arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A042arrayidx; 
	fi;
A034arrayidxarrayidx3arrayidx: 
	if 
	:: cmp12 = (v7 < v8); goto A035arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A034arrayidx3arrayidx; 
	fi;
A033arrayidx3arrayidx: 
	if 
	:: v8 = memory[arrayidx11]; goto A034arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A033arrayidx; 
	fi;
A044arrayidxarrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx21); goto A045arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A044arrayidx1arrayidx; 
	fi;
A043arrayidx1arrayidx: 
	if 
	::exitcond -> goto A044arrayidx1arrayidx; 
	::!exitcond -> j_023 = inc; goto A019arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A043arrayidx; 
	fi;
A042arrayidx: 
	if 
	:: exitcond = (inc == 2); goto A043arrayidx; 
	:: memory[arrayidx] = 0; goto A042; 
	fi;
A041: inc = j_023 + 1; goto A042; 
A035arrayidxarrayidx1arrayidx: 
	if 
	::cmp12 -> goto A029arrayidxarrayidx1arrayidx; 
	::!cmp12 -> goto A036arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A035arrayidx1arrayidx; 
	fi;
A034arrayidx1arrayidx: 
	if 
	:: cmp12 = (v7 < v8); goto A035arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A034arrayidx; 
	fi;
A033arrayidx: 
	if 
	:: v8 = memory[arrayidx11]; goto A034arrayidx; 
	:: memory[arrayidx] = 0; goto A033; 
	fi;
A032: v7 = memory[arrayidx8]; goto A033; 
A044arrayidxarrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx21); goto A045arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A044arrayidx3arrayidx; 
	fi;
A043arrayidx3arrayidx: 
	if 
	::exitcond -> goto A044arrayidx3arrayidx; 
	::!exitcond -> j_023 = inc; goto A019arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A043arrayidx; 
	fi;
A035arrayidxarrayidx3arrayidx: 
	if 
	::cmp12 -> goto A029arrayidxarrayidx3arrayidx; 
	::!cmp12 -> goto A036arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A035arrayidx3arrayidx; 
	fi;
A034arrayidx3arrayidx: 
	if 
	:: cmp12 = (v7 < v8); goto A035arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A034arrayidx; 
	fi;
A045arrayidxarrayidx1arrayidx: 
	if 
	:: goto A046arrayidxarrayidx1arrayidxarrayidx21; 
	:: memory[arrayidx] = 1; goto A045arrayidx1arrayidx; 
	fi;
A044arrayidx1arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx21); goto A045arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A044arrayidx; 
	fi;
A043arrayidx: 
	if 
	::exitcond -> goto A044arrayidx; 
	::!exitcond -> j_023 = inc; goto A019arrayidx; 
	:: memory[arrayidx] = 0; goto A043; 
	fi;
A042: exitcond = (inc == 2); goto A043; 
A036arrayidxarrayidx1arrayidx: 
	if 
	:: v9 = memory[arrayidx8]; goto A037arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A036arrayidx1arrayidx; 
	fi;
A035arrayidx1arrayidx: 
	if 
	::cmp12 -> goto A029arrayidx1arrayidx; 
	::!cmp12 -> goto A036arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A035arrayidx; 
	fi;
A034arrayidx: 
	if 
	:: cmp12 = (v7 < v8); goto A035arrayidx; 
	:: memory[arrayidx] = 0; goto A034; 
	fi;
A033: v8 = memory[arrayidx11]; goto A034; 
A045arrayidxarrayidx3arrayidx: 
	if 
	:: goto A046arrayidxarrayidx3arrayidxarrayidx21; 
	:: memory[arrayidx] = 1; goto A045arrayidx3arrayidx; 
	fi;
A044arrayidx3arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx21); goto A045arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A044arrayidx; 
	fi;
A036arrayidxarrayidx3arrayidx: 
	if 
	:: v9 = memory[arrayidx8]; goto A037arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A036arrayidx3arrayidx; 
	fi;
A035arrayidx3arrayidx: 
	if 
	::cmp12 -> goto A029arrayidx3arrayidx; 
	::!cmp12 -> goto A036arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A035arrayidx; 
	fi;
A046arrayidxarrayidx1arrayidxarrayidx21: memory[arrayidx] = 1; goto A046arrayidx1arrayidxarrayidx21; 
A045arrayidx1arrayidx: 
	if 
	:: goto A046arrayidx1arrayidxarrayidx21; 
	:: memory[arrayidx1] = add; goto A045arrayidx; 
	fi;
A044arrayidx: 
	if 
	:: getelementptr(2, number, 0 + i, arrayidx21); goto A045arrayidx; 
	:: memory[arrayidx] = 0; goto A044; 
	fi;
A043: 
	if 
	::exitcond -> goto A044; 
	::!exitcond -> j_023 = inc; goto A019; 
	fi;
A037arrayidxarrayidx1arrayidx: 
	if 
	:: 10 = memory[arrayidx11]; goto A038arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A037arrayidx1arrayidx; 
	fi;
A036arrayidx1arrayidx: 
	if 
	:: v9 = memory[arrayidx8]; goto A037arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A036arrayidx; 
	fi;
A035arrayidx: 
	if 
	::cmp12 -> goto A029arrayidx; 
	::!cmp12 -> goto A036arrayidx; 
	:: memory[arrayidx] = 0; goto A035; 
	fi;
A034: cmp12 = (v7 < v8); goto A035; 
A046arrayidxarrayidx3arrayidxarrayidx21: memory[arrayidx] = 1; goto A046arrayidx3arrayidxarrayidx21; 
A045arrayidx3arrayidx: 
	if 
	:: goto A046arrayidx3arrayidxarrayidx21; 
	:: memory[arrayidx3] = add2; goto A045arrayidx; 
	fi;
A037arrayidxarrayidx3arrayidx: 
	if 
	:: 10 = memory[arrayidx11]; goto A038arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A037arrayidx3arrayidx; 
	fi;
A036arrayidx3arrayidx: 
	if 
	:: v9 = memory[arrayidx8]; goto A037arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A036arrayidx; 
	fi;
A046arrayidx1arrayidxarrayidx21: memory[arrayidx1] = add; goto A046arrayidxarrayidx21; 
A045arrayidx: 
	if 
	:: goto A046arrayidxarrayidx21; 
	:: memory[arrayidx] = 0; goto A045; 
	fi;
A044: getelementptr(2, number, 0 + i, arrayidx21); goto A045; 
A038arrayidxarrayidx1arrayidx: 
	if 
	:: cmp15 = (v9 == 10); goto A039arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A038arrayidx1arrayidx; 
	fi;
A037arrayidx1arrayidx: 
	if 
	:: 10 = memory[arrayidx11]; goto A038arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A037arrayidx; 
	fi;
A036arrayidx: 
	if 
	:: v9 = memory[arrayidx8]; goto A037arrayidx; 
	:: memory[arrayidx] = 0; goto A036; 
	fi;
A035: 
	if 
	::cmp12 -> goto A029; 
	::!cmp12 -> goto A036; 
	fi;
A046arrayidx3arrayidxarrayidx21: memory[arrayidx3] = add2; goto A046arrayidxarrayidx21; 
A038arrayidxarrayidx3arrayidx: 
	if 
	:: cmp15 = (v9 == 10); goto A039arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A038arrayidx3arrayidx; 
	fi;
A037arrayidx3arrayidx: 
	if 
	:: 10 = memory[arrayidx11]; goto A038arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A037arrayidx; 
	fi;
A046arrayidxarrayidx21: memory[arrayidx] = 0; goto A046arrayidx21; 
A045: goto A046arrayidx21; 
A039arrayidxarrayidx1arrayidx: 
	if 
	:: or_cond = cmp15 & cmp17; goto A040arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A039arrayidx1arrayidx; 
	fi;
A038arrayidx1arrayidx: 
	if 
	:: cmp15 = (v9 == 10); goto A039arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A038arrayidx; 
	fi;
A037arrayidx: 
	if 
	:: 10 = memory[arrayidx11]; goto A038arrayidx; 
	:: memory[arrayidx] = 0; goto A037; 
	fi;
A036: v9 = memory[arrayidx8]; goto A037; 
A039arrayidxarrayidx3arrayidx: 
	if 
	:: or_cond = cmp15 & cmp17; goto A040arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A039arrayidx3arrayidx; 
	fi;
A038arrayidx3arrayidx: 
	if 
	:: cmp15 = (v9 == 10); goto A039arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A038arrayidx; 
	fi;
A046arrayidx21: memory[arrayidx21] = 0; goto A046; 
A040arrayidxarrayidx1arrayidx: 
	if 
	::or_cond -> goto A029arrayidxarrayidx1arrayidx; 
	::!or_cond -> goto A041arrayidxarrayidx1arrayidx; 
	:: memory[arrayidx] = 1; goto A040arrayidx1arrayidx; 
	fi;
A039arrayidx1arrayidx: 
	if 
	:: or_cond = cmp15 & cmp17; goto A040arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A039arrayidx; 
	fi;
A038arrayidx: 
	if 
	:: cmp15 = (v9 == 10); goto A039arrayidx; 
	:: memory[arrayidx] = 0; goto A038; 
	fi;
A037: 10 = memory[arrayidx11]; goto A038; 
A040arrayidxarrayidx3arrayidx: 
	if 
	::or_cond -> goto A029arrayidxarrayidx3arrayidx; 
	::!or_cond -> goto A041arrayidxarrayidx3arrayidx; 
	:: memory[arrayidx] = 1; goto A040arrayidx3arrayidx; 
	fi;
A039arrayidx3arrayidx: 
	if 
	:: or_cond = cmp15 & cmp17; goto A040arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A039arrayidx; 
	fi;
A046: goto AEnd;
A040arrayidx1arrayidx: 
	if 
	::or_cond -> goto A029arrayidx1arrayidx; 
	::!or_cond -> goto A041arrayidx1arrayidx; 
	:: memory[arrayidx1] = add; goto A040arrayidx; 
	fi;
A039arrayidx: 
	if 
	:: or_cond = cmp15 & cmp17; goto A040arrayidx; 
	:: memory[arrayidx] = 0; goto A039; 
	fi;
A038: cmp15 = (v9 == 10); goto A039; 
A040arrayidx3arrayidx: 
	if 
	::or_cond -> goto A029arrayidx3arrayidx; 
	::!or_cond -> goto A041arrayidx3arrayidx; 
	:: memory[arrayidx3] = add2; goto A040arrayidx; 
	fi;
A040arrayidx: 
	if 
	::or_cond -> goto A029arrayidx; 
	::!or_cond -> goto A041arrayidx; 
	:: memory[arrayidx] = 0; goto A040; 
	fi;
A039: or_cond = cmp15 & cmp17; goto A040; 
A040: 
	if 
	::or_cond -> goto A029; 
	::!or_cond -> goto A041; 
	fi;
AEnd: skip;

}


inline main(returnvalue){

BStart: goto B0;
B0: returnvalue = 0; goto BEnd;
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
	alloca(2, choosing);
	alloca(2, number);
	

	run process1();
	run process2();
	}
}

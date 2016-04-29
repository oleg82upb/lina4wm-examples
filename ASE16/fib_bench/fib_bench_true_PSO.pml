#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short i = 1;
short j = 1;
short str = 0; //Array: please, check initialization in the init process
short str1 = 0; //Array: please, check initialization in the init process
short _PRETTY_FUNCTION___main = 0; //Array: please, check initialization in the init process


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}



inline t1(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
AStart: goto A000;
A000: v0 = memory[j]; goto A001; 
A001: v1 = memory[i]; goto A002; 
A002: add = v1 + v0; goto A003; 
A003: goto A004i; 
A004i: 
	if 
	:: v2 = memory[j]; goto A005i; 
	:: memory[i] = add; goto A004; 
	fi;
A005i: 
	if 
	:: v3 = memory[i]; goto A006i; 
	:: memory[i] = add; goto A005; 
	fi;
A004: v2 = memory[j]; goto A005; 
A006i: 
	if 
	:: add_1 = v3 + v2; goto A007i; 
	:: memory[i] = add; goto A006; 
	fi;
A005: v3 = memory[i]; goto A006; 
A007i: 
	if 
	:: goto A008ii; 
	:: memory[i] = add; goto A007; 
	fi;
A006: add_1 = v3 + v2; goto A007; 
A008ii: 
	if 
	:: v4 = memory[j]; goto A009ii; 
	:: memory[i] = add; goto A008i; 
	:: memory[i] = add_1; goto A008iadd; 
	fi;
A007: goto A008i; 
A009ii: 
	if 
	:: v5 = memory[i]; goto A010ii; 
	:: memory[i] = add; goto A009i; 
	:: memory[i] = add_1; goto A009iadd; 
	fi;
A008i: 
	if 
	:: v4 = memory[j]; goto A009i; 
	:: memory[i] = add_1; goto A008; 
	fi;
A008iadd: 
	if 
	:: v4 = memory[j]; goto A009iadd; 
	:: memory[i] = add; goto A008; 
	fi;
A010ii: 
	if 
	:: add_2 = v5 + v4; goto A011ii; 
	:: memory[i] = add; goto A010i; 
	:: memory[i] = add_1; goto A010iadd; 
	fi;
A009i: 
	if 
	:: v5 = memory[i]; goto A010i; 
	:: memory[i] = add_1; goto A009; 
	fi;
A009iadd: 
	if 
	:: v5 = memory[i]; goto A010iadd; 
	:: memory[i] = add; goto A009; 
	fi;
A008: v4 = memory[j]; goto A009; 
A011ii: 
	if 
	:: goto A012iii; 
	:: memory[i] = add; goto A011i; 
	:: memory[i] = add_1; goto A011iadd; 
	fi;
A010i: 
	if 
	:: add_2 = v5 + v4; goto A011i; 
	:: memory[i] = add_1; goto A010; 
	fi;
A010iadd: 
	if 
	:: add_2 = v5 + v4; goto A011iadd; 
	:: memory[i] = add; goto A010; 
	fi;
A009: v5 = memory[i]; goto A010; 
A012iii: 
	if 
	:: v6 = memory[j]; goto A013iii; 
	:: memory[i] = add; goto A012ii; 
	:: memory[i] = add_1; goto A012iaddiadd_2; 
	:: memory[i] = add_2; goto A012iaddiadd_1; 
	fi;
A011i: 
	if 
	:: goto A012ii; 
	:: memory[i] = add_1; goto A011; 
	fi;
A011iadd: 
	if 
	:: goto A012iaddiadd_2; 
	:: memory[i] = add; goto A011; 
	fi;
A010: add_2 = v5 + v4; goto A011; 
A013iii: 
	if 
	:: v7 = memory[i]; goto A014iii; 
	:: memory[i] = add; goto A013ii; 
	:: memory[i] = add_1; goto A013iaddiadd_2; 
	:: memory[i] = add_2; goto A013iaddiadd_1; 
	fi;
A012ii: 
	if 
	:: v6 = memory[j]; goto A013ii; 
	:: memory[i] = add_1; goto A012i; 
	:: memory[i] = add_2; goto A012iadd_1; 
	fi;
A012iaddiadd_2: 
	if 
	:: v6 = memory[j]; goto A013iaddiadd_2; 
	:: memory[i] = add; goto A012i; 
	:: memory[i] = add_2; goto A012iadd; 
	fi;
A012iaddiadd_1: 
	if 
	:: v6 = memory[j]; goto A013iaddiadd_1; 
	:: memory[i] = add; goto A012iadd_1; 
	:: memory[i] = add_1; goto A012iadd; 
	fi;
A011: goto A012i; 
A014iii: 
	if 
	:: add_3 = v7 + v6; goto A015iii; 
	:: memory[i] = add; goto A014ii; 
	:: memory[i] = add_1; goto A014iaddiadd_2; 
	:: memory[i] = add_2; goto A014iaddiadd_1; 
	fi;
A013ii: 
	if 
	:: v7 = memory[i]; goto A014ii; 
	:: memory[i] = add_1; goto A013i; 
	:: memory[i] = add_2; goto A013iadd_1; 
	fi;
A013iaddiadd_2: 
	if 
	:: v7 = memory[i]; goto A014iaddiadd_2; 
	:: memory[i] = add; goto A013i; 
	:: memory[i] = add_2; goto A013iadd; 
	fi;
A013iaddiadd_1: 
	if 
	:: v7 = memory[i]; goto A014iaddiadd_1; 
	:: memory[i] = add; goto A013iadd_1; 
	:: memory[i] = add_1; goto A013iadd; 
	fi;
A012i: 
	if 
	:: v6 = memory[j]; goto A013i; 
	:: memory[i] = add_2; goto A012; 
	fi;
A012iadd_1: 
	if 
	:: v6 = memory[j]; goto A013iadd_1; 
	:: memory[i] = add_1; goto A012; 
	fi;
A012iadd: 
	if 
	:: v6 = memory[j]; goto A013iadd; 
	:: memory[i] = add; goto A012; 
	fi;
A015iii: 
	if 
	:: goto A016iiii; 
	:: memory[i] = add; goto A015ii; 
	:: memory[i] = add_1; goto A015iaddiadd_2; 
	:: memory[i] = add_2; goto A015iaddiadd_1; 
	fi;
A014ii: 
	if 
	:: add_3 = v7 + v6; goto A015ii; 
	:: memory[i] = add_1; goto A014i; 
	:: memory[i] = add_2; goto A014iadd_1; 
	fi;
A014iaddiadd_2: 
	if 
	:: add_3 = v7 + v6; goto A015iaddiadd_2; 
	:: memory[i] = add; goto A014i; 
	:: memory[i] = add_2; goto A014iadd; 
	fi;
A014iaddiadd_1: 
	if 
	:: add_3 = v7 + v6; goto A015iaddiadd_1; 
	:: memory[i] = add; goto A014iadd_1; 
	:: memory[i] = add_1; goto A014iadd; 
	fi;
A013i: 
	if 
	:: v7 = memory[i]; goto A014i; 
	:: memory[i] = add_2; goto A013; 
	fi;
A013iadd_1: 
	if 
	:: v7 = memory[i]; goto A014iadd_1; 
	:: memory[i] = add_1; goto A013; 
	fi;
A013iadd: 
	if 
	:: v7 = memory[i]; goto A014iadd; 
	:: memory[i] = add; goto A013; 
	fi;
A012: v6 = memory[j]; goto A013; 
A016iiii: 
	if 
	:: v8 = memory[j]; goto A017iiii; 
	:: memory[i] = add; goto A016iii; 
	:: memory[i] = add_1; goto A016iaddiadd_2iadd_3; 
	:: memory[i] = add_2; goto A016iaddiadd_1iadd_3; 
	:: memory[i] = add_3; goto A016iaddiadd_1iadd_2; 
	fi;
A015ii: 
	if 
	:: goto A016iii; 
	:: memory[i] = add_1; goto A015i; 
	:: memory[i] = add_2; goto A015iadd_1; 
	fi;
A015iaddiadd_2: 
	if 
	:: goto A016iaddiadd_2iadd_3; 
	:: memory[i] = add; goto A015i; 
	:: memory[i] = add_2; goto A015iadd; 
	fi;
A015iaddiadd_1: 
	if 
	:: goto A016iaddiadd_1iadd_3; 
	:: memory[i] = add; goto A015iadd_1; 
	:: memory[i] = add_1; goto A015iadd; 
	fi;
A014i: 
	if 
	:: add_3 = v7 + v6; goto A015i; 
	:: memory[i] = add_2; goto A014; 
	fi;
A014iadd_1: 
	if 
	:: add_3 = v7 + v6; goto A015iadd_1; 
	:: memory[i] = add_1; goto A014; 
	fi;
A014iadd: 
	if 
	:: add_3 = v7 + v6; goto A015iadd; 
	:: memory[i] = add; goto A014; 
	fi;
A013: v7 = memory[i]; goto A014; 
A017iiii: 
	if 
	:: v9 = memory[i]; goto A018iiii; 
	:: memory[i] = add; goto A017iii; 
	:: memory[i] = add_1; goto A017iaddiadd_2iadd_3; 
	:: memory[i] = add_2; goto A017iaddiadd_1iadd_3; 
	:: memory[i] = add_3; goto A017iaddiadd_1iadd_2; 
	fi;
A016iii: 
	if 
	:: v8 = memory[j]; goto A017iii; 
	:: memory[i] = add_1; goto A016ii; 
	:: memory[i] = add_2; goto A016iadd_1iadd_3; 
	:: memory[i] = add_3; goto A016iadd_1iadd_2; 
	fi;
A016iaddiadd_2iadd_3: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_2iadd_3; 
	:: memory[i] = add; goto A016ii; 
	:: memory[i] = add_2; goto A016iaddiadd_3; 
	:: memory[i] = add_3; goto A016iaddiadd_2; 
	fi;
A016iaddiadd_1iadd_3: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_1iadd_3; 
	:: memory[i] = add; goto A016iadd_1iadd_3; 
	:: memory[i] = add_1; goto A016iaddiadd_3; 
	:: memory[i] = add_3; goto A016iaddiadd_1; 
	fi;
A016iaddiadd_1iadd_2: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_1iadd_2; 
	:: memory[i] = add; goto A016iadd_1iadd_2; 
	:: memory[i] = add_1; goto A016iaddiadd_2; 
	:: memory[i] = add_2; goto A016iaddiadd_1; 
	fi;
A015i: 
	if 
	:: goto A016ii; 
	:: memory[i] = add_2; goto A015; 
	fi;
A015iadd_1: 
	if 
	:: goto A016iadd_1iadd_3; 
	:: memory[i] = add_1; goto A015; 
	fi;
A015iadd: 
	if 
	:: goto A016iaddiadd_3; 
	:: memory[i] = add; goto A015; 
	fi;
A014: add_3 = v7 + v6; goto A015; 
A018iiii: 
	if 
	:: add_4 = v9 + v8; goto A019iiii; 
	:: memory[i] = add; goto A018iii; 
	:: memory[i] = add_1; goto A018iaddiadd_2iadd_3; 
	:: memory[i] = add_2; goto A018iaddiadd_1iadd_3; 
	:: memory[i] = add_3; goto A018iaddiadd_1iadd_2; 
	fi;
A017iii: 
	if 
	:: v9 = memory[i]; goto A018iii; 
	:: memory[i] = add_1; goto A017ii; 
	:: memory[i] = add_2; goto A017iadd_1iadd_3; 
	:: memory[i] = add_3; goto A017iadd_1iadd_2; 
	fi;
A017iaddiadd_2iadd_3: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_2iadd_3; 
	:: memory[i] = add; goto A017ii; 
	:: memory[i] = add_2; goto A017iaddiadd_3; 
	:: memory[i] = add_3; goto A017iaddiadd_2; 
	fi;
A017iaddiadd_1iadd_3: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_1iadd_3; 
	:: memory[i] = add; goto A017iadd_1iadd_3; 
	:: memory[i] = add_1; goto A017iaddiadd_3; 
	:: memory[i] = add_3; goto A017iaddiadd_1; 
	fi;
A017iaddiadd_1iadd_2: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_1iadd_2; 
	:: memory[i] = add; goto A017iadd_1iadd_2; 
	:: memory[i] = add_1; goto A017iaddiadd_2; 
	:: memory[i] = add_2; goto A017iaddiadd_1; 
	fi;
A016ii: 
	if 
	:: v8 = memory[j]; goto A017ii; 
	:: memory[i] = add_2; goto A016i; 
	:: memory[i] = add_3; goto A016iadd_2; 
	fi;
A016iadd_1iadd_3: 
	if 
	:: v8 = memory[j]; goto A017iadd_1iadd_3; 
	:: memory[i] = add_1; goto A016i; 
	:: memory[i] = add_3; goto A016iadd_1; 
	fi;
A016iadd_1iadd_2: 
	if 
	:: v8 = memory[j]; goto A017iadd_1iadd_2; 
	:: memory[i] = add_1; goto A016iadd_2; 
	:: memory[i] = add_2; goto A016iadd_1; 
	fi;
A016iaddiadd_3: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_3; 
	:: memory[i] = add; goto A016i; 
	:: memory[i] = add_3; goto A016iadd; 
	fi;
A016iaddiadd_2: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_2; 
	:: memory[i] = add; goto A016iadd_2; 
	:: memory[i] = add_2; goto A016iadd; 
	fi;
A016iaddiadd_1: 
	if 
	:: v8 = memory[j]; goto A017iaddiadd_1; 
	:: memory[i] = add; goto A016iadd_1; 
	:: memory[i] = add_1; goto A016iadd; 
	fi;
A015: goto A016i; 
A019iiii: 
	if 
	:: goto A020iiiii; 
	:: memory[i] = add; goto A019iii; 
	:: memory[i] = add_1; goto A019iaddiadd_2iadd_3; 
	:: memory[i] = add_2; goto A019iaddiadd_1iadd_3; 
	:: memory[i] = add_3; goto A019iaddiadd_1iadd_2; 
	fi;
A018iii: 
	if 
	:: add_4 = v9 + v8; goto A019iii; 
	:: memory[i] = add_1; goto A018ii; 
	:: memory[i] = add_2; goto A018iadd_1iadd_3; 
	:: memory[i] = add_3; goto A018iadd_1iadd_2; 
	fi;
A018iaddiadd_2iadd_3: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_2iadd_3; 
	:: memory[i] = add; goto A018ii; 
	:: memory[i] = add_2; goto A018iaddiadd_3; 
	:: memory[i] = add_3; goto A018iaddiadd_2; 
	fi;
A018iaddiadd_1iadd_3: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_1iadd_3; 
	:: memory[i] = add; goto A018iadd_1iadd_3; 
	:: memory[i] = add_1; goto A018iaddiadd_3; 
	:: memory[i] = add_3; goto A018iaddiadd_1; 
	fi;
A018iaddiadd_1iadd_2: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_1iadd_2; 
	:: memory[i] = add; goto A018iadd_1iadd_2; 
	:: memory[i] = add_1; goto A018iaddiadd_2; 
	:: memory[i] = add_2; goto A018iaddiadd_1; 
	fi;
A017ii: 
	if 
	:: v9 = memory[i]; goto A018ii; 
	:: memory[i] = add_2; goto A017i; 
	:: memory[i] = add_3; goto A017iadd_2; 
	fi;
A017iadd_1iadd_3: 
	if 
	:: v9 = memory[i]; goto A018iadd_1iadd_3; 
	:: memory[i] = add_1; goto A017i; 
	:: memory[i] = add_3; goto A017iadd_1; 
	fi;
A017iadd_1iadd_2: 
	if 
	:: v9 = memory[i]; goto A018iadd_1iadd_2; 
	:: memory[i] = add_1; goto A017iadd_2; 
	:: memory[i] = add_2; goto A017iadd_1; 
	fi;
A017iaddiadd_3: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_3; 
	:: memory[i] = add; goto A017i; 
	:: memory[i] = add_3; goto A017iadd; 
	fi;
A017iaddiadd_2: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_2; 
	:: memory[i] = add; goto A017iadd_2; 
	:: memory[i] = add_2; goto A017iadd; 
	fi;
A017iaddiadd_1: 
	if 
	:: v9 = memory[i]; goto A018iaddiadd_1; 
	:: memory[i] = add; goto A017iadd_1; 
	:: memory[i] = add_1; goto A017iadd; 
	fi;
A016i: 
	if 
	:: v8 = memory[j]; goto A017i; 
	:: memory[i] = add_3; goto A016; 
	fi;
A016iadd_2: 
	if 
	:: v8 = memory[j]; goto A017iadd_2; 
	:: memory[i] = add_2; goto A016; 
	fi;
A016iadd_1: 
	if 
	:: v8 = memory[j]; goto A017iadd_1; 
	:: memory[i] = add_1; goto A016; 
	fi;
A016iadd: 
	if 
	:: v8 = memory[j]; goto A017iadd; 
	:: memory[i] = add; goto A016; 
	fi;
A020iiiii: 
	if 
	:: memory[i] = add; goto A020iiii; 
	:: memory[i] = add_1; goto A020iaddiadd_2iadd_3iadd_4; 
	:: memory[i] = add_2; goto A020iaddiadd_1iadd_3iadd_4; 
	:: memory[i] = add_3; goto A020iaddiadd_1iadd_2iadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_1iadd_2iadd_3; 
	fi;
A019iii: 
	if 
	:: goto A020iiii; 
	:: memory[i] = add_1; goto A019ii; 
	:: memory[i] = add_2; goto A019iadd_1iadd_3; 
	:: memory[i] = add_3; goto A019iadd_1iadd_2; 
	fi;
A019iaddiadd_2iadd_3: 
	if 
	:: goto A020iaddiadd_2iadd_3iadd_4; 
	:: memory[i] = add; goto A019ii; 
	:: memory[i] = add_2; goto A019iaddiadd_3; 
	:: memory[i] = add_3; goto A019iaddiadd_2; 
	fi;
A019iaddiadd_1iadd_3: 
	if 
	:: goto A020iaddiadd_1iadd_3iadd_4; 
	:: memory[i] = add; goto A019iadd_1iadd_3; 
	:: memory[i] = add_1; goto A019iaddiadd_3; 
	:: memory[i] = add_3; goto A019iaddiadd_1; 
	fi;
A019iaddiadd_1iadd_2: 
	if 
	:: goto A020iaddiadd_1iadd_2iadd_4; 
	:: memory[i] = add; goto A019iadd_1iadd_2; 
	:: memory[i] = add_1; goto A019iaddiadd_2; 
	:: memory[i] = add_2; goto A019iaddiadd_1; 
	fi;
A018ii: 
	if 
	:: add_4 = v9 + v8; goto A019ii; 
	:: memory[i] = add_2; goto A018i; 
	:: memory[i] = add_3; goto A018iadd_2; 
	fi;
A018iadd_1iadd_3: 
	if 
	:: add_4 = v9 + v8; goto A019iadd_1iadd_3; 
	:: memory[i] = add_1; goto A018i; 
	:: memory[i] = add_3; goto A018iadd_1; 
	fi;
A018iadd_1iadd_2: 
	if 
	:: add_4 = v9 + v8; goto A019iadd_1iadd_2; 
	:: memory[i] = add_1; goto A018iadd_2; 
	:: memory[i] = add_2; goto A018iadd_1; 
	fi;
A018iaddiadd_3: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_3; 
	:: memory[i] = add; goto A018i; 
	:: memory[i] = add_3; goto A018iadd; 
	fi;
A018iaddiadd_2: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_2; 
	:: memory[i] = add; goto A018iadd_2; 
	:: memory[i] = add_2; goto A018iadd; 
	fi;
A018iaddiadd_1: 
	if 
	:: add_4 = v9 + v8; goto A019iaddiadd_1; 
	:: memory[i] = add; goto A018iadd_1; 
	:: memory[i] = add_1; goto A018iadd; 
	fi;
A017i: 
	if 
	:: v9 = memory[i]; goto A018i; 
	:: memory[i] = add_3; goto A017; 
	fi;
A017iadd_2: 
	if 
	:: v9 = memory[i]; goto A018iadd_2; 
	:: memory[i] = add_2; goto A017; 
	fi;
A017iadd_1: 
	if 
	:: v9 = memory[i]; goto A018iadd_1; 
	:: memory[i] = add_1; goto A017; 
	fi;
A017iadd: 
	if 
	:: v9 = memory[i]; goto A018iadd; 
	:: memory[i] = add; goto A017; 
	fi;
A016: v8 = memory[j]; goto A017; 
A020iiii: 
	if 
	:: memory[i] = add_1; goto A020iii; 
	:: memory[i] = add_2; goto A020iadd_1iadd_3iadd_4; 
	:: memory[i] = add_3; goto A020iadd_1iadd_2iadd_4; 
	:: memory[i] = add_4; goto A020iadd_1iadd_2iadd_3; 
	fi;
A020iaddiadd_2iadd_3iadd_4: 
	if 
	:: memory[i] = add; goto A020iii; 
	:: memory[i] = add_2; goto A020iaddiadd_3iadd_4; 
	:: memory[i] = add_3; goto A020iaddiadd_2iadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_2iadd_3; 
	fi;
A020iaddiadd_1iadd_3iadd_4: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_3iadd_4; 
	:: memory[i] = add_1; goto A020iaddiadd_3iadd_4; 
	:: memory[i] = add_3; goto A020iaddiadd_1iadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_1iadd_3; 
	fi;
A020iaddiadd_1iadd_2iadd_4: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_2iadd_4; 
	:: memory[i] = add_1; goto A020iaddiadd_2iadd_4; 
	:: memory[i] = add_2; goto A020iaddiadd_1iadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_1iadd_2; 
	fi;
A020iaddiadd_1iadd_2iadd_3: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_2iadd_3; 
	:: memory[i] = add_1; goto A020iaddiadd_2iadd_3; 
	:: memory[i] = add_2; goto A020iaddiadd_1iadd_3; 
	:: memory[i] = add_3; goto A020iaddiadd_1iadd_2; 
	fi;
A019ii: 
	if 
	:: goto A020iii; 
	:: memory[i] = add_2; goto A019i; 
	:: memory[i] = add_3; goto A019iadd_2; 
	fi;
A019iadd_1iadd_3: 
	if 
	:: goto A020iadd_1iadd_3iadd_4; 
	:: memory[i] = add_1; goto A019i; 
	:: memory[i] = add_3; goto A019iadd_1; 
	fi;
A019iadd_1iadd_2: 
	if 
	:: goto A020iadd_1iadd_2iadd_4; 
	:: memory[i] = add_1; goto A019iadd_2; 
	:: memory[i] = add_2; goto A019iadd_1; 
	fi;
A019iaddiadd_3: 
	if 
	:: goto A020iaddiadd_3iadd_4; 
	:: memory[i] = add; goto A019i; 
	:: memory[i] = add_3; goto A019iadd; 
	fi;
A019iaddiadd_2: 
	if 
	:: goto A020iaddiadd_2iadd_4; 
	:: memory[i] = add; goto A019iadd_2; 
	:: memory[i] = add_2; goto A019iadd; 
	fi;
A019iaddiadd_1: 
	if 
	:: goto A020iaddiadd_1iadd_4; 
	:: memory[i] = add; goto A019iadd_1; 
	:: memory[i] = add_1; goto A019iadd; 
	fi;
A018i: 
	if 
	:: add_4 = v9 + v8; goto A019i; 
	:: memory[i] = add_3; goto A018; 
	fi;
A018iadd_2: 
	if 
	:: add_4 = v9 + v8; goto A019iadd_2; 
	:: memory[i] = add_2; goto A018; 
	fi;
A018iadd_1: 
	if 
	:: add_4 = v9 + v8; goto A019iadd_1; 
	:: memory[i] = add_1; goto A018; 
	fi;
A018iadd: 
	if 
	:: add_4 = v9 + v8; goto A019iadd; 
	:: memory[i] = add; goto A018; 
	fi;
A017: v9 = memory[i]; goto A018; 
A020iii: 
	if 
	:: memory[i] = add_2; goto A020ii; 
	:: memory[i] = add_3; goto A020iadd_2iadd_4; 
	:: memory[i] = add_4; goto A020iadd_2iadd_3; 
	fi;
A020iadd_1iadd_3iadd_4: 
	if 
	:: memory[i] = add_1; goto A020ii; 
	:: memory[i] = add_3; goto A020iadd_1iadd_4; 
	:: memory[i] = add_4; goto A020iadd_1iadd_3; 
	fi;
A020iadd_1iadd_2iadd_4: 
	if 
	:: memory[i] = add_1; goto A020iadd_2iadd_4; 
	:: memory[i] = add_2; goto A020iadd_1iadd_4; 
	:: memory[i] = add_4; goto A020iadd_1iadd_2; 
	fi;
A020iadd_1iadd_2iadd_3: 
	if 
	:: memory[i] = add_1; goto A020iadd_2iadd_3; 
	:: memory[i] = add_2; goto A020iadd_1iadd_3; 
	:: memory[i] = add_3; goto A020iadd_1iadd_2; 
	fi;
A020iaddiadd_3iadd_4: 
	if 
	:: memory[i] = add; goto A020ii; 
	:: memory[i] = add_3; goto A020iaddiadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_3; 
	fi;
A020iaddiadd_2iadd_4: 
	if 
	:: memory[i] = add; goto A020iadd_2iadd_4; 
	:: memory[i] = add_2; goto A020iaddiadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_2; 
	fi;
A020iaddiadd_2iadd_3: 
	if 
	:: memory[i] = add; goto A020iadd_2iadd_3; 
	:: memory[i] = add_2; goto A020iaddiadd_3; 
	:: memory[i] = add_3; goto A020iaddiadd_2; 
	fi;
A020iaddiadd_1iadd_4: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_4; 
	:: memory[i] = add_1; goto A020iaddiadd_4; 
	:: memory[i] = add_4; goto A020iaddiadd_1; 
	fi;
A020iaddiadd_1iadd_3: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_3; 
	:: memory[i] = add_1; goto A020iaddiadd_3; 
	:: memory[i] = add_3; goto A020iaddiadd_1; 
	fi;
A020iaddiadd_1iadd_2: 
	if 
	:: memory[i] = add; goto A020iadd_1iadd_2; 
	:: memory[i] = add_1; goto A020iaddiadd_2; 
	:: memory[i] = add_2; goto A020iaddiadd_1; 
	fi;
A019i: 
	if 
	:: goto A020ii; 
	:: memory[i] = add_3; goto A019; 
	fi;
A019iadd_2: 
	if 
	:: goto A020iadd_2iadd_4; 
	:: memory[i] = add_2; goto A019; 
	fi;
A019iadd_1: 
	if 
	:: goto A020iadd_1iadd_4; 
	:: memory[i] = add_1; goto A019; 
	fi;
A019iadd: 
	if 
	:: goto A020iaddiadd_4; 
	:: memory[i] = add; goto A019; 
	fi;
A018: add_4 = v9 + v8; goto A019; 
A020ii: 
	if 
	:: memory[i] = add_3; goto A020i; 
	:: memory[i] = add_4; goto A020iadd_3; 
	fi;
A020iadd_2iadd_4: 
	if 
	:: memory[i] = add_2; goto A020i; 
	:: memory[i] = add_4; goto A020iadd_2; 
	fi;
A020iadd_2iadd_3: 
	if 
	:: memory[i] = add_2; goto A020iadd_3; 
	:: memory[i] = add_3; goto A020iadd_2; 
	fi;
A020iadd_1iadd_4: 
	if 
	:: memory[i] = add_1; goto A020i; 
	:: memory[i] = add_4; goto A020iadd_1; 
	fi;
A020iadd_1iadd_3: 
	if 
	:: memory[i] = add_1; goto A020iadd_3; 
	:: memory[i] = add_3; goto A020iadd_1; 
	fi;
A020iadd_1iadd_2: 
	if 
	:: memory[i] = add_1; goto A020iadd_2; 
	:: memory[i] = add_2; goto A020iadd_1; 
	fi;
A020iaddiadd_4: 
	if 
	:: memory[i] = add; goto A020i; 
	:: memory[i] = add_4; goto A020iadd; 
	fi;
A020iaddiadd_3: 
	if 
	:: memory[i] = add; goto A020iadd_3; 
	:: memory[i] = add_3; goto A020iadd; 
	fi;
A020iaddiadd_2: 
	if 
	:: memory[i] = add; goto A020iadd_2; 
	:: memory[i] = add_2; goto A020iadd; 
	fi;
A020iaddiadd_1: 
	if 
	:: memory[i] = add; goto A020iadd_1; 
	:: memory[i] = add_1; goto A020iadd; 
	fi;
A019: goto A020i; 
A020i: memory[i] = add_4; goto A020; 
A020iadd_3: memory[i] = add_3; goto A020; 
A020iadd_2: memory[i] = add_2; goto A020; 
A020iadd_1: memory[i] = add_1; goto A020; 
A020iadd: memory[i] = add; goto A020; 
A020: returnvalue = null; goto AEnd;
AEnd: skip;

}


inline t2(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
BStart: goto B000;
B000: v0 = memory[i]; goto B001; 
B001: v1 = memory[j]; goto B002; 
B002: add = v1 + v0; goto B003; 
B003: goto B004j; 
B004j: 
	if 
	:: v2 = memory[i]; goto B005j; 
	:: memory[j] = add; goto B004; 
	fi;
B005j: 
	if 
	:: v3 = memory[j]; goto B006j; 
	:: memory[j] = add; goto B005; 
	fi;
B004: v2 = memory[i]; goto B005; 
B006j: 
	if 
	:: add_1 = v3 + v2; goto B007j; 
	:: memory[j] = add; goto B006; 
	fi;
B005: v3 = memory[j]; goto B006; 
B007j: 
	if 
	:: goto B008jj; 
	:: memory[j] = add; goto B007; 
	fi;
B006: add_1 = v3 + v2; goto B007; 
B008jj: 
	if 
	:: v4 = memory[i]; goto B009jj; 
	:: memory[j] = add; goto B008j; 
	:: memory[j] = add_1; goto B008jadd; 
	fi;
B007: goto B008j; 
B009jj: 
	if 
	:: v5 = memory[j]; goto B010jj; 
	:: memory[j] = add; goto B009j; 
	:: memory[j] = add_1; goto B009jadd; 
	fi;
B008j: 
	if 
	:: v4 = memory[i]; goto B009j; 
	:: memory[j] = add_1; goto B008; 
	fi;
B008jadd: 
	if 
	:: v4 = memory[i]; goto B009jadd; 
	:: memory[j] = add; goto B008; 
	fi;
B010jj: 
	if 
	:: add_2 = v5 + v4; goto B011jj; 
	:: memory[j] = add; goto B010j; 
	:: memory[j] = add_1; goto B010jadd; 
	fi;
B009j: 
	if 
	:: v5 = memory[j]; goto B010j; 
	:: memory[j] = add_1; goto B009; 
	fi;
B009jadd: 
	if 
	:: v5 = memory[j]; goto B010jadd; 
	:: memory[j] = add; goto B009; 
	fi;
B008: v4 = memory[i]; goto B009; 
B011jj: 
	if 
	:: goto B012jjj; 
	:: memory[j] = add; goto B011j; 
	:: memory[j] = add_1; goto B011jadd; 
	fi;
B010j: 
	if 
	:: add_2 = v5 + v4; goto B011j; 
	:: memory[j] = add_1; goto B010; 
	fi;
B010jadd: 
	if 
	:: add_2 = v5 + v4; goto B011jadd; 
	:: memory[j] = add; goto B010; 
	fi;
B009: v5 = memory[j]; goto B010; 
B012jjj: 
	if 
	:: v6 = memory[i]; goto B013jjj; 
	:: memory[j] = add; goto B012jj; 
	:: memory[j] = add_1; goto B012jaddjadd_2; 
	:: memory[j] = add_2; goto B012jaddjadd_1; 
	fi;
B011j: 
	if 
	:: goto B012jj; 
	:: memory[j] = add_1; goto B011; 
	fi;
B011jadd: 
	if 
	:: goto B012jaddjadd_2; 
	:: memory[j] = add; goto B011; 
	fi;
B010: add_2 = v5 + v4; goto B011; 
B013jjj: 
	if 
	:: v7 = memory[j]; goto B014jjj; 
	:: memory[j] = add; goto B013jj; 
	:: memory[j] = add_1; goto B013jaddjadd_2; 
	:: memory[j] = add_2; goto B013jaddjadd_1; 
	fi;
B012jj: 
	if 
	:: v6 = memory[i]; goto B013jj; 
	:: memory[j] = add_1; goto B012j; 
	:: memory[j] = add_2; goto B012jadd_1; 
	fi;
B012jaddjadd_2: 
	if 
	:: v6 = memory[i]; goto B013jaddjadd_2; 
	:: memory[j] = add; goto B012j; 
	:: memory[j] = add_2; goto B012jadd; 
	fi;
B012jaddjadd_1: 
	if 
	:: v6 = memory[i]; goto B013jaddjadd_1; 
	:: memory[j] = add; goto B012jadd_1; 
	:: memory[j] = add_1; goto B012jadd; 
	fi;
B011: goto B012j; 
B014jjj: 
	if 
	:: add_3 = v7 + v6; goto B015jjj; 
	:: memory[j] = add; goto B014jj; 
	:: memory[j] = add_1; goto B014jaddjadd_2; 
	:: memory[j] = add_2; goto B014jaddjadd_1; 
	fi;
B013jj: 
	if 
	:: v7 = memory[j]; goto B014jj; 
	:: memory[j] = add_1; goto B013j; 
	:: memory[j] = add_2; goto B013jadd_1; 
	fi;
B013jaddjadd_2: 
	if 
	:: v7 = memory[j]; goto B014jaddjadd_2; 
	:: memory[j] = add; goto B013j; 
	:: memory[j] = add_2; goto B013jadd; 
	fi;
B013jaddjadd_1: 
	if 
	:: v7 = memory[j]; goto B014jaddjadd_1; 
	:: memory[j] = add; goto B013jadd_1; 
	:: memory[j] = add_1; goto B013jadd; 
	fi;
B012j: 
	if 
	:: v6 = memory[i]; goto B013j; 
	:: memory[j] = add_2; goto B012; 
	fi;
B012jadd_1: 
	if 
	:: v6 = memory[i]; goto B013jadd_1; 
	:: memory[j] = add_1; goto B012; 
	fi;
B012jadd: 
	if 
	:: v6 = memory[i]; goto B013jadd; 
	:: memory[j] = add; goto B012; 
	fi;
B015jjj: 
	if 
	:: goto B016jjjj; 
	:: memory[j] = add; goto B015jj; 
	:: memory[j] = add_1; goto B015jaddjadd_2; 
	:: memory[j] = add_2; goto B015jaddjadd_1; 
	fi;
B014jj: 
	if 
	:: add_3 = v7 + v6; goto B015jj; 
	:: memory[j] = add_1; goto B014j; 
	:: memory[j] = add_2; goto B014jadd_1; 
	fi;
B014jaddjadd_2: 
	if 
	:: add_3 = v7 + v6; goto B015jaddjadd_2; 
	:: memory[j] = add; goto B014j; 
	:: memory[j] = add_2; goto B014jadd; 
	fi;
B014jaddjadd_1: 
	if 
	:: add_3 = v7 + v6; goto B015jaddjadd_1; 
	:: memory[j] = add; goto B014jadd_1; 
	:: memory[j] = add_1; goto B014jadd; 
	fi;
B013j: 
	if 
	:: v7 = memory[j]; goto B014j; 
	:: memory[j] = add_2; goto B013; 
	fi;
B013jadd_1: 
	if 
	:: v7 = memory[j]; goto B014jadd_1; 
	:: memory[j] = add_1; goto B013; 
	fi;
B013jadd: 
	if 
	:: v7 = memory[j]; goto B014jadd; 
	:: memory[j] = add; goto B013; 
	fi;
B012: v6 = memory[i]; goto B013; 
B016jjjj: 
	if 
	:: v8 = memory[i]; goto B017jjjj; 
	:: memory[j] = add; goto B016jjj; 
	:: memory[j] = add_1; goto B016jaddjadd_2jadd_3; 
	:: memory[j] = add_2; goto B016jaddjadd_1jadd_3; 
	:: memory[j] = add_3; goto B016jaddjadd_1jadd_2; 
	fi;
B015jj: 
	if 
	:: goto B016jjj; 
	:: memory[j] = add_1; goto B015j; 
	:: memory[j] = add_2; goto B015jadd_1; 
	fi;
B015jaddjadd_2: 
	if 
	:: goto B016jaddjadd_2jadd_3; 
	:: memory[j] = add; goto B015j; 
	:: memory[j] = add_2; goto B015jadd; 
	fi;
B015jaddjadd_1: 
	if 
	:: goto B016jaddjadd_1jadd_3; 
	:: memory[j] = add; goto B015jadd_1; 
	:: memory[j] = add_1; goto B015jadd; 
	fi;
B014j: 
	if 
	:: add_3 = v7 + v6; goto B015j; 
	:: memory[j] = add_2; goto B014; 
	fi;
B014jadd_1: 
	if 
	:: add_3 = v7 + v6; goto B015jadd_1; 
	:: memory[j] = add_1; goto B014; 
	fi;
B014jadd: 
	if 
	:: add_3 = v7 + v6; goto B015jadd; 
	:: memory[j] = add; goto B014; 
	fi;
B013: v7 = memory[j]; goto B014; 
B017jjjj: 
	if 
	:: v9 = memory[j]; goto B018jjjj; 
	:: memory[j] = add; goto B017jjj; 
	:: memory[j] = add_1; goto B017jaddjadd_2jadd_3; 
	:: memory[j] = add_2; goto B017jaddjadd_1jadd_3; 
	:: memory[j] = add_3; goto B017jaddjadd_1jadd_2; 
	fi;
B016jjj: 
	if 
	:: v8 = memory[i]; goto B017jjj; 
	:: memory[j] = add_1; goto B016jj; 
	:: memory[j] = add_2; goto B016jadd_1jadd_3; 
	:: memory[j] = add_3; goto B016jadd_1jadd_2; 
	fi;
B016jaddjadd_2jadd_3: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_2jadd_3; 
	:: memory[j] = add; goto B016jj; 
	:: memory[j] = add_2; goto B016jaddjadd_3; 
	:: memory[j] = add_3; goto B016jaddjadd_2; 
	fi;
B016jaddjadd_1jadd_3: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_1jadd_3; 
	:: memory[j] = add; goto B016jadd_1jadd_3; 
	:: memory[j] = add_1; goto B016jaddjadd_3; 
	:: memory[j] = add_3; goto B016jaddjadd_1; 
	fi;
B016jaddjadd_1jadd_2: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_1jadd_2; 
	:: memory[j] = add; goto B016jadd_1jadd_2; 
	:: memory[j] = add_1; goto B016jaddjadd_2; 
	:: memory[j] = add_2; goto B016jaddjadd_1; 
	fi;
B015j: 
	if 
	:: goto B016jj; 
	:: memory[j] = add_2; goto B015; 
	fi;
B015jadd_1: 
	if 
	:: goto B016jadd_1jadd_3; 
	:: memory[j] = add_1; goto B015; 
	fi;
B015jadd: 
	if 
	:: goto B016jaddjadd_3; 
	:: memory[j] = add; goto B015; 
	fi;
B014: add_3 = v7 + v6; goto B015; 
B018jjjj: 
	if 
	:: add_4 = v9 + v8; goto B019jjjj; 
	:: memory[j] = add; goto B018jjj; 
	:: memory[j] = add_1; goto B018jaddjadd_2jadd_3; 
	:: memory[j] = add_2; goto B018jaddjadd_1jadd_3; 
	:: memory[j] = add_3; goto B018jaddjadd_1jadd_2; 
	fi;
B017jjj: 
	if 
	:: v9 = memory[j]; goto B018jjj; 
	:: memory[j] = add_1; goto B017jj; 
	:: memory[j] = add_2; goto B017jadd_1jadd_3; 
	:: memory[j] = add_3; goto B017jadd_1jadd_2; 
	fi;
B017jaddjadd_2jadd_3: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_2jadd_3; 
	:: memory[j] = add; goto B017jj; 
	:: memory[j] = add_2; goto B017jaddjadd_3; 
	:: memory[j] = add_3; goto B017jaddjadd_2; 
	fi;
B017jaddjadd_1jadd_3: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_1jadd_3; 
	:: memory[j] = add; goto B017jadd_1jadd_3; 
	:: memory[j] = add_1; goto B017jaddjadd_3; 
	:: memory[j] = add_3; goto B017jaddjadd_1; 
	fi;
B017jaddjadd_1jadd_2: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_1jadd_2; 
	:: memory[j] = add; goto B017jadd_1jadd_2; 
	:: memory[j] = add_1; goto B017jaddjadd_2; 
	:: memory[j] = add_2; goto B017jaddjadd_1; 
	fi;
B016jj: 
	if 
	:: v8 = memory[i]; goto B017jj; 
	:: memory[j] = add_2; goto B016j; 
	:: memory[j] = add_3; goto B016jadd_2; 
	fi;
B016jadd_1jadd_3: 
	if 
	:: v8 = memory[i]; goto B017jadd_1jadd_3; 
	:: memory[j] = add_1; goto B016j; 
	:: memory[j] = add_3; goto B016jadd_1; 
	fi;
B016jadd_1jadd_2: 
	if 
	:: v8 = memory[i]; goto B017jadd_1jadd_2; 
	:: memory[j] = add_1; goto B016jadd_2; 
	:: memory[j] = add_2; goto B016jadd_1; 
	fi;
B016jaddjadd_3: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_3; 
	:: memory[j] = add; goto B016j; 
	:: memory[j] = add_3; goto B016jadd; 
	fi;
B016jaddjadd_2: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_2; 
	:: memory[j] = add; goto B016jadd_2; 
	:: memory[j] = add_2; goto B016jadd; 
	fi;
B016jaddjadd_1: 
	if 
	:: v8 = memory[i]; goto B017jaddjadd_1; 
	:: memory[j] = add; goto B016jadd_1; 
	:: memory[j] = add_1; goto B016jadd; 
	fi;
B015: goto B016j; 
B019jjjj: 
	if 
	:: goto B020jjjjj; 
	:: memory[j] = add; goto B019jjj; 
	:: memory[j] = add_1; goto B019jaddjadd_2jadd_3; 
	:: memory[j] = add_2; goto B019jaddjadd_1jadd_3; 
	:: memory[j] = add_3; goto B019jaddjadd_1jadd_2; 
	fi;
B018jjj: 
	if 
	:: add_4 = v9 + v8; goto B019jjj; 
	:: memory[j] = add_1; goto B018jj; 
	:: memory[j] = add_2; goto B018jadd_1jadd_3; 
	:: memory[j] = add_3; goto B018jadd_1jadd_2; 
	fi;
B018jaddjadd_2jadd_3: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_2jadd_3; 
	:: memory[j] = add; goto B018jj; 
	:: memory[j] = add_2; goto B018jaddjadd_3; 
	:: memory[j] = add_3; goto B018jaddjadd_2; 
	fi;
B018jaddjadd_1jadd_3: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_1jadd_3; 
	:: memory[j] = add; goto B018jadd_1jadd_3; 
	:: memory[j] = add_1; goto B018jaddjadd_3; 
	:: memory[j] = add_3; goto B018jaddjadd_1; 
	fi;
B018jaddjadd_1jadd_2: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_1jadd_2; 
	:: memory[j] = add; goto B018jadd_1jadd_2; 
	:: memory[j] = add_1; goto B018jaddjadd_2; 
	:: memory[j] = add_2; goto B018jaddjadd_1; 
	fi;
B017jj: 
	if 
	:: v9 = memory[j]; goto B018jj; 
	:: memory[j] = add_2; goto B017j; 
	:: memory[j] = add_3; goto B017jadd_2; 
	fi;
B017jadd_1jadd_3: 
	if 
	:: v9 = memory[j]; goto B018jadd_1jadd_3; 
	:: memory[j] = add_1; goto B017j; 
	:: memory[j] = add_3; goto B017jadd_1; 
	fi;
B017jadd_1jadd_2: 
	if 
	:: v9 = memory[j]; goto B018jadd_1jadd_2; 
	:: memory[j] = add_1; goto B017jadd_2; 
	:: memory[j] = add_2; goto B017jadd_1; 
	fi;
B017jaddjadd_3: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_3; 
	:: memory[j] = add; goto B017j; 
	:: memory[j] = add_3; goto B017jadd; 
	fi;
B017jaddjadd_2: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_2; 
	:: memory[j] = add; goto B017jadd_2; 
	:: memory[j] = add_2; goto B017jadd; 
	fi;
B017jaddjadd_1: 
	if 
	:: v9 = memory[j]; goto B018jaddjadd_1; 
	:: memory[j] = add; goto B017jadd_1; 
	:: memory[j] = add_1; goto B017jadd; 
	fi;
B016j: 
	if 
	:: v8 = memory[i]; goto B017j; 
	:: memory[j] = add_3; goto B016; 
	fi;
B016jadd_2: 
	if 
	:: v8 = memory[i]; goto B017jadd_2; 
	:: memory[j] = add_2; goto B016; 
	fi;
B016jadd_1: 
	if 
	:: v8 = memory[i]; goto B017jadd_1; 
	:: memory[j] = add_1; goto B016; 
	fi;
B016jadd: 
	if 
	:: v8 = memory[i]; goto B017jadd; 
	:: memory[j] = add; goto B016; 
	fi;
B020jjjjj: 
	if 
	:: memory[j] = add; goto B020jjjj; 
	:: memory[j] = add_1; goto B020jaddjadd_2jadd_3jadd_4; 
	:: memory[j] = add_2; goto B020jaddjadd_1jadd_3jadd_4; 
	:: memory[j] = add_3; goto B020jaddjadd_1jadd_2jadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_1jadd_2jadd_3; 
	fi;
B019jjj: 
	if 
	:: goto B020jjjj; 
	:: memory[j] = add_1; goto B019jj; 
	:: memory[j] = add_2; goto B019jadd_1jadd_3; 
	:: memory[j] = add_3; goto B019jadd_1jadd_2; 
	fi;
B019jaddjadd_2jadd_3: 
	if 
	:: goto B020jaddjadd_2jadd_3jadd_4; 
	:: memory[j] = add; goto B019jj; 
	:: memory[j] = add_2; goto B019jaddjadd_3; 
	:: memory[j] = add_3; goto B019jaddjadd_2; 
	fi;
B019jaddjadd_1jadd_3: 
	if 
	:: goto B020jaddjadd_1jadd_3jadd_4; 
	:: memory[j] = add; goto B019jadd_1jadd_3; 
	:: memory[j] = add_1; goto B019jaddjadd_3; 
	:: memory[j] = add_3; goto B019jaddjadd_1; 
	fi;
B019jaddjadd_1jadd_2: 
	if 
	:: goto B020jaddjadd_1jadd_2jadd_4; 
	:: memory[j] = add; goto B019jadd_1jadd_2; 
	:: memory[j] = add_1; goto B019jaddjadd_2; 
	:: memory[j] = add_2; goto B019jaddjadd_1; 
	fi;
B018jj: 
	if 
	:: add_4 = v9 + v8; goto B019jj; 
	:: memory[j] = add_2; goto B018j; 
	:: memory[j] = add_3; goto B018jadd_2; 
	fi;
B018jadd_1jadd_3: 
	if 
	:: add_4 = v9 + v8; goto B019jadd_1jadd_3; 
	:: memory[j] = add_1; goto B018j; 
	:: memory[j] = add_3; goto B018jadd_1; 
	fi;
B018jadd_1jadd_2: 
	if 
	:: add_4 = v9 + v8; goto B019jadd_1jadd_2; 
	:: memory[j] = add_1; goto B018jadd_2; 
	:: memory[j] = add_2; goto B018jadd_1; 
	fi;
B018jaddjadd_3: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_3; 
	:: memory[j] = add; goto B018j; 
	:: memory[j] = add_3; goto B018jadd; 
	fi;
B018jaddjadd_2: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_2; 
	:: memory[j] = add; goto B018jadd_2; 
	:: memory[j] = add_2; goto B018jadd; 
	fi;
B018jaddjadd_1: 
	if 
	:: add_4 = v9 + v8; goto B019jaddjadd_1; 
	:: memory[j] = add; goto B018jadd_1; 
	:: memory[j] = add_1; goto B018jadd; 
	fi;
B017j: 
	if 
	:: v9 = memory[j]; goto B018j; 
	:: memory[j] = add_3; goto B017; 
	fi;
B017jadd_2: 
	if 
	:: v9 = memory[j]; goto B018jadd_2; 
	:: memory[j] = add_2; goto B017; 
	fi;
B017jadd_1: 
	if 
	:: v9 = memory[j]; goto B018jadd_1; 
	:: memory[j] = add_1; goto B017; 
	fi;
B017jadd: 
	if 
	:: v9 = memory[j]; goto B018jadd; 
	:: memory[j] = add; goto B017; 
	fi;
B016: v8 = memory[i]; goto B017; 
B020jjjj: 
	if 
	:: memory[j] = add_1; goto B020jjj; 
	:: memory[j] = add_2; goto B020jadd_1jadd_3jadd_4; 
	:: memory[j] = add_3; goto B020jadd_1jadd_2jadd_4; 
	:: memory[j] = add_4; goto B020jadd_1jadd_2jadd_3; 
	fi;
B020jaddjadd_2jadd_3jadd_4: 
	if 
	:: memory[j] = add; goto B020jjj; 
	:: memory[j] = add_2; goto B020jaddjadd_3jadd_4; 
	:: memory[j] = add_3; goto B020jaddjadd_2jadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_2jadd_3; 
	fi;
B020jaddjadd_1jadd_3jadd_4: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_3jadd_4; 
	:: memory[j] = add_1; goto B020jaddjadd_3jadd_4; 
	:: memory[j] = add_3; goto B020jaddjadd_1jadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_1jadd_3; 
	fi;
B020jaddjadd_1jadd_2jadd_4: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_2jadd_4; 
	:: memory[j] = add_1; goto B020jaddjadd_2jadd_4; 
	:: memory[j] = add_2; goto B020jaddjadd_1jadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_1jadd_2; 
	fi;
B020jaddjadd_1jadd_2jadd_3: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_2jadd_3; 
	:: memory[j] = add_1; goto B020jaddjadd_2jadd_3; 
	:: memory[j] = add_2; goto B020jaddjadd_1jadd_3; 
	:: memory[j] = add_3; goto B020jaddjadd_1jadd_2; 
	fi;
B019jj: 
	if 
	:: goto B020jjj; 
	:: memory[j] = add_2; goto B019j; 
	:: memory[j] = add_3; goto B019jadd_2; 
	fi;
B019jadd_1jadd_3: 
	if 
	:: goto B020jadd_1jadd_3jadd_4; 
	:: memory[j] = add_1; goto B019j; 
	:: memory[j] = add_3; goto B019jadd_1; 
	fi;
B019jadd_1jadd_2: 
	if 
	:: goto B020jadd_1jadd_2jadd_4; 
	:: memory[j] = add_1; goto B019jadd_2; 
	:: memory[j] = add_2; goto B019jadd_1; 
	fi;
B019jaddjadd_3: 
	if 
	:: goto B020jaddjadd_3jadd_4; 
	:: memory[j] = add; goto B019j; 
	:: memory[j] = add_3; goto B019jadd; 
	fi;
B019jaddjadd_2: 
	if 
	:: goto B020jaddjadd_2jadd_4; 
	:: memory[j] = add; goto B019jadd_2; 
	:: memory[j] = add_2; goto B019jadd; 
	fi;
B019jaddjadd_1: 
	if 
	:: goto B020jaddjadd_1jadd_4; 
	:: memory[j] = add; goto B019jadd_1; 
	:: memory[j] = add_1; goto B019jadd; 
	fi;
B018j: 
	if 
	:: add_4 = v9 + v8; goto B019j; 
	:: memory[j] = add_3; goto B018; 
	fi;
B018jadd_2: 
	if 
	:: add_4 = v9 + v8; goto B019jadd_2; 
	:: memory[j] = add_2; goto B018; 
	fi;
B018jadd_1: 
	if 
	:: add_4 = v9 + v8; goto B019jadd_1; 
	:: memory[j] = add_1; goto B018; 
	fi;
B018jadd: 
	if 
	:: add_4 = v9 + v8; goto B019jadd; 
	:: memory[j] = add; goto B018; 
	fi;
B017: v9 = memory[j]; goto B018; 
B020jjj: 
	if 
	:: memory[j] = add_2; goto B020jj; 
	:: memory[j] = add_3; goto B020jadd_2jadd_4; 
	:: memory[j] = add_4; goto B020jadd_2jadd_3; 
	fi;
B020jadd_1jadd_3jadd_4: 
	if 
	:: memory[j] = add_1; goto B020jj; 
	:: memory[j] = add_3; goto B020jadd_1jadd_4; 
	:: memory[j] = add_4; goto B020jadd_1jadd_3; 
	fi;
B020jadd_1jadd_2jadd_4: 
	if 
	:: memory[j] = add_1; goto B020jadd_2jadd_4; 
	:: memory[j] = add_2; goto B020jadd_1jadd_4; 
	:: memory[j] = add_4; goto B020jadd_1jadd_2; 
	fi;
B020jadd_1jadd_2jadd_3: 
	if 
	:: memory[j] = add_1; goto B020jadd_2jadd_3; 
	:: memory[j] = add_2; goto B020jadd_1jadd_3; 
	:: memory[j] = add_3; goto B020jadd_1jadd_2; 
	fi;
B020jaddjadd_3jadd_4: 
	if 
	:: memory[j] = add; goto B020jj; 
	:: memory[j] = add_3; goto B020jaddjadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_3; 
	fi;
B020jaddjadd_2jadd_4: 
	if 
	:: memory[j] = add; goto B020jadd_2jadd_4; 
	:: memory[j] = add_2; goto B020jaddjadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_2; 
	fi;
B020jaddjadd_2jadd_3: 
	if 
	:: memory[j] = add; goto B020jadd_2jadd_3; 
	:: memory[j] = add_2; goto B020jaddjadd_3; 
	:: memory[j] = add_3; goto B020jaddjadd_2; 
	fi;
B020jaddjadd_1jadd_4: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_4; 
	:: memory[j] = add_1; goto B020jaddjadd_4; 
	:: memory[j] = add_4; goto B020jaddjadd_1; 
	fi;
B020jaddjadd_1jadd_3: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_3; 
	:: memory[j] = add_1; goto B020jaddjadd_3; 
	:: memory[j] = add_3; goto B020jaddjadd_1; 
	fi;
B020jaddjadd_1jadd_2: 
	if 
	:: memory[j] = add; goto B020jadd_1jadd_2; 
	:: memory[j] = add_1; goto B020jaddjadd_2; 
	:: memory[j] = add_2; goto B020jaddjadd_1; 
	fi;
B019j: 
	if 
	:: goto B020jj; 
	:: memory[j] = add_3; goto B019; 
	fi;
B019jadd_2: 
	if 
	:: goto B020jadd_2jadd_4; 
	:: memory[j] = add_2; goto B019; 
	fi;
B019jadd_1: 
	if 
	:: goto B020jadd_1jadd_4; 
	:: memory[j] = add_1; goto B019; 
	fi;
B019jadd: 
	if 
	:: goto B020jaddjadd_4; 
	:: memory[j] = add; goto B019; 
	fi;
B018: add_4 = v9 + v8; goto B019; 
B020jj: 
	if 
	:: memory[j] = add_3; goto B020j; 
	:: memory[j] = add_4; goto B020jadd_3; 
	fi;
B020jadd_2jadd_4: 
	if 
	:: memory[j] = add_2; goto B020j; 
	:: memory[j] = add_4; goto B020jadd_2; 
	fi;
B020jadd_2jadd_3: 
	if 
	:: memory[j] = add_2; goto B020jadd_3; 
	:: memory[j] = add_3; goto B020jadd_2; 
	fi;
B020jadd_1jadd_4: 
	if 
	:: memory[j] = add_1; goto B020j; 
	:: memory[j] = add_4; goto B020jadd_1; 
	fi;
B020jadd_1jadd_3: 
	if 
	:: memory[j] = add_1; goto B020jadd_3; 
	:: memory[j] = add_3; goto B020jadd_1; 
	fi;
B020jadd_1jadd_2: 
	if 
	:: memory[j] = add_1; goto B020jadd_2; 
	:: memory[j] = add_2; goto B020jadd_1; 
	fi;
B020jaddjadd_4: 
	if 
	:: memory[j] = add; goto B020j; 
	:: memory[j] = add_4; goto B020jadd; 
	fi;
B020jaddjadd_3: 
	if 
	:: memory[j] = add; goto B020jadd_3; 
	:: memory[j] = add_3; goto B020jadd; 
	fi;
B020jaddjadd_2: 
	if 
	:: memory[j] = add; goto B020jadd_2; 
	:: memory[j] = add_2; goto B020jadd; 
	fi;
B020jaddjadd_1: 
	if 
	:: memory[j] = add; goto B020jadd_1; 
	:: memory[j] = add_1; goto B020jadd; 
	fi;
B019: goto B020j; 
B020j: memory[j] = add_4; goto B020; 
B020jadd_3: memory[j] = add_3; goto B020; 
B020jadd_2: memory[j] = add_2; goto B020; 
B020jadd_1: memory[j] = add_1; goto B020; 
B020jadd: memory[j] = add; goto B020; 
B020: returnvalue = null; goto BEnd;
BEnd: skip;

}


//Stubs
proctype process1(){
	short arg, returnvalue;
	t1(arg, returnvalue);
	assert(!(i> 144 || j > 144));
}

proctype process2(){
	short arg, returnvalue;
	t2(arg, returnvalue);
	assert(!(i> 144 || j > 144));
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, i);
	alloca(1, j);
	memory[i] = 1;
	memory[j] = 1;
	

	run process1();
	run process2();
	}
}

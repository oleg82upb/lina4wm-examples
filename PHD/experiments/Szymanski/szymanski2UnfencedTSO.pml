#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  1
#define PTR 1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag0 = null;
short flag1 = null;
short mtxOwner = 0;

inline acquire(pid)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = pid;
	 }
}

inline release(pid)
{
	atomic{
	 assert(mtxOwner == pid);
	 mtxOwner = 0;
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



inline proc0(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12, cmp8, v13;
AStart: goto A000;
A000: v0 = memory[flag0]; goto A001; 
A001: goto A002v0; 
A002v0: 
	if 
	:: v1 = memory[flag1]; goto A003v0; 
	:: memory[v0] = 1; goto A002; 
	fi;
A003v0: 
	if 
	:: goto A004v0; 
	:: memory[v0] = 1; goto A003; 
	fi;
A002: v1 = memory[flag1]; goto A003; 
A004v0: 
	if 
	:: v2 = memory[v1]; goto A005v0; 
	:: memory[v0] = 1; goto A004; 
	fi;
A003: goto A004; 
A005v0: 
	if 
	:: cmp = (v2 > 2); goto A006v0; 
	:: memory[v0] = 1; goto A005; 
	fi;
A004: v2 = memory[v1]; goto A005; 
A006v0: 
	if 
	::cmp -> goto A004v0; 
	::!cmp -> goto A007v0; 
	:: memory[v0] = 1; goto A006; 
	fi;
A005: cmp = (v2 > 2); goto A006; 
A007v0: 
	if 
	:: v3 = memory[flag0]; goto A008v0; 
	:: memory[v0] = 1; goto A007; 
	fi;
A006: 
	if 
	::cmp -> goto A004; 
	::!cmp -> goto A007; 
	fi;
A008v0: 
	if 
	:: goto A009v0v3; 
	:: memory[v0] = 1; goto A008; 
	fi;
A007: v3 = memory[flag0]; goto A008; 
A009v0v3: 
	if 
	:: v4 = memory[flag1]; goto A010v0v3; 
	:: memory[v0] = 1; goto A009v3; 
	fi;
A008: goto A009v3; 
A010v0v3: 
	if 
	:: v5 = memory[v4]; goto A011v0v3; 
	:: memory[v0] = 1; goto A010v3; 
	fi;
A009v3: 
	if 
	:: v4 = memory[flag1]; goto A010v3; 
	:: memory[v3] = 3; goto A009; 
	fi;
A011v0v3: 
	if 
	:: cmp1 = (v5 == 1); goto A012v0v3; 
	:: memory[v0] = 1; goto A011v3; 
	fi;
A010v3: 
	if 
	:: v5 = memory[v4]; goto A011v3; 
	:: memory[v3] = 3; goto A010; 
	fi;
A009: v4 = memory[flag1]; goto A010; 
A012v0v3: 
	if 
	::cmp1 -> goto A013v0v3; 
	::!cmp1 -> goto A020v0v3; 
	:: memory[v0] = 1; goto A012v3; 
	fi;
A011v3: 
	if 
	:: cmp1 = (v5 == 1); goto A012v3; 
	:: memory[v3] = 3; goto A011; 
	fi;
A010: v5 = memory[v4]; goto A011; 
A013v0v3: 
	if 
	:: v6 = memory[flag0]; goto A014v0v3; 
	:: memory[v0] = 1; goto A013v3; 
	fi;
A020v0v3: 
	if 
	:: v9 = memory[flag0]; goto A021v0v3; 
	:: memory[v0] = 1; goto A020v3; 
	fi;
A012v3: 
	if 
	::cmp1 -> goto A013v3; 
	::!cmp1 -> goto A020v3; 
	:: memory[v3] = 3; goto A012; 
	fi;
A011: cmp1 = (v5 == 1); goto A012; 
A014v0v3: 
	if 
	:: goto A015v0v3v6; 
	:: memory[v0] = 1; goto A014v3; 
	fi;
A013v3: 
	if 
	:: v6 = memory[flag0]; goto A014v3; 
	:: memory[v3] = 3; goto A013; 
	fi;
A021v0v3: 
	if 
	:: goto A022v0v3v9; 
	:: memory[v0] = 1; goto A021v3; 
	fi;
A020v3: 
	if 
	:: v9 = memory[flag0]; goto A021v3; 
	:: memory[v3] = 3; goto A020; 
	fi;
A012: 
	if 
	::cmp1 -> goto A013; 
	::!cmp1 -> goto A020; 
	fi;
A015v0v3v6: 
	if 
	:: v7 = memory[flag1]; goto A016v0v3v6; 
	:: memory[v0] = 1; goto A015v3v6; 
	fi;
A014v3: 
	if 
	:: goto A015v3v6; 
	:: memory[v3] = 3; goto A014; 
	fi;
A013: v6 = memory[flag0]; goto A014; 
A022v0v3v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v0v3v9; 
	:: memory[v0] = 1; goto A022v3v9; 
	fi;
A021v3: 
	if 
	:: goto A022v3v9; 
	:: memory[v3] = 3; goto A021; 
	fi;
A020: v9 = memory[flag0]; goto A021; 
A016v0v3v6: 
	if 
	:: goto A017v0v3v6; 
	:: memory[v0] = 1; goto A016v3v6; 
	fi;
A015v3v6: 
	if 
	:: v7 = memory[flag1]; goto A016v3v6; 
	:: memory[v3] = 3; goto A015v6; 
	fi;
A014: goto A015v6; 
A023v0v3v9: 
	if 
	:: release(_pid); goto A024v0v3v9; 
	:: memory[v0] = 1; goto A023v3v9; 
	fi;
A022v3v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v3v9; 
	:: memory[v3] = 3; goto A022v9; 
	fi;
A021: goto A022v9; 
A017v0v3v6: 
	if 
	:: v8 = memory[v7]; goto A018v0v3v6; 
	:: memory[v0] = 1; goto A017v3v6; 
	fi;
A016v3v6: 
	if 
	:: goto A017v3v6; 
	:: memory[v3] = 3; goto A016v6; 
	fi;
A015v6: 
	if 
	:: v7 = memory[flag1]; goto A016v6; 
	:: memory[v6] = 2; goto A015; 
	fi;
A024v0v3v9: 
	if 
	:: v11 = memory[v10]; goto A025v0v3v9; 
	:: memory[v0] = 1; goto A024v3v9; 
	fi;
A023v3v9: 
	if 
	:: release(_pid); goto A024v3v9; 
	:: memory[v3] = 3; goto A023v9; 
	fi;
A022v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v9; 
	:: memory[v9] = 4; goto A022; 
	fi;
A018v0v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto A019v0v3v6; 
	:: memory[v0] = 1; goto A018v3v6; 
	fi;
A017v3v6: 
	if 
	:: v8 = memory[v7]; goto A018v3v6; 
	:: memory[v3] = 3; goto A017v6; 
	fi;
A016v6: 
	if 
	:: goto A017v6; 
	:: memory[v6] = 2; goto A016; 
	fi;
A015: v7 = memory[flag1]; goto A016; 
A025v0v3v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v0v3v9; 
	:: memory[v0] = 1; goto A025v3v9; 
	fi;
A024v3v9: 
	if 
	:: v11 = memory[v10]; goto A025v3v9; 
	:: memory[v3] = 3; goto A024v9; 
	fi;
A023v9: 
	if 
	:: release(_pid); goto A024v9; 
	:: memory[v9] = 4; goto A023; 
	fi;
A022: acquire(_pid); v10 = memory[flag1]; goto A023; 
A019v0v3v6: 
	if 
	::cmp3 -> goto A020v0v3v6; 
	::!cmp3 -> goto A017v0v3v6; 
	:: memory[v0] = 1; goto A019v3v6; 
	fi;
A018v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto A019v3v6; 
	:: memory[v3] = 3; goto A018v6; 
	fi;
A017v6: 
	if 
	:: v8 = memory[v7]; goto A018v6; 
	:: memory[v6] = 2; goto A017; 
	fi;
A016: goto A017; 
A026v0v3v9: 
	if 
	::cmp7 -> goto A024v0v3v9; 
	::!cmp7 -> goto A027v0v3v9; 
	:: memory[v0] = 1; goto A026v3v9; 
	fi;
A025v3v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v3v9; 
	:: memory[v3] = 3; goto A025v9; 
	fi;
A024v9: 
	if 
	:: v11 = memory[v10]; goto A025v9; 
	:: memory[v9] = 4; goto A024; 
	fi;
A023: release(_pid); goto A024; 
A020v0v3v6: 
	if 
	:: v9 = memory[flag0]; goto A021v0v3v6; 
	:: memory[v0] = 1; goto A020v3v6; 
	fi;
A019v3v6: 
	if 
	::cmp3 -> goto A020v3v6; 
	::!cmp3 -> goto A017v3v6; 
	:: memory[v3] = 3; goto A019v6; 
	fi;
A018v6: 
	if 
	:: cmp3 = (v8 == 4); goto A019v6; 
	:: memory[v6] = 2; goto A018; 
	fi;
A017: v8 = memory[v7]; goto A018; 
A027v0v3v9: 
	if 
	:: v12 = memory[v10]; goto A028v0v3v9; 
	:: memory[v0] = 1; goto A027v3v9; 
	fi;
A026v3v9: 
	if 
	::cmp7 -> goto A024v3v9; 
	::!cmp7 -> goto A027v3v9; 
	:: memory[v3] = 3; goto A026v9; 
	fi;
A025v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v9; 
	:: memory[v9] = 4; goto A025; 
	fi;
A024: v11 = memory[v10]; goto A025; 
A021v0v3v6: 
	if 
	:: goto A022v0v3v6v9; 
	:: memory[v0] = 1; goto A021v3v6; 
	fi;
A020v3v6: 
	if 
	:: v9 = memory[flag0]; goto A021v3v6; 
	:: memory[v3] = 3; goto A020v6; 
	fi;
A019v6: 
	if 
	::cmp3 -> goto A020v6; 
	::!cmp3 -> goto A017v6; 
	:: memory[v6] = 2; goto A019; 
	fi;
A018: cmp3 = (v8 == 4); goto A019; 
A028v0v3v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v0v3v9; 
	:: memory[v0] = 1; goto A028v3v9; 
	fi;
A027v3v9: 
	if 
	:: v12 = memory[v10]; goto A028v3v9; 
	:: memory[v3] = 3; goto A027v9; 
	fi;
A026v9: 
	if 
	::cmp7 -> goto A024v9; 
	::!cmp7 -> goto A027v9; 
	:: memory[v9] = 4; goto A026; 
	fi;
A025: cmp7 = (v11 == 2); goto A026; 
A022v0v3v6v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v0v3v6v9; 
	:: memory[v0] = 1; goto A022v3v6v9; 
	fi;
A021v3v6: 
	if 
	:: goto A022v3v6v9; 
	:: memory[v3] = 3; goto A021v6; 
	fi;
A020v6: 
	if 
	:: v9 = memory[flag0]; goto A021v6; 
	:: memory[v6] = 2; goto A020; 
	fi;
A019: 
	if 
	::cmp3 -> goto A020; 
	::!cmp3 -> goto A017; 
	fi;
A029v0v3v9: 
	if 
	::cmp8 -> goto A024v0v3v9; 
	::!cmp8 -> goto A030v0v3v9; 
	:: memory[v0] = 1; goto A029v3v9; 
	fi;
A028v3v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v3v9; 
	:: memory[v3] = 3; goto A028v9; 
	fi;
A027v9: 
	if 
	:: v12 = memory[v10]; goto A028v9; 
	:: memory[v9] = 4; goto A027; 
	fi;
A026: 
	if 
	::cmp7 -> goto A024; 
	::!cmp7 -> goto A027; 
	fi;
A023v0v3v6v9: 
	if 
	:: release(_pid); goto A024v0v3v6v9; 
	:: memory[v0] = 1; goto A023v3v6v9; 
	fi;
A022v3v6v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v3v6v9; 
	:: memory[v3] = 3; goto A022v6v9; 
	fi;
A021v6: 
	if 
	:: goto A022v6v9; 
	:: memory[v6] = 2; goto A021; 
	fi;
A030v0v3v9: 
	if 
	:: v13 = memory[flag0]; goto A031v0v3v9; 
	:: memory[v0] = 1; goto A030v3v9; 
	fi;
A029v3v9: 
	if 
	::cmp8 -> goto A024v3v9; 
	::!cmp8 -> goto A030v3v9; 
	:: memory[v3] = 3; goto A029v9; 
	fi;
A028v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v9; 
	:: memory[v9] = 4; goto A028; 
	fi;
A027: v12 = memory[v10]; goto A028; 
A024v0v3v6v9: 
	if 
	:: v11 = memory[v10]; goto A025v0v3v6v9; 
	:: memory[v0] = 1; goto A024v3v6v9; 
	fi;
A023v3v6v9: 
	if 
	:: release(_pid); goto A024v3v6v9; 
	:: memory[v3] = 3; goto A023v6v9; 
	fi;
A022v6v9: 
	if 
	:: acquire(_pid); v10 = memory[flag1]; goto A023v6v9; 
	:: memory[v6] = 2; goto A022v9; 
	fi;
A031v0v3v9: 
	if 
	:: goto A032v0v3v9v13; 
	:: memory[v0] = 1; goto A031v3v9; 
	fi;
A030v3v9: 
	if 
	:: v13 = memory[flag0]; goto A031v3v9; 
	:: memory[v3] = 3; goto A030v9; 
	fi;
A029v9: 
	if 
	::cmp8 -> goto A024v9; 
	::!cmp8 -> goto A030v9; 
	:: memory[v9] = 4; goto A029; 
	fi;
A028: cmp8 = (v12 == 3); goto A029; 
A025v0v3v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v0v3v6v9; 
	:: memory[v0] = 1; goto A025v3v6v9; 
	fi;
A024v3v6v9: 
	if 
	:: v11 = memory[v10]; goto A025v3v6v9; 
	:: memory[v3] = 3; goto A024v6v9; 
	fi;
A023v6v9: 
	if 
	:: release(_pid); goto A024v6v9; 
	:: memory[v6] = 2; goto A023v9; 
	fi;
A032v0v3v9v13: memory[v0] = 1; goto A032v3v9v13; 
A031v3v9: 
	if 
	:: goto A032v3v9v13; 
	:: memory[v3] = 3; goto A031v9; 
	fi;
A030v9: 
	if 
	:: v13 = memory[flag0]; goto A031v9; 
	:: memory[v9] = 4; goto A030; 
	fi;
A029: 
	if 
	::cmp8 -> goto A024; 
	::!cmp8 -> goto A030; 
	fi;
A026v0v3v6v9: 
	if 
	::cmp7 -> goto A024v0v3v6v9; 
	::!cmp7 -> goto A027v0v3v6v9; 
	:: memory[v0] = 1; goto A026v3v6v9; 
	fi;
A025v3v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v3v6v9; 
	:: memory[v3] = 3; goto A025v6v9; 
	fi;
A024v6v9: 
	if 
	:: v11 = memory[v10]; goto A025v6v9; 
	:: memory[v6] = 2; goto A024v9; 
	fi;
A032v3v9v13: memory[v3] = 3; goto A032v9v13; 
A031v9: 
	if 
	:: goto A032v9v13; 
	:: memory[v9] = 4; goto A031; 
	fi;
A030: v13 = memory[flag0]; goto A031; 
A027v0v3v6v9: 
	if 
	:: v12 = memory[v10]; goto A028v0v3v6v9; 
	:: memory[v0] = 1; goto A027v3v6v9; 
	fi;
A026v3v6v9: 
	if 
	::cmp7 -> goto A024v3v6v9; 
	::!cmp7 -> goto A027v3v6v9; 
	:: memory[v3] = 3; goto A026v6v9; 
	fi;
A025v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A026v6v9; 
	:: memory[v6] = 2; goto A025v9; 
	fi;
A032v9v13: memory[v9] = 4; goto A032v13; 
A031: goto A032v13; 
A028v0v3v6v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v0v3v6v9; 
	:: memory[v0] = 1; goto A028v3v6v9; 
	fi;
A027v3v6v9: 
	if 
	:: v12 = memory[v10]; goto A028v3v6v9; 
	:: memory[v3] = 3; goto A027v6v9; 
	fi;
A026v6v9: 
	if 
	::cmp7 -> goto A024v6v9; 
	::!cmp7 -> goto A027v6v9; 
	:: memory[v6] = 2; goto A026v9; 
	fi;
A032v13: memory[v13] = 0; goto A032; 
A029v0v3v6v9: 
	if 
	::cmp8 -> goto A024v0v3v6v9; 
	::!cmp8 -> goto A030v0v3v6v9; 
	:: memory[v0] = 1; goto A029v3v6v9; 
	fi;
A028v3v6v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v3v6v9; 
	:: memory[v3] = 3; goto A028v6v9; 
	fi;
A027v6v9: 
	if 
	:: v12 = memory[v10]; goto A028v6v9; 
	:: memory[v6] = 2; goto A027v9; 
	fi;
A032: goto AEnd;
A030v0v3v6v9: 
	if 
	:: v13 = memory[flag0]; goto A031v0v3v6v9; 
	:: memory[v0] = 1; goto A030v3v6v9; 
	fi;
A029v3v6v9: 
	if 
	::cmp8 -> goto A024v3v6v9; 
	::!cmp8 -> goto A030v3v6v9; 
	:: memory[v3] = 3; goto A029v6v9; 
	fi;
A028v6v9: 
	if 
	:: cmp8 = (v12 == 3); goto A029v6v9; 
	:: memory[v6] = 2; goto A028v9; 
	fi;
A031v0v3v6v9: 
	if 
	:: goto A032v0v3v6v9v13; 
	:: memory[v0] = 1; goto A031v3v6v9; 
	fi;
A030v3v6v9: 
	if 
	:: v13 = memory[flag0]; goto A031v3v6v9; 
	:: memory[v3] = 3; goto A030v6v9; 
	fi;
A029v6v9: 
	if 
	::cmp8 -> goto A024v6v9; 
	::!cmp8 -> goto A030v6v9; 
	:: memory[v6] = 2; goto A029v9; 
	fi;
A032v0v3v6v9v13: memory[v0] = 1; goto A032v3v6v9v13; 
A031v3v6v9: 
	if 
	:: goto A032v3v6v9v13; 
	:: memory[v3] = 3; goto A031v6v9; 
	fi;
A030v6v9: 
	if 
	:: v13 = memory[flag0]; goto A031v6v9; 
	:: memory[v6] = 2; goto A030v9; 
	fi;
A032v3v6v9v13: memory[v3] = 3; goto A032v6v9v13; 
A031v6v9: 
	if 
	:: goto A032v6v9v13; 
	:: memory[v6] = 2; goto A031v9; 
	fi;
A032v6v9v13: memory[v6] = 2; goto A032v9v13; 
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B000;
B000: v0 = memory[flag1]; goto B001; 
B001: goto B002v0; 
B002v0: 
	if 
	:: v1 = memory[flag0]; goto B003v0; 
	:: memory[v0] = 1; goto B002; 
	fi;
B003v0: 
	if 
	:: goto B004v0; 
	:: memory[v0] = 1; goto B003; 
	fi;
B002: v1 = memory[flag0]; goto B003; 
B004v0: 
	if 
	:: v2 = memory[v1]; goto B005v0; 
	:: memory[v0] = 1; goto B004; 
	fi;
B003: goto B004; 
B005v0: 
	if 
	:: cmp = (v2 > 2); goto B006v0; 
	:: memory[v0] = 1; goto B005; 
	fi;
B004: v2 = memory[v1]; goto B005; 
B006v0: 
	if 
	::cmp -> goto B004v0; 
	::!cmp -> goto B007v0; 
	:: memory[v0] = 1; goto B006; 
	fi;
B005: cmp = (v2 > 2); goto B006; 
B007v0: 
	if 
	:: v3 = memory[flag1]; goto B008v0; 
	:: memory[v0] = 1; goto B007; 
	fi;
B006: 
	if 
	::cmp -> goto B004; 
	::!cmp -> goto B007; 
	fi;
B008v0: 
	if 
	:: goto B009v0v3; 
	:: memory[v0] = 1; goto B008; 
	fi;
B007: v3 = memory[flag1]; goto B008; 
B009v0v3: 
	if 
	:: v4 = memory[flag0]; goto B010v0v3; 
	:: memory[v0] = 1; goto B009v3; 
	fi;
B008: goto B009v3; 
B010v0v3: 
	if 
	:: v5 = memory[v4]; goto B011v0v3; 
	:: memory[v0] = 1; goto B010v3; 
	fi;
B009v3: 
	if 
	:: v4 = memory[flag0]; goto B010v3; 
	:: memory[v3] = 3; goto B009; 
	fi;
B011v0v3: 
	if 
	:: cmp1 = (v5 == 1); goto B012v0v3; 
	:: memory[v0] = 1; goto B011v3; 
	fi;
B010v3: 
	if 
	:: v5 = memory[v4]; goto B011v3; 
	:: memory[v3] = 3; goto B010; 
	fi;
B009: v4 = memory[flag0]; goto B010; 
B012v0v3: 
	if 
	::cmp1 -> goto B013v0v3; 
	::!cmp1 -> goto B020v0v3; 
	:: memory[v0] = 1; goto B012v3; 
	fi;
B011v3: 
	if 
	:: cmp1 = (v5 == 1); goto B012v3; 
	:: memory[v3] = 3; goto B011; 
	fi;
B010: v5 = memory[v4]; goto B011; 
B013v0v3: 
	if 
	:: v6 = memory[flag1]; goto B014v0v3; 
	:: memory[v0] = 1; goto B013v3; 
	fi;
B020v0v3: 
	if 
	:: v9 = memory[flag1]; goto B021v0v3; 
	:: memory[v0] = 1; goto B020v3; 
	fi;
B012v3: 
	if 
	::cmp1 -> goto B013v3; 
	::!cmp1 -> goto B020v3; 
	:: memory[v3] = 3; goto B012; 
	fi;
B011: cmp1 = (v5 == 1); goto B012; 
B014v0v3: 
	if 
	:: goto B015v0v3v6; 
	:: memory[v0] = 1; goto B014v3; 
	fi;
B013v3: 
	if 
	:: v6 = memory[flag1]; goto B014v3; 
	:: memory[v3] = 3; goto B013; 
	fi;
B021v0v3: 
	if 
	:: goto B022v0v3v9; 
	:: memory[v0] = 1; goto B021v3; 
	fi;
B020v3: 
	if 
	:: v9 = memory[flag1]; goto B021v3; 
	:: memory[v3] = 3; goto B020; 
	fi;
B012: 
	if 
	::cmp1 -> goto B013; 
	::!cmp1 -> goto B020; 
	fi;
B015v0v3v6: 
	if 
	:: v7 = memory[flag0]; goto B016v0v3v6; 
	:: memory[v0] = 1; goto B015v3v6; 
	fi;
B014v3: 
	if 
	:: goto B015v3v6; 
	:: memory[v3] = 3; goto B014; 
	fi;
B013: v6 = memory[flag1]; goto B014; 
B022v0v3v9: 
	if 
	:: v10 = memory[flag0]; goto B023v0v3v9; 
	:: memory[v0] = 1; goto B022v3v9; 
	fi;
B021v3: 
	if 
	:: goto B022v3v9; 
	:: memory[v3] = 3; goto B021; 
	fi;
B020: v9 = memory[flag1]; goto B021; 
B016v0v3v6: 
	if 
	:: goto B017v0v3v6; 
	:: memory[v0] = 1; goto B016v3v6; 
	fi;
B015v3v6: 
	if 
	:: v7 = memory[flag0]; goto B016v3v6; 
	:: memory[v3] = 3; goto B015v6; 
	fi;
B014: goto B015v6; 
B023v0v3v9: 
	if 
	:: goto B024v0v3v9; 
	:: memory[v0] = 1; goto B023v3v9; 
	fi;
B022v3v9: 
	if 
	:: v10 = memory[flag0]; goto B023v3v9; 
	:: memory[v3] = 3; goto B022v9; 
	fi;
B021: goto B022v9; 
B017v0v3v6: 
	if 
	:: v8 = memory[v7]; goto B018v0v3v6; 
	:: memory[v0] = 1; goto B017v3v6; 
	fi;
B016v3v6: 
	if 
	:: goto B017v3v6; 
	:: memory[v3] = 3; goto B016v6; 
	fi;
B015v6: 
	if 
	:: v7 = memory[flag0]; goto B016v6; 
	:: memory[v6] = 2; goto B015; 
	fi;
B024v0v3v9: 
	if 
	:: v11 = memory[v10]; goto B025v0v3v9; 
	:: memory[v0] = 1; goto B024v3v9; 
	fi;
B023v3v9: 
	if 
	:: goto B024v3v9; 
	:: memory[v3] = 3; goto B023v9; 
	fi;
B022v9: 
	if 
	:: v10 = memory[flag0]; goto B023v9; 
	:: memory[v9] = 4; goto B022; 
	fi;
B018v0v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto B019v0v3v6; 
	:: memory[v0] = 1; goto B018v3v6; 
	fi;
B017v3v6: 
	if 
	:: v8 = memory[v7]; goto B018v3v6; 
	:: memory[v3] = 3; goto B017v6; 
	fi;
B016v6: 
	if 
	:: goto B017v6; 
	:: memory[v6] = 2; goto B016; 
	fi;
B015: v7 = memory[flag0]; goto B016; 
B025v0v3v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v0v3v9; 
	:: memory[v0] = 1; goto B025v3v9; 
	fi;
B024v3v9: 
	if 
	:: v11 = memory[v10]; goto B025v3v9; 
	:: memory[v3] = 3; goto B024v9; 
	fi;
B023v9: 
	if 
	:: goto B024v9; 
	:: memory[v9] = 4; goto B023; 
	fi;
B022: v10 = memory[flag0]; goto B023; 
B019v0v3v6: 
	if 
	::cmp3 -> goto B020v0v3v6; 
	::!cmp3 -> goto B017v0v3v6; 
	:: memory[v0] = 1; goto B019v3v6; 
	fi;
B018v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto B019v3v6; 
	:: memory[v3] = 3; goto B018v6; 
	fi;
B017v6: 
	if 
	:: v8 = memory[v7]; goto B018v6; 
	:: memory[v6] = 2; goto B017; 
	fi;
B016: goto B017; 
B026v0v3v9: 
	if 
	::cmp7 -> goto B024v0v3v9; 
	::!cmp7 -> acquire(_pid); goto B027v0v3v9; 
	:: memory[v0] = 1; goto B026v3v9; 
	fi;
B025v3v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v3v9; 
	:: memory[v3] = 3; goto B025v9; 
	fi;
B024v9: 
	if 
	:: v11 = memory[v10]; goto B025v9; 
	:: memory[v9] = 4; goto B024; 
	fi;
B023: goto B024; 
B020v0v3v6: 
	if 
	:: v9 = memory[flag1]; goto B021v0v3v6; 
	:: memory[v0] = 1; goto B020v3v6; 
	fi;
B019v3v6: 
	if 
	::cmp3 -> goto B020v3v6; 
	::!cmp3 -> goto B017v3v6; 
	:: memory[v3] = 3; goto B019v6; 
	fi;
B018v6: 
	if 
	:: cmp3 = (v8 == 4); goto B019v6; 
	:: memory[v6] = 2; goto B018; 
	fi;
B017: v8 = memory[v7]; goto B018; 
B027v0v3v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v0v3v9; 
	:: memory[v0] = 1; goto B027v3v9; 
	fi;
B026v3v9: 
	if 
	::cmp7 -> goto B024v3v9; 
	::!cmp7 -> acquire(_pid); goto B027v3v9; 
	:: memory[v3] = 3; goto B026v9; 
	fi;
B025v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v9; 
	:: memory[v9] = 4; goto B025; 
	fi;
B024: v11 = memory[v10]; goto B025; 
B021v0v3v6: 
	if 
	:: goto B022v0v3v6v9; 
	:: memory[v0] = 1; goto B021v3v6; 
	fi;
B020v3v6: 
	if 
	:: v9 = memory[flag1]; goto B021v3v6; 
	:: memory[v3] = 3; goto B020v6; 
	fi;
B019v6: 
	if 
	::cmp3 -> goto B020v6; 
	::!cmp3 -> goto B017v6; 
	:: memory[v6] = 2; goto B019; 
	fi;
B018: cmp3 = (v8 == 4); goto B019; 
B028v0v3v9: 
	if 
	:: goto B029v0v3v9v12; 
	:: memory[v0] = 1; goto B028v3v9; 
	fi;
B027v3v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v3v9; 
	:: memory[v3] = 3; goto B027v9; 
	fi;
B026v9: 
	if 
	::cmp7 -> goto B024v9; 
	::!cmp7 -> acquire(_pid); goto B027v9; 
	:: memory[v9] = 4; goto B026; 
	fi;
B025: cmp7 = (v11 > 1); goto B026; 
B022v0v3v6v9: 
	if 
	:: v10 = memory[flag0]; goto B023v0v3v6v9; 
	:: memory[v0] = 1; goto B022v3v6v9; 
	fi;
B021v3v6: 
	if 
	:: goto B022v3v6v9; 
	:: memory[v3] = 3; goto B021v6; 
	fi;
B020v6: 
	if 
	:: v9 = memory[flag1]; goto B021v6; 
	:: memory[v6] = 2; goto B020; 
	fi;
B019: 
	if 
	::cmp3 -> goto B020; 
	::!cmp3 -> goto B017; 
	fi;
B029v0v3v9v12: memory[v0] = 1; goto B029v3v9v12; 
B028v3v9: 
	if 
	:: goto B029v3v9v12; 
	:: memory[v3] = 3; goto B028v9; 
	fi;
B027v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v9; 
	:: memory[v9] = 4; goto B027; 
	fi;
B026: 
	if 
	::cmp7 -> goto B024; 
	::!cmp7 -> acquire(_pid); goto B027; 
	fi;
B023v0v3v6v9: 
	if 
	:: goto B024v0v3v6v9; 
	:: memory[v0] = 1; goto B023v3v6v9; 
	fi;
B022v3v6v9: 
	if 
	:: v10 = memory[flag0]; goto B023v3v6v9; 
	:: memory[v3] = 3; goto B022v6v9; 
	fi;
B021v6: 
	if 
	:: goto B022v6v9; 
	:: memory[v6] = 2; goto B021; 
	fi;
B029v3v9v12: memory[v3] = 3; goto B029v9v12; 
B028v9: 
	if 
	:: goto B029v9v12; 
	:: memory[v9] = 4; goto B028; 
	fi;
B027: release(_pid); v12 = memory[flag1]; goto B028; 
B024v0v3v6v9: 
	if 
	:: v11 = memory[v10]; goto B025v0v3v6v9; 
	:: memory[v0] = 1; goto B024v3v6v9; 
	fi;
B023v3v6v9: 
	if 
	:: goto B024v3v6v9; 
	:: memory[v3] = 3; goto B023v6v9; 
	fi;
B022v6v9: 
	if 
	:: v10 = memory[flag0]; goto B023v6v9; 
	:: memory[v6] = 2; goto B022v9; 
	fi;
B029v9v12: memory[v9] = 4; goto B029v12; 
B028: goto B029v12; 
B025v0v3v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v0v3v6v9; 
	:: memory[v0] = 1; goto B025v3v6v9; 
	fi;
B024v3v6v9: 
	if 
	:: v11 = memory[v10]; goto B025v3v6v9; 
	:: memory[v3] = 3; goto B024v6v9; 
	fi;
B023v6v9: 
	if 
	:: goto B024v6v9; 
	:: memory[v6] = 2; goto B023v9; 
	fi;
B029v12: memory[v12] = 0; goto B029; 
B026v0v3v6v9: 
	if 
	::cmp7 -> goto B024v0v3v6v9; 
	::!cmp7 -> acquire(_pid); goto B027v0v3v6v9; 
	:: memory[v0] = 1; goto B026v3v6v9; 
	fi;
B025v3v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v3v6v9; 
	:: memory[v3] = 3; goto B025v6v9; 
	fi;
B024v6v9: 
	if 
	:: v11 = memory[v10]; goto B025v6v9; 
	:: memory[v6] = 2; goto B024v9; 
	fi;
B029: goto BEnd;
B027v0v3v6v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v0v3v6v9; 
	:: memory[v0] = 1; goto B027v3v6v9; 
	fi;
B026v3v6v9: 
	if 
	::cmp7 -> goto B024v3v6v9; 
	::!cmp7 -> acquire(_pid); goto B027v3v6v9; 
	:: memory[v3] = 3; goto B026v6v9; 
	fi;
B025v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B026v6v9; 
	:: memory[v6] = 2; goto B025v9; 
	fi;
B028v0v3v6v9: 
	if 
	:: goto B029v0v3v6v9v12; 
	:: memory[v0] = 1; goto B028v3v6v9; 
	fi;
B027v3v6v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v3v6v9; 
	:: memory[v3] = 3; goto B027v6v9; 
	fi;
B026v6v9: 
	if 
	::cmp7 -> goto B024v6v9; 
	::!cmp7 -> acquire(_pid); goto B027v6v9; 
	:: memory[v6] = 2; goto B026v9; 
	fi;
B029v0v3v6v9v12: memory[v0] = 1; goto B029v3v6v9v12; 
B028v3v6v9: 
	if 
	:: goto B029v3v6v9v12; 
	:: memory[v3] = 3; goto B028v6v9; 
	fi;
B027v6v9: 
	if 
	:: release(_pid); v12 = memory[flag1]; goto B028v6v9; 
	:: memory[v6] = 2; goto B027v9; 
	fi;
B029v3v6v9v12: memory[v3] = 3; goto B029v6v9v12; 
B028v6v9: 
	if 
	:: goto B029v6v9v12; 
	:: memory[v6] = 2; goto B028v9; 
	fi;
B029v6v9v12: memory[v6] = 2; goto B029v9v12; 
BEnd: skip;

}



//Stubs
proctype process1(){
	proc0();
}

proctype process2(){
	proc1();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	//two layers of pointers need initialization
	memory[flag0] = 3;
	memory[flag1] = 4;

	run process1();
	run process2();
	}
}
ltl prop{ [] !((process1@A023v0v3v6v9 
|| process1@A023v3v6v9 || process1@A023v0v3v9 
|| process1@A023v6v9 || process1@A023v3v9 
|| process1@A023v9 || process1@A023    
)  
&& (
process2@B027v0v3v6v9 
|| process2@B027v3v6v9 || process2@B027v0v3v9 
|| process2@B027v6v9 || process2@B027v3v9  
|| process2@B027v9 || process2@B027 
))}
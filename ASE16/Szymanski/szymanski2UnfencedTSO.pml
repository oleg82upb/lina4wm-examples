#define MEM_SIZE 15	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory


short flag = zeroinitializer;
short flag0 = null;
short flag1 = null;


//standard stuff
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}



inline proc0(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v14, cmp8, v12, v13, v15;
AStart: goto A000;
A000: goto A001; 
A001: v0 = memory[flag0]; goto A002; 
A002: goto A003v0; 
A003v0: 
	if 
	:: goto A004v0; 
	:: memory[v0] = 1; goto A003; 
	fi;
A004v0: 
	if 
	:: v1 = memory[flag1]; goto A005v0; 
	:: memory[v0] = 1; goto A004; 
	fi;
A003: goto A004; 
A005v0: 
	if 
	:: v2 = memory[v1]; goto A006v0; 
	:: memory[v0] = 1; goto A005; 
	fi;
A004: v1 = memory[flag1]; goto A005; 
A006v0: 
	if 
	:: cmp = (v2 > 2); goto A007v0; 
	:: memory[v0] = 1; goto A006; 
	fi;
A005: v2 = memory[v1]; goto A006; 
A007v0: 
	if 
	::cmp -> goto A008v0; 
	::!cmp -> goto A009v0; 
	:: memory[v0] = 1; goto A007; 
	fi;
A006: cmp = (v2 > 2); goto A007; 
A008v0: 
	if 
	:: goto A004v0; 
	:: memory[v0] = 1; goto A008; 
	fi;
A009v0: 
	if 
	:: v3 = memory[flag0]; goto A010v0; 
	:: memory[v0] = 1; goto A009; 
	fi;
A007: 
	if 
	::cmp -> goto A008; 
	::!cmp -> goto A009; 
	fi;
A008: goto A004; 
A010v0: 
	if 
	:: goto A011v0v3; 
	:: memory[v0] = 1; goto A010; 
	fi;
A009: v3 = memory[flag0]; goto A010; 
A011v0v3: 
	if 
	:: v4 = memory[flag1]; goto A012v0v3; 
	:: memory[v0] = 1; goto A011v3; 
	fi;
A010: goto A011v3; 
A012v0v3: 
	if 
	:: v5 = memory[v4]; goto A013v0v3; 
	:: memory[v0] = 1; goto A012v3; 
	fi;
A011v3: 
	if 
	:: v4 = memory[flag1]; goto A012v3; 
	:: memory[v3] = 3; goto A011; 
	fi;
A013v0v3: 
	if 
	:: cmp1 = (v5 == 1); goto A014v0v3; 
	:: memory[v0] = 1; goto A013v3; 
	fi;
A012v3: 
	if 
	:: v5 = memory[v4]; goto A013v3; 
	:: memory[v3] = 3; goto A012; 
	fi;
A011: v4 = memory[flag1]; goto A012; 
A014v0v3: 
	if 
	::cmp1 -> goto A015v0v3; 
	::!cmp1 -> goto A024v0v3; 
	:: memory[v0] = 1; goto A014v3; 
	fi;
A013v3: 
	if 
	:: cmp1 = (v5 == 1); goto A014v3; 
	:: memory[v3] = 3; goto A013; 
	fi;
A012: v5 = memory[v4]; goto A013; 
A015v0v3: 
	if 
	:: v6 = memory[flag0]; goto A016v0v3; 
	:: memory[v0] = 1; goto A015v3; 
	fi;
A024v0v3: 
	if 
	:: v9 = memory[flag0]; goto A025v0v3; 
	:: memory[v0] = 1; goto A024v3; 
	fi;
A014v3: 
	if 
	::cmp1 -> goto A015v3; 
	::!cmp1 -> goto A024v3; 
	:: memory[v3] = 3; goto A014; 
	fi;
A013: cmp1 = (v5 == 1); goto A014; 
A016v0v3: 
	if 
	:: goto A017v0v3v6; 
	:: memory[v0] = 1; goto A016v3; 
	fi;
A015v3: 
	if 
	:: v6 = memory[flag0]; goto A016v3; 
	:: memory[v3] = 3; goto A015; 
	fi;
A025v0v3: 
	if 
	:: goto A026v0v3v9; 
	:: memory[v0] = 1; goto A025v3; 
	fi;
A024v3: 
	if 
	:: v9 = memory[flag0]; goto A025v3; 
	:: memory[v3] = 3; goto A024; 
	fi;
A014: 
	if 
	::cmp1 -> goto A015; 
	::!cmp1 -> goto A024; 
	fi;
A017v0v3v6: 
	if 
	:: goto A018v0v3v6; 
	:: memory[v0] = 1; goto A017v3v6; 
	fi;
A016v3: 
	if 
	:: goto A017v3v6; 
	:: memory[v3] = 3; goto A016; 
	fi;
A015: v6 = memory[flag0]; goto A016; 
A026v0v3v9: 
	if 
	:: goto A027v0v3v9; 
	:: memory[v0] = 1; goto A026v3v9; 
	fi;
A025v3: 
	if 
	:: goto A026v3v9; 
	:: memory[v3] = 3; goto A025; 
	fi;
A024: v9 = memory[flag0]; goto A025; 
A018v0v3v6: 
	if 
	:: v7 = memory[flag1]; goto A019v0v3v6; 
	:: memory[v0] = 1; goto A018v3v6; 
	fi;
A017v3v6: 
	if 
	:: goto A018v3v6; 
	:: memory[v3] = 3; goto A017v6; 
	fi;
A016: goto A017v6; 
A027v0v3v9: 
	if 
	:: v10 = memory[flag1]; goto A028v0v3v9; 
	:: memory[v0] = 1; goto A027v3v9; 
	fi;
A026v3v9: 
	if 
	:: goto A027v3v9; 
	:: memory[v3] = 3; goto A026v9; 
	fi;
A025: goto A026v9; 
A019v0v3v6: 
	if 
	:: v8 = memory[v7]; goto A020v0v3v6; 
	:: memory[v0] = 1; goto A019v3v6; 
	fi;
A018v3v6: 
	if 
	:: v7 = memory[flag1]; goto A019v3v6; 
	:: memory[v3] = 3; goto A018v6; 
	fi;
A017v6: 
	if 
	:: goto A018v6; 
	:: memory[v6] = 2; goto A017; 
	fi;
A028v0v3v9: 
	if 
	:: v11 = memory[v10]; goto A029v0v3v9; 
	:: memory[v0] = 1; goto A028v3v9; 
	fi;
A027v3v9: 
	if 
	:: v10 = memory[flag1]; goto A028v3v9; 
	:: memory[v3] = 3; goto A027v9; 
	fi;
A026v9: 
	if 
	:: goto A027v9; 
	:: memory[v9] = 4; goto A026; 
	fi;
A020v0v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto A021v0v3v6; 
	:: memory[v0] = 1; goto A020v3v6; 
	fi;
A019v3v6: 
	if 
	:: v8 = memory[v7]; goto A020v3v6; 
	:: memory[v3] = 3; goto A019v6; 
	fi;
A018v6: 
	if 
	:: v7 = memory[flag1]; goto A019v6; 
	:: memory[v6] = 2; goto A018; 
	fi;
A017: goto A018; 
A029v0v3v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v0v3v9; 
	:: memory[v0] = 1; goto A029v3v9; 
	fi;
A028v3v9: 
	if 
	:: v11 = memory[v10]; goto A029v3v9; 
	:: memory[v3] = 3; goto A028v9; 
	fi;
A027v9: 
	if 
	:: v10 = memory[flag1]; goto A028v9; 
	:: memory[v9] = 4; goto A027; 
	fi;
A026: goto A027; 
A021v0v3v6: 
	if 
	::cmp3 -> goto A022v0v3v6; 
	::!cmp3 -> goto A023v0v3v6; 
	:: memory[v0] = 1; goto A021v3v6; 
	fi;
A020v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto A021v3v6; 
	:: memory[v3] = 3; goto A020v6; 
	fi;
A019v6: 
	if 
	:: v8 = memory[v7]; goto A020v6; 
	:: memory[v6] = 2; goto A019; 
	fi;
A018: v7 = memory[flag1]; goto A019; 
A030v0v3v9: 
	if 
	::cmp7 -> v14 = true; goto A035v0v3v9; 
	::!cmp7 -> goto A031v0v3v9; 
	:: memory[v0] = 1; goto A030v3v9; 
	fi;
A029v3v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v3v9; 
	:: memory[v3] = 3; goto A029v9; 
	fi;
A028v9: 
	if 
	:: v11 = memory[v10]; goto A029v9; 
	:: memory[v9] = 4; goto A028; 
	fi;
A027: v10 = memory[flag1]; goto A028; 
A022v0v3v6: 
	if 
	:: goto A018v0v3v6; 
	:: memory[v0] = 1; goto A022v3v6; 
	fi;
A023v0v3v6: 
	if 
	:: goto A024v0v3v6; 
	:: memory[v0] = 1; goto A023v3v6; 
	fi;
A021v3v6: 
	if 
	::cmp3 -> goto A022v3v6; 
	::!cmp3 -> goto A023v3v6; 
	:: memory[v3] = 3; goto A021v6; 
	fi;
A020v6: 
	if 
	:: cmp3 = (v8 == 4); goto A021v6; 
	:: memory[v6] = 2; goto A020; 
	fi;
A019: v8 = memory[v7]; goto A020; 
A035v0v3v9: 
	if 
	:: goto A036v0v3v9; 
	:: memory[v0] = 1; goto A035v3v9; 
	fi;
A031v0v3v9: 
	if 
	:: v12 = memory[flag1]; goto A032v0v3v9; 
	:: memory[v0] = 1; goto A031v3v9; 
	fi;
A030v3v9: 
	if 
	::cmp7 -> v14 = true; goto A035v3v9; 
	::!cmp7 -> goto A031v3v9; 
	:: memory[v3] = 3; goto A030v9; 
	fi;
A029v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v9; 
	:: memory[v9] = 4; goto A029; 
	fi;
A028: v11 = memory[v10]; goto A029; 
A022v3v6: 
	if 
	:: goto A018v3v6; 
	:: memory[v3] = 3; goto A022v6; 
	fi;
A024v0v3v6: 
	if 
	:: v9 = memory[flag0]; goto A025v0v3v6; 
	:: memory[v0] = 1; goto A024v3v6; 
	fi;
A023v3v6: 
	if 
	:: goto A024v3v6; 
	:: memory[v3] = 3; goto A023v6; 
	fi;
A021v6: 
	if 
	::cmp3 -> goto A022v6; 
	::!cmp3 -> goto A023v6; 
	:: memory[v6] = 2; goto A021; 
	fi;
A020: cmp3 = (v8 == 4); goto A021; 
A036v0v3v9: 
	if 
	::v14 -> goto A037v0v3v9; 
	::!v14 -> goto A038v0v3v9; 
	:: memory[v0] = 1; goto A036v3v9; 
	fi;
A035v3v9: 
	if 
	:: goto A036v3v9; 
	:: memory[v3] = 3; goto A035v9; 
	fi;
A032v0v3v9: 
	if 
	:: v13 = memory[v12]; goto A033v0v3v9; 
	:: memory[v0] = 1; goto A032v3v9; 
	fi;
A031v3v9: 
	if 
	:: v12 = memory[flag1]; goto A032v3v9; 
	:: memory[v3] = 3; goto A031v9; 
	fi;
A030v9: 
	if 
	::cmp7 -> v14 = true; goto A035v9; 
	::!cmp7 -> goto A031v9; 
	:: memory[v9] = 4; goto A030; 
	fi;
A029: cmp7 = (v11 == 2); goto A030; 
A022v6: 
	if 
	:: goto A018v6; 
	:: memory[v6] = 2; goto A022; 
	fi;
A025v0v3v6: 
	if 
	:: goto A026v0v3v6v9; 
	:: memory[v0] = 1; goto A025v3v6; 
	fi;
A024v3v6: 
	if 
	:: v9 = memory[flag0]; goto A025v3v6; 
	:: memory[v3] = 3; goto A024v6; 
	fi;
A023v6: 
	if 
	:: goto A024v6; 
	:: memory[v6] = 2; goto A023; 
	fi;
A021: 
	if 
	::cmp3 -> goto A022; 
	::!cmp3 -> goto A023; 
	fi;
A037v0v3v9: 
	if 
	:: goto A027v0v3v9; 
	:: memory[v0] = 1; goto A037v3v9; 
	fi;
A038v0v3v9: 
	if 
	:: v15 = memory[flag0]; goto A039v0v3v9; 
	:: memory[v0] = 1; goto A038v3v9; 
	fi;
A036v3v9: 
	if 
	::v14 -> goto A037v3v9; 
	::!v14 -> goto A038v3v9; 
	:: memory[v3] = 3; goto A036v9; 
	fi;
A035v9: 
	if 
	:: goto A036v9; 
	:: memory[v9] = 4; goto A035; 
	fi;
A033v0v3v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v0v3v9; 
	:: memory[v0] = 1; goto A033v3v9; 
	fi;
A032v3v9: 
	if 
	:: v13 = memory[v12]; goto A033v3v9; 
	:: memory[v3] = 3; goto A032v9; 
	fi;
A031v9: 
	if 
	:: v12 = memory[flag1]; goto A032v9; 
	:: memory[v9] = 4; goto A031; 
	fi;
A030: 
	if 
	::cmp7 -> v14 = true; goto A035; 
	::!cmp7 -> goto A031; 
	fi;
A022: goto A018; 
A026v0v3v6v9: 
	if 
	:: goto A027v0v3v6v9; 
	:: memory[v0] = 1; goto A026v3v6v9; 
	fi;
A025v3v6: 
	if 
	:: goto A026v3v6v9; 
	:: memory[v3] = 3; goto A025v6; 
	fi;
A024v6: 
	if 
	:: v9 = memory[flag0]; goto A025v6; 
	:: memory[v6] = 2; goto A024; 
	fi;
A023: goto A024; 
A037v3v9: 
	if 
	:: goto A027v3v9; 
	:: memory[v3] = 3; goto A037v9; 
	fi;
A039v0v3v9: 
	if 
	:: goto A040v0v3v9v15; 
	:: memory[v0] = 1; goto A039v3v9; 
	fi;
A038v3v9: 
	if 
	:: v15 = memory[flag0]; goto A039v3v9; 
	:: memory[v3] = 3; goto A038v9; 
	fi;
A036v9: 
	if 
	::v14 -> goto A037v9; 
	::!v14 -> goto A038v9; 
	:: memory[v9] = 4; goto A036; 
	fi;
A035: goto A036; 
A034v0v3v9: 
	if 
	:: v14 = cmp8; goto A035v0v3v9; 
	:: memory[v0] = 1; goto A034v3v9; 
	fi;
A033v3v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v3v9; 
	:: memory[v3] = 3; goto A033v9; 
	fi;
A032v9: 
	if 
	:: v13 = memory[v12]; goto A033v9; 
	:: memory[v9] = 4; goto A032; 
	fi;
A031: v12 = memory[flag1]; goto A032; 
A027v0v3v6v9: 
	if 
	:: v10 = memory[flag1]; goto A028v0v3v6v9; 
	:: memory[v0] = 1; goto A027v3v6v9; 
	fi;
A026v3v6v9: 
	if 
	:: goto A027v3v6v9; 
	:: memory[v3] = 3; goto A026v6v9; 
	fi;
A025v6: 
	if 
	:: goto A026v6v9; 
	:: memory[v6] = 2; goto A025; 
	fi;
A037v9: 
	if 
	:: goto A027v9; 
	:: memory[v9] = 4; goto A037; 
	fi;
A040v0v3v9v15: memory[v0] = 1; goto A040v3v9v15; 
A039v3v9: 
	if 
	:: goto A040v3v9v15; 
	:: memory[v3] = 3; goto A039v9; 
	fi;
A038v9: 
	if 
	:: v15 = memory[flag0]; goto A039v9; 
	:: memory[v9] = 4; goto A038; 
	fi;
A036: 
	if 
	::v14 -> goto A037; 
	::!v14 -> goto A038; 
	fi;
A034v3v9: 
	if 
	:: v14 = cmp8; goto A035v3v9; 
	:: memory[v3] = 3; goto A034v9; 
	fi;
A033v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v9; 
	:: memory[v9] = 4; goto A033; 
	fi;
A032: v13 = memory[v12]; goto A033; 
A028v0v3v6v9: 
	if 
	:: v11 = memory[v10]; goto A029v0v3v6v9; 
	:: memory[v0] = 1; goto A028v3v6v9; 
	fi;
A027v3v6v9: 
	if 
	:: v10 = memory[flag1]; goto A028v3v6v9; 
	:: memory[v3] = 3; goto A027v6v9; 
	fi;
A026v6v9: 
	if 
	:: goto A027v6v9; 
	:: memory[v6] = 2; goto A026v9; 
	fi;
A037: goto A027; 
A040v3v9v15: memory[v3] = 3; goto A040v9v15; 
A039v9: 
	if 
	:: goto A040v9v15; 
	:: memory[v9] = 4; goto A039; 
	fi;
A038: v15 = memory[flag0]; goto A039; 
A034v9: 
	if 
	:: v14 = cmp8; goto A035v9; 
	:: memory[v9] = 4; goto A034; 
	fi;
A033: cmp8 = (v13 == 3); goto A034; 
A029v0v3v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v0v3v6v9; 
	:: memory[v0] = 1; goto A029v3v6v9; 
	fi;
A028v3v6v9: 
	if 
	:: v11 = memory[v10]; goto A029v3v6v9; 
	:: memory[v3] = 3; goto A028v6v9; 
	fi;
A027v6v9: 
	if 
	:: v10 = memory[flag1]; goto A028v6v9; 
	:: memory[v6] = 2; goto A027v9; 
	fi;
A040v9v15: memory[v9] = 4; goto A040v15; 
A039: goto A040v15; 
A034: v14 = cmp8; goto A035; 
A030v0v3v6v9: 
	if 
	::cmp7 -> v14 = true; goto A035v0v3v6v9; 
	::!cmp7 -> goto A031v0v3v6v9; 
	:: memory[v0] = 1; goto A030v3v6v9; 
	fi;
A029v3v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v3v6v9; 
	:: memory[v3] = 3; goto A029v6v9; 
	fi;
A028v6v9: 
	if 
	:: v11 = memory[v10]; goto A029v6v9; 
	:: memory[v6] = 2; goto A028v9; 
	fi;
A040v15: memory[v15] = 0; goto A040; 
A035v0v3v6v9: 
	if 
	:: goto A036v0v3v6v9; 
	:: memory[v0] = 1; goto A035v3v6v9; 
	fi;
A031v0v3v6v9: 
	if 
	:: v12 = memory[flag1]; goto A032v0v3v6v9; 
	:: memory[v0] = 1; goto A031v3v6v9; 
	fi;
A030v3v6v9: 
	if 
	::cmp7 -> v14 = true; goto A035v3v6v9; 
	::!cmp7 -> goto A031v3v6v9; 
	:: memory[v3] = 3; goto A030v6v9; 
	fi;
A029v6v9: 
	if 
	:: cmp7 = (v11 == 2); goto A030v6v9; 
	:: memory[v6] = 2; goto A029v9; 
	fi;
A040: goto AEnd;
A036v0v3v6v9: 
	if 
	::v14 -> goto A037v0v3v6v9; 
	::!v14 -> goto A038v0v3v6v9; 
	:: memory[v0] = 1; goto A036v3v6v9; 
	fi;
A035v3v6v9: 
	if 
	:: goto A036v3v6v9; 
	:: memory[v3] = 3; goto A035v6v9; 
	fi;
A032v0v3v6v9: 
	if 
	:: v13 = memory[v12]; goto A033v0v3v6v9; 
	:: memory[v0] = 1; goto A032v3v6v9; 
	fi;
A031v3v6v9: 
	if 
	:: v12 = memory[flag1]; goto A032v3v6v9; 
	:: memory[v3] = 3; goto A031v6v9; 
	fi;
A030v6v9: 
	if 
	::cmp7 -> v14 = true; goto A035v6v9; 
	::!cmp7 -> goto A031v6v9; 
	:: memory[v6] = 2; goto A030v9; 
	fi;
A037v0v3v6v9: 
	if 
	:: goto A027v0v3v6v9; 
	:: memory[v0] = 1; goto A037v3v6v9; 
	fi;
A038v0v3v6v9: 
	if 
	:: v15 = memory[flag0]; goto A039v0v3v6v9; 
	:: memory[v0] = 1; goto A038v3v6v9; 
	fi;
A036v3v6v9: 
	if 
	::v14 -> goto A037v3v6v9; 
	::!v14 -> goto A038v3v6v9; 
	:: memory[v3] = 3; goto A036v6v9; 
	fi;
A035v6v9: 
	if 
	:: goto A036v6v9; 
	:: memory[v6] = 2; goto A035v9; 
	fi;
A033v0v3v6v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v0v3v6v9; 
	:: memory[v0] = 1; goto A033v3v6v9; 
	fi;
A032v3v6v9: 
	if 
	:: v13 = memory[v12]; goto A033v3v6v9; 
	:: memory[v3] = 3; goto A032v6v9; 
	fi;
A031v6v9: 
	if 
	:: v12 = memory[flag1]; goto A032v6v9; 
	:: memory[v6] = 2; goto A031v9; 
	fi;
A037v3v6v9: 
	if 
	:: goto A027v3v6v9; 
	:: memory[v3] = 3; goto A037v6v9; 
	fi;
A039v0v3v6v9: 
	if 
	:: goto A040v0v3v6v9v15; 
	:: memory[v0] = 1; goto A039v3v6v9; 
	fi;
A038v3v6v9: 
	if 
	:: v15 = memory[flag0]; goto A039v3v6v9; 
	:: memory[v3] = 3; goto A038v6v9; 
	fi;
A036v6v9: 
	if 
	::v14 -> goto A037v6v9; 
	::!v14 -> goto A038v6v9; 
	:: memory[v6] = 2; goto A036v9; 
	fi;
A034v0v3v6v9: 
	if 
	:: v14 = cmp8; goto A035v0v3v6v9; 
	:: memory[v0] = 1; goto A034v3v6v9; 
	fi;
A033v3v6v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v3v6v9; 
	:: memory[v3] = 3; goto A033v6v9; 
	fi;
A032v6v9: 
	if 
	:: v13 = memory[v12]; goto A033v6v9; 
	:: memory[v6] = 2; goto A032v9; 
	fi;
A037v6v9: 
	if 
	:: goto A027v6v9; 
	:: memory[v6] = 2; goto A037v9; 
	fi;
A040v0v3v6v9v15: memory[v0] = 1; goto A040v3v6v9v15; 
A039v3v6v9: 
	if 
	:: goto A040v3v6v9v15; 
	:: memory[v3] = 3; goto A039v6v9; 
	fi;
A038v6v9: 
	if 
	:: v15 = memory[flag0]; goto A039v6v9; 
	:: memory[v6] = 2; goto A038v9; 
	fi;
A034v3v6v9: 
	if 
	:: v14 = cmp8; goto A035v3v6v9; 
	:: memory[v3] = 3; goto A034v6v9; 
	fi;
A033v6v9: 
	if 
	:: cmp8 = (v13 == 3); goto A034v6v9; 
	:: memory[v6] = 2; goto A033v9; 
	fi;
A040v3v6v9v15: memory[v3] = 3; goto A040v6v9v15; 
A039v6v9: 
	if 
	:: goto A040v6v9v15; 
	:: memory[v6] = 2; goto A039v9; 
	fi;
A034v6v9: 
	if 
	:: v14 = cmp8; goto A035v6v9; 
	:: memory[v6] = 2; goto A034v9; 
	fi;
A040v6v9v15: memory[v6] = 2; goto A040v9v15; 
AEnd: skip;

}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
BStart: goto B000;
B000: goto B001; 
B001: v0 = memory[flag1]; goto B002; 
B002: goto B003v0; 
B003v0: 
	if 
	:: goto B004v0; 
	:: memory[v0] = 1; goto B003; 
	fi;
B004v0: 
	if 
	:: v1 = memory[flag0]; goto B005v0; 
	:: memory[v0] = 1; goto B004; 
	fi;
B003: goto B004; 
B005v0: 
	if 
	:: v2 = memory[v1]; goto B006v0; 
	:: memory[v0] = 1; goto B005; 
	fi;
B004: v1 = memory[flag0]; goto B005; 
B006v0: 
	if 
	:: cmp = (v2 > 2); goto B007v0; 
	:: memory[v0] = 1; goto B006; 
	fi;
B005: v2 = memory[v1]; goto B006; 
B007v0: 
	if 
	::cmp -> goto B008v0; 
	::!cmp -> goto B009v0; 
	:: memory[v0] = 1; goto B007; 
	fi;
B006: cmp = (v2 > 2); goto B007; 
B008v0: 
	if 
	:: goto B004v0; 
	:: memory[v0] = 1; goto B008; 
	fi;
B009v0: 
	if 
	:: v3 = memory[flag1]; goto B010v0; 
	:: memory[v0] = 1; goto B009; 
	fi;
B007: 
	if 
	::cmp -> goto B008; 
	::!cmp -> goto B009; 
	fi;
B008: goto B004; 
B010v0: 
	if 
	:: goto B011v0v3; 
	:: memory[v0] = 1; goto B010; 
	fi;
B009: v3 = memory[flag1]; goto B010; 
B011v0v3: 
	if 
	:: v4 = memory[flag0]; goto B012v0v3; 
	:: memory[v0] = 1; goto B011v3; 
	fi;
B010: goto B011v3; 
B012v0v3: 
	if 
	:: v5 = memory[v4]; goto B013v0v3; 
	:: memory[v0] = 1; goto B012v3; 
	fi;
B011v3: 
	if 
	:: v4 = memory[flag0]; goto B012v3; 
	:: memory[v3] = 3; goto B011; 
	fi;
B013v0v3: 
	if 
	:: cmp1 = (v5 == 1); goto B014v0v3; 
	:: memory[v0] = 1; goto B013v3; 
	fi;
B012v3: 
	if 
	:: v5 = memory[v4]; goto B013v3; 
	:: memory[v3] = 3; goto B012; 
	fi;
B011: v4 = memory[flag0]; goto B012; 
B014v0v3: 
	if 
	::cmp1 -> goto B015v0v3; 
	::!cmp1 -> goto B024v0v3; 
	:: memory[v0] = 1; goto B014v3; 
	fi;
B013v3: 
	if 
	:: cmp1 = (v5 == 1); goto B014v3; 
	:: memory[v3] = 3; goto B013; 
	fi;
B012: v5 = memory[v4]; goto B013; 
B015v0v3: 
	if 
	:: v6 = memory[flag1]; goto B016v0v3; 
	:: memory[v0] = 1; goto B015v3; 
	fi;
B024v0v3: 
	if 
	:: v9 = memory[flag1]; goto B025v0v3; 
	:: memory[v0] = 1; goto B024v3; 
	fi;
B014v3: 
	if 
	::cmp1 -> goto B015v3; 
	::!cmp1 -> goto B024v3; 
	:: memory[v3] = 3; goto B014; 
	fi;
B013: cmp1 = (v5 == 1); goto B014; 
B016v0v3: 
	if 
	:: goto B017v0v3v6; 
	:: memory[v0] = 1; goto B016v3; 
	fi;
B015v3: 
	if 
	:: v6 = memory[flag1]; goto B016v3; 
	:: memory[v3] = 3; goto B015; 
	fi;
B025v0v3: 
	if 
	:: goto B026v0v3v9; 
	:: memory[v0] = 1; goto B025v3; 
	fi;
B024v3: 
	if 
	:: v9 = memory[flag1]; goto B025v3; 
	:: memory[v3] = 3; goto B024; 
	fi;
B014: 
	if 
	::cmp1 -> goto B015; 
	::!cmp1 -> goto B024; 
	fi;
B017v0v3v6: 
	if 
	:: goto B018v0v3v6; 
	:: memory[v0] = 1; goto B017v3v6; 
	fi;
B016v3: 
	if 
	:: goto B017v3v6; 
	:: memory[v3] = 3; goto B016; 
	fi;
B015: v6 = memory[flag1]; goto B016; 
B026v0v3v9: 
	if 
	:: goto B027v0v3v9; 
	:: memory[v0] = 1; goto B026v3v9; 
	fi;
B025v3: 
	if 
	:: goto B026v3v9; 
	:: memory[v3] = 3; goto B025; 
	fi;
B024: v9 = memory[flag1]; goto B025; 
B018v0v3v6: 
	if 
	:: v7 = memory[flag0]; goto B019v0v3v6; 
	:: memory[v0] = 1; goto B018v3v6; 
	fi;
B017v3v6: 
	if 
	:: goto B018v3v6; 
	:: memory[v3] = 3; goto B017v6; 
	fi;
B016: goto B017v6; 
B027v0v3v9: 
	if 
	:: v10 = memory[flag0]; goto B028v0v3v9; 
	:: memory[v0] = 1; goto B027v3v9; 
	fi;
B026v3v9: 
	if 
	:: goto B027v3v9; 
	:: memory[v3] = 3; goto B026v9; 
	fi;
B025: goto B026v9; 
B019v0v3v6: 
	if 
	:: v8 = memory[v7]; goto B020v0v3v6; 
	:: memory[v0] = 1; goto B019v3v6; 
	fi;
B018v3v6: 
	if 
	:: v7 = memory[flag0]; goto B019v3v6; 
	:: memory[v3] = 3; goto B018v6; 
	fi;
B017v6: 
	if 
	:: goto B018v6; 
	:: memory[v6] = 2; goto B017; 
	fi;
B028v0v3v9: 
	if 
	:: v11 = memory[v10]; goto B029v0v3v9; 
	:: memory[v0] = 1; goto B028v3v9; 
	fi;
B027v3v9: 
	if 
	:: v10 = memory[flag0]; goto B028v3v9; 
	:: memory[v3] = 3; goto B027v9; 
	fi;
B026v9: 
	if 
	:: goto B027v9; 
	:: memory[v9] = 4; goto B026; 
	fi;
B020v0v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto B021v0v3v6; 
	:: memory[v0] = 1; goto B020v3v6; 
	fi;
B019v3v6: 
	if 
	:: v8 = memory[v7]; goto B020v3v6; 
	:: memory[v3] = 3; goto B019v6; 
	fi;
B018v6: 
	if 
	:: v7 = memory[flag0]; goto B019v6; 
	:: memory[v6] = 2; goto B018; 
	fi;
B017: goto B018; 
B029v0v3v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v0v3v9; 
	:: memory[v0] = 1; goto B029v3v9; 
	fi;
B028v3v9: 
	if 
	:: v11 = memory[v10]; goto B029v3v9; 
	:: memory[v3] = 3; goto B028v9; 
	fi;
B027v9: 
	if 
	:: v10 = memory[flag0]; goto B028v9; 
	:: memory[v9] = 4; goto B027; 
	fi;
B026: goto B027; 
B021v0v3v6: 
	if 
	::cmp3 -> goto B022v0v3v6; 
	::!cmp3 -> goto B023v0v3v6; 
	:: memory[v0] = 1; goto B021v3v6; 
	fi;
B020v3v6: 
	if 
	:: cmp3 = (v8 == 4); goto B021v3v6; 
	:: memory[v3] = 3; goto B020v6; 
	fi;
B019v6: 
	if 
	:: v8 = memory[v7]; goto B020v6; 
	:: memory[v6] = 2; goto B019; 
	fi;
B018: v7 = memory[flag0]; goto B019; 
B030v0v3v9: 
	if 
	::cmp7 -> goto B031v0v3v9; 
	::!cmp7 -> goto B032v0v3v9; 
	:: memory[v0] = 1; goto B030v3v9; 
	fi;
B029v3v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v3v9; 
	:: memory[v3] = 3; goto B029v9; 
	fi;
B028v9: 
	if 
	:: v11 = memory[v10]; goto B029v9; 
	:: memory[v9] = 4; goto B028; 
	fi;
B027: v10 = memory[flag0]; goto B028; 
B022v0v3v6: 
	if 
	:: goto B018v0v3v6; 
	:: memory[v0] = 1; goto B022v3v6; 
	fi;
B023v0v3v6: 
	if 
	:: goto B024v0v3v6; 
	:: memory[v0] = 1; goto B023v3v6; 
	fi;
B021v3v6: 
	if 
	::cmp3 -> goto B022v3v6; 
	::!cmp3 -> goto B023v3v6; 
	:: memory[v3] = 3; goto B021v6; 
	fi;
B020v6: 
	if 
	:: cmp3 = (v8 == 4); goto B021v6; 
	:: memory[v6] = 2; goto B020; 
	fi;
B019: v8 = memory[v7]; goto B020; 
B031v0v3v9: 
	if 
	:: goto B027v0v3v9; 
	:: memory[v0] = 1; goto B031v3v9; 
	fi;
B032v0v3v9: 
	if 
	:: v12 = memory[flag1]; goto B033v0v3v9; 
	:: memory[v0] = 1; goto B032v3v9; 
	fi;
B030v3v9: 
	if 
	::cmp7 -> goto B031v3v9; 
	::!cmp7 -> goto B032v3v9; 
	:: memory[v3] = 3; goto B030v9; 
	fi;
B029v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v9; 
	:: memory[v9] = 4; goto B029; 
	fi;
B028: v11 = memory[v10]; goto B029; 
B022v3v6: 
	if 
	:: goto B018v3v6; 
	:: memory[v3] = 3; goto B022v6; 
	fi;
B024v0v3v6: 
	if 
	:: v9 = memory[flag1]; goto B025v0v3v6; 
	:: memory[v0] = 1; goto B024v3v6; 
	fi;
B023v3v6: 
	if 
	:: goto B024v3v6; 
	:: memory[v3] = 3; goto B023v6; 
	fi;
B021v6: 
	if 
	::cmp3 -> goto B022v6; 
	::!cmp3 -> goto B023v6; 
	:: memory[v6] = 2; goto B021; 
	fi;
B020: cmp3 = (v8 == 4); goto B021; 
B031v3v9: 
	if 
	:: goto B027v3v9; 
	:: memory[v3] = 3; goto B031v9; 
	fi;
B033v0v3v9: 
	if 
	:: goto B034v0v3v9v12; 
	:: memory[v0] = 1; goto B033v3v9; 
	fi;
B032v3v9: 
	if 
	:: v12 = memory[flag1]; goto B033v3v9; 
	:: memory[v3] = 3; goto B032v9; 
	fi;
B030v9: 
	if 
	::cmp7 -> goto B031v9; 
	::!cmp7 -> goto B032v9; 
	:: memory[v9] = 4; goto B030; 
	fi;
B029: cmp7 = (v11 > 1); goto B030; 
B022v6: 
	if 
	:: goto B018v6; 
	:: memory[v6] = 2; goto B022; 
	fi;
B025v0v3v6: 
	if 
	:: goto B026v0v3v6v9; 
	:: memory[v0] = 1; goto B025v3v6; 
	fi;
B024v3v6: 
	if 
	:: v9 = memory[flag1]; goto B025v3v6; 
	:: memory[v3] = 3; goto B024v6; 
	fi;
B023v6: 
	if 
	:: goto B024v6; 
	:: memory[v6] = 2; goto B023; 
	fi;
B021: 
	if 
	::cmp3 -> goto B022; 
	::!cmp3 -> goto B023; 
	fi;
B031v9: 
	if 
	:: goto B027v9; 
	:: memory[v9] = 4; goto B031; 
	fi;
B034v0v3v9v12: memory[v0] = 1; goto B034v3v9v12; 
B033v3v9: 
	if 
	:: goto B034v3v9v12; 
	:: memory[v3] = 3; goto B033v9; 
	fi;
B032v9: 
	if 
	:: v12 = memory[flag1]; goto B033v9; 
	:: memory[v9] = 4; goto B032; 
	fi;
B030: 
	if 
	::cmp7 -> goto B031; 
	::!cmp7 -> goto B032; 
	fi;
B022: goto B018; 
B026v0v3v6v9: 
	if 
	:: goto B027v0v3v6v9; 
	:: memory[v0] = 1; goto B026v3v6v9; 
	fi;
B025v3v6: 
	if 
	:: goto B026v3v6v9; 
	:: memory[v3] = 3; goto B025v6; 
	fi;
B024v6: 
	if 
	:: v9 = memory[flag1]; goto B025v6; 
	:: memory[v6] = 2; goto B024; 
	fi;
B023: goto B024; 
B031: goto B027; 
B034v3v9v12: memory[v3] = 3; goto B034v9v12; 
B033v9: 
	if 
	:: goto B034v9v12; 
	:: memory[v9] = 4; goto B033; 
	fi;
B032: v12 = memory[flag1]; goto B033; 
B027v0v3v6v9: 
	if 
	:: v10 = memory[flag0]; goto B028v0v3v6v9; 
	:: memory[v0] = 1; goto B027v3v6v9; 
	fi;
B026v3v6v9: 
	if 
	:: goto B027v3v6v9; 
	:: memory[v3] = 3; goto B026v6v9; 
	fi;
B025v6: 
	if 
	:: goto B026v6v9; 
	:: memory[v6] = 2; goto B025; 
	fi;
B034v9v12: memory[v9] = 4; goto B034v12; 
B033: goto B034v12; 
B028v0v3v6v9: 
	if 
	:: v11 = memory[v10]; goto B029v0v3v6v9; 
	:: memory[v0] = 1; goto B028v3v6v9; 
	fi;
B027v3v6v9: 
	if 
	:: v10 = memory[flag0]; goto B028v3v6v9; 
	:: memory[v3] = 3; goto B027v6v9; 
	fi;
B026v6v9: 
	if 
	:: goto B027v6v9; 
	:: memory[v6] = 2; goto B026v9; 
	fi;
B034v12: memory[v12] = 0; goto B034; 
B029v0v3v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v0v3v6v9; 
	:: memory[v0] = 1; goto B029v3v6v9; 
	fi;
B028v3v6v9: 
	if 
	:: v11 = memory[v10]; goto B029v3v6v9; 
	:: memory[v3] = 3; goto B028v6v9; 
	fi;
B027v6v9: 
	if 
	:: v10 = memory[flag0]; goto B028v6v9; 
	:: memory[v6] = 2; goto B027v9; 
	fi;
B034: goto BEnd;
B030v0v3v6v9: 
	if 
	::cmp7 -> goto B031v0v3v6v9; 
	::!cmp7 -> goto B032v0v3v6v9; 
	:: memory[v0] = 1; goto B030v3v6v9; 
	fi;
B029v3v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v3v6v9; 
	:: memory[v3] = 3; goto B029v6v9; 
	fi;
B028v6v9: 
	if 
	:: v11 = memory[v10]; goto B029v6v9; 
	:: memory[v6] = 2; goto B028v9; 
	fi;
B031v0v3v6v9: 
	if 
	:: goto B027v0v3v6v9; 
	:: memory[v0] = 1; goto B031v3v6v9; 
	fi;
B032v0v3v6v9: 
	if 
	:: v12 = memory[flag1]; goto B033v0v3v6v9; 
	:: memory[v0] = 1; goto B032v3v6v9; 
	fi;
B030v3v6v9: 
	if 
	::cmp7 -> goto B031v3v6v9; 
	::!cmp7 -> goto B032v3v6v9; 
	:: memory[v3] = 3; goto B030v6v9; 
	fi;
B029v6v9: 
	if 
	:: cmp7 = (v11 > 1); goto B030v6v9; 
	:: memory[v6] = 2; goto B029v9; 
	fi;
B031v3v6v9: 
	if 
	:: goto B027v3v6v9; 
	:: memory[v3] = 3; goto B031v6v9; 
	fi;
B033v0v3v6v9: 
	if 
	:: goto B034v0v3v6v9v12; 
	:: memory[v0] = 1; goto B033v3v6v9; 
	fi;
B032v3v6v9: 
	if 
	:: v12 = memory[flag1]; goto B033v3v6v9; 
	:: memory[v3] = 3; goto B032v6v9; 
	fi;
B030v6v9: 
	if 
	::cmp7 -> goto B031v6v9; 
	::!cmp7 -> goto B032v6v9; 
	:: memory[v6] = 2; goto B030v9; 
	fi;
B031v6v9: 
	if 
	:: goto B027v6v9; 
	:: memory[v6] = 2; goto B031v9; 
	fi;
B034v0v3v6v9v12: memory[v0] = 1; goto B034v3v6v9v12; 
B033v3v6v9: 
	if 
	:: goto B034v3v6v9v12; 
	:: memory[v3] = 3; goto B033v6v9; 
	fi;
B032v6v9: 
	if 
	:: v12 = memory[flag1]; goto B033v6v9; 
	:: memory[v6] = 2; goto B032v9; 
	fi;
B034v3v6v9v12: memory[v3] = 3; goto B034v6v9v12; 
B033v6v9: 
	if 
	:: goto B034v6v9v12; 
	:: memory[v6] = 2; goto B033v9; 
	fi;
B034v6v9v12: memory[v6] = 2; goto B034v9v12; 
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
	//TODO: empty stub

	run process1();
	run process2();
	}
}

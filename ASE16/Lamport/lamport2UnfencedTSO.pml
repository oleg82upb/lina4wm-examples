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
AStart: goto A000;
A000: getelementptr(1, choosing, -1, arrayidx); goto A001; 
A001: v0 = memory[arrayidx]; goto A002; 
A002: goto A003v0; 
A003v0: 
	if 
	:: v1 = memory[]; goto A004v0; 
	:: memory[v0] = 1; goto A003; 
	fi;
A004v0: 
	if 
	:: v2 = memory[v1]; goto A005v0; 
	:: memory[v0] = 1; goto A004; 
	fi;
A003: v1 = memory[]; goto A004; 
A005v0: 
	if 
	:: v3 = memory[]; goto A006v0; 
	:: memory[v0] = 1; goto A005; 
	fi;
A004: v2 = memory[v1]; goto A005; 
A006v0: 
	if 
	:: v4 = memory[v3]; goto A007v0; 
	:: memory[v0] = 1; goto A006; 
	fi;
A005: v3 = memory[]; goto A006; 
A007v0: 
	if 
	:: cmp = (v2 < v4); goto A008v0; 
	:: memory[v0] = 1; goto A007; 
	fi;
A006: v4 = memory[v3]; goto A007; 
A008v0: 
	if 
	::cmp -> goto A009v0; 
	::!cmp -> goto A014v0; 
	:: memory[v0] = 1; goto A008; 
	fi;
A007: cmp = (v2 < v4); goto A008; 
A009v0: 
	if 
	:: add = v4 + 1; goto A010v0; 
	:: memory[v0] = 1; goto A009; 
	fi;
A014v0: 
	if 
	:: add2 = v2 + 1; goto A015v0; 
	:: memory[v0] = 1; goto A014; 
	fi;
A008: 
	if 
	::cmp -> goto A009; 
	::!cmp -> goto A014; 
	fi;
A010v0: 
	if 
	:: getelementptr(1, number, -1, arrayidx1); goto A011v0; 
	:: memory[v0] = 1; goto A010; 
	fi;
A009: add = v4 + 1; goto A010; 
A015v0: 
	if 
	:: getelementptr(1, number, -1, arrayidx3); goto A016v0; 
	:: memory[v0] = 1; goto A015; 
	fi;
A014: add2 = v2 + 1; goto A015; 
A011v0: 
	if 
	:: v5 = memory[arrayidx1]; goto A012v0; 
	:: memory[v0] = 1; goto A011; 
	fi;
A010: getelementptr(1, number, -1, arrayidx1); goto A011; 
A016v0: 
	if 
	:: v6 = memory[arrayidx3]; goto A017v0; 
	:: memory[v0] = 1; goto A016; 
	fi;
A015: getelementptr(1, number, -1, arrayidx3); goto A016; 
A012v0: 
	if 
	:: goto A013v0v5; 
	:: memory[v0] = 1; goto A012; 
	fi;
A011: v5 = memory[arrayidx1]; goto A012; 
A017v0: 
	if 
	:: goto A018v0v6; 
	:: memory[v0] = 1; goto A017; 
	fi;
A016: v6 = memory[arrayidx3]; goto A017; 
A013v0v5: 
	if 
	:: goto A019v0v5; 
	:: memory[v0] = 1; goto A013v5; 
	fi;
A012: goto A013v5; 
A018v0v6: 
	if 
	:: goto A019v0v6; 
	:: memory[v0] = 1; goto A018v6; 
	fi;
A017: goto A018v6; 
A019v0v5: 
	if 
	:: v7 = memory[arrayidx]; goto A020v0v5; 
	:: memory[v0] = 1; goto A019v5; 
	fi;
A013v5: 
	if 
	:: goto A019v5; 
	:: memory[v5] = add; goto A013; 
	fi;
A019v0v6: 
	if 
	:: v7 = memory[arrayidx]; goto A020v0v6; 
	:: memory[v0] = 1; goto A019v6; 
	fi;
A018v6: 
	if 
	:: goto A019v6; 
	:: memory[v6] = add2; goto A018; 
	fi;
A020v0v5: 
	if 
	:: goto A021v0v5v7; 
	:: memory[v0] = 1; goto A020v5; 
	fi;
A019v5: 
	if 
	:: v7 = memory[arrayidx]; goto A020v5; 
	:: memory[v5] = add; goto A019; 
	fi;
A013: goto A019; 
A020v0v6: 
	if 
	:: goto A021v0v6v7; 
	:: memory[v0] = 1; goto A020v6; 
	fi;
A019v6: 
	if 
	:: v7 = memory[arrayidx]; goto A020v6; 
	:: memory[v6] = add2; goto A019; 
	fi;
A018: goto A019; 
A021v0v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx11); goto A022v0v5v7; 
	:: memory[v0] = 1; goto A021v5v7; 
	fi;
A020v5: 
	if 
	:: goto A021v5v7; 
	:: memory[v5] = add; goto A020; 
	fi;
A019: v7 = memory[arrayidx]; goto A020; 
A021v0v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx11); goto A022v0v6v7; 
	:: memory[v0] = 1; goto A021v6v7; 
	fi;
A020v6: 
	if 
	:: goto A021v6v7; 
	:: memory[v6] = add2; goto A020; 
	fi;
A022v0v5v7: 
	if 
	:: j_023 = 0; goto A023v0v5v7; 
	:: memory[v0] = 1; goto A022v5v7; 
	fi;
A021v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx11); goto A022v5v7; 
	:: memory[v5] = add; goto A021v7; 
	fi;
A020: goto A021v7; 
A022v0v6v7: 
	if 
	:: j_023 = 0; goto A023v0v6v7; 
	:: memory[v0] = 1; goto A022v6v7; 
	fi;
A021v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx11); goto A022v6v7; 
	:: memory[v6] = add2; goto A021v7; 
	fi;
A023v0v5v7: 
	if 
	:: goto A024v0v5v7; 
	:: memory[v0] = 1; goto A023v5v7; 
	fi;
A022v5v7: 
	if 
	:: j_023 = 0; goto A023v5v7; 
	:: memory[v5] = add; goto A022v7; 
	fi;
A021v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx11); goto A022v7; 
	:: memory[v7] = 0; goto A021; 
	fi;
A023v0v6v7: 
	if 
	:: goto A024v0v6v7; 
	:: memory[v0] = 1; goto A023v6v7; 
	fi;
A022v6v7: 
	if 
	:: j_023 = 0; goto A023v6v7; 
	:: memory[v6] = add2; goto A022v7; 
	fi;
A024v0v5v7: 
	if 
	:: getelementptr(1, choosing, -1, arrayidx6); goto A025v0v5v7; 
	:: memory[v0] = 1; goto A024v5v7; 
	fi;
A023v5v7: 
	if 
	:: goto A024v5v7; 
	:: memory[v5] = add; goto A023v7; 
	fi;
A022v7: 
	if 
	:: j_023 = 0; goto A023v7; 
	:: memory[v7] = 0; goto A022; 
	fi;
A021: getelementptr(1, number, -1, arrayidx11); goto A022; 
A024v0v6v7: 
	if 
	:: getelementptr(1, choosing, -1, arrayidx6); goto A025v0v6v7; 
	:: memory[v0] = 1; goto A024v6v7; 
	fi;
A023v6v7: 
	if 
	:: goto A024v6v7; 
	:: memory[v6] = add2; goto A023v7; 
	fi;
A025v0v5v7: 
	if 
	:: v8 = memory[arrayidx6]; goto A026v0v5v7; 
	:: memory[v0] = 1; goto A025v5v7; 
	fi;
A024v5v7: 
	if 
	:: getelementptr(1, choosing, -1, arrayidx6); goto A025v5v7; 
	:: memory[v5] = add; goto A024v7; 
	fi;
A023v7: 
	if 
	:: goto A024v7; 
	:: memory[v7] = 0; goto A023; 
	fi;
A022: j_023 = 0; goto A023; 
A025v0v6v7: 
	if 
	:: v8 = memory[arrayidx6]; goto A026v0v6v7; 
	:: memory[v0] = 1; goto A025v6v7; 
	fi;
A024v6v7: 
	if 
	:: getelementptr(1, choosing, -1, arrayidx6); goto A025v6v7; 
	:: memory[v6] = add2; goto A024v7; 
	fi;
A026v0v5v7: 
	if 
	:: v9 = memory[v8]; goto A027v0v5v7; 
	:: memory[v0] = 1; goto A026v5v7; 
	fi;
A025v5v7: 
	if 
	:: v8 = memory[arrayidx6]; goto A026v5v7; 
	:: memory[v5] = add; goto A025v7; 
	fi;
A024v7: 
	if 
	:: getelementptr(1, choosing, -1, arrayidx6); goto A025v7; 
	:: memory[v7] = 0; goto A024; 
	fi;
A023: goto A024; 
A026v0v6v7: 
	if 
	:: v9 = memory[v8]; goto A027v0v6v7; 
	:: memory[v0] = 1; goto A026v6v7; 
	fi;
A025v6v7: 
	if 
	:: v8 = memory[arrayidx6]; goto A026v6v7; 
	:: memory[v6] = add2; goto A025v7; 
	fi;
A027v0v5v7: 
	if 
	:: v10 = v9 & 1; goto A028v0v5v7; 
	:: memory[v0] = 1; goto A027v5v7; 
	fi;
A026v5v7: 
	if 
	:: v9 = memory[v8]; goto A027v5v7; 
	:: memory[v5] = add; goto A026v7; 
	fi;
A025v7: 
	if 
	:: v8 = memory[arrayidx6]; goto A026v7; 
	:: memory[v7] = 0; goto A025; 
	fi;
A024: getelementptr(1, choosing, -1, arrayidx6); goto A025; 
A027v0v6v7: 
	if 
	:: v10 = v9 & 1; goto A028v0v6v7; 
	:: memory[v0] = 1; goto A027v6v7; 
	fi;
A026v6v7: 
	if 
	:: v9 = memory[v8]; goto A027v6v7; 
	:: memory[v6] = add2; goto A026v7; 
	fi;
A028v0v5v7: 
	if 
	:: tobool = (v10 == 0); goto A029v0v5v7; 
	:: memory[v0] = 1; goto A028v5v7; 
	fi;
A027v5v7: 
	if 
	:: v10 = v9 & 1; goto A028v5v7; 
	:: memory[v5] = add; goto A027v7; 
	fi;
A026v7: 
	if 
	:: v9 = memory[v8]; goto A027v7; 
	:: memory[v7] = 0; goto A026; 
	fi;
A025: v8 = memory[arrayidx6]; goto A026; 
A028v0v6v7: 
	if 
	:: tobool = (v10 == 0); goto A029v0v6v7; 
	:: memory[v0] = 1; goto A028v6v7; 
	fi;
A027v6v7: 
	if 
	:: v10 = v9 & 1; goto A028v6v7; 
	:: memory[v6] = add2; goto A027v7; 
	fi;
A029v0v5v7: 
	if 
	::tobool -> goto A031v0v5v7; 
	::!tobool -> goto A030v0v5v7; 
	:: memory[v0] = 1; goto A029v5v7; 
	fi;
A028v5v7: 
	if 
	:: tobool = (v10 == 0); goto A029v5v7; 
	:: memory[v5] = add; goto A028v7; 
	fi;
A027v7: 
	if 
	:: v10 = v9 & 1; goto A028v7; 
	:: memory[v7] = 0; goto A027; 
	fi;
A026: v9 = memory[v8]; goto A027; 
A029v0v6v7: 
	if 
	::tobool -> goto A031v0v6v7; 
	::!tobool -> goto A030v0v6v7; 
	:: memory[v0] = 1; goto A029v6v7; 
	fi;
A028v6v7: 
	if 
	:: tobool = (v10 == 0); goto A029v6v7; 
	:: memory[v6] = add2; goto A028v7; 
	fi;
A031v0v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx8); goto A032v0v5v7; 
	:: memory[v0] = 1; goto A031v5v7; 
	fi;
A030v0v5v7: 
	if 
	:: goto A030v0v5v7; 
	:: memory[v0] = 1; goto A030v5v7; 
	fi;
A029v5v7: 
	if 
	::tobool -> goto A031v5v7; 
	::!tobool -> goto A030v5v7; 
	:: memory[v5] = add; goto A029v7; 
	fi;
A028v7: 
	if 
	:: tobool = (v10 == 0); goto A029v7; 
	:: memory[v7] = 0; goto A028; 
	fi;
A027: v10 = v9 & 1; goto A028; 
A031v0v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx8); goto A032v0v6v7; 
	:: memory[v0] = 1; goto A031v6v7; 
	fi;
A030v0v6v7: 
	if 
	:: goto A030v0v6v7; 
	:: memory[v0] = 1; goto A030v6v7; 
	fi;
A029v6v7: 
	if 
	::tobool -> goto A031v6v7; 
	::!tobool -> goto A030v6v7; 
	:: memory[v6] = add2; goto A029v7; 
	fi;
A032v0v5v7: 
	if 
	:: v11 = memory[arrayidx8]; goto A033v0v5v7; 
	:: memory[v0] = 1; goto A032v5v7; 
	fi;
A031v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx8); goto A032v5v7; 
	:: memory[v5] = add; goto A031v7; 
	fi;
A030v5v7: 
	if 
	:: goto A030v5v7; 
	:: memory[v5] = add; goto A030v7; 
	fi;
A029v7: 
	if 
	::tobool -> goto A031v7; 
	::!tobool -> goto A030v7; 
	:: memory[v7] = 0; goto A029; 
	fi;
A028: tobool = (v10 == 0); goto A029; 
A032v0v6v7: 
	if 
	:: v11 = memory[arrayidx8]; goto A033v0v6v7; 
	:: memory[v0] = 1; goto A032v6v7; 
	fi;
A031v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx8); goto A032v6v7; 
	:: memory[v6] = add2; goto A031v7; 
	fi;
A030v6v7: 
	if 
	:: goto A030v6v7; 
	:: memory[v6] = add2; goto A030v7; 
	fi;
A033v0v5v7: 
	if 
	:: v12 = memory[v11]; goto A034v0v5v7; 
	:: memory[v0] = 1; goto A033v5v7; 
	fi;
A032v5v7: 
	if 
	:: v11 = memory[arrayidx8]; goto A033v5v7; 
	:: memory[v5] = add; goto A032v7; 
	fi;
A031v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx8); goto A032v7; 
	:: memory[v7] = 0; goto A031; 
	fi;
A030v7: 
	if 
	:: goto A030v7; 
	:: memory[v7] = 0; goto A030; 
	fi;
A029: 
	if 
	::tobool -> goto A031; 
	::!tobool -> goto A030; 
	fi;
A033v0v6v7: 
	if 
	:: v12 = memory[v11]; goto A034v0v6v7; 
	:: memory[v0] = 1; goto A033v6v7; 
	fi;
A032v6v7: 
	if 
	:: v11 = memory[arrayidx8]; goto A033v6v7; 
	:: memory[v6] = add2; goto A032v7; 
	fi;
A034v0v5v7: 
	if 
	:: cmp9 = (v12 == 0); goto A035v0v5v7; 
	:: memory[v0] = 1; goto A034v5v7; 
	fi;
A033v5v7: 
	if 
	:: v12 = memory[v11]; goto A034v5v7; 
	:: memory[v5] = add; goto A033v7; 
	fi;
A032v7: 
	if 
	:: v11 = memory[arrayidx8]; goto A033v7; 
	:: memory[v7] = 0; goto A032; 
	fi;
A031: getelementptr(1, number, -1, arrayidx8); goto A032; 
A030: goto A030; 
A034v0v6v7: 
	if 
	:: cmp9 = (v12 == 0); goto A035v0v6v7; 
	:: memory[v0] = 1; goto A034v6v7; 
	fi;
A033v6v7: 
	if 
	:: v12 = memory[v11]; goto A034v6v7; 
	:: memory[v6] = add2; goto A033v7; 
	fi;
A035v0v5v7: 
	if 
	:: cmp17 = (j_023 < i); goto A036v0v5v7; 
	:: memory[v0] = 1; goto A035v5v7; 
	fi;
A034v5v7: 
	if 
	:: cmp9 = (v12 == 0); goto A035v5v7; 
	:: memory[v5] = add; goto A034v7; 
	fi;
A033v7: 
	if 
	:: v12 = memory[v11]; goto A034v7; 
	:: memory[v7] = 0; goto A033; 
	fi;
A032: v11 = memory[arrayidx8]; goto A033; 
A035v0v6v7: 
	if 
	:: cmp17 = (j_023 < i); goto A036v0v6v7; 
	:: memory[v0] = 1; goto A035v6v7; 
	fi;
A034v6v7: 
	if 
	:: cmp9 = (v12 == 0); goto A035v6v7; 
	:: memory[v6] = add2; goto A034v7; 
	fi;
A036v0v5v7: 
	if 
	::cmp9 -> goto A044v0v5v7; 
	::!cmp9 -> goto A037v0v5v7; 
	:: memory[v0] = 1; goto A036v5v7; 
	fi;
A035v5v7: 
	if 
	:: cmp17 = (j_023 < i); goto A036v5v7; 
	:: memory[v5] = add; goto A035v7; 
	fi;
A034v7: 
	if 
	:: cmp9 = (v12 == 0); goto A035v7; 
	:: memory[v7] = 0; goto A034; 
	fi;
A033: v12 = memory[v11]; goto A034; 
A036v0v6v7: 
	if 
	::cmp9 -> goto A044v0v6v7; 
	::!cmp9 -> goto A037v0v6v7; 
	:: memory[v0] = 1; goto A036v6v7; 
	fi;
A035v6v7: 
	if 
	:: cmp17 = (j_023 < i); goto A036v6v7; 
	:: memory[v6] = add2; goto A035v7; 
	fi;
A044v0v5v7: 
	if 
	:: inc = j_023 + 1; goto A045v0v5v7; 
	:: memory[v0] = 1; goto A044v5v7; 
	fi;
A037v0v5v7: 
	if 
	:: v13 = memory[arrayidx11]; goto A038v0v5v7; 
	:: memory[v0] = 1; goto A037v5v7; 
	fi;
A036v5v7: 
	if 
	::cmp9 -> goto A044v5v7; 
	::!cmp9 -> goto A037v5v7; 
	:: memory[v5] = add; goto A036v7; 
	fi;
A035v7: 
	if 
	:: cmp17 = (j_023 < i); goto A036v7; 
	:: memory[v7] = 0; goto A035; 
	fi;
A034: cmp9 = (v12 == 0); goto A035; 
A044v0v6v7: 
	if 
	:: inc = j_023 + 1; goto A045v0v6v7; 
	:: memory[v0] = 1; goto A044v6v7; 
	fi;
A037v0v6v7: 
	if 
	:: v13 = memory[arrayidx11]; goto A038v0v6v7; 
	:: memory[v0] = 1; goto A037v6v7; 
	fi;
A036v6v7: 
	if 
	::cmp9 -> goto A044v6v7; 
	::!cmp9 -> goto A037v6v7; 
	:: memory[v6] = add2; goto A036v7; 
	fi;
A045v0v5v7: 
	if 
	:: exitcond = (inc == 2); goto A046v0v5v7; 
	:: memory[v0] = 1; goto A045v5v7; 
	fi;
A044v5v7: 
	if 
	:: inc = j_023 + 1; goto A045v5v7; 
	:: memory[v5] = add; goto A044v7; 
	fi;
A038v0v5v7: 
	if 
	:: v14 = memory[v13]; goto A039v0v5v7; 
	:: memory[v0] = 1; goto A038v5v7; 
	fi;
A037v5v7: 
	if 
	:: v13 = memory[arrayidx11]; goto A038v5v7; 
	:: memory[v5] = add; goto A037v7; 
	fi;
A036v7: 
	if 
	::cmp9 -> goto A044v7; 
	::!cmp9 -> goto A037v7; 
	:: memory[v7] = 0; goto A036; 
	fi;
A035: cmp17 = (j_023 < i); goto A036; 
A045v0v6v7: 
	if 
	:: exitcond = (inc == 2); goto A046v0v6v7; 
	:: memory[v0] = 1; goto A045v6v7; 
	fi;
A044v6v7: 
	if 
	:: inc = j_023 + 1; goto A045v6v7; 
	:: memory[v6] = add2; goto A044v7; 
	fi;
A038v0v6v7: 
	if 
	:: v14 = memory[v13]; goto A039v0v6v7; 
	:: memory[v0] = 1; goto A038v6v7; 
	fi;
A037v6v7: 
	if 
	:: v13 = memory[arrayidx11]; goto A038v6v7; 
	:: memory[v6] = add2; goto A037v7; 
	fi;
A046v0v5v7: 
	if 
	::exitcond -> goto A047v0v5v7; 
	::!exitcond -> j_023 = inc; goto A023v0v5v7; 
	:: memory[v0] = 1; goto A046v5v7; 
	fi;
A045v5v7: 
	if 
	:: exitcond = (inc == 2); goto A046v5v7; 
	:: memory[v5] = add; goto A045v7; 
	fi;
A044v7: 
	if 
	:: inc = j_023 + 1; goto A045v7; 
	:: memory[v7] = 0; goto A044; 
	fi;
A039v0v5v7: 
	if 
	:: cmp12 = (v12 < v14); goto A040v0v5v7; 
	:: memory[v0] = 1; goto A039v5v7; 
	fi;
A038v5v7: 
	if 
	:: v14 = memory[v13]; goto A039v5v7; 
	:: memory[v5] = add; goto A038v7; 
	fi;
A037v7: 
	if 
	:: v13 = memory[arrayidx11]; goto A038v7; 
	:: memory[v7] = 0; goto A037; 
	fi;
A036: 
	if 
	::cmp9 -> goto A044; 
	::!cmp9 -> goto A037; 
	fi;
A046v0v6v7: 
	if 
	::exitcond -> goto A047v0v6v7; 
	::!exitcond -> j_023 = inc; goto A023v0v6v7; 
	:: memory[v0] = 1; goto A046v6v7; 
	fi;
A045v6v7: 
	if 
	:: exitcond = (inc == 2); goto A046v6v7; 
	:: memory[v6] = add2; goto A045v7; 
	fi;
A039v0v6v7: 
	if 
	:: cmp12 = (v12 < v14); goto A040v0v6v7; 
	:: memory[v0] = 1; goto A039v6v7; 
	fi;
A038v6v7: 
	if 
	:: v14 = memory[v13]; goto A039v6v7; 
	:: memory[v6] = add2; goto A038v7; 
	fi;
A047v0v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx21); goto A048v0v5v7; 
	:: memory[v0] = 1; goto A047v5v7; 
	fi;
A046v5v7: 
	if 
	::exitcond -> goto A047v5v7; 
	::!exitcond -> j_023 = inc; goto A023v5v7; 
	:: memory[v5] = add; goto A046v7; 
	fi;
A045v7: 
	if 
	:: exitcond = (inc == 2); goto A046v7; 
	:: memory[v7] = 0; goto A045; 
	fi;
A044: inc = j_023 + 1; goto A045; 
A040v0v5v7: 
	if 
	:: cmp15 = (v12 == v14); goto A041v0v5v7; 
	:: memory[v0] = 1; goto A040v5v7; 
	fi;
A039v5v7: 
	if 
	:: cmp12 = (v12 < v14); goto A040v5v7; 
	:: memory[v5] = add; goto A039v7; 
	fi;
A038v7: 
	if 
	:: v14 = memory[v13]; goto A039v7; 
	:: memory[v7] = 0; goto A038; 
	fi;
A037: v13 = memory[arrayidx11]; goto A038; 
A047v0v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx21); goto A048v0v6v7; 
	:: memory[v0] = 1; goto A047v6v7; 
	fi;
A046v6v7: 
	if 
	::exitcond -> goto A047v6v7; 
	::!exitcond -> j_023 = inc; goto A023v6v7; 
	:: memory[v6] = add2; goto A046v7; 
	fi;
A040v0v6v7: 
	if 
	:: cmp15 = (v12 == v14); goto A041v0v6v7; 
	:: memory[v0] = 1; goto A040v6v7; 
	fi;
A039v6v7: 
	if 
	:: cmp12 = (v12 < v14); goto A040v6v7; 
	:: memory[v6] = add2; goto A039v7; 
	fi;
A048v0v5v7: 
	if 
	:: v15 = memory[arrayidx21]; goto A049v0v5v7; 
	:: memory[v0] = 1; goto A048v5v7; 
	fi;
A047v5v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx21); goto A048v5v7; 
	:: memory[v5] = add; goto A047v7; 
	fi;
A046v7: 
	if 
	::exitcond -> goto A047v7; 
	::!exitcond -> j_023 = inc; goto A023v7; 
	:: memory[v7] = 0; goto A046; 
	fi;
A045: exitcond = (inc == 2); goto A046; 
A041v0v5v7: 
	if 
	:: or_cond = cmp15 & cmp17; goto A042v0v5v7; 
	:: memory[v0] = 1; goto A041v5v7; 
	fi;
A040v5v7: 
	if 
	:: cmp15 = (v12 == v14); goto A041v5v7; 
	:: memory[v5] = add; goto A040v7; 
	fi;
A039v7: 
	if 
	:: cmp12 = (v12 < v14); goto A040v7; 
	:: memory[v7] = 0; goto A039; 
	fi;
A038: v14 = memory[v13]; goto A039; 
A048v0v6v7: 
	if 
	:: v15 = memory[arrayidx21]; goto A049v0v6v7; 
	:: memory[v0] = 1; goto A048v6v7; 
	fi;
A047v6v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx21); goto A048v6v7; 
	:: memory[v6] = add2; goto A047v7; 
	fi;
A041v0v6v7: 
	if 
	:: or_cond = cmp15 & cmp17; goto A042v0v6v7; 
	:: memory[v0] = 1; goto A041v6v7; 
	fi;
A040v6v7: 
	if 
	:: cmp15 = (v12 == v14); goto A041v6v7; 
	:: memory[v6] = add2; goto A040v7; 
	fi;
A049v0v5v7: 
	if 
	:: goto A050v0v5v7v15; 
	:: memory[v0] = 1; goto A049v5v7; 
	fi;
A048v5v7: 
	if 
	:: v15 = memory[arrayidx21]; goto A049v5v7; 
	:: memory[v5] = add; goto A048v7; 
	fi;
A047v7: 
	if 
	:: getelementptr(1, number, -1, arrayidx21); goto A048v7; 
	:: memory[v7] = 0; goto A047; 
	fi;
A046: 
	if 
	::exitcond -> goto A047; 
	::!exitcond -> j_023 = inc; goto A023; 
	fi;
A042v0v5v7: 
	if 
	:: or_cond24 = cmp12 | or_cond; goto A043v0v5v7; 
	:: memory[v0] = 1; goto A042v5v7; 
	fi;
A041v5v7: 
	if 
	:: or_cond = cmp15 & cmp17; goto A042v5v7; 
	:: memory[v5] = add; goto A041v7; 
	fi;
A040v7: 
	if 
	:: cmp15 = (v12 == v14); goto A041v7; 
	:: memory[v7] = 0; goto A040; 
	fi;
A039: cmp12 = (v12 < v14); goto A040; 
A049v0v6v7: 
	if 
	:: goto A050v0v6v7v15; 
	:: memory[v0] = 1; goto A049v6v7; 
	fi;
A048v6v7: 
	if 
	:: v15 = memory[arrayidx21]; goto A049v6v7; 
	:: memory[v6] = add2; goto A048v7; 
	fi;
A042v0v6v7: 
	if 
	:: or_cond24 = cmp12 | or_cond; goto A043v0v6v7; 
	:: memory[v0] = 1; goto A042v6v7; 
	fi;
A041v6v7: 
	if 
	:: or_cond = cmp15 & cmp17; goto A042v6v7; 
	:: memory[v6] = add2; goto A041v7; 
	fi;
A050v0v5v7v15: memory[v0] = 1; goto A050v5v7v15; 
A049v5v7: 
	if 
	:: goto A050v5v7v15; 
	:: memory[v5] = add; goto A049v7; 
	fi;
A048v7: 
	if 
	:: v15 = memory[arrayidx21]; goto A049v7; 
	:: memory[v7] = 0; goto A048; 
	fi;
A047: getelementptr(1, number, -1, arrayidx21); goto A048; 
A043v0v5v7: 
	if 
	::or_cond24 -> goto A037v0v5v7; 
	::!or_cond24 -> goto A044v0v5v7; 
	:: memory[v0] = 1; goto A043v5v7; 
	fi;
A042v5v7: 
	if 
	:: or_cond24 = cmp12 | or_cond; goto A043v5v7; 
	:: memory[v5] = add; goto A042v7; 
	fi;
A041v7: 
	if 
	:: or_cond = cmp15 & cmp17; goto A042v7; 
	:: memory[v7] = 0; goto A041; 
	fi;
A040: cmp15 = (v12 == v14); goto A041; 
A050v0v6v7v15: memory[v0] = 1; goto A050v6v7v15; 
A049v6v7: 
	if 
	:: goto A050v6v7v15; 
	:: memory[v6] = add2; goto A049v7; 
	fi;
A043v0v6v7: 
	if 
	::or_cond24 -> goto A037v0v6v7; 
	::!or_cond24 -> goto A044v0v6v7; 
	:: memory[v0] = 1; goto A043v6v7; 
	fi;
A042v6v7: 
	if 
	:: or_cond24 = cmp12 | or_cond; goto A043v6v7; 
	:: memory[v6] = add2; goto A042v7; 
	fi;
A050v5v7v15: memory[v5] = add; goto A050v7v15; 
A049v7: 
	if 
	:: goto A050v7v15; 
	:: memory[v7] = 0; goto A049; 
	fi;
A048: v15 = memory[arrayidx21]; goto A049; 
A043v5v7: 
	if 
	::or_cond24 -> goto A037v5v7; 
	::!or_cond24 -> goto A044v5v7; 
	:: memory[v5] = add; goto A043v7; 
	fi;
A042v7: 
	if 
	:: or_cond24 = cmp12 | or_cond; goto A043v7; 
	:: memory[v7] = 0; goto A042; 
	fi;
A041: or_cond = cmp15 & cmp17; goto A042; 
A050v6v7v15: memory[v6] = add2; goto A050v7v15; 
A043v6v7: 
	if 
	::or_cond24 -> goto A037v6v7; 
	::!or_cond24 -> goto A044v6v7; 
	:: memory[v6] = add2; goto A043v7; 
	fi;
A050v7v15: memory[v7] = 0; goto A050v15; 
A049: goto A050v15; 
A043v7: 
	if 
	::or_cond24 -> goto A037v7; 
	::!or_cond24 -> goto A044v7; 
	:: memory[v7] = 0; goto A043; 
	fi;
A042: or_cond24 = cmp12 | or_cond; goto A043; 
A050v15: memory[v15] = 0; goto A050; 
A043: 
	if 
	::or_cond24 -> goto A037; 
	::!or_cond24 -> goto A044; 
	fi;
A050: goto AEnd;
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

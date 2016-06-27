#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 3 	//size of Buffer 
#define null 0
#define I32  1
#define PTR 1
short memUse = 1; 	//shows to the next free cell in memory

//#include "sc.pml"
#include "tso.pml"
//#include "pso.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
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

//Note, CAS operations in LLVM return a tuple (i32, i1), the value read and a success bit.
//Sometimes the follow up code uses the succes bit but usually the read value. 
//Adjust CAS semantics, if necessary.




//------------- functions ------------------

inline proc11(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, 10, inc10;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(x, v4); 
 write(v4, 1);
 read(y, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp = (v8 == add); 
 if 
 	:: cmp ->  goto ifend6;
 	:: !cmp -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend6: 
 write(ly1, v6);
 and7 = add & 1; 
 tobool8 = (and7 == 0); 
 if 
 	:: tobool8 -> 	retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool8 ->  goto ifthen9;
 fi;
 

ifthen9: 
 mfence();
 read(glb, v9); 
 read(v9, 10); 
 inc10 = 10 + 1; 
 write(v9, inc10);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc21(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, and7, tobool8, v9, 10, inc10;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(y, v4); 
 write(v4, 1);
 read(x, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp = (v8 == add); 
 if 
 	:: cmp ->  goto ifend6;
 	:: !cmp -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend6: 
 write(lx2, v6);
 and7 = add & 1; 
 tobool8 = (and7 == 0); 
 if 
 	:: tobool8 -> 	retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool8 ->  goto ifthen9;
 fi;
 

ifthen9: 
 mfence();
 read(glb, v9); 
 read(v9, 10); 
 inc10 = 10 + 1; 
 write(v9, inc10);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc12(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, 10, 11, 12, cmp7, and10, tobool11, 13, 14, inc13;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(x, v4); 
 write(v4, 1);
 read(x, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp = (v8 == add); 
 if 
 	:: cmp ->  goto ifend6;
 	:: !cmp -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend6: 
 write(lx1, v6);
 read(y, v9); 
 read(v9, 10); 
 read(glb, 11); 
 read(11, 12); 
 cmp7 = (12 == add); 
 if 
 	:: cmp7 ->  goto ifend9;
 	:: !cmp7 -> 	retval_0 = -1;
 		retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend9: 
 write(ly1, 10);
 and10 = add & 1; 
 tobool11 = (and10 == 0); 
 if 
 	:: tobool11 -> 	retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool11 ->  goto ifthen12;
 fi;
 

ifthen12: 
 mfence();
 read(glb, 13); 
 read(13, 14); 
 inc13 = 14 + 1; 
 write(13, inc13);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc22(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, v5, v6, v7, v8, cmp, v9, 10, 11, 12, cmp7, and10, tobool11, 13, 14, inc13;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(y, v4); 
 write(v4, 1);
 read(y, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp = (v8 == add); 
 if 
 	:: cmp ->  goto ifend6;
 	:: !cmp -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend6: 
 write(ly2, v6);
 read(x, v9); 
 read(v9, 10); 
 read(glb, 11); 
 read(11, 12); 
 cmp7 = (12 == add); 
 if 
 	:: cmp7 ->  goto ifend9;
 	:: !cmp7 -> 	retval_0 = -1;
 		retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend9: 
 write(lx2, 10);
 and10 = add & 1; 
 tobool11 = (and10 == 0); 
 if 
 	:: tobool11 -> 	retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool11 ->  goto ifthen12;
 fi;
 

ifthen12: 
 mfence();
 read(glb, 13); 
 read(13, 14); 
 inc13 = 14 + 1; 
 write(13, inc13);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc13(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, and5, tobool6, v5, v6, inc8;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(x, v4); 
 write(v4, 1);
 and5 = add & 1; 
 tobool6 = (and5 == 0); 
 if 
 	:: tobool6 -> 	retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool6 ->  goto ifthen7;
 fi;
 

ifthen7: 
 mfence();
 read(glb, v5); 
 read(v5, v6); 
 inc8 = v6 + 1; 
 write(v5, inc8);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc23(returnvalue){
short v0, v1, and, tobool, add, v2, v3, v4, retval_0, and5, tobool6, v5, v6, inc8;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto ifthen;
 	:: !tobool ->  goto dobody;
 fi;
 

ifthen: 
 add = v1 + 1; 
 cas(v0, v1, add, v2); 
 v3 = (v2 == v1); 
 if 
 	:: v3 ->  goto ifend4;
 	:: !v3 -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend4: 
 read(y, v4); 
 write(v4, 1);
 and5 = add & 1; 
 tobool6 = (and5 == 0); 
 if 
 	:: tobool6 -> 	retval_0 = 1;
 		retval_0 = 1;
 	 goto return1;
 	:: !tobool6 ->  goto ifthen7;
 fi;
 

ifthen7: 
 mfence();
 read(glb, v5); 
 read(v5, v6); 
 inc8 = v6 + 1; 
 write(v5, inc8);
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc33(returnvalue){
short v0, v1, and, tobool, v2, v3, v4, cmp, retval_0, v5, v6, v7, v8, cmp1;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto doend;
 	:: !tobool ->  goto dobody;
 fi;
 

doend: 
 read(x, v2); 
 read(v2, v3); 
 read(v0, v4); 
 cmp = (v4 == v1); 
 if 
 	:: cmp ->  goto ifend;
 	:: !cmp -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend: 
 write(lx1, v3);
 read(y, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp1 = (v8 == v1); 
 if 
 	:: cmp1 ->  goto ifend3;
 	:: !cmp1 -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend3: 
 write(ly1, v6);
 	retval_0 = 1;
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline proc43(returnvalue){
short v0, v1, and, tobool, v2, v3, v4, cmp, retval_0, v5, v6, v7, v8, cmp1;
skip;
entry: 
 read(glb, v0); 
   goto dobody;
 

dobody: 
 read(v0, v1); 
 and = v1 & 1; 
 tobool = (and == 0); 
 if 
 	:: tobool ->  goto doend;
 	:: !tobool ->  goto dobody;
 fi;
 

doend: 
 read(y, v2); 
 read(v2, v3); 
 read(v0, v4); 
 cmp = (v4 == v1); 
 if 
 	:: cmp ->  goto ifend;
 	:: !cmp -> 	retval_0 = -1;
 	 goto return1;
 fi;
 

ifend: 
 write(ly2, v3);
 read(x, v5); 
 read(v5, v6); 
 read(glb, v7); 
 read(v7, v8); 
 cmp1 = (v8 == v1); 
 if 
 	:: cmp1 ->  goto ifend3;
 	:: !cmp1 -> 	retval_0 = -1;
 		retval_0 = -1;
 	 goto return1;
 fi;
 

ifend3: 
 write(lx2, v6);
 	retval_0 = 1;
 	retval_0 = 1;
 	retval_0 = 1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline main(argc, argv, returnvalue){

skip;
entry: 
 returnvalue = 0; 
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	//TODO: empty stub
}

proctype process2(chan ch){
	//TODO: empty stub
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, glb);
	alloca(1, x);
	alloca(1, y);
	alloca(1, lx1);
	alloca(1, ly1);
	alloca(1, lx2);
	alloca(1, ly2);
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

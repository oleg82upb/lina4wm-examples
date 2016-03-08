#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 3 	//size of Buffer 
#define null 0
#define I32  0 		// = {0};
#define PTR 0

//#include "sc.pml"
#include "tso.pml"
//#include "pso.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
short choosing = zeroinitializer;
short number = zeroinitializer;

//------------- functions ------------------

inline proci(i){
short arrayidx, v0, v1, v2, v3, v4, cmp, add, add2, arrayidx1, arrayidx3, v5, v6, v7, arrayidx11, j_023, inc, arrayidx6, v8, v9, v10, tobool, arrayidx8, v11, v12, cmp9, cmp17, v13, exitcond, v14, cmp12, arrayidx21, cmp15, v15, or_cond, or_cond24;
skip;
entry: 
 getelementptr(1, choosing, -1, arrayidx); 
 read(arrayidx, v0); 
 write(v0, 1);
 read(, v1); 
 read(v1, v2); 
 read(, v3); 
 read(v3, v4); 
 cmp = (v2 < v4); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto ifelse;
 fi;
 

ifthen: 
 add = v4 + 1; 
 getelementptr(1, number, -1, arrayidx1); 
 read(arrayidx1, v5); 
 write(v5, add);
   goto ifend;
 

ifelse: 
 add2 = v2 + 1; 
 getelementptr(1, number, -1, arrayidx3); 
 read(arrayidx3, v6); 
 write(v6, add2);
   goto ifend;
 

ifend: 
 read(arrayidx, v7); 
 write(v7, 0);
 getelementptr(1, number, -1, arrayidx11); 
 	j_023 = 0;
   goto whilecondpreheader;
 

whilecondpreheader: 
 // phi instruction replaced by assignments before  the goto to this block 
 getelementptr(1, choosing, -1, arrayidx6); 
 read(arrayidx6, v8); 
 read(v8, v9); 
 v10 = v9 & 1; 
 tobool = (v10 == 0); 
 if 
 	:: tobool ->  goto whilecond7loopexitsplit;
 	:: !tobool ->  goto whilecond;
 fi;
 

whilecond: 
   goto whilecond;
 

whilecond7loopexitsplit: 
 getelementptr(1, number, -1, arrayidx8); 
 read(arrayidx8, v11); 
 read(v11, v12); 
 cmp9 = (v12 == 0); 
 cmp17 = (j_023 < i); 
 if 
 	:: cmp9 ->  goto forincsplit;
 	:: !cmp9 ->  goto landrhs;
 fi;
 

landrhs: 
 read(arrayidx11, v13); 
 read(v13, v14); 
 cmp12 = (v12 < v14); 
 cmp15 = (v12 == v14); 
 or_cond = cmp15 & cmp17; 
 or_cond24 = cmp12 | or_cond; 
 if 
 	:: or_cond24 ->  goto landrhs;
 	:: !or_cond24 ->  goto forincsplit;
 fi;
 

forincsplit: 
 inc = j_023 + 1; 
 exitcond = (inc == 2); 
 if 
 	:: exitcond ->  goto forend;
 	:: !exitcond -> 	j_023 = inc;
 	 goto whilecondpreheader;
 fi;
 

forend: 
 getelementptr(1, number, -1, arrayidx21); 
 read(arrayidx21, v15); 
 write(v15, 0);
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
	//TODO: initialize global variables or allocate space here, if necessary
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

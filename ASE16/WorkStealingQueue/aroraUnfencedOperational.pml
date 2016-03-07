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
short bot = null;
short deq = null;
short age = null;
short top = null;

//------------- functions ------------------

inline push(elem){
short v0, v1, v2, arrayidx, inc;
skip;
entry: 
 read(bot, v0); 
 read(v0, v1); 
 read(deq, v2); 
 getelementptr(0, v2, 0, arrayidx); 
 write(arrayidx, elem);
 inc = v1 + 1; 
 write(v0, inc);
 goto ret;


ret: skip;
}


inline dequeue(returnvalue){
short v0, v1, v2, v3, shr, cmp, v4, retval_0, _, arrayidx, v5, add5, v6, v7;
skip;
entry: 
 read(age, v0); 
 read(v0, v1); 
 read(bot, v2); 
 read(v2, v3); 
 shr = v1 >> 16; 
 cmp = (v3 > shr); 
 if 
 	:: cmp ->  goto ifend;
 	:: !cmp -> 	retval_0 = -1;
 	 goto return;
 fi;
 

ifend: 
 read(deq, v4); 
 getelementptr(0, v4, 0, arrayidx); 
 read(arrayidx, v5); 
 add5 = v1 + 65536; 
 cas(v0, v1, add5, v6); 
 v7 = (v6 == v1); 
 _ = (v7 -> v5 : -2); 
 	retval_0 = _;
   goto return;
 

return: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


inline pop(returnvalue){
short v0, v1, cmp, retval_0, v3, dec, v2, arrayidx, v4, v5, shr, cmp1, and, add, cmp5, v6, v8, _pre, v7;
skip;
entry: 
 read(bot, v0); 
 read(v0, v1); 
 cmp = (v1 == 0); 
 if 
 	:: cmp -> 	retval_0 = -1;
 	 goto return;
 	:: !cmp ->  goto ifend;
 fi;
 

ifend: 
 dec = v1 + -1; 
 write(v0, dec);
 read(deq, v2); 
 getelementptr(0, v2, 0, arrayidx); 
 read(arrayidx, v3); 
 read(age, v4); 
 read(v4, v5); 
 shr = v5 >> 16; 
 cmp1 = (dec > shr); 
 if 
 	:: cmp1 -> 	retval_0 = v3;
 	 goto return;
 	:: !cmp1 ->  goto ifend3;
 fi;
 

ifend3: 
 write(v0, 0);
 and = v5 & 65535; 
 add = and + 1; 
 cmp5 = (dec == shr); 
 if 
 	:: cmp5 ->  goto ifthen6;
 	:: !cmp5 -> 	v8 = v4;
 	 goto ifend9;
 fi;
 

ifthen6: 
 cas(v4, v5, add, v6); 
 v7 = (v6 == v5); 
 if 
 	:: v7 -> 	retval_0 = v3;
 	 goto return;
 	:: !v7 ->  goto ifthen6ifend9_crit_edge;
 fi;
 

ifthen6ifend9_crit_edge: 
 read(age, _pre); 
 	v8 = _pre;
   goto ifend9;
 

ifend9: 
 // phi instruction replaced by assignments before  the goto to this block 
 write(v8, add);
 	retval_0 = -1;
   goto return;
 

return: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(){
	//TODO: empty stub
}

proctype process2(){
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
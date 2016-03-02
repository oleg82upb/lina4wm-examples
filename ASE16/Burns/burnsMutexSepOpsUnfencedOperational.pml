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
short f0 = 1;
short f1 = 2;

//------------- functions ------------------
//function was renamed from: @_Z5p1_aqv
inline p1_acq(){
short v0, tobool, conv, cmp;
skip;
entry: 
 write(f0, 1);
   goto whilecond;
 

whilecond: 
 read(f1, v0); 
 tobool = v0; 
 conv = tobool; 
 cmp = (conv != 0); 
 if 
 	:: cmp ->  goto whilebody;
 	:: !cmp ->  goto whileend;
 fi;
 

whilebody: 
   goto whilecond;
 

whileend: 
 goto ret;


ret: skip;
}

//function was renamed from: @_Z6p1_relv
inline p1_rel(){

skip;
entry: 
 write(f0, 0);
 goto ret;


ret: skip;
}

//function was renamed from: @_Z5p2_aqv
inline p2_acq(){
short v0, tobool, conv, cmp, v1, tobool1, conv2, cmp3;
skip;
entry: 
   goto retry;
 

retry: 
   goto whilecond;
 

whilecond: 
 read(f0, v0); 
 tobool = v0; 
 conv = tobool; 
 cmp = (conv != 0); 
 if 
 	:: cmp ->  goto whilebody;
 	:: !cmp ->  goto whileend;
 fi;
 

whilebody: 
   goto whilecond;
 

whileend: 
 write(f1, 1);
 read(f0, v1); 
 tobool1 = v1; 
 conv2 = tobool1; 
 cmp3 = (conv2 != 0); 
 if 
 	:: cmp3 ->  goto ifthen;
 	:: !cmp3 ->  goto ifend;
 fi;
 

ifthen: 
 write(f1, 0);
   goto retry;
 

ifend: 
 goto ret;


ret: skip;
}

//function was renamed from: @_Z6p2_relv
inline p2_rel(){

skip;
entry: 
 write(f1, 0);
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	p1_acq();
	c1: skip;
	p1_rel();
}

proctype process2(chan ch){
	p2_acq();
	c2: skip;
	p2_rel();
}


init{
atomic{
	//TODO: initialize global variables or allocate space here, if necessary
	//run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	//run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	//run process1();
	//run process2();
	}
}

ltl check{ [] ! (process1 @ c1 && process2 @ c2 )}
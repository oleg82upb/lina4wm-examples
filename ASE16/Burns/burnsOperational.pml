#define MEM_SIZE 10	//size of memory
#define null 0
#define I32  0 		// = {0};
#define PTR 0

#include "../x86_tso_buffer.pml"

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
short f0 = 0;
short f1 = 0;
short i = 0;

//------------- functions ------------------
//function was renamed from: @_Z5p1_aqv
inline p1_acq(){
short v0, v1, tobool;
entry: 
 write(f0, 1);
 read(f1, v0); 
 v1 = v0 & 1; 
 tobool = (v1 == 0); 
 if 
 	:: tobool -> goto whileendsplit;
 	:: !tobool -> goto whilecond;
 fi;
 

whilecond: 
 goto whilecond;
 

whileendsplit: 
 goto ret;


ret: skip;
}

//function was renamed from: @_Z6p1_relv
inline p1_rel(){

entry: 
 write(f0, 0);
 goto ret;


ret: skip;
}

//function was renamed from: @_Z5p2_aqv
inline p2_acq(){
short v0, v1, tobool;
entry: 
 read(f0, v0); 
 v1 = v0 & 1; 
 tobool = (v1 == 0); 
 if 
 	:: tobool -> goto ifend;
 	:: !tobool -> goto whilecondbackedge;
 fi;
 

whilecondbackedge: 
 goto whilecondbackedge;
 

ifend: 
 write(f1, 1);
 goto ret;


ret: skip;
}

//function was renamed from: @_Z6p2_relv
inline p2_rel(){

entry: 
 write(f1, 0);
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
	run bufferProcess(channelT1);
	run bufferProcess(channelT2);
	run process1(channelT1);
	run process2(channelT2);
	}
}

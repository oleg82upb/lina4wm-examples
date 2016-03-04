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

//------------- functions ------------------
//function was renamed from: @_ZN5Stack4pushEi
inline push(this, v){
short call, val, head, next, v0, v1, v2, v3, v4, v5, v6;
skip;
invokecont: 
 Znwj(8, call); 
 val = call; 
 write(val, v);
 getelementptr(0, this, 0, head); 
 getelementptr(0, call, 1, next);  /*Needs attention due to different types of first index and aggregate.*/ 
 v0 = next; 
 v1 = this; 
 v2 = call; 
   goto dobody;
 

dobody: 
 read(head, v3); 
 write(v0, v3);
 v4 = v3; 
 cas(v1, v4, v2, v5); 
 v6 = (v5 == v4); 
 if 
 	:: v6 ->  goto doend;
 	:: !v6 ->  goto dobody;
 fi;
 

doend: 
 goto ret;


ret: skip;
}

//function was renamed from: @_ZN5Stack3popEv
inline pop(this, returnvalue){
short head, v0, v1, cmp, retval_0, next, v2, v3, v4, v5, v6;
skip;
entry: 
 getelementptr(0, this, 0, head); 
 v0 = this; 
   goto dobody;
 

dobody: 
 read(head, v1); 
 cmp = (v1 == null); 
 if 
 	:: cmp -> 	retval_0 = null;
 	 goto return;
 	:: !cmp ->  goto ifend;
 fi;
 

ifend: 
 getelementptr(1, v1, 1, next); 
 read(next, v2); 
 v3 = v1; 
 v4 = v2; 
 cas(v0, v3, v4, v5); 
 v6 = (v5 == v3); 
 if 
 	:: v6 -> 	retval_0 = v1;
 	 goto return;
 	:: !v6 ->  goto dobody;
 fi;
 

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

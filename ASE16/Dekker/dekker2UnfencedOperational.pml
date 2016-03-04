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
short flag0 = null;
short flag1 = null;
short turn = null;

//------------- functions ------------------

inline p0(){
short v2, v4, v7, v8;
skip;
entry: 
 write(flag0, 1);
   goto whilecond;
 

whilecond: 
 read(flag1, v2); 
 if 
 	:: v2 ->  goto whilebody;
 	:: !v2 ->  goto whileend12;
 fi;
 

whilebody: 
 read(turn, v4); 
 if 
 	:: v4 ->  goto whilecond;
 	:: !v4 ->  goto ifthen;
 fi;
 

ifthen: 
 write(flag0, 0);
   goto whilecond6;
 

whilecond6: 
 read(turn, v7); 
 if 
 	:: v7 ->  goto whileend;
 	:: !v7 ->  goto whilecond6;
 fi;
 

whileend: 
 read(flag0, v8); 
 write(v8, 1);
   goto whilecond;
 

whileend12: 
 write(turn, 1);
 write(flag0, 0);
 goto ret;


ret: skip;
}


inline p1(){
short v0, v1, v2, tobool, conv, cmp, v3, v9, v4, tobool2, v10, conv3, cmp4, v5, v6, v7, tobool7, conv8, cmp9, v8;
skip;
entry: 
 read(flag1, v0); 
 write(flag1, 1);
   goto whilecond;
 

whilecond: 
 read(flag0, v1); 
 read(v1, v2); 
 tobool = v2; 
 conv = tobool; 
 cmp = (conv == 1); 
 if 
 	:: cmp ->  goto whilebody;
 	:: !cmp ->  goto whileend12;
 fi;
 

whilebody: 
 read(turn, v3); 
 read(v3, v4); 
 tobool2 = v4; 
 conv3 = tobool2; 
 cmp4 = (conv3 != 1); 
 if 
 	:: cmp4 ->  goto ifthen;
 	:: !cmp4 ->  goto ifend;
 fi;
 

ifthen: 
 read(flag1, v5); 
 write(v5, 0);
   goto whilecond6;
 

whilecond6: 
 read(turn, v6); 
 read(v6, v7); 
 tobool7 = v7; 
 conv8 = tobool7; 
 cmp9 = (conv8 != 1); 
 if 
 	:: cmp9 ->  goto whilebody11;
 	:: !cmp9 ->  goto whileend;
 fi;
 

whilebody11: 
   goto whilecond6;
 

whileend: 
 read(flag1, v8); 
 write(v8, 1);
   goto ifend;
 

ifend: 
   goto whilecond;
 

whileend12: 
 read(turn, v9); 
 write(v9, 0);
 read(flag1, v10); 
 write(v10, 0);
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

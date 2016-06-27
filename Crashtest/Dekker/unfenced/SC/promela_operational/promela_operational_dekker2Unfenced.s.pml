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
short flag0 = null;
short flag1 = null;
short turn = null;


//memory allocation
inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type;
	assert(memUse < MEM_SIZE);
	}
}





//------------- functions ------------------

inline p0(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, 10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
skip;
entry: 
 read(flag0, v0); 
 write(v0, 1);
   goto whilecond;
 

whilecond: 
 read(flag1, v1); 
 read(v1, v2); 
 tobool = v2; 
 if 
 	:: tobool ->  goto whilebody;
 	:: !tobool ->  goto whileend9;
 fi;
 

whilebody: 
 read(turn, v3); 
 read(v3, v4); 
 tobool1 = v4; 
 conv = tobool1; 
 cmp = (conv != 0); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto ifend;
 fi;
 

ifthen: 
 read(flag0, v5); 
 write(v5, 0);
   goto whilecond3;
 

whilecond3: 
 read(turn, v6); 
 read(v6, v7); 
 tobool4 = v7; 
 conv5 = tobool4; 
 cmp6 = (conv5 != 0); 
 if 
 	:: cmp6 ->  goto whilebody8;
 	:: !cmp6 ->  goto whileend;
 fi;
 

whilebody8: 
   goto whilecond3;
 

whileend: 
 read(flag0, v8); 
 write(v8, 1);
   goto ifend;
 

ifend: 
   goto whilecond;
 

whileend9: 
 read(turn, v9); 
 write(v9, 1);
 read(flag0, 10); 
 write(10, 0);
 goto ret;


ret: skip;
}


inline p1(){
short v0, v1, v2, tobool, v3, v9, v4, tobool1, 10, conv, cmp, v5, v6, v7, tobool4, conv5, cmp6, v8;
skip;
entry: 
 read(flag1, v0); 
 write(v0, 1);
   goto whilecond;
 

whilecond: 
 read(flag0, v1); 
 read(v1, v2); 
 tobool = v2; 
 if 
 	:: tobool ->  goto whilebody;
 	:: !tobool ->  goto whileend9;
 fi;
 

whilebody: 
 read(turn, v3); 
 read(v3, v4); 
 tobool1 = v4; 
 conv = tobool1; 
 cmp = (conv != 1); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto ifend;
 fi;
 

ifthen: 
 read(flag1, v5); 
 write(v5, 0);
   goto whilecond3;
 

whilecond3: 
 read(turn, v6); 
 read(v6, v7); 
 tobool4 = v7; 
 conv5 = tobool4; 
 cmp6 = (conv5 != 1); 
 if 
 	:: cmp6 ->  goto whilebody8;
 	:: !cmp6 ->  goto whileend;
 fi;
 

whilebody8: 
   goto whilecond3;
 

whileend: 
 read(flag1, v8); 
 write(v8, 1);
   goto ifend;
 

ifend: 
   goto whilecond;
 

whileend9: 
 read(turn, v9); 
 write(v9, 0);
 read(flag1, 10); 
 write(10, 0);
 goto ret;


ret: skip;
}


inline main(returnvalue){

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
	alloca(1, flag0);
	alloca(1, flag1);
	alloca(1, turn);
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

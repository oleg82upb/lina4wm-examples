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
short i = 1;
short j = 1;
short str = 0; //Array: please, check initialization in the init process
short str1 = 0; //Array: please, check initialization in the init process
short _PRETTY_FUNCTION___main = 0; //Array: please, check initialization in the init process


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

inline t1(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
skip;
entry: 
 read(j, v0); 
 read(i, v1); 
 add = v1 + v0; 
 write(i, add);
 read(j, v2); 
 read(i, v3); 
 add_1 = v3 + v2; 
 write(i, add_1);
 read(j, v4); 
 read(i, v5); 
 add_2 = v5 + v4; 
 write(i, add_2);
 read(j, v6); 
 read(i, v7); 
 add_3 = v7 + v6; 
 write(i, add_3);
 read(j, v8); 
 read(i, v9); 
 add_4 = v9 + v8; 
 write(i, add_4);
 returnvalue = null; 
 goto ret;


ret: skip;
}


inline t2(arg, returnvalue){
short v0, v1, add, v2, v3, add_1, v4, v5, add_2, v6, v7, add_3, v8, v9, add_4;
skip;
entry: 
 read(i, v0); 
 read(j, v1); 
 add = v1 + v0; 
 write(j, add);
 read(i, v2); 
 read(j, v3); 
 add_1 = v3 + v2; 
 write(j, add_1);
 read(i, v4); 
 read(j, v5); 
 add_2 = v5 + v4; 
 write(j, add_2);
 read(i, v6); 
 read(j, v7); 
 add_3 = v7 + v6; 
 write(j, add_3);
 read(i, v8); 
 read(j, v9); 
 add_4 = v9 + v8; 
 write(j, add_4);
 returnvalue = null; 
 goto ret;


ret: skip;
}


inline main(argc, argv, returnvalue){
short id1, id2, call, call1, v0, cmp, v1, cmp2;
skip;
entry: 
 alloca(1, id1); 
 alloca(1, id2); 
 pthread_create(id1, null, , null, call); 
 pthread_create(id2, null, , null, call1); 
 read(i, v0); 
 cmp = (v0 > 144); 
 if 
 	:: cmp ->  goto ifthen;
 	:: !cmp ->  goto lorlhsfalse;
 fi;
 

lorlhsfalse: 
 read(j, v1); 
 cmp2 = (v1 > 144); 
 if 
 	:: cmp2 ->  goto ifthen;
 	:: !cmp2 ->  goto ifend;
 fi;
 

ifthen: 
 _assert_fail(str + 0, str1 + 0, 47, _PRETTY_FUNCTION___main + 0); 
 // NOT SUPPORTED: Unreachable

ifend: 
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
	alloca(1, i);
	alloca(1, j);
	alloca(2, str);
	alloca(17, str1);
	alloca(23, _PRETTY_FUNCTION___main);
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

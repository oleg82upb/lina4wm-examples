#define MEM_SIZE 10	//size of memory
#define BUFF_SIZE 5 	//size of Buffer 
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

inline proc0(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12, cmp8, v13;
skip;
entry: 
 read(flag0, v0); 
 write(v0, 1);
 read(flag1, v1); 
   goto whilecond;
 

whilecond: 
 read(v1, v2); 
 cmp = (v2 > 2); 
 if 
 	:: cmp ->  goto whilecond;
 	:: !cmp ->  goto whileend;
 fi;
 

whileend: 
 read(flag0, v3); 
 write(v3, 3);
 read(flag1, v4); 
 read(v4, v5); 
 cmp1 = (v5 == 1); 
 if 
 	:: cmp1 ->  goto ifthen;
 	:: !cmp1 ->  goto ifend;
 fi;
 

ifthen: 
 read(flag0, v6); 
 write(v6, 2);
 read(flag1, v7); 
   goto whilecond2;
 

whilecond2: 
 read(v7, v8); 
 cmp3 = (v8 == 4); 
 if 
 	:: cmp3 ->  goto ifend;
 	:: !cmp3 ->  goto whilecond2;
 fi;
 

ifend: 
 read(flag0, v9); 
 write(v9, 4);
 read(flag1, v10); 
critical:   goto whilecond6;
 

whilecond6: 
 read(v10, v11); 
 cmp7 = (v11 == 2); 
 if 
 	:: cmp7 ->  goto whilecond6;
 	:: !cmp7 ->  goto lorrhs;
 fi;
 

lorrhs: 
 read(v10, v12); 
 cmp8 = (v12 == 3); 
 if 
 	:: cmp8 ->  goto whilecond6;
 	:: !cmp8 ->  goto whileend10;
 fi;
 

whileend10: 
 read(flag0, v13); 
 write(v13, 0);
 goto ret;


ret: skip;
}


inline proc1(){
short v0, v1, v2, cmp, v3, v4, v5, cmp1, v6, v9, v7, v10, v8, v11, cmp3, cmp7, v12;
skip;
entry: 
 read(flag1, v0); 
 write(v0, 1);
 read(flag0, v1); 
   goto whilecond;
 

whilecond: 
 read(v1, v2); 
 cmp = (v2 > 2); 
 if 
 	:: cmp ->  goto whilecond;
 	:: !cmp ->  goto whileend;
 fi;
 

whileend: 
 read(flag1, v3); 
 write(v3, 3);
 read(flag0, v4); 
 read(v4, v5); 
 cmp1 = (v5 == 1); 
 if 
 	:: cmp1 ->  goto ifthen;
 	:: !cmp1 ->  goto ifend;
 fi;
 

ifthen: 
 read(flag1, v6); 
 write(v6, 2);
 read(flag0, v7); 
   goto whilecond2;
 

whilecond2: 
 read(v7, v8); 
 cmp3 = (v8 == 4); 
 if 
 	:: cmp3 ->  goto ifend;
 	:: !cmp3 ->  goto whilecond2;
 fi;
 

ifend: 
 read(flag1, v9); 
 write(v9, 4);
 read(flag0, v10); 
   goto whilecond6;
 

whilecond6: 
 read(v10, v11); 
 cmp7 = (v11 > 1); 
 if 
 	:: cmp7 ->  goto whilecond6;
 	:: !cmp7 ->  goto whileend9;
 fi;
 

whileend9: 
 read(flag1, v12); 
 write(v12, 0);
 goto ret;


ret: skip;
}


//------------- process template -------------

//Stubs
proctype process1(chan ch){
	proc0();
}

proctype process2(chan ch){
	proc1();
}


init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, flag0);
	alloca(1, flag1);
	//two layers of pointers need initialization
	memory[flag0] = 3;
	memory[flag1] = 4;
	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run process1(channelT1);
	run process2(channelT2);
	}
}

ltl prop{ [] !((process1@critical) && (process2@whileend9))}
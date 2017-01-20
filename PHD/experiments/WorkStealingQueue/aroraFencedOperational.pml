#define MEM_SIZE 15	//size of memory
#define BUFF_SIZE 3 	//size of Buffer 
#define null 0
#define I32  1
#define PTR 1
short memUse = 1; 	//shows to the next free cell in memory



//abstract deque as array----------------------
#define ASSIZE 5
short asDeq[ASSIZE];
hidden byte asTop = 0, asBot = 0;

inline asEmpty()
{
	assert (asTop == asBot);
}

inline asPop(popValue) 
{
	atomic
	{
		assert(asBot < asTop); //not empty
		asTop--;								 
		assert (asDeq[asTop] == popValue); 	 	
		asDeq[asTop] = 0;						
	}
}

inline asDequeue(deqValue) 
{
	atomic
	{ 
		assert(asBot < asTop); //not empty
		assert (asDeq[asBot] == deqValue); 	
		asDeq[asBot] = 0;						
		asBot++;
	}
}

inline asPush(pushValue)
{
	atomic
	{
		assert(asTop < ASSIZE); //make sure, stack array is never full
		asDeq[asTop] = pushValue;
		asTop++;
	}
}


//#include "sc.pml"
#include "tso.pml"
//#include "pso.pml"


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
chan channelT3 = [0] of {mtype, short, short, short};
short bot = null;
short deq = null;
short age = null;
short top = null;


//pointer computation 
inline getelementptr(type, instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
	assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
	}
}
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


inline casLPDeq(adr, oldValue, newValue, casRes, res)
{
atomic{
 	cas(adr, oldValue, newValue, casRes);
 	if 
 		:: casRes == oldValue -> asDequeue(res); printf("Stealer stolen: %d \n", res);
 		:: else -> skip; //may be not empty anymore
 	fi;
 	}
}

inline casLPPop(adr, oldValue, newValue, casRes, v3)
{
atomic{
 	cas(adr, oldValue, newValue, casRes);
 	if 
 		:: casRes == oldValue -> asPop(v3); printf("Owner Pop: %d \n", v3);
 		:: else -> asEmpty(); printf("Owner Empty  \n");
 	fi;
 	}
}

//------------- functions ------------------

inline push(elem){
short v0, v1, v2, arrayidx, inc;
skip;
entry: 
 read(bot, v0); 
 read(v0, v1); 
 read(deq, v2); 
 getelementptr(10, v2, v1, arrayidx); 
 write(arrayidx, elem);
 inc = v1 + 1; 
 mfence();
 writeLP(v0, inc, elem);		//flush is LP
 printf("Owner Push: %d \n", elem);
 goto ret;


ret: skip;
}


inline dequeue(returnvalue){
short v0, v1, v2, v3, shr, cmp, v4, retval_0, _v, arrayidx, v5, add5, v6, v7;
skip;
entry: 
 read(age, v0); 
 read(v0, v1); 
 read(bot, v2); 
 
 //atomic{
 read(v2, v3); 			//LP if empty, but may also fail due to being interupted for too long (thus failing for seemingly no reason)
 //if 
 //	:: !(v3 > (v1 >> 8)) -> asEmpty();  printf("Stealer Empty\n");
 //	:: else -> skip;
 //fi;
 //}	
 shr = v1 >> 8; 
 cmp = (v3 > shr); 
 if 
 	:: cmp ->  goto ifend;
 	:: !cmp -> 	retval_0 = -1; goto return1;
 fi;
 

ifend: 
 read(deq, v4); 
 getelementptr(10, v4, shr, arrayidx); 
 read(arrayidx, v5); 
 add5 = v1 + 256; 
 casLPDeq(v0, v1, add5, v6, v5); 		//LP if non-empty
 v7 = (v6 == v1); 
 _v = (v7 -> v5 : -2); 
 	retval_0 = _v;
   goto return1;
 

return1: 
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
 atomic{
 read(v0, v1); 				//LP if empty
 cmp = (v1 == 0);
 if
 	:: cmp -> asEmpty(); printf("Owner Empty\n");
 	:: else -> skip;
 fi; 
 }
 if 
 	:: cmp -> 	retval_0 = -1;
 	 goto return1;
 	:: !cmp ->  goto ifend;
 fi;
 

ifend: 
 dec = v1 -1; 
 write(v0, dec);
 read(deq, v2); 
 getelementptr(10, v2, dec, arrayidx); 
 read(arrayidx, v3); 
 read(age, v4); 
 mfence();
 atomic{
 read(v4, v5);			//LP if more elements left 
 if 
 	:: (dec > (v5 >> 8)) -> asPop(v3); printf("Owner Pop: %d \n", v3);
 	:: else -> skip;
 fi;
 }
 shr = v5 >> 8; 
 cmp1 = (dec > shr); 
 if 
 	:: cmp1 -> 	retval_0 = v3; goto return1;
 	:: !cmp1 ->  goto ifend3;
 fi;

ifend3: 
 write(v0, 0);
 and = v5 & 255; 
 add = and + 1; 
 cmp5 = (dec == shr); 
 if 
 	:: cmp5 ->  goto ifthen6;
 	:: !cmp5 -> v8 = v4; goto ifend9;
 fi;
 

ifthen6: 
 casLPPop(v4, v5, add, v6, v3); 			//LP if last element
 v7 = (v6 == v5); 
 if 
 	:: v7 -> retval_0 = v3;  goto return1;
 	:: !v7 ->  goto ifthen6ifend9_crit_edge;
 fi;
 

ifthen6ifend9_crit_edge: 
 read(age, _pre); 
 	v8 = _pre;
   goto ifend9;
 

ifend9: 
 // phi instruction replaced by assignments before  the goto to this block 
 mfence(); //only required for PSO
 write(v8, add);
 	retval_0 = -1;
   goto return1;
 

return1: 
 // phi instruction replaced by assignments before  the goto to this block 
 returnvalue = retval_0; 
 goto ret;


ret: skip;
}


//------------- process template -------------

short result1, result2, result3;
//Stubs
proctype process1(chan ch){
	
	push(111);
	mfence();
	push(222);
	mfence();
	push(333);
	mfence();
	pop(result1);
	//assert(result1 == -1 || result1 == 111 || result1 == 222 || result1 == 333);
	mfence();
	//printf("Proc1: %d \n", result);
	pop(result2);
	//assert(result2 == -1 || result2 == 111 || result2 == 222 );
	//printf("Proc1: %d \n", result);
	mfence();
	push(444);
	mfence();
	pop(result3);
	//assert(result3 == -1 || result3 == 111  || result3 == 444);
}

proctype process2(chan ch){
	short result;
	dequeue(result);
	//assert (!(result != -1 && result != -2) || (result != result1 && result != result2 && result != result3));
	mfence();
	dequeue(result);
	//assert (!(result != -1 && result != -2) || (result != result1 && result != result2 && result != result3));
	mfence();
	dequeue(result);
	//assert (!(result != -1 && result != -2) || (result != result1 && result != result2 && result != result3));
	//assert(result == -1 || result == -2 || result == 111 || result == 222 || result == 333 || result == 444);
}


//Stubs
proctype process3(chan ch){
	short result;
	push(111);
	mfence();
	pop(result);
	//assert(result == -1 || result == 111);
	mfence();
	push(222);
	mfence();
	pop(result);
	//assert(result == -1 || result == 222);
	mfence();
	push(333);
	mfence();
	pop(result);
	//assert(result == -1 || result == 222 || result == 333);
}

proctype process4(chan ch){
	short result;
	dequeue(result);
	mfence();
	dequeue(result);
	//assert(result == -1 || result == -2 || result == 111 || result == 222 || result == 333);
}

proctype process5(chan ch){
	short result;
	dequeue(result);
	mfence();
	dequeue(result);
	//assert(result == -1 || result == -2 || result == 111 || result == 222 || result == 333);
}

init{
atomic{
	//initialize global variables or allocate memory space here, if necessary
	alloca(1, bot);
	alloca(1, memory[bot]);
	alloca(1, age);
	alloca(1, memory[age]);
	alloca(1, deq);
	alloca(6, memory[deq]);
	

	
	run bufferProcess(channelT1); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT2); //obsolete for SC, remove line when SC is chosen
	run bufferProcess(channelT3); //obsolete for SC, remove line when SC is chosen
	//run process1(channelT1);
	//run process2(channelT2);
	run process3(channelT1);
	run process4(channelT2);
	run process5(channelT3);
	}
}

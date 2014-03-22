/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 12.2013

workstealing queue implementation
*/
/*
	trying to specify the LLVM-compiled workstealingqueue implementation (wsq.s)
*/
//-----------------------------------------------------------------------------------------------------------------------------------------------
//global variable declaration
short wsq_ptr;
short top, bottom;
#define EMPTY 42
#define ABORT 1337
//-----------------------------------------------------------------------------------------------------------------------------------------------

#define BUFF_SIZE 14	//size of Buffer
#define MEM_SIZE 40	//size of memory
#define MAX_QUEUE_SIZE 10
//-----------------------------------------------------------------------------------------------------------------------------------------------
/* abstract Queue implementation as array*/




//byte asSize = 1;
short asQueue[MAX_QUEUE_SIZE];   //Promlem promela intends const.
hidden byte asTop = 0;
hidden byte asBottom = 0;
bool flag = 0;


/*
inline asExpand(){
	assert(asSize*2 <= MAX_QUEUE_SIZE);
	asSize = 2*asSize;
}
*/

inline writeFlagTake(bottom, v2){
	atomic{
		write(bottom, v2);
		flag = 1;
	}
}

inline asEmpty(){
	assert (asTop == asBottom);
	assert (asQueue[asTop] == 0);
}


inline asPush(asValue){
	atomic{
			/*if
			::(asBottom - asTop >= asSize) -> asExpand();
			::else -> skip;
			fi -> 
			*/
			assert(asBottom < MAX_QUEUE_SIZE); 
			asQueue[asBottom] = memory[memory[memory[wsq_ptr]+1] + asValue-1];			//set new value in the queue, asValue = newlocalbottom; so look at place where ap = memory[wsq_ptr]+1 is pointing to
			asBottom = (asBottom+1);				//move tail
			printf("-----------------   value written --------------\n");
		}
}


inline readLPTake(t, v5 ,v4){
	atomic{ 
		read(t, v5);
		if 	:: v4 < v5 -> asEmpty(); printf("---- EMPTY: nothing to TAKE ----\n");
			:: else -> skip;
		fi;
	}
}

inline casLPtake(top, t, new_t, success, task){
	// 2 steps for the executing process, but atomic on memory
	
	ch ! iCas, top, t, new_t;
	atomic{
		ch ? iCas, top, success, _;
		if 	:: success -> asPopBottom(task); printf("popBottom CAS success\n")
			:: else -> asEmpty(); printf("---- EMPTY: nothing to TAKE ----\n"); skip;  //cas may fail
		fi; 
	}
}


//abstract TAKE()
inline asPopBottom(task){
	atomic{
		flag = 0;
		printf("FLAG: %d\n", flag);
		asBottom = (asBottom-1);					//move bottom to the next in line
		assert((asQueue[asBottom] == task)|| (task == EMPTY));
		if
		::(asQueue[asBottom] == task) -> asQueue[asBottom] = 0;						//remove element from queue
										printf("---- TAKE successful ----\n");  	//asValue must be the element top is pointing to
		:: (task == EMPTY) -> asEmpty(); printf("---- EMPTY: nothing to TAKE ----\n"); 
		:: else -> printf("MISTAKE!!!\n");
		fi;	
	}
}


inline readLPSteal(bot, v1, v0){
	atomic{ 
		read(bot, v1);
	
		if 	
			:: (v0 >= v1)
				->	if
						::(flag == 0) -> asEmpty(); printf("---- EMPTY: nothing to steal ----\n");
						::else -> printf("!!!!! Empty failed !!!!!!   \n");
					fi
			:: else -> printf("there is something to steal  \n");
		fi;
	}
}

inline casLPsteal(top, t, new_t, success, task){
	// 2 steps for the executing process, but atomic on memory
	
	ch ! iCas, top, t, new_t;
	atomic{
		ch ? iCas, top, success, _;
		if 	:: success -> asPopTop(task); printf("popTop CAS success\n")
			:: else -> printf("---- ABORT: nothing to steal ----\n"); skip;  //cas may fail
		fi; 
	}
}

//abstract steal()
//task is the value we expect to be at the place top is pointing to
inline asPopTop(task){
	atomic{	
		assert(asQueue[asTop] == task);
		if
		:: (asQueue[asTop] == task) ->	asQueue[asTop] = 0;					//remove element from queue	
										asTop = (asTop+1);					//move top to the next in line
										printf("---- steal successful ----\n"); 	//asValue must be the element top is pointing to
		:: else -> printf("MISSTEAL!!!\n");
		fi;
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "tso_buffer_wsq.pml"
//-----------------------------------------------------------------------------------------------------------------------------------------------

//Types for LLVM, actually their length in size of pointers and values
#define I32  0 		// = {0};
#define Ptr  0
#define item_t 1	// stands for typedef item_t{short size; short* ap};

short memUse = 1; 	//shows to the next free cell in memory


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
//chan channelT3 = [0] of {mtype, short, short, short};

inline getelementptr(type, instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//offset directly correspond to adding it to instance address. 
	assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
	}
}

inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}
//-------------------------------------------------------------------------------------------------

inline expand(returnval){
	
	printf("EXPAND()\n");
	
	short exp_newsize, exp_newitems, exp_newitems_ptr, exp_newq, exp_newq_ptr, j, exp_size, exp_size3, exp_size6, exp_ap, exp_ap2, exp_arrayindex, exp_arrayindex2;
	short exp_v0, exp_v1, exp_v2, exp_v5, exp_v6, exp_v7, exp_v9, exp_v10, exp_v11, exp_v12, exp_v13, exp_v14, exp_v15, exp_v16, exp_v17, exp_v18, exp_v19, exp_v20, exp_v21, exp_v22;

entry:	
	atomic{
		alloca(I32, exp_newsize);
		alloca(Ptr, exp_newitems_ptr);
		alloca(Ptr, exp_newq_ptr);
		alloca(I32, j);
	}
	read(wsq_ptr, exp_v0);
	getelementptr(item_t, exp_v0, 0, exp_size);
	read(exp_size, exp_v1);
	write(exp_newsize, 2*exp_v1);
	read(exp_newsize, exp_v2);
	alloca(exp_v2, exp_newitems); //creates an array of size newsize
	memory[exp_newitems_ptr] = exp_newitems;
	alloca(item_t, exp_newq);
	memory[exp_newq_ptr] = exp_newq;
	read(top, exp_v5);
	write(j, exp_v5);
	
forCond:
	read(j, exp_v6);
	read(bottom, exp_v7);	
	if
	::(exp_v6 < exp_v7) -> goto forBody; 	// in llvm: slt "=" Signed Less Equal (<)
	::else -> goto forEnd;
	fi
	->

forBody:
	read(wsq_ptr, exp_v9);
	getelementptr(item_t, exp_v9, 0, exp_size3);
	read(exp_size3, exp_v10);
	read(wsq_ptr, exp_v11);
	getelementptr(item_t, exp_v11, 1, exp_ap);
	read(exp_ap, exp_v12);
	getelementptr(exp_v10, exp_v12, exp_v6  % exp_v10, exp_arrayindex); // exp_v10 is the size of the "old" wsq_ptr. so loop through this array which has no more than exp_v10 entries.
	read(exp_arrayindex, exp_v13); //exp_13 holds the value which stands in the array at the certain place
	read(j, exp_v14);
	read(exp_newsize, exp_v15);
	read(exp_newitems_ptr, exp_v16);
	getelementptr(exp_v15, exp_v16, exp_v14 % exp_v15, exp_arrayindex2);
	write(exp_arrayindex2, exp_v13); //should write the contain of the old array in the newone

forInc:
	read(j, exp_v17);
	exp_v17 = exp_v17 + 1;
	write(j, exp_v17); 
	goto forCond;	

forEnd:
	read(exp_newsize, exp_v18);
	read(exp_newq_ptr, exp_v19);
	getelementptr(item_t, exp_v19, 0, exp_size6);
	write(exp_size6, exp_v18);
	read(exp_newitems_ptr, exp_v20);
	read(exp_newq_ptr, exp_v21); //could be left out and reuse exp_v19 because it's local
	getelementptr(item_t, exp_v21, 1, exp_ap2);
	write(exp_ap2, exp_v20);  //exp_ap2 = exp_newitems;
	read(exp_newq_ptr, exp_v22);
	write(wsq_ptr, exp_v22); //wsq_ptr = exp_newq_ptr;
	returnval = exp_v22;
	printf("Queue enlarged \n");	
}	


inline push(task)
{
	printf("PUSH %d\n",task);
	short task_addr, b, t, q_ptr, size, size2, returnval, ap, arrayindex;
	short v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13;
entry:
	atomic{
		alloca(I32, task_addr);
		alloca(I32, b);
		alloca(I32, t);
		alloca(Ptr, q_ptr);
	}
	write(task_addr,task);
	read(bottom, v0);
	write(b,v0);
	read(top, v1);
	write(t, v1);
	read(wsq_ptr, v2);
	write(q_ptr, v2);
	read(b, v3);
	read(t, v4);
	read(q_ptr, v5);
	getelementptr(item_t, v5, 0, size);
	read(size, v6);
	if
	::(v3-v4 >= v6-1) -> 	expand(returnval);
							write(q_ptr, returnval); 
	:: else -> skip;
	fi;
	
	read(task_addr, v7);
	read(b, v8);
	read(q_ptr, v9);
	getelementptr(item_t, v9, 0, size2);
	read(size2, v10);
	read(q_ptr, v11);
	getelementptr(item_t, v11, 1, ap);
	read(ap, v12); //ap is pointer
	getelementptr(v10, v12, v8 % v10, arrayindex);
	write(arrayindex, v7);
	read(b, v13);
	v13 = v13 +1;
	writeLP(bottom, v13, 1);						//LP
	printf("Finished PUSHing %d\n",task);
}	
	
inline take(returnvalue)
{
	printf("ENTERING take()\n");
	short retval, b, t, q_ptr, task, size, ap, arrayindex, success;
	short v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v20, v21, v22;
	atomic{
		alloca(I32, retval);
		alloca(I32, b);
		alloca(Ptr, q_ptr);
		alloca(I32, t);
		alloca(I32, task);
	}
	read(bottom, v0);
	write(b, v0 - 1);
	read(wsq_ptr, v1);
	write(q_ptr, v1);
	read(b, v2);
    writeFlagTake(bottom, v2);         
	read(top, v3);
	write(t, v3);
	read(b, v4);
	readLPTake(t, v5 ,v4);			//LP
	if
	:: (v4 < v5) -> 	read(t, v6);			//possible reduction
						write(bottom, v6);
						write(retval, EMPTY);
						goto returnLabel;
	:: else -> goto ifEnd;
	fi;
	
ifEnd:
	read(b, v7);
	read(q_ptr, v8);
	getelementptr(item_t, v8, 0, size);
	read(size, v9);
	read(q_ptr, v10);
	getelementptr(item_t, v10, 1, ap);
	read(ap, v11);
	getelementptr(v9, v11, v7 % v9, arrayindex);
	read(arrayindex, v12);
	write(task, v12);
	read(b, v13);
	read(t, v14);			
	if
	::(v13 > v14) -> 	read(task, v15);
						writeLP(retval, v15, v12);		//LP???				//possible reduction: write(retval = v12)???
						goto returnLabel;
	:: else -> goto ifEnd3;
	fi;
	
ifEnd3:
	read(t, v16);
	v17 = v16 + 1;
	casLPtake(top, v16, v17, success, v12);		//LP				//v12 = content of task(because variable task ist allocated)
	if
	:: (success) -> goto ifEnd5;
	:: else -> write(task, EMPTY); goto ifEnd5;
	fi;

ifEnd5:
	read(t, v20);
	v20 = v20 + 1;
	write(bottom, v20);
	read(task, v21);
	write(retval, v21);
	goto returnLabel;
	
returnLabel:
	read(retval, v22);
	returnvalue = v22; 
	printf("LEAVING take()\n");
}

inline steal(returnvalue){
	printf("ENTERING steal()\n");
	short retval, t, b, q_ptr, task, size, ap, arrayindex, success;
	short v0, v1, v2, v3, v4, v5, v6, v7,v8, v9, v10, v11, v12, v15, v16;

entry:
	atomic{
		alloca(I32, retval);
		alloca(I32, t);
		alloca(I32, b);
		alloca(Ptr, q_ptr);
		alloca(I32, task);
	}
	read(top, v0);		//here could be the Problem!!!!!! if push is running in parallel 
	write(t, v0);		// LPfail here????
	readLPSteal(bottom, v1, v0); //if bottom changes after this point LP differs????
	write(b,v1);
	read(wsq_ptr, v2);
	write(q_ptr, v2);
	read(t,v3);
	read(b, v4);			//if bottom hasn't changed LP is here
	if
	::(v3 >= v4) -> write(retval, EMPTY); 
					goto returnLabel;
	::else -> goto ifEnd;
	fi;
	
ifEnd:
	read(t,v5);
	read(q_ptr, v6);
	getelementptr(item_t, v6, 0, size);
	read(size, v7);
	read(q_ptr, v8);
	getelementptr(item_t, v8, 1, ap);
	read(ap,v9);
	getelementptr(v7, v9, v5 % v7, arrayindex);
	read(arrayindex, v10);
	write(task, v10);
	read(t, v11);
	v12 = v11+1;
	casLPsteal(top, v11, v12, success, v10);
	if
	::(success == true) -> 	read(task, v15); 
							write(retval, v15);
	::else -> write(retval, ABORT);
			  goto returnLabel;
	fi;
	
returnLabel:
	read(retval, v16);
	returnvalue = v16;
	printf("LEAVING steal()\n");

}
	
	

proctype process1 (chan ch){
	short tvalue1, tvalue2;
	push(555); 
	//mfence();
	//take(tvalue2);
	mfence();
	//push(777);
	push(999);
	take(tvalue1);
}

 proctype process2 (chan ch) {
 	short svalue;
	steal(svalue); printf("svalue: %d\n", svalue);
	//steal(s2);printf("svalue: %d\n", s2);
	skip;
}

/* proctype process3 (chan ch){
	short stealval;
	steal(stealval);
	printf("stealval: %d\n", stealval);
}
*/

init{
	short wsq;
		alloca(Ptr, wsq_ptr);
		alloca(item_t, wsq);
		memory[wsq_ptr] = wsq;
		alloca(I32, top);
		memory[top]=0;
		alloca(I32, bottom);
		memory[bottom]=0;
		memory[wsq] = 3; //initial size = 3
		memory[wsq+1] = 6; //ap Pointer points to memorypart of size "memory[wsq]"(= size of wsq) 
		//memory[6]=0; not neccessary because memory is initialized
		memUse = memUse + memory[wsq];
	atomic{
		run process1(channelT1); 
		run bufferProcess(channelT1);
		run process2(channelT2);
		run bufferProcess(channelT2);
		//run process3(channelT3);
		//run bufferProcess(channelT3);
	}	
}	
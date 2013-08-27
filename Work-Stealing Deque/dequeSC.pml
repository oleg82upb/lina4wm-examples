#define BUFF_SIZE 6 	//size of Buffer
#define MEM_SIZE 30	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
//Types for LLVM, actually their length in size of pointers and values
#define Queue  1 	//= {0,1}; (head and tail)
#define Node  1	//= {0,1};
#define I32  0 		// = {0};
#define Ptr  0
#define ABORT -256
#define Age 1
#define NULL 0


short memUse = 1; 	//shows to the next free cell in memory
short bot, age; //, deq;

//-------------------------------------------------------------------------------------------------
//abstract Queue implemented as array----------------------
#define ASSIZE 6
short asQueue[ASSIZE];
hidden byte asHead = 0;
hidden byte asTail = 0;
//hidden byte asIsEmpty = true;

short deq[ASSIZE]; 

inline cas(adr, oldValue, newValue, returnValue) {
	atomic{
	if 	:: adr == oldValue
			-> {
				adr = newValue;
				returnValue = true;
				}
		:: else -> returnValue = false;
	fi;
	}
}


inline asEnqueue(asValue)
{
	
	atomic{
	assert(asTail < ASSIZE);
	asTail = (asTail+1);										//move tail
	asQueue[asTail] = asValue;									//set new value in the queue
	}
}



inline asDequeueFail()
{
	assert (asHead == asTail);
}

inline asPopBottomFail()
{
	assert (asHead == asTail);
}


inline asPopBottom(asValue)
{
	atomic
	{
		assert (asQueue[asTail] == asValue);  	//asValue must be the element tail is poniting to
		asQueue[asTail] = 0;							//remove element from queue
		asTail = (asTail-1);					//move head to the next in line
	}
}

//asValue the value we expect to be at the place head is pointing to
inline asPopTop(task)
{
	atomic
	{
		assert(asHead != asTail);				//check non-empty
		asHead = (asHead+1);					//move head to the next, since it is always pointing to slot before actual content 
		assert (asQueue[asHead] == task);  		//asValue must be the element head is poniting to
		asQueue[asHead] = 0;					//remove element from queue
	}
}

inline popTopFailCheck(localBot, oldAge)
{
	atomic{ 
	if 	:: (localBot <= (oldAge % 100)) -> /*asDequeueFail();*/printf("popTop empty failed\n");
		:: else -> skip;
	fi;
	}
}
inline asPopTopCheck(task, casResult)
{
	// 2 steps for the executing process, but atomic on memory
	
	atomic{
	if 	:: casResult -> asPopTop(task); printf("popTop CAS success\n")
		:: else -> skip;  //cas may fail non-deterministically
	fi; 
	}
}


inline asPushBottom(asValue)
{
	atomic{
	asEnqueue(asValue);
	printf("pushBottom success\n");
	}
}


//------------------------------------------------------------------------------------------------------


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

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

inline alloca(type, targetRegister)
{
	atomic{
	//need c_Code here, but for now we could use this to statically define used addresses
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}

//-------------------------------------------------------------------------------------------

inline pushBottom(task)
{
printf("inv pushBottom");
	short localBot;
	localBot = bot;
	deq[localBot] = task;
	localBot = localBot + 1;
	atomic{
	bot = localBot;
	asPushBottom(task);
	}
printf("ret pushBottom");
}

inline popTop(result)
{
printf("inv popTop");
		short oldAge, localBot, oldAgeTop, task, newAge;
		bit casResult;
		
		oldAge = age;
		oldAgeTop = (oldAge % 100);
		
		atomic{
		localBot = bot;
		popTopFailCheck(localBot, oldAge); //LP: OP may non-deterministically fail, e.g. if popBottom removes element 
		}
		 
		if 	:: localBot <= oldAgeTop -> result = NULL; goto retT;
			:: else -> skip;
		fi;
		
		task = deq[oldAgeTop];
		newAge = oldAge;
		newAge = newAge + 1;	
		atomic{
		cas(age, oldAge, newAge, casResult);
		asPopTopCheck(task, casResult);
		}
		if 	:: casResult -> result = task;
			:: else -> result = NULL;
		fi;		
retT: 	printf("ret popTop");
}


inline popBottom(result)
{
		printf("inv popBottom");
		short  localBot, task, oldAge, oldAgeTop, newAge, tmp, tmp2;
		bit casResult;
		
		atomic{//LP
		localBot = bot;
		if 	:: localBot == 0 -> asPopBottomFail();
			:: else -> skip;
		fi;
		}
		
		
		if	:: localBot == 0 -> result = NULL; goto retB;
			:: else -> skip;
		fi;
		
		localBot = localBot - 1;
		
		atomic{
		bot = localBot;				//LP
//		if 	:: (asTail - asHead > 1)/*asHead != asTail*/ -> asPopBottom(deq[localBot]); tmp2  = deq[localBot];
//			:: else -> skip; //not linearized yet 		//asPopBottomFail(); tmp2 = NULL;
//		fi;
		}
		task = deq[localBot];
		
		atomic{
		oldAge = age;
		oldAgeTop = (oldAge % 100);
		if :: localBot > oldAgeTop -> //if non empty, removes element
			{
			asPopBottom(deq[localBot]); tmp2  = deq[localBot];	
			//if 	:: true/*asHead != asTail*/ -> asPopBottom(deq[localBot]); tmp2  = deq[localBot];	
			//	:: else -> asPopBottomFail(); tmp2 = NULL;
			//fi;
			}
			:: else -> skip;
		fi;
		}
		 
		
		if	:: localBot > oldAgeTop -> result = task; goto retB;
			:: else -> skip;
		fi;
		
		atomic{
		bot = 0;
		//asPopBottom(deq[localBot]);			not LP
		}
		//newAge = 0;	//obsolete
		tmp = oldAge - (oldAge % 100);	
		newAge = tmp + 100; 	 
		
		if	:: localBot == oldAgeTop 
			-> 	{
					atomic{
					cas(age, oldAge, newAge, casResult); //LP wenn es das letzte element ist
					if	:: casResult -> {asPopBottom(deq[localBot]);tmp2  = deq[localBot];}
						:: else skip;
					fi;
					}
					if	:: casResult -> result = task; goto retB;
						:: else skip;
					fi;
				}
			:: else skip;
		fi;
		
		age = newAge;
		result = NULL;
		
retB: 	printf("ret popBottom");
		assert(result == tmp2);
}
//---------------------------------------------------------------------------------------------------------------------------------------

short result1, result2;
proctype process1(chan ch){
	short result;
	pushBottom(111);
	pushBottom(222);
	pushBottom(333);
	popBottom(result);
	printf("Proc1: %d \n", result);
	popBottom(result);
	printf("Proc1: %d \n", result);
	pushBottom(444);
	popBottom(result);
	//assert(result == 333);
	printf("Proc1: %d \n", result);
}

proctype process2(chan ch){
	short result;
	popTop(result);
	//skip;
	//assert(result == ABORT || memory[4] != 0 || result == 333);
	printf("Proc2: %d \n", result);
}

proctype process3(chan ch){
	short result;
	popTop(result);
	printf("Proc3: %d \n", result);
	//skip;
	//assert(result == ABORT || memory[4] != 0 || result == 333);
}

proctype process4(chan ch){
	short result;
	popTop(result);
	printf("Proc4: %d \n", result);
	//skip;
	//assert(result == ABORT || memory[4] != 0 || result == 333);
}



init{
atomic{
	//alloca(Ptr, bot);	//int*
	//alloca(Ptr, age);	//int*
	//alloca(Ptr, deq);	
	//alloca(ASSIZE, memory[deq]);
	bot = 0; 
	age = 0;
	

	run process1(channelT1);
	//run bufferProcess(channelT1);
	run process2(channelT2);
	run process3(channelT2);
	run process4(channelT2);
	//run bufferProcess(channelT2);
	//run process3(channelT3);
	//run bufferProcess(channelT3);
	}
}

// check{ [] (process1@retB && process2@retT -> (result1 == 0 || result1 != result2)) }
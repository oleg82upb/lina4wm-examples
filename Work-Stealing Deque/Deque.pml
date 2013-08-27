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


short memUse = 1; 	//shows to the next free cell in memory
short bot, age, deq;

//-------------------------------------------------------------------------------------------------
//abstract Queue implemented as array----------------------
#define ASSIZE 6
short asQueue[ASSIZE];
hidden byte asHead = 0;
hidden byte asTail = 0;
//hidden byte asIsEmpty = true; 


inline asEnqueue(asValue)
{
	
	atomic{
	assert(asTail < ASSIZE);
	asTail = (asTail+1);										//move tail
	asQueue[asTail] = asValue;									//set new value in the queue
	printf("-----------------   value written --------------\n");
	}
}
inline asEmpty()
{
	assert (asHead == asTail);
}

inline casLP(age, v0, v1, casResult, task)
{	
	ch ! iCas, age, v0, v1;
	atomic{
	ch ? iCas, age, casResult, _;
	if	:: casResult -> asPopBottom(task);
		:: else -> skip;
	fi; 
	}
}
inline asPopBottom(asValue)
{
	atomic
	{
		assert (asQueue[asTail] == asValue);  	//asValue must be the element head is poniting to
		asQueue[asTail] = 0;							//remove element from queue
		asTail = (asTail-1);					//move head to the next in line
	}
}


//asValue the value we expect to be at the place head is pointing to
inline asPopTop(asValue)
{
	atomic
	{
		
		asHead = (asHead+1);					//move head to the next in line
		assert (asQueue[asHead] == task);  	//asValue must be the element head is poniting to
		asQueue[asHead] = 0;							//remove element from queue
	}
}

inline readLPpopTopFail(bot, localBot, oldAge)
{
	atomic{ 
	read(bot, localBot);
	if 	:: (localBot < (oldAge % 100)) -> asEmpty();printf("popTop empty failed\n");
		:: else -> skip;
	fi;
	}
}
inline casLPpopTop(age, v0, v5, casResult, task)
{
	// 2 steps for the executing process, but atomic on memory
	
	ch ! iCas, age, v0, v5;
	atomic{
	ch ? iCas, age, casResult, _;
	if 	:: casResult -> asPopTop(task); printf("popTop CAS success\n")
		:: else -> skip;  //cas may fail non-deterministically
	fi; 
	}
}

inline readLPpopBottomFail(bot, localBot)
{
	atomic{ 
	read(bot, localBot);
	if 	:: (localBot == 0) -> asEmpty();printf("popBottom empty failed\n");
		:: else -> skip;
	fi;
	}
}

inline readLPPopBottom(age, v0, localBot, task)
{
	atomic{
	read(age, v0);
	if	:: localBot > (v0 % 100) -> asPopBottom(task);
		:: else -> skip;
	fi;
	} 
}

//inline writeLPpopBottom(bot, localBot)
//{
//	ch ! iWrite, bot, localBot, 1;
//}


inline writeLPpushBottom(bot, localBot)
{	
	ch ! iWrite, bot, localBot, 3;
}
inline asPushBottom(asValue)
{
	atomic{
	asEnqueue(memory[memory[deq]+asValue-1]);
	printf("pushBottom success\n");
	}
}

#include "Deque_TSO.pml"
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
	short localBot, localDeq, v0,v1;
	read(bot, localBot);
	read(deq, localDeq);
	v0 = localDeq + localBot;
	write(v0, task);				
	v1 = localBot + 1;
	writeLPpushBottom(bot, v1);					//LP
printf("ret pushBottom");
}

inline popTop(result)
{
printf("inv popTop");
		short oldAge, localBot, oldAgeTop, task, localDeq, newAge, v0,v1, v2, v3,v4, v5, v6;
		bit casResult;
		
		alloca(Ptr, oldAge);
		alloca(Ptr, newAge);
		
		read(age, v0);
		write(oldAge, v0);
		read(bot, localBot);
		//readLPpopTopFail(bot, localBot, v0);			//LP if bot <= oldAgeTop but no check since non-det. failing
		
		oldAgeTop = (v0 % 100);							//oldAge.top == last two digits
		if :: (localBot <= oldAgeTop)					//read oldAge.top
			-> result = NULL; goto ret; 
			:: else -> skip;
		fi;
		
		read(deq, localDeq);
		v3 = localDeq+oldAgeTop;
		read(v3, task);
		
		read(oldAge, v1);
		write(newAge, v1); 								//newAge = oldage;	useless write here
		v5=	(v1 % 100) + 1;	//newAge.top++
		write(newAge, v5);
		
		casLPpopTop(age, v0, v5, casResult, task);		//LP	cas(age, oldAge, newAge, casResult)
		
		if 	:: (casResult) -> result = task;
			:: else -> result = ABORT; 
		fi;
ret: skip;
printf("ret popTop");
}


inline popBottom(result)
{
printf("inv popBottom");
	short  localBot, localDeq, task, v0, oldAge, oldAgeTop, newAge, v1, v2, v3, v4, v5, v6,v7;
	bit casResult;
		
		result = NULL;
		alloca(Ptr, oldAge);
		alloca(Ptr, newAge);
		
		readLPpopBottomFail(bot, localBot);			//LP if bot == 0
		if :: (localBot == 0)						   
			-> goto ret;
			:: else -> skip;
		fi;
		
		localBot--;
		write(bot, localBot);						//not LP, as it turned out in SC version
		//FENCE NEEDED HERE, OTHERWISE TASKS MAY BE ASSIGNED TWICE 
		mfence();
		
		read(deq, localDeq);
		v3 = localDeq+localBot;
		read(v3, task);
		readLPPopBottom(age, v0, localBot, task);	//the actual LP
		write(oldAge, v0);				
		oldAgeTop = (v0 % 100);
		if :: (localBot > oldAgeTop)				//read oldAge.top
			-> result = task; goto ret; 
			:: else -> skip;
		fi;
		
		write(bot, 0);
		
		
		//last two digits are 00 -> do nothing
		//v5 = (newAge + 1);	//newAge.top address
		//write(v5, 0);   	//newAge.top = 0
		
		//first two digits are incremented
		//read(oldAge, v0);		//deref oldAge pointer
		//read(v0, v1);  			//read oldAge.tag
		//v6 = (v1+1);
		//write(newAge, v6);		//newAge.tag = oldAge.tag + 1
		atomic{
		v1 = v0- (v0%100);	//v1 first two digits remain, the last two are 00
		v1 = v1 + 100; 		//tag increment
		}
		write(newAge, v1);								//local yet
		
		if :: (localBot == oldAgeTop)					//read oldAge.top
			->  
			{
			casLP(age, v0, v1, casResult, task);  		//LP if last element; orininal version really swaps v1 and age in case of success
			if :: (casResult)			
				-> result = task; goto ret; 
				:: else-> skip;
			fi;
			}
			:: else -> skip;
		fi;
		//read(newAge, v2);								//a compiled version would reload here
		write(age, v1);s
ret: skip;
printf("ret popBottom");
}
//---------------------------------------------------------------------------------------------------------------------------------------
proctype process1(chan ch){
	short result;
	pushBottom(111);
	mfence();
	pushBottom(222);
	mfence();
	pushBottom(333);
	mfence();
	popBottom(result);
	mfence();
	//printf("Proc1: %d \n", result);
	popBottom(result);
	//printf("Proc1: %d \n", result);
	mfence();
	pushBottom(444);
	mfence();
	popBottom(result);
	//printf("Proc1: %d \n", result);
}

proctype process2(chan ch){
	short result;
	popTop(result);
	mfence();
	popTop(result);
	mfence();
	popTop(result);
	//skip;
}


init{
atomic{
	alloca(Ptr, bot);	//int*
	alloca(Ptr, age);	//int*
	//alloca(Age, memory[age]);
	alloca(Ptr, deq);	
	alloca(ASSIZE, memory[deq]);
	

	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	//run process3(channelT3);
	//run bufferProcess(channelT3);
	}
}

	
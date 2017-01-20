//abstract deque as array----------------------
#define ASSIZE 5
short asDeq[ASSIZE];
hidden byte asTop = 0, asBot;

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
		assert (asDeq[asBot] == poppedValue); 	
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




inline readLPPopFail(adr, target)
{
	atomic{
	//short readValue;
	read(adr, target)
	//target = readValue;
	if 
		:: target == NULL -> asPopFail();
		:: else -> skip;
	fi
	}
}

inline casLPPop(adr, oldValue, newValue, success) 
{
	// 2 steps for the executing process, but atomic on memory
	//bit success;
	atomic{
	cas(adr, oldValue, newValue, success);
	//returnValue = success;
	if 
		:: success -> asPop(oldValue, success); //if successfull, then the popped value is the oldValue
		:: else -> skip;
	fi
	}
}

inline casLPPush(adr, oldValue, newValue, success, controlValue) 
{
	// 2 steps for the executing process, but atomic on memory
	//bit success;
	atomic{
	cas(adr, oldValue, newValue, success);
	//returnValue = success;
	if 	:: success -> asPush(controlValue);
		:: else -> skip;
	fi
	}
}
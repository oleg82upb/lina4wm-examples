//abstract Stack implemented as array----------------------
#define ASSIZE 4
short asStack[ASSIZE];
hidden byte asTop = 0;

//asValue the value we expect to be on top of the stack
inline asPop(asValue, asReturn) //can leave out the returnValue????????????????????????????????
{
	atomic
	{
		asTop--;										//decrement top 
		assert (asStack[asTop] == memory[asValue]);  	//asValue must be top element
		asStack[asTop] = 0;								//remove element from stack
	}
}

inline asPopFail()
{
	assert (asTop == 0)
}

inline asPush(asValue)
{
	atomic
	{
		assert(asTop < ASSIZE); //make sure, stack array is never full
		asStack[asTop] = asValue;
		asTop++;
	}
	//should we return something?
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
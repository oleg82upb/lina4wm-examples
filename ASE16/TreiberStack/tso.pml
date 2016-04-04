// Start of user code operational TSO model
// This code will not be regenerated, if you change it. Delete the file 
// or remove the first and last line of the file, if you want it to be regenerated.  
#define NULL 0

/*Buffer as a 2 dimensional array which represents the queue [(nx2)-matrix]*/
typedef matrix{short line [2]}

mtype = {iWrite, iRead , iMfence, iCas};
/*memory*/
short memory[MEM_SIZE];


inline write(adr, newValue)
{
	ch ! iWrite, adr, newValue, NULL;
}

inline read(adr, target)
{
	atomic{
	ch ! iRead, adr, NULL, NULL;
	ch ? iRead, NULL, target, NULL;
	}
}

inline mfence()
{
	atomic{
	ch ! iMfence, NULL, NULL, NULL;
	ch ? iMfence, NULL, NULL, NULL;
	}
}	

inline cas(adr, oldValue, newValue, successBit) 
{
	// 2 steps for the executing process, but atomic on memory
	atomic{
	assert(adr != null);
	ch ! iCas, adr, oldValue, newValue;
	ch ? iCas, NULL, successBit, NULL; 
	}
}

inline writeB() {
		assert(tail < BUFF_SIZE && address != null);
		buffer[tail].line[0] = address;
		buffer[tail].line[1] = value;
		tail++;
		address = 0;
		value = 0;
}


inline readB() {
	i = tail-1;
	do
	:: i >= 0  -> 
			if
			/* if an address in the buffer is equivalent to the searched -> return value*/
			::buffer[i].line[0] == address 
				->  channel ! iRead,NULL,buffer[i].line[1],NULL;
					break;
			::else -> i--;
			fi
			/*else: access to memory and return value of searched address*/
	::else ->
		channel ! iRead,NULL,memory[address],NULL;
		break;
	od;
	address = 0;
	value=0;
	i = 0;
}


inline flushB() {
	if 
	:: (tail > 0) ->	{
		//write value in memory: memory[address] = value
		memory[buffer[0].line[0]] = buffer[0].line[1];
		//move all content one step further
		
		for (i : 1 .. tail-1) {
			buffer[i-1].line[0] = buffer[i].line[0];
			buffer[i-1].line[1] = buffer[i].line[1];
		} 
		//remove duplicate tail
		buffer[tail-1].line[0] = 0;
		buffer[tail-1].line[1] = 0;
		tail--;
		i = 0;
		}
	:: else -> skip;
	fi;
}

inline mfenceB() {
	do
	::(tail<=0) -> break;	//tail > 0 iff buffer not empty
	:: else -> flushB(); 
	od;
}

inline fenceWithResponse() {
	mfenceB();
	channel ! iMfence, NULL, NULL, NULL;
}
	
inline casB() 
{
		mfenceB();	//buffer must be empty 
		if 
			:: memory[address] == value 
				-> 	memory[address] = newValue;
					channel ! iCas, NULL, true, NULL;
			:: else -> channel ! iCas, NULL, false, NULL;
		fi;
		address = 0;
		value = 0;
		newValue = 0;
}

proctype bufferProcess(chan channel)
{		
	/*start resp. end of queue*/
	short tail = 0;
	short i = 0;
	short address = 0;
	short value = 0; 
	short newValue = 0;
	
	/*writebuffer*/
	matrix buffer [BUFF_SIZE];

	
end:	do 
		::	if
				//WRITE
				:: atomic{channel ? iWrite(address,value, NULL) -> writeB();
				//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
				}
				//READ
				:: atomic{channel ? iRead, address, NULL, NULL -> readB();
				//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
				}
				//FLUSH
				:: atomic{(tail > 0) -> flushB();  //tail > 0  iff not empty
				//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
				}
				//FENCE
				:: atomic{channel ? iMfence, NULL, NULL ,NULL -> fenceWithResponse();
				//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
				}
				//COMPARE AND SWAP
				:: atomic{channel ? iCas, address , value, newValue -> casB();
				//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
				}
			fi
		od
}
// End of user code

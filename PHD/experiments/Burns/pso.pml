// Start of user code operational PSO model
// This code will not be regenerated, if you change it. Delete the file 
// or remove the first and last line of the file, if you want it to be regenerated.  
#define NULL 0


//---------------- abstract spec
short mtxOwner = 0;

inline acquire(pid)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = pid;
	 }
}

inline release(pid)
{
	atomic{
	 assert(mtxOwner == pid);
	 mtxOwner = 0;
	 }
}
//---------------- abstract spec end


mtype = {iWrite, iRead , iMfence, iCas};
/*memory*/

//buffer for each address 
typedef SingleAdrBuffer {short entry [BUFF_SIZE]};

//the memory
short memory[MEM_SIZE];

//------------------------------------------------------------
// interface to memory model that is used by program processes
inline write(adr, newValue)
{
	atomic{
	ch ! iWrite, adr, newValue, NULL;
	}
}

inline writeLP(adr, newValue, lp)
{
	atomic{
	ch ! iWrite, adr, newValue, lp;
	}
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
		ch ! iCas, adr, oldValue, newValue;
		ch ? iCas, NULL, successBit, NULL; 
	}
}


//-------------------------------------------------------------
//the semantics for each instruction
inline writeB() {
	atomic{
	assert(address != 0);
	assert(address < MEM_SIZE);
	assert(tail[address] < BUFF_SIZE);
	buffer[address].entry[tail[address]] = value;
	bufferLPs[address].entry[tail[address]] = lp;
	tail[address]++;
	address = 0;
	value = 0;
	lp = 0;
	}
}


inline readB() {
	atomic{
	assert(address != 0);
	if	
		//entry in buffer exists
		:: ((tail[address]) > 0) 
			-> channel ! iRead, NULL, buffer[address].entry[(tail[address] - 1)], NULL;
		//no entry in buffer, take it from memory
		:: else 
			-> channel ! iRead, NULL, memory[address], NULL;
	fi;
	address = 0;
	value=0;
	}
}


inline flushB() {
atomic{
	//select all possible addresses to flush from (non-deterministically)
	//select(address : 1 .. (BUFF_SIZE - 1));
	flushAdr = 0;
	if 
		:: 1 < MEM_SIZE && tail[1] > 0 -> flushAdr = 1;
		:: 2 < MEM_SIZE && tail[2] > 0 -> flushAdr = 2;
		:: 3 < MEM_SIZE && tail[3] > 0 -> flushAdr = 3;
		:: 4 < MEM_SIZE && tail[4] > 0 -> flushAdr = 4;
		:: 5 < MEM_SIZE && tail[5] > 0 -> flushAdr = 5;
		:: 6 < MEM_SIZE && tail[6] > 0 -> flushAdr = 6;
		:: 7 < MEM_SIZE && tail[7] > 0 -> flushAdr = 7;
		:: 8 < MEM_SIZE && tail[8] > 0 -> flushAdr = 8;
		:: 9 < MEM_SIZE && tail[9] > 0 -> flushAdr = 9;
		:: 10 < MEM_SIZE && tail[10] > 0 -> flushAdr = 10;
		:: 11 < MEM_SIZE && tail[11] > 0 -> flushAdr = 11;
		:: 12 < MEM_SIZE && tail[12] > 0 -> flushAdr = 12;
		:: 13 < MEM_SIZE && tail[13] > 0 -> flushAdr = 13;
		:: 14 < MEM_SIZE && tail[14] > 0 -> flushAdr = 14;
		:: 15 < MEM_SIZE && tail[15] > 0 -> flushAdr = 15;
		:: 16 < MEM_SIZE && tail[16] > 0 -> flushAdr = 16;
		:: 17 < MEM_SIZE && tail[17] > 0 -> flushAdr = 17;
		:: 18 < MEM_SIZE && tail[18] > 0 -> flushAdr = 18;
		:: 19 < MEM_SIZE && tail[19] > 0 -> flushAdr = 19;
		:: 20 < MEM_SIZE && tail[20] > 0 -> flushAdr = 20;
		//...
		//extend if more memory is required
		//...
		:: else -> skip;
	fi;
	
	if 
	:: (flushAdr > 0) ->	{
		//write oldest value to memory
		memory[flushAdr] = buffer[flushAdr].entry[0];
		
		// triggering abstract operation during LP flush here
		if
			:: bufferLPs[flushAdr].entry[0] != 0 -> release(bufferLPs[flushAdr].entry[0]);
			:: else -> skip;
		fi;
		
		
		//move all content one step further
		for (i : 1 .. (tail[flushAdr]-1)) 
		{
			buffer[flushAdr].entry[i-1] = buffer[flushAdr].entry[i]
			bufferLPs[flushAdr].entry[i-1] = bufferLPs[flushAdr].entry[i]
		} 
		//remove duplicate tail
		buffer[flushAdr].entry[tail[flushAdr]-1] = 0; //i = tail-1
		bufferLPs[flushAdr].entry[tail[flushAdr]-1] = 0; //i = tail-1
		tail[flushAdr]--;	//tail--;
		flushAdr = 0;
		i = 0;
		}
	:: else -> skip;
	fi;
	}
}

inline mfenceB() {
	atomic{	
		do
		::
			if
			::(    (1 >= MEM_SIZE || tail[1] <= 0) 
				&& (2 >= MEM_SIZE || tail[2] <= 0)
				&& (3 >= MEM_SIZE || tail[3] <= 0)
				&& (4 >= MEM_SIZE || tail[4] <= 0)
				&& (5 >= MEM_SIZE || tail[5] <= 0)
				&& (6 >= MEM_SIZE || tail[6] <= 0)
				&& (7 >= MEM_SIZE || tail[7] <= 0)
				&& (8 >= MEM_SIZE || tail[8] <= 0)
				&& (9 >= MEM_SIZE || tail[9] <= 0)
				&& (10 >= MEM_SIZE || tail[10] <= 0)
				&& (11 >= MEM_SIZE || tail[11] <= 0)
				&& (12 >= MEM_SIZE || tail[12] <= 0)
				&& (13 >= MEM_SIZE || tail[13] <= 0)
				&& (14 >= MEM_SIZE || tail[14] <= 0)
				&& (15 >= MEM_SIZE || tail[15] <= 0)
				&& (16 >= MEM_SIZE || tail[16] <= 0)
				&& (17 >= MEM_SIZE || tail[17] <= 0)
				&& (18 >= MEM_SIZE || tail[18] <= 0)
				&& (19 >= MEM_SIZE || tail[19] <= 0)
				&& (20 >= MEM_SIZE || tail[20] <= 0)
				//...
				//extend if more memory is required
				//...
				) -> break;	//tail[i] > 0 iff buffer not empty
			::else -> flushB(); 
			fi;
		od;
	}
}

inline fenceWithResponse() {
	mfenceB();
	channel ! iMfence, NULL, NULL, NULL;
}
	
inline casB() 
{
	mfenceB();	//buffer must be empty
	atomic{
	assert(address != 0);
	i = memory[address];
	if 
		:: memory[address] == value 
			-> 	memory[address] = newValue;
		:: else -> skip;
	fi;
	channel ! iCas, NULL, i, NULL;
	address = 0;
	value = 0;
	newValue = 0;
	i = 0;
	}
}




proctype bufferProcess(chan channel)
{		
	/*start resp. end of queue*/
	short i = 0;
	short address = 0;
	short flushAdr = 0;
	short value = 0; 
	short newValue = 0;
	SingleAdrBuffer buffer [MEM_SIZE];
	SingleAdrBuffer bufferLPs [MEM_SIZE];
	short tail [MEM_SIZE];

	
end:	do 
		::	if
				//WRITE
				:: atomic{channel ? iWrite(address,value, lp) -> writeB();
					//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
					}
				//READ
				:: atomic{channel ? iRead, address, NULL, NULL -> readB();
					//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
					}
				//FLUSH
				:: atomic{flushB();  
					//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
					}
				//FENCE
				:: atomic{channel ? iMfence, NULL, NULL, NULL -> fenceWithResponse();
					//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
					}
				//COMPARE AND SWAP
				:: atomic{channel ? iCas, address , value, newValue -> casB();
					//i = 0; address = 0; value = 0; newValue = 0; //can reduce state space, but not reliably
					};
			fi
		od
}
// End of user code

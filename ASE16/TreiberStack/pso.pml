// Start of user code operational PSO model
// This code will not be regenerated, if you change it. Delete the file 
// or remove the first and last line of the file, if you want it to be regenerated.  
#define NULL 0

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


//-------------------------------------------------------------
//the semantics for each instruction
inline writeB() {
	atomic{
	assert(address < MEM_SIZE);
	assert(tail[address] < BUFF_SIZE && address != null);
	buffer[address].entry[tail[address]] = value;
	tail[address]++;
	address = 0;
	value = 0;
	}
}


inline readB() {
	atomic{
	assert(address != 0);
	if	
		//entry in buffer exists
		:: ((tail[address] - 1) > 0) 
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
	flAdr = 0;
	if 
		:: 1 < MEM_SIZE && tail[1] > 0 -> flAdr = 1;
		:: 2 < MEM_SIZE && tail[2] > 0 -> flAdr = 2;
		:: 3 < MEM_SIZE && tail[3] > 0 -> flAdr = 3;
		:: 4 < MEM_SIZE && tail[4] > 0 -> flAdr = 4;
		:: 5 < MEM_SIZE && tail[5] > 0 -> flAdr = 5;
		:: 6 < MEM_SIZE && tail[6] > 0 -> flAdr = 6;
		:: 7 < MEM_SIZE && tail[7] > 0 -> flAdr = 7;
		:: 8 < MEM_SIZE && tail[8] > 0 -> flAdr = 8;
		:: 9 < MEM_SIZE && tail[9] > 0 -> flAdr = 9;
		:: 10 < MEM_SIZE && tail[10] > 0 -> flAdr = 10;
		:: 11 < MEM_SIZE && tail[11] > 0 -> flAdr = 11;
		:: 12 < MEM_SIZE && tail[12] > 0 -> flAdr = 12;
		:: 13 < MEM_SIZE && tail[13] > 0 -> flAdr = 13;
		:: 14 < MEM_SIZE && tail[14] > 0 -> flAdr = 14;
		:: 15 < MEM_SIZE && tail[15] > 0 -> flAdr = 15;
		:: 16 < MEM_SIZE && tail[16] > 0 -> flAdr = 16;
		:: 17 < MEM_SIZE && tail[17] > 0 -> flAdr = 17;
		:: 18 < MEM_SIZE && tail[18] > 0 -> flAdr = 18;
		:: 19 < MEM_SIZE && tail[19] > 0 -> flAdr = 19;
		:: 20 < MEM_SIZE && tail[20] > 0 -> flAdr = 20;
		//...
		//extend if more memory is required
		//...
		:: else -> skip;
	fi;
	
	if 
	:: (flAdr > 0) ->	{
		//write oldest value to memory
		memory[flAdr] = buffer[flAdr].entry[0];
		
		//move all content one step further
		for (i : 1 .. (tail[flAdr]-1)) 
		{
			buffer[flAdr].entry[i-1] = buffer[flAdr].entry[i]
		} 
		//remove duplicate tail
		buffer[flAdr].entry[tail[flAdr]-1] = 0; //i = tail-1
		tail[flAdr]--;	//tail--;
		flAdr = 0;
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
}




proctype bufferProcess(chan channel)
{		
	/*start resp. end of queue*/
	short i = 0;
	short address = 0;
	short flAdr = 0;
	short value = 0; 
	short newValue = 0;
	SingleAdrBuffer buffer [MEM_SIZE];
	short tail [MEM_SIZE];

	
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

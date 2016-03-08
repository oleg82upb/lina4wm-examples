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
	ch ? iRead, adr, target, NULL;
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
		ch ? iCas, adr, successBit, _; 
	}
}


//-------------------------------------------------------------
//the semantics for each instruction
inline writeB() {
	atomic{
	assert(address < MEM_SIZE);
	i = tail[address];
	assert(i < BUFF_SIZE);
	buffer[address].entry[i] = value;
	tail[address]++;
	i= 0;
	}
}


inline readB() {
	assert(address != 0);
	i = tail[address] - 1;
	do
	//entry in buffer exists
	:: i >= 0     
		->	channel ! iRead,address,buffer[address].entry[i],NULL;
			break;
	//no entry in buffer, take it from memory
	:: else 
		->	channel ! iRead, address, memory[address], NULL;
			break;
	od;
	i = 0;
}


inline flushB() {
atomic{
	//select all possible addresses to flush from (non-deterministically)
	//select(address : 1 .. (BUFF_SIZE - 1));
	address = 0;
	if 
		:: 1 < MEM_SIZE && tail[1] > 0 -> address = 1;
		:: 2 < MEM_SIZE && tail[2] > 0 -> address = 2;
		:: 3 < MEM_SIZE && tail[3] > 0 -> address = 3;
		:: 4 < MEM_SIZE && tail[4] > 0 -> address = 4;
		:: 5 < MEM_SIZE && tail[5] > 0 -> address = 5;
		:: 6 < MEM_SIZE && tail[6] > 0 -> address = 6;
		:: 7 < MEM_SIZE && tail[7] > 0 -> address = 7;
		:: 8 < MEM_SIZE && tail[8] > 0 -> address = 8;
		:: 9 < MEM_SIZE && tail[9] > 0 -> address = 9;
		:: 10 < MEM_SIZE && tail[10] > 0 -> address = 10;
		:: 11 < MEM_SIZE && tail[11] > 0 -> address = 11;
		:: 12 < MEM_SIZE && tail[12] > 0 -> address = 12;
		:: 13 < MEM_SIZE && tail[13] > 0 -> address = 13;
		:: 14 < MEM_SIZE && tail[14] > 0 -> address = 14;
		:: 15 < MEM_SIZE && tail[15] > 0 -> address = 15;
		:: 16 < MEM_SIZE && tail[16] > 0 -> address = 16;
		:: 17 < MEM_SIZE && tail[17] > 0 -> address = 17;
		:: 18 < MEM_SIZE && tail[18] > 0 -> address = 18;
		:: 19 < MEM_SIZE && tail[19] > 0 -> address = 19;
		:: 20 < MEM_SIZE && tail[20] > 0 -> address = 20;
		//...
		//extend if more memory is required
		//...
		:: else -> skip;
	fi;
	
	if 
	:: (address > 0) ->	{
		//write oldest value to memory
		memory[address] = buffer[address].entry[0];
		
		//move all content one step further
		for (i : 1 .. (tail[address]-1)) 
		{
			buffer[address].entry[i-1] = buffer[address].entry[i]
		} 
		//remove duplicate tail
		buffer[address].entry[tail[address]-1] = 0; //i = tail-1
		tail[address]--;	//tail--;
		address = 0;
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
		bit result = false;
		if 
			:: memory[address] == value 
				-> 	memory[address] = newValue;
					result = true;
			:: else -> skip;
		fi
		->
		channel ! iCas, address, result, NULL;
		//reducing state space from here on
	}
	
}




proctype bufferProcess(chan channel)
{		
	/*start resp. end of queue*/
	short i = 0;
	short address = 0;
	short value = 0; 
	short newValue = 0;
	SingleAdrBuffer buffer [MEM_SIZE];
	short tail [MEM_SIZE];

	
end:	do 
		::	if
				//WRITE
				:: atomic{channel ? iWrite(address,value, _) -> writeB();
					i = 0; address = 0; value = 0; newValue = 0;
					}
				//READ
				:: atomic{channel ? iRead, address, value, _ -> readB();
					i = 0; address = 0; value = 0; newValue = 0;
					}
				//FLUSH
				:: atomic{flushB();  
					i = 0; address = 0; value = 0; newValue = 0;
					}
				//FENCE
				:: atomic{channel ? iMfence, _, _ ,_ -> fenceWithResponse();
					i = 0; address = 0; value = 0; newValue = 0;
					}
				//COMPARE AND SWAP
				:: atomic{channel ? iCas, address , value, newValue -> casB();
					i = 0; address = 0; value = 0; newValue = 0;
					};
			fi
		od
}





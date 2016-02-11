#define NULL 0
#define ADRESSE_X 1
#define ADRESSE_Y 2
#define BUFF_LENGTH 1	//number of copies per address in buffer
#define BUFF_SIZE 3 	//size of Buffer (number of different addresses accepted by buffer + 1) 
#define MEM_SIZE 5		//size of memory 


mtype = {iWrite, iRead , iMfence, iCas};
/*memory*/

//array of values makes an entry
typedef SingleAdrBuffer {short entry [BUFF_LENGTH]};
//one array per address makes a buffer
//and tails for each buffer/FIFO-queue
//typedef Buffer {SingleBuffer buffer [BUFF_SIZE];
//				short tail [BUFF_SIZE]};

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
	ch ! iMfence, NULL, NULL, NULL;
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
	assert(address < BUFF_SIZE);
	i = tail[address];
	assert(i < BUFF_LENGTH);
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
	select(address : 1 .. (BUFF_SIZE - 1));
	if 
	:: (tail[address] > 0) ->	{
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
			i = 0;
			for(address : 1 .. BUFF_SIZE)
			{
				i =  i || (tail[address] > 0);
			}
			if
			::(i <= 0) -> address = 0; i = 0; break;	//tail > 0 iff buffer not empty
			::else -> flushB(); 
			fi;
		od;
	}
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
	SingleAdrBuffer buffer [BUFF_SIZE];
	short tail [BUFF_SIZE];

	
end:	do 
		::	if
				//WRITE
				:: atomic{channel ? iWrite(address,value, _) -> writeB();
					//i = 0; address = 0; value = 0; newValue = 0;
					}
				//READ
				:: atomic{channel ? iRead, address, value, _ -> readB();
					//i = 0; address = 0; value = 0; newValue = 0;
					}
				//FLUSH
				:: atomic{flushB();  
					//i = 0; address = 0; value = 0; newValue = 0;
					}
				//FENCE
				:: channel ? iMfence, _, _ ,_ -> mfenceB();
				//COMPARE AND SWAP
				:: atomic{channel ? iCas, address , value, newValue -> casB()
					//i = 0; address = 0; value = 0; newValue = 0;
					};
			fi
		od
}




//------------------------------------------
// one channel per process should be declared
chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};






//-----------------------------------------
//global variable definitions
short r1 = 0;
short r2 = 0;
short r3 = 0;
short r4 = 0;



//-----------------------------------------
//proctypes


proctype process1(chan ch)
{
	write(ADRESSE_X, 1);
	read(ADRESSE_X, r1);
	read(ADRESSE_Y, r2);
	end: skip;
}


proctype process2(chan ch)
{	
	write(ADRESSE_Y, 1);
	read(ADRESSE_Y, r3);
	read(ADRESSE_X, r4);
	end: skip;	
}

init
{
	atomic{
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2)
	}
}

ltl check_0{ [] (process1 @ end && process2 @ end -> ( ! (r1 == 1 && r2 == 0 && r3 == 1 && r4 == 0)))}

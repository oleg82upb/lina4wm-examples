/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 06.2013

seqlock implementation

*/

/*
	trying to specify the LLVM-compiled seqlock implementation (seqlock.s)
*/

#define BUFF_SIZE 12 	//size of Buffer
#define MEM_SIZE 13	//size of memory
//initalization of global variables
#define x1 1
#define x2 2
#define c 3
 
//--------------------------------------------------------------------------------------------------------------
//abstract spezification
short val1, val2;	//abstract specification values


inline asWrite(){
atomic{
	val1 = memory[x1];
	val2 = memory[x2];
	}
}


inline asRead(value1, value2){
atomic{
	assert( val1 == value1 && val2 == value2);
	}
}
//--------------------------------------------------------------------------------------------------------------
 #include "seqlock_llvm_TSO.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
//Types for LLVM, actually their length in size of pointers and values
#define I32  0 		// = {0};
#define Ptr  0
#define Array 1
short memUse = 4; 	//shows to the next free cell in memory
short arrayp1, arrayp2;

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
chan channelT3 = [0] of {mtype, short, short, short};

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
	//need c_Code here, but for now we could use this to statically define used addresses
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}
//-------------------------------------------------------------------------------------------------

inline swrite(word1, word2){
short word1_addr, word2_addr, v0, v1, v2, v3;

entry:
	atomic{
		alloca(I32, word1_addr);
		alloca(I32, word2_addr);
	}
	write(word1_addr, word1);
	write(word2_addr, word2);
	read(c,v0);
	write(c,v0+1);
	read(word1_addr, v1);
	write(x1,v1);
	read(word2_addr, v2);
	write(x2,v2);
	read(c,v3);
	writeLP(c, v3+1, 1);
}



inline sread(word){
short word_addr, v0, v2, v3, v4, v5, v6, arrayidx, arrayidx2;

entry:
	atomic{
		alloca(I32, word_addr);
	}
	write(word_addr, word);
	
doBody1: read(c,v0);

	if 
	::(v0%2) -> goto doBody1
	:: else -> skip;
	fi;
	read(x1,v2);
	read(word_addr, v3);
	getelementptr(Array, v3, 0, arrayidx);
	write(arrayidx, v2);
	read(x2,v4);
	read(word_addr,v5);
	getelementptr(Array, v5, 1, arrayidx2);
	write(arrayidx2, v4);	
	
	readLP(c, v6, v2, v4, v0);
	if
	:: (v6 != v0) -> goto doBody1;
	:: else -> skip				
	fi;	
}

proctype process1 (chan ch){
	//short i;
	//for (i : 1 .. 2) 
	{
			swrite(1,1);
			swrite(2,2);
			//mfence();
	} 
}

proctype process2(chan ch){

	sread(arrayp1);
	sread(arrayp1);
	//for (i : 1 .. 2) {sread(array);}		
}

proctype process3(chan ch){
	sread(arrayp2);
	
	//for (i : 1 .. 2) {sread(array);}		
}

init{		
	atomic{
		alloca(Array, arrayp1);
		//alloca(Array, arrayp2);
		run process1(channelT1);
		run bufferProcess(channelT1);
		run process2(channelT2);
		run bufferProcess(channelT2	);
		//run process3(channelT3);
		//run bufferProcess(channelT3	);
	}
}		

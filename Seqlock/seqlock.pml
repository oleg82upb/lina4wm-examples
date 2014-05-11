
/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 05.2013

Lseqlock (abstracted from: "Show No Weakness: Sequentially Consistent Specifications of TSO Libraries; Alexey Gotsman, Madanlal Musuvathi, and Hongseok Yang
*/

#define BUFF_SIZE 10 	//size of Buffer
#define MEM_SIZE 5	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "../x86_tso_buffer.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
	
chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};
chan channelT3 = [0] of {mtype, short, short, short};

short x1 = 1;			//x1, x2, c are memory addresses -> initial mapping	(better allocate???)
short x2 = 2;
short c = 3;
short c_new = 0;		// variable to update the value of c
short counter = 0;

inline writeSeqL( d1, d2)
{
	read(c, c_new);						//before and after writing the delivered values d1 and d2 to x1 and x2 c ist incremented by 1
	write(c, c_new +1);
	write(x1, d1);
	write(x2, d2);
	read(c, c_new)						
	write(c, c_new +1);
}

inline readSeqL( d1, d2)
{
	short c0;

loop:
 	read(c, c0);		
	if	
	:: (c0 % 2) -> goto loop;		// while (c0 % 2), means updating c0 if c is not even (that means process1 is writing)
	:: else -> skip;
	fi;
	
	read(x1,d1);
	read(x2,d2);
	read(c, counter)						
	if
	:: counter != c0 -> goto loop;				
	:: else -> skip;
	fi;
};


//------------------------------------------------------------------------------
	
proctype process1(chan ch){
	writeSeqL(222, 333);
	writeSeqL(444, 555);
	writeSeqL(666, 777);
}

proctype process2(chan ch){
	short word1, word2;
	readSeqL(word1, word2);
}
proctype process3(chan ch){
	short word3, word4;
	readSeqL(word3, word4);
}


init
{
atomic{
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	run process3(channelT3);
	run bufferProcess(channelT3);
	}
}
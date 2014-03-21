/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 03.2014

Burns Mutex SepOps based onSpezification in KIV
*/

#define BUFF_SIZE 2 	//size of Buffer
#define MEM_SIZE 3	//size of memory
#define f0 1
#define f1 2
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "burnsSepOps_TSO.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
		//declaration of the variables

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

short whoIsInCritical = 0; // 0 = nobody, 1 = process1, 2 = process2
//reicht eig nicht
hidden short ls = 0; // 0 = neutral, 1 = P1A1, 2= P1A2, 3 = P1A3 // local declaration in process?
hidden short ls2 = 0;

inline p1_aq()
{
	bool v0;
Invop:
entry:
printf("Processid : %d", _pid);
	assert( _pid == 1 && whoIsInCritical != 1 && memory[f0] == 0);
//ls1=1;
	write(f0,1);
	mfence();
p1a1: assert(ls1 == 1 && memory[f0] == 1);
//ls1=2	
p1a2:
whileCond:
	readLP(f1, v0, 1);
	if
	:: v0 != 0 ->	//ls = 2;
					goto whileCond;
	::else ->//ls = 3; 
			skip;
	fi;	
p1aR:
	ls = 0;
}

inline p1_rel()
{	
relP1I: assert( ls == 0 && memory[f0] = 1);
	//ls = R1;
relP11:	writeLP(f0, 0);
	assert(memory[f0] == 0);
	//ls = R2;
relP1R:
	//ls = 0;
}

inline p2_aq()
{
	bool v0, v1;
p2aI:
	assert (ls2 == 0 && memory[f1] == 0);
	//ls2 = 1;

retry:
p2aq1:
	read(f0, v0);
	if
	:: (v0 != 0) ->  // ls2 = 1;
					goto retry;
	:: else ->  //ls2 = 2;
				skip;
	fi;

whileEnd:
p2a2:
	atomic{	//ls2 = 3;
	write(f1, 1);
	}
	mfence();
	readLP(f0, v1, 2);
	if
	:: v1 != 0 ->//ls = 4;
p2a4:			 atomic{
				 	write(f1, 0);
				 	//ls = 1;
				 }
				 goto retry;
	::else -> //ls2 = 8;
p2a8:			 atomic{
					skip;
					//ls2 = 0;
				}
	fi;
	
}

inline p2_rel()
{
	writeLP(f1,0);
}
//----------------------------------------------------------------------

proctype process1(chan ch){
	do :: 
	p1_aq();
	p1_rel();
	od;
}

proctype process2(chan ch){
	do:: 
	p2_aq();
	p2_rel();
	od;
}


init 
{
atomic{
	assert( memory[f0] == 0 && memory[f1] == 0);
	printf("number of processes before starting process1: %d ", _nr_pr);
	run process1(channelT1);
	run bufferProcess(channelT1);
	printf("number of processes before starting proc2: %d ", _nr_pr);
	run process2(channelT2);
	run bufferProcess(channelT2);
	printf("number of processes after all initialisation: %d ", _nr_pr);
	assert( _nr_pr == 5 ) //why do I have an error here???
	}
}
ltl constDisjDef { [] (f0 != f1) && (f0 != NULL) && (f1 != NULL)}  //what about the auxiliary variable?
//ltl noOtherProcess { [] _nr_pr <=5 } // what about "for all" statements?
//ltl INVOP { 

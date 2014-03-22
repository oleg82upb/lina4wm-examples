/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 03.2014

Burns Mutex SepOps based on specification in KIV
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

bool M1,M2;

inline p1_aq()
{
//N:
	bool n1; //local Variable
P1A1:
	atomic{ //entry:
		write(f0,1);
		mfence();
	assert( memory[f0] == 1);
	}

P1A2: atomic {
	//whileCond:
		readLP(f1, n0, 1);
		if
			:: n0 == 0 -> M1 = 1; goto P1A3;
			:: else -> goto P1A2; //whileCond;
		fi;	
	}
P1A3: //skip;
//N:

}

inline p1_rel()
{	
//N: 
	assert(memory[f0] = 1);
R1: atomic{
		writeLP(f0, 0);
		M1 = 0;
	}
	
R2: //skip;
//N:
}

inline p2_aq()
{
//N: 
	atomic {
		bool n0, v1;
		assert ( memory[f1] == 0);
	}
	
P2A1	
//retry:
	read(f0, n0);
	if
	:: (v0 == 0) -> goto P2A2;
	:: else -> goto P2A1; //goto retry
	fi;

//whileEnd:
P2A2:	atomic{
			write(f1, 1);
			mfence();
		}
P2A3:	atomic {
			readLP(f0, n0, 2);
			if
				:: n0 == 0 -> M2 = 1; goto P2A8		
				:: else -> 	if
							:: true -> goto P2A4 
							:: true -> goto P2A5 
							fi;	
			fi;
		}
P2A4:	atomic{
			write(f1, 0);
			goto P2A1;	
		}
P2A5:	atomic{
			read(f0, n0)  //LP?????
			if
				:: n0 == 0 -> goto P2A6;
				:: n0 == 1 -> goto P2A5;
				:: n0 == 1 -> goto P2A7;
				//do I need a skip-statement as else branch?
			fi;

P2A6:	atomic{
			write(f1, 0);
			//fence necessary here?
			goto P2A2;	
		}

P2A7: 	atomic{
			write(f1, 0);
			goto P2A1;	
		}

P2A8: //skip;
//N;
}	

inline p2_rel()
{
//N:
	assert(memory[f1] = 1);
R1: atomic{
		writeLP(f1, 0);
		M2 = 0;
	}
R2: //skip;
//N:
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

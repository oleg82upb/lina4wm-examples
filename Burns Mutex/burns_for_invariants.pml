/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 03.2014

Burns Mutex SepOps based on specification in KIV
*/

#define BUFF_SIZE 2 	//size of Buffer
#define MEM_SIZE 3	//size of memory
#define F0 1
#define F1 2
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "burnsSepOps_TSO.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
		//declaration of the variables

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

bool M1 = 0;		//must it be a pointer???
bool M2 = 0;

inline p1_aq()
{
//N:
	bool n1; //local Variable
P1A1:
	atomic{ //entry:
		write(F0,1);
		mfence();
	}

P1A2: atomic {
	//whileCond:
		readLP(F1, n1, 1);
		if
			:: n1 == 0 -> M1 = 1; goto P1A3;
			:: else -> goto P1A2; //whileCond;
		fi;	
	}
P1A3: //skip;
//N:

}

inline p2_aq()
{
//N2 
	bool n0;
	//assert ( memory[F1] == 0);			//why do I get an error here???
	
P2A1: 	atomic{	
//retry:
			read(F0, n0);
			if
			:: (n0 == 0) -> goto P2A2;
			:: else -> goto P2A1; //goto retry
			fi;
		}
//whileEnd:
P2A2:	atomic{
			write(F1, 1);
			mfence();
		}
P2A3:	atomic {
			readLP(F0, n0, 2);
			if
				:: n0 == 0 -> M2 = 1; goto P2A8		
				:: else -> 	if
							:: true -> goto P2A4 
							:: true -> goto P2A5 
							fi;	
			fi;
		}
P2A4:	atomic{
			write(F1, 0);
			goto P2A1;	
		}
P2A5:	atomic{
			readLP(F0, n0, 2)  //LP?????
			if
				:: n0 == 0 -> goto P2A6;
				:: n0 == 1 -> goto P2A5;
				:: n0 == 1 -> goto P2A7;
				//do I need a skip-statement as an else branch?
			fi;
		}

P2A6:	printf("I am in P2A6!!!\n");
		atomic{
			write(F1, 0);
			//fence necessary here?
			goto P2A2;	//why do we go back to P2A2??? 
		}

P2A7: 	atomic{
			write(F1, 0);
			goto P2A1;	
		}

P2A8: //skip;
//N;
}	


inline release(process){
//N:
	assert((process == 1 && memory[F0] == 1) || (process == 3 && memory[F1] == 1));
R1: atomic{
 		if
 		:: _pid == 1 -> writeLP(F0, 0);
						M1 = 0;
						
		:: else -> 		writeLP(F1, 0);
						M2 = 0;
		fi;
	}
R2: //skip;
//N:
}

//----------------------------------------------------------------------

proctype process1(chan ch){
	do :: 
	p1_aq();
	release(_pid);
	od;
}

proctype process2(chan ch){
	do:: 
	p2_aq();
	release(_pid);
	od;
}


init 
{
atomic{
	//assert( memory[F0] == 0 && memory[F1] == 0);
	printf("number of processes before starting process1: %d ", _nr_pr);
	run process1(channelT1);
	run bufferProcess(channelT1);
	printf("number of processes before starting proc2: %d ", _nr_pr);
	run process2(channelT2);
	run bufferProcess(channelT2);
	printf("number of processes after all initialisation: %d ", _nr_pr);
	//assert( _nr_pr == 5 ) //why do I have an error here???
	}
}
ltl constDisjDef { (F0 != F1) && (F0 != NULL) && (F1 != NULL)}  //what about the auxiliary variable?
//ltl noOtherProcess { [] _nr_pr <=5 } // what about "for all" statements?
//ltl INVOP { 



 //ltl inv_1 { [] !(memory[F0] == 1 && memory[F1] == 1 && M1 == 1 && M2 == 1) }
 
 
 ltl inv_2 { [] (process1 @ P1A1 || process1 @ P1A2) -> M1 == 0}
 
 
 
 
 
 
 /*
 
 (ls .pid = P1 ∨ ls .pid = P2) ∧ (locOfP1(ls .pc) → ls .pid = P1) ∧ (locOfP2(ls .pc) → ls .pid = P2) ∧ M1 ≠ null ∧ M2 ≠ null
               ∧ F0 ≠ null ∧ F1 ≠ null ∧ F0 ≠ F1 ∧ F0 ≠ M1 ∧ F0 ≠ M2 ∧ F1 ≠ M1 ∧ F1 ≠ M2 ∧ M1 ≠ M2 ∧ P1 ≠ P2
               ∧ ¬ (mem[F0] = 1 ∧ mem[F1] = 1 ∧ mem[M1] = 1 ∧ mem[M2] = 1) ∧ (ls .pc = P1A1 ∨ ls .pc = P1A2 → mem[M1] = 0)
               ∧ (ls .pc = P1A3 → mem[M1] = 1) ∧ (ls .pc = P1A1 → mem[F0] = 0) ∧ (ls .pc = P1A2 ∨ ls .pc = P1A3 → mem[F0] = 1)
               ∧ (ls .pc = P2A1 ∨ ls .pc = P2A2 ∨ ls .pc = P2A3 ∨ ls .pc = P2A4 ∨ ls .pc = P2A5 ∨ ls .pc = P2A6 ∨ ls .pc = P2A7 → mem[M2] = 0)
               ∧ (ls .pc = P2A8 → mem[M2] = 1) ∧ (ls .pc = P2A1 ∨ ls .pc = P2A2 → mem[F1] = 0)
               ∧ (ls .pc = P2A3 ∨ ls .pc = P2A4 ∨ ls .pc = P2A5 ∨ ls .pc = P2A6 ∨ ls .pc = P2A7 ∨ ls .pc = P2A8 → mem[F1] = 1)
               ∧ (ls .pc = R1 ∧ ls .pid = P1 → mem[F0] = 1 ∧ mem[M1] = 1) ∧ (ls .pc = R1 ∧ ls .pid = P2 → mem[F1] = 1 ∧ mem[M2] = 1)
               ∧ (ls .pc = R2 ∧ ls .pid = P1 → mem[F0] = 0 ∧ mem[M1] = 0) ∧ (ls .pc = R2 ∧ ls .pid = P2 → mem[F1] = 0 ∧ mem[M2] = 0)
               ∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 0 ↔ mem[M1] = 0)) ∧ (ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 0 ↔ mem[M2] = 0))
               ∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 1 ↔ mem[M1] = 1)) ∧ (ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 1 ↔ mem[M2] = 1)));
      
*/
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
#include "sc-model.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
		//declaration of the variables

bool M1 = 0;	
bool M2 = 0;

inline p1_aq()
{
//N:
	bool n1; //local Variable
P1A1:
	atomic{ //entry:
		write(F0,1);
	}

P1A2: atomic {
	//whileCond:
		read(F1, n1);
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
		}
P2A3:	atomic {
			read(F0, n0);
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
			read(F0, n0)  
			if
				:: n0 == 0 -> goto P2A6;
				:: n0 == 1 -> goto P2A5;
				:: n0 == 1 -> goto P2A7;
				//do I need a skip-statement as an else branch?
			fi;
		}

P2A6:	atomic{
			printf("I am in P2A6!!!\n");
			write(F1, 0);
			goto P2A2; 
		}

P2A7: 	atomic{
			write(F1, 0);
			goto P2A1;	
		}

P2A8: //skip;
//N:
}	


inline release(){
//N:
	assert((_pid == 1 && memory[F0] == 1) || (_pid == 2 && memory[F1] == 1));
R1: atomic{
 		if
 		:: _pid == 1 -> write(F0, 0);
						M1 = 0;
						
		:: else -> 		write(F1, 0);
						M2 = 0;
		fi;
	}
R2: skip;
//N: 
}

//----------------------------------------------------------------------

proctype process1(){
	printf("Processid von proc1: %d \n",_pid);
	do :: 
	p1_aq();
	release();
	od;
}

proctype process2(){
	printf("Processid von proc2: %d \n",_pid);
	do:: 
	p2_aq();
	release();
	od;
}


init 
{
atomic{
	assert( memory[F0] == 0 && memory[F1] == 0);
	run process1();
	run process2();
	}
}

ltl inv_1 { [] !(memory[F0] == 1 && memory[F1] == 1 && M1 == 1 && M2 == 1)}
ltl inv_2 { [] (process1 @ P1A1 || process1 @ P1A2) -> M1 == 0}
ltl inv_3 { [] (process1 @ P1A3 -> M1 == 1) && (process1 @ P1A1 -> memory[F0] == 0) && (process1 @ P1A2 || process1 @ P1A3 -> memory[F0] == 1)}
ltl inv_4 { [] (process2 @ P2A1 || process2 @ P2A2 || process2 @ P2A3 || process2 @ P2A4 || process2 @ P2A5 || process2 @ P2A6 || process2 @ P2A7 -> M2 == 0)}
ltl inv_5 { [] (process2 @ P2A8 -> M2 == 1) && (process2 @ P2A1 || process2 @ P2A2 -> memory[F1] == 0)}
ltl inv_6 { [] (process2 @ P2A3 || process2 @ P2A4 || process2 @ P2A5 || process2 @ P2A6 || process2 @ P2A7 || process2 @ P2A8  -> memory[F1] == 1)}
ltl inv_7 { [] ((process1 @ R1 -> memory[F0] == 1 && M1 == 1) && (process2 @ R1 -> memory[F1] == 1 && M2 == 1))}
ltl inv_8 { [] ((process1 @ R2 -> memory[F0] == 0 && M1 == 0) && (process2 @ R2 -> memory[F1] == 0 && M2 == 0))}
ltl inv_9 { [] ((!process1 @ P1A1 && !process1 @ P1A2 && !process1 @ P1A3  && !process1 @ R1 && !process1 @ R2) -> (memory[F0] == 0 <-> M1 == 0))}
ltl inv_10 { [] ((!process2 @ P2A1 && !process2 @ P2A2 && !process2 @ P2A3 && !process2 @ P2A4 && !process2 @ P2A5 && !process2 @ P2A6 && !process2 @ P2A7 && !process2 @ P2A8 && !process2 @ R1 && !process2 @ R2) -> (memory[F1] == 0 <-> M2 == 0))}
ltl inv_11 { [] ((!process1 @ P1A1 && !process1 @ P1A2 && !process1 @ P1A3  && !process1 @ R1 && !process1 @ R2) -> (memory[F0] == 1 <-> M1 == 1))}
ltl inv_12 { [] ((!process2 @ P2A1 && !process2 @ P2A2 && !process2 @ P2A3 && !process2 @ P2A4 && !process2 @ P2A5 && !process2 @ P2A6 && !process2 @ P2A7 && !process2 @ P2A8  && !process2 @ R1 && !process2 @ R2) -> (memory[F1] == 1 <-> M2 == 1))}

/*
 
 (ls .pid = P1 ∨ ls .pid = P2) ∧ (locOfP1(ls .pc) → ls .pid = P1) ∧ (locOfP2(ls .pc) → ls .pid = P2) ∧ M1 ≠ null ∧ M2 ≠ null
               ∧ F0 ≠ null ∧ F1 ≠ null ∧ F0 ≠ F1 ∧ F0 ≠ M1 ∧ F0 ≠ M2 ∧ F1 ≠ M1 ∧ F1 ≠ M2 ∧ M1 ≠ M2 ∧ P1 ≠ P2
              // ∧ ¬ (mem[F0] = 1 ∧ mem[F1] = 1 ∧ mem[M1] = 1 ∧ mem[M2] = 1) ∧ (ls .pc = P1A1 ∨ ls .pc = P1A2 → mem[M1] = 0)
              // ∧ (ls .pc = P1A3 → mem[M1] = 1) ∧ (ls .pc = P1A1 → mem[F0] = 0) ∧ (ls .pc = P1A2 ∨ ls .pc = P1A3 → mem[F0] = 1)
              // ∧ (ls .pc = P2A1 ∨ ls .pc = P2A2 ∨ ls .pc = P2A3 ∨ ls .pc = P2A4 ∨ ls .pc = P2A5 ∨ ls .pc = P2A6 ∨ ls .pc = P2A7 → mem[M2] = 0)
              // ∧ (ls .pc = P2A8 → mem[M2] = 1) ∧ (ls .pc = P2A1 ∨ ls .pc = P2A2 → mem[F1] = 0)
              // ∧ (ls .pc = P2A3 ∨ ls .pc = P2A4 ∨ ls .pc = P2A5 ∨ ls .pc = P2A6 ∨ ls .pc = P2A7 ∨ ls .pc = P2A8 → mem[F1] = 1)
              // ∧ (ls .pc = R1 ∧ ls .pid = P1 → mem[F0] = 1 ∧ mem[M1] = 1) ∧ (ls .pc = R1 ∧ ls .pid = P2 → mem[F1] = 1 ∧ mem[M2] = 1)
              // ∧ (ls .pc = R2 ∧ ls .pid = P1 → mem[F0] = 0 ∧ mem[M1] = 0) ∧ (ls .pc = R2 ∧ ls .pid = P2 → mem[F1] = 0 ∧ mem[M2] = 0)
              // ∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 0 ↔ mem[M1] = 0))
              // ∧(ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 0 ↔ mem[M2] = 0))
              // ∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 1 ↔ mem[M1] = 1)) 
              // ∧ (ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 1 ↔ mem[M2] = 1)));
      
*/
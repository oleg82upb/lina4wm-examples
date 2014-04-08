/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 03.2014

Burns Mutex SepOps based on specification in KIV (COP with buffer)
*/
#define BUFF_SIZE 2
#define MEM_SIZE 3	//size of memory
#define F0 1
#define F1 2
//-----------------------------------------------------------------------------------------------------------------------------------------------
#define PROC_NUMBER 2
#include "burnsSepOps_TSO_globalarray.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
		//declaration of the variables

chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

bool M1 = 0;	
bool M2 = 0;

bool n0 = 0;	//actually a local Variable of process 2
bool n1 = 0;	//actually a local Variable of process 1; global to enable ltl check
  
  
inline p1_aq()
{
	//bool n1; //local Variable
//N:
	//assert(memory[F0] == 0);		//same problem as p2_aq
	skip;
P1A1:
	atomic{ //entry:
		write(F0,1);
	}
P1A2:
	atomic{
		mfence();
	}

P1A3: atomic {
	//whileCond:
		readLP(F1, n1, 1);
		if
			:: n1 == 0 -> M1 = 1; goto P1A4;
			:: else -> goto P1A3; //whileCond;
		fi;	
	}
P1A4: //skip;
//N:

}

inline release(){
//N:
	assert((_pid == 1 && memory[F0] == 1) || (_pid == 3 && memory[F1] == 1));
R1: atomic{
 		if
 		:: _pid == 1 -> writeLP(F0, 0); M1 = 0; //should be set when a buffer element is written to memory
						
		:: _pid == 3 ->	writeLP(F1, 0); M2 = 0; //same problem
		:: else -> assert(false);
		fi;
	}
R2: skip;
//N: 
}



inline p2_aq()
{
//N2 
	//bool n0;
	//assert (memory[F1] == 0);			//error if write(F1,0) is still in the buffer and a new aquire is executed
	skip;
P2A1: 	atomic{	
			read(F0, n0);
			if
			:: (n0 == 0) -> goto P2A2;
			:: else -> goto P2A1; 
			fi;
		}
//buffer
P2A2:	atomic{
			write(F1, 1);
		}
//buffer		
P2A3: 	atomic{
			mfence();
		}
		
P2A4:	atomic {
			readLP(F0, n0, 2);
			if
				:: n0 == 0 -> M2 = 1; goto P2A6		
				:: else -> goto P2A5;
			fi;
		}

P2A5: 	atomic{
			write(F1, 0);
			//do I need a fence here???
			goto P2A1;	
		}

P2A6: //skip;
//N:
}	


//----------------------------------------------------------------------

proctype process1(chan ch){
	do :: 
	p1_aq();
	printf("BUFFER: %d ,    %d  ;  %d ,   %d\n" , proc[1].buffer[0].line[0], proc[1].buffer[0].line[2], proc[1].buffer[1].line[0],proc[1].buffer[1].line[1]);
	release();
	od;
}

proctype process2(chan ch){
	do:: 
	p2_aq();
	release();
	od;
}


init 
{
atomic{
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
}

//¬ (mem[F0] = 1 ∧ mem[F1] = 1 ∧ mem[M1] = 1 ∧ mem[M2] = 1)
ltl inv_1 { [] !(memory[F0] == 1 && memory[F1] == 1 && M1 == 1 && M2 == 1)}
//(ls .pc = P1A1 ∨ ls .pc = P1A1' ∨ ls .pc = P1A2 ∨ ls .pc = P1A3 ∨ ls .pc = P1A3' ∧ ls .n1 ≠ 0 → mem[M1] = 0)
ltl inv_2 { [] (process1 @ P1A1 || process1 @ P1A2 || process1 @ P1A3 && n1 != 0 -> M1 == 0) }
//(ls .pc = P1A1 ∨ ls .pc = P1A3 ∨ ls .pc = P1A3' ∨ ls .pc = P1A4 → ls .buf = [])
ltl inv_3 { [] (process1 @ P1A1 || process1 @ P1A3 || process1 @ P1A4 -> proc[1].buffer[0].line[0] == 0)} //global buffer necessary????
//(ls .pc = P1A3' ∧ ls .n1 = 0 ∨ ls .pc = P1A4 → mem[M1] = 1)
ltl inv_4 {	[] (process1 @ P1A4 -> M1 == 1)}		//how to translate this part: "ls .pc = P1A3' ∧ ls .n1 = 0 ∨" ? -> process1 @ P1A3 && n1 == 0 || 		//??
//(ls .pc = P1A1 ∨ (ls .pc = P1A1' ∨ ls .pc = P1A2) ∧ contains(F0, ls .buf) ∨ ls .pc = R2 ∧ ls .pid = P1 → mem[F0] = 0)
ltl inv_5 { [] (process1 @ P1A1 ||(process1 @ P1A2) && (proc[1].buffer[0].line[0] == F0 || proc[1].buffer[1].line[0] == F0)|| process1 @ R2 -> memory[F0] == 0)}



ltl inv_6 { [] (process1 @ P1A2 || process1 @ P1A3 || process1 @ P1A4 || process1 @ R1 -> memory[F0] == 1)}
ltl inv_7 {	[] (process1 @ P1A1 || process1 @ P1A2 || process1 @ P1A3 && n1 != 0 -> M1 == 0)}

ltl inv_8 { [] ( !(proc[1].buffer[0].line[0] == F0 && proc[1].buffer[1].line[0] == F0) -> proc[1].buffer[0].line[0] == 0)}
//ltl inv_ { [] (process2 @ P2A1 || process2 @ P2A2 || process2 @ P2A3 || process2 @ P2A4 && n0 != 0 || process2 @ P2A5 -> M2 == 0)}
//ltl inv_ { [] (process2 @ P2A4 || process2 @ P2A5 ->  proc[2].buffer[0].line[0] == 0) && (n0 == 0 || process2 @ P2A6 -> M2 == 1)}


 /* 3∧ (ls .pc = P1A1 ∨ ls .pc = P1A3 ∨ ls .pc = P1A3' ∨ ls .pc = P1A4 → ls .buf = [])
	4∧ (ls .pc = P1A3' ∧ ls .n1 = 0 ∨ ls .pc = P1A4 → mem[M1] = 1)  
    5∧ (ls .pc = P1A1 ∨ (ls .pc = P1A1' ∨ ls .pc = P1A2) ∧ contains(F0, ls .buf) ∨ ls .pc = R2 ∧ ls .pid = P1 → mem[F0] = 0)             
    ????∧ (    (ls .pc = P1A1' ∨ ls .pc = P1A2) ∧ ¬ contains(F0, ls .buf) ∨ ls .pc = P1A3 ∨ ls .pc = P1A3' ∨ ls .pc = P1A4
                    ∨ ls .pid = P1 ∧ (ls .pc = R1 ∨ ls .pc = R1' ∧ contains(F0, ls .buf))x
                  → mem[F0] = 1)           
  ??????? ∧ (locOfP1(ls .pc) ∧ contains(F0, ls .buf) → (ls .pc = P1A1' ∨ ls .pc = P1A2 → ls .buf = (F0 × 1) ' + []))         
               
 ???????? ∧ (ls .pid = P1 ∧ ¬ contains(F0, ls .buf) → ls .buf = [])
    ∧ (    ls .pc = P2A1 ∨ ls .pc = P2A1' ∨ ls .pc = P2A2 ∨ ls .pc = P2A2' ∨ ls .pc = P2A3 ∨ ls .pc = P2A4 ∨ ls .pc = P2A4' ∧ ls .n0 ≠ 0
                    ∨ ls .pc = P2A5 ∨ ls .pc = P2A5'
                  → mem[M2] = 0)        
   ∧ (ls .pc = P2A4 ∨ ls .pc = P2A4' ∨ ls .pc = P2A5 → ls .buf = []) ∧ (ls .pc = P2A4' ∧ ls .n0 = 0 ∨ ls .pc = P2A6 → mem[M2] = 1)
              
              
	// ∧ (    ls .pc = P2A3 ∧ contains(F1, ls .buf)
                    ∨ (ls .pc = P2A1 ∨ ls .pc = P2A1' ∨ ls .pc = P2A2 ∨ ls .pc = P2A5') ∧ ¬ contains(F1, ls .buf) ∨ ls .pc = R2 ∧ ls .pid = P2
                  → mem[F1] = 0)
               ∧ (ls .pc = P2A3 ∧ ¬ contains(F1, ls .buf) → mem[F1] = 1 )
               ∧ (    (ls .pc = P2A2' ∨ ls .pc = P2A3) ∧ ¬ contains(F1, ls .buf) ∨ ls .pc = P2A4 ∨ ls .pc = P2A4' ∨ ls .pc = P2A5
                    ∨ (ls .pc = P2A1 ∨ ls .pc = P2A1' ∨ ls .pc = P2A2 ∨ ls .pc = P2A5') ∧ contains(F1, ls .buf) ∨ ls .pc = P2A6
                    ∨ ls .pid = P2 ∧ (ls .pc = R1 ∨ ls .pc = R1' ∧ contains(F1, ls .buf))
                  → mem[F1] = 1)
               ∧ (ls .pc = P2A2' ∧ ls .buf = (F1 × 1) ' + [] → mem[F1] = 0) ∧ (ls .pc = P2A2' ∧ ls .buf = (F1 × 0) ' + (F1 × 1) ' + [] → mem[F1] = 1)
               ∧ (  locOfP2(ls .pc) ∧ contains(F1, ls .buf)
                  →   (ls .pc = P2A1 ∨ ls .pc = P2A1' ∨ ls .pc = P2A2 ∨ ls .pc = P2A5' → ls .buf = (F1 × 0) ' + [])
                    ∧ (ls .pc = P2A2' ∨ ls .pc = P2A3 → ls .buf = (F1 × 1) ' + [] ∨ ls .buf = (F1 × 0) ' + (F1 × 1) ' + []))
               ∧ (ls .pid = P2 ∧ ¬ contains(F1, ls .buf) → ls .buf = []) ∧ (ls .pc = P2A6 → ls .buf = []) ∧ (ls .pc = R1 → ls .buf = [])
              // ∧ (ls .pc = R1 ∧ ls .pid = P1 → mem[F0] = 1 ∧ mem[M1] = 1) ∧ (ls .pc = R1 ∧ ls .pid = P2 → mem[F1] = 1 ∧ mem[M2] = 1)
               ∧ (  ls .pc = R1'
                  →   (ls .pid = P1 ∧ contains(F0, ls .buf) → (mem[M1] = 1 ∧ ls .pid = P2 ∧ contains(F1, ls .buf) → mem[M2] = 1))
                    ∧ (ls .pid = P1 ∧ ¬ contains(F0, ls .buf) → (mem[M1] = 0 ∧ ls .pid = P2 ∧ ¬ contains(F1, ls .buf) → mem[M2] = 0)))
               ∧ (ls .pc = R1' ∧ contains(F0, ls .buf) → ls .buf = (F0 × 0) ' + [])
               ∧ (ls .pc = R1' ∧ contains(F1, ls .buf) → ls .buf = (F1 × 0) ' + []) ∧ (ls .pc = R2 → ls .buf = [])
              // ∧ (ls .pc = R2 ∧ ls .pid = P1 → mem[F0] = 0 ∧ mem[M1] = 0) ∧ (ls .pc = R2 ∧ ls .pid = P2 → mem[F1] = 0 ∧ mem[M2] = 0)
               //∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 0 ↔ mem[M1] = 0)) ∧ (ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 0 ↔ mem[M2] = 0))
              // ∧ (ls .pc = N ∧ ls .pid = P1 → (mem[F0] = 1 ↔ mem[M1] = 1)) ∧ (ls .pc = N ∧ ls .pid = P2 → (mem[F1] = 1 ↔ mem[M2] = 1))
               ∧ (ls .pc = N → ls .buf = []));               
 */
ltl inv_9 { [] (process1 @ R1 -> (memory[F0] == 1 && M1 == 1))}
ltl inv_10 { [] (process1 @ R1 -> (memory[F1] == 1 && M2 == 1))} 
ltl inv_11 { [] (process1 @ R2 -> (memory[F0] == 0 && M1 == 0))}
ltl inv_12 { [] (process1 @ R2 -> (memory[F1] == 0 && M2 == 0))} 
ltl inv_13 { [] ((!process1 @ P1A1 && !process1 @ P1A2 && !process1 @ P1A3 && !process1 @ P1A4 && !process1 @ R1 && !process1 @ R2) -> (memory[F0] == 0 <-> M1 == 0))}
ltl inv_14 { [] ((!process2 @ P2A1 && !process2 @ P2A2 && !process2 @ P2A3 && !process2 @ P2A4 && !process2 @ P2A5 && !process2 @ P2A6 && !process2 @ R1 && !process2 @ R2) -> (memory[F1] == 0 <-> M2 == 0))}
 
ltl inv_15 { [] ((!process1 @ P1A1 && !process1 @ P1A2 && !process1 @ P1A3 && !process1 @ P1A4 && !process1 @ R1 && !process1 @ R2) -> (memory[F0] == 1 <-> M1 == 1))}
ltl inv_16 { [] ((!process2 @ P2A1 && !process2 @ P2A2 && !process2 @ P2A3 && !process2 @ P2A4 && !process2 @ P2A5 && !process2 @ P2A6 && !process2 @ R1 && !process2 @ R2) -> (memory[F1] == 1 <-> M2 == 1))}
ltl inv_17 { [] ((!process1 @ P1A1 && !process1 @ P1A2 && !process1 @ P1A3 && !process1 @ P1A4 && !process1 @ R1 && !process1 @ R2) -> proc[1].buffer[0].line[0] == 0 )}
ltl inv_18 { [] ((!process2 @ P2A1 && !process2 @ P2A2 && !process2 @ P2A3 && !process2 @ P2A4 && !process2 @ P2A5 && !process2 @ P2A6 && !process2 @ R1 && !process2 @ R2) -> proc[2].buffer[0].line[0] == 0 )}
 
/*
	trying to specify the LLVM-compiled Treiber Stack implementation  
*/

//#define BUFF_SIZE 8 	//size of Buffer
#define MEM_SIZE 3	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "../sc-model.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------


//Types for LLVM, actually their length in size of pointers and values

#define FLAG0 1
#define FLAG1 2
short crit = 0;


inline critical()
{
	assert(crit == 0); 
	crit = _pid;
}

inline uncritical()
{
	assert(crit == _pid); 
	crit = 0;
}


inline p1()
{
short v0;

whileBegin:	write(FLAG0, 1);
			//mfence();

whileCond1:	read(FLAG1, v0);
			if
				:: v0 != 0 -> goto whileCond1;
				:: atomic{else -> critical(); skip;}
			fi
			->
			uncritical();
			write(FLAG0, 0);
end:		goto whileBegin;
}




inline p2()
{
	short v0,v1;
while:		read(FLAG0,v0);	
			if
				:: v0 != 0 -> goto while;
				:: else -> skip;
			fi
			->
			write(FLAG1, 1);
			//mfence();
			read(FLAG0, v1);
			if
				:: v1 != 0 -> goto ifend;
				:: atomic{else -> critical(); skip;}
			fi
			->
			
			uncritical();

ifend:		write(FLAG1, 0);
end:		goto while;
}

init{
atomic{
	run process1();
	run process2();
	}
}

proctype process1(){
	p1();
}

proctype process2(){
	p2();
}

//ltl neverBothCritical{ [] !(process1 @ critical && process2 @ critical)}

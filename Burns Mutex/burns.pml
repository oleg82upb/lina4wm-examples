/*
	trying to specify the LLVM-compiled Treiber Stack implementation  
*/

#define BUFF_SIZE 8 	//size of Buffer
#define MEM_SIZE 3	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
/* too work with the global buffer add the line #define PROC_NUMBER 2 to define the numbers of processes with are involved
 * and substitute "x86_tso_buffer.pml" with "x86_tso_buffer_globalarray.pml"  
 */ 
#include "x86_tso_buffer.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------


//Types for LLVM, actually their length in size of pointers and values
#define Ptr  0
#define FLAG0 1
#define FLAG1 2
short memUse = 1; 	//shows to the next free cell in memory
short crit = 0;


chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

inline getelementptr(type, instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
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
			mfence();

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
			mfence();
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
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
}

proctype process1(chan ch){
	p1();
}

proctype process2(chan ch){
	p2();
}

//ltl neverBothCritical{ [] !(process1 @ critical && process2 @ critical)}

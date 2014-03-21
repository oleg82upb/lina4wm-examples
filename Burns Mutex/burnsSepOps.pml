/*
author: Annika Mütze <muetze.annika@gmail.com>
date: 05.2013

Burns Mutex SepOps implementation
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





inline p1_aq()
{
	bool v0;
entry: 
	write(f0,1);
	mfence();
whileCond:
	readLP(f1, v0, 1);
	if
	:: v0 != 0 -> goto whileCond;
	::else -> skip;
	fi;	
}

inline p1_rel()
{
	writeLP(f0, 0);
}

inline p2_aq()
{
	bool v0, v1;
retry:
	read(f0, v0);
	if
	:: (v0 != 0) -> goto retry;
	:: else -> skip;
	fi;

whileEnd:
	write(f1, 1);
	mfence();
	readLP(f0, v1, 2);
	if
	:: v1 != 0 -> write(f1, 0);
				 goto retry;
	::else -> skip;
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
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	}
}

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
#include "sc-model.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
		//declaration of the variables



short as = 0;
inline asAcquire(p)
{
	atomic{
		assert(as == 0);
		as = p;
	}
}
inline asRelease(p)
{
	atomic{
		assert(as == p);
		as = 0;
	}
}

inline readLP(f, r, p)
{
atomic{
	read(f, r);
	if :: r == 0 -> asAcquire(p);
	   :: else -> skip;
	fi;}
}


inline writeLP(adr, newValue)
{
atomic{
	write(adr,newValue);
	asRelease(adr);
	}
}


inline p1_aq()
{
	bool v0;
entry: 
	write(f0,1);
	//mfence();
whileCond:
	readLP(f1, v0, 1);
	if
	:: v0 != 0 -> goto whileCond;
	:: else -> skip;
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
	//mfence();
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

proctype process1(){
	do :: 
	p1_aq();
	p1_rel();
	od;
}

proctype process2(){
	do:: 
	p2_aq();
	p2_rel();
	od;
}


init 
{
atomic{
	run process1();
	run process2();
	}
}
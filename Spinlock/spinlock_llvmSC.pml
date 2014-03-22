/*
*author: Annika Mütze <muetze.annika@gmail.com>
*date: 06.2013
*subject: spinlock implementation: specification of the LLVM-compiled spinlock implementation (spinlock.s)
*/

#define MEM_SIZE 2	//size of memory
 //----------------------------------------------------------------------------------------------------------------------------------------------
 //abstract specification
 short owner = -1;	//initial set to -1, means no process is in its critical section
 
inline casLPAquire(adr, oldValue, newValue, successBit){
	atomic{
	cas(adr, oldValue, newValue, successBit);
	if 	
	:: successBit -> asAquire();
	:: else -> assert(owner != -1);
	fi
	}
}


inline casLPTry(adr, oldValue, newValue, successBit){
	atomic{
	cas(adr, oldValue, newValue, successBit);
	if 	
	:: successBit -> asAquire();
	:: else -> assert(owner != -1);
	fi
	}
}
 
 
inline asAquire(){
 	assert(owner == -1);
 	owner = _pid; 
}

inline writeLP(adr,val){
atomic{
	write(adr,val);
	asRelease();
	}
}

inline asRelease(){
	atomic{	
 		assert(owner == (_pid )); // buffer proc's pid is always increased by 1 
 		owner = -1;
 	}
}
 
 
 
 
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "sc-model.pml"

//-----------------------------------------------------------------------------------------------------------------------------------------------
//Deklaration of Pointertypes, channels and usefull functions
//Types for LLVM, actually their length in size of pointers and values
#define I32  0 		// = {0};
#define Ptr  0
short memUse = 2; 	//shows to the next free cell in memory, initialized to 2 because PtrX is set to 1


inline getelementptr(type, instance, offset, targetRegister){
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
	assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
	}
}

inline alloca(type, targetRegister){
	atomic{
	//need c_Code here, but for now we could use this to statically define used addresses
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}
//-----------------------------------------------------------------------------------------------------------------------------
				//specific inlines

#define ptrX 1		//global Ptr

inline aquire(){
short v0, v2;

whileBody:
	casLPAquire(ptrX,1,0,v0); 			//cas(adr, oldValue, newValue, returnValue) 
	if
	::(v0 == 1) -> goto End;
	:: else -> skip;
	fi;

whileCond1:
	read(ptrX, v2);
	if
	:: v2 == 0 -> goto whileCond1;		//endlessloop???
	:: else -> goto whileBody;
	fi;
	
End:
	skip;
}

inline release(){

	writeLP(ptrX,1);
}
/*Alternative:
inline tryaquire(returnvalue){
short retval, v0, v2;

entry:
	alloca(I32, retval);
	casLPTry(ptrX,1,0,v0);
	if
	:: v0 == 1 	-> 	write(retval, 1); goto End;
	:: else 	-> 	write(retval, 0); goto End;
	fi;

End:
	read(retval, returnvalue);
*/	

inline tryaquire(retval){

	//alloca(I32, returnValue);
	casLPTry(ptrX,1,0,retval);
//originally the compiled program looks like this and has an "alloc" for returnValue: 
//	write(returnValue,casResult);
//	read(returnValue, retval);
}


proctype process1 (){
	bit returnvalue;
	do ::
	aquire();
	release();
	:: tryaquire(returnvalue);
		if
		:: returnvalue -> release();
		::else ->skip
		fi;
	od;
}

proctype process2 (){
	bit returnvalue;
	do ::
	aquire();
	release();
	:: tryaquire(returnvalue);
		if
		:: returnvalue -> release();
		::else ->skip
		fi;
	od;
}

proctype process3 (){
	do ::
	aquire();
	release();
	od;;
}

proctype process4 (){
	bit returnvalue;
	do::
	tryaquire(returnvalue);
	if
	:: returnvalue -> release();
	::else ->skip
	fi;
	od;
}

init{
	memory[ptrX] = 1;
atomic{
	run process1();
	run process1();
	run process1();
	run process1();
	}
}

//ltl neverBothInCrit{ [] !(process1 @ critical_sec && process2 @critical_sec)};

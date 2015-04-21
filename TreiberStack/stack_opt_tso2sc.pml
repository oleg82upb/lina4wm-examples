#define MEM_SIZE 25	//size of memory
#define NULL 0
#define I32  0 		// = {0};
#define Ptr  0
#define Stack  0 	//= {0};
#define Node  1	//= {0,1};
#define EMPTY 0

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory
short this;

inline getelementptr(instance, offset, targetRegister)
{
	atomic{
	//simplified version of what llvm does.
	//we don't need the type as long as we assume our memory to hold only values/pointers etc of equal length. 
	//In this case, the offset directly correspond to adding it to instance address. 
	//assert(offset <= type); //offset shouldn't be greater than the type range
	targetRegister = instance + offset;
	}
}

inline alloca(type, targetRegister)
{
	atomic{
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}

inline CAS(ref, old, new, result)
{
atomic{
	if	:: memory[ref] == old -> memory[ref] = new; result = 1;
		:: else -> result = 0;
	fi;
	}
}

//-------------------------------------


inline push(v ){ 
short call, val, head, next, v0, v1,v2,v3,v4,v5;
U0: alloca(Node, call);	
U1: val = call; 
//U2: skip;

U3val: 
if	:: true -> memory[val] = v; goto U3;
	:: true -> getelementptr(this,0, head); goto U4val; 
fi;

U3: getelementptr(this,0, head); goto U4;
 
U4val: 
if	:: true -> memory[val] = v; goto U4;
	:: true -> getelementptr(call,1, next); goto U5val; 
fi;

U4: getelementptr(call, 1, next); goto U5; 
U5val: 
if	:: true -> memory[val] = v; goto U5;
	:: true -> v0 = next; goto U6val; 
fi;

U5: v0 = next; goto U6; 
U6val: 
if	:: true -> memory[val] = v; goto U6;
	:: true -> v1 = this; goto U7val; 
fi;
U6: v1 = this; goto U7; 
U7val: 
if	:: true -> memory[val] = v; goto U7;
	:: true -> v2 = call; goto U8val; 
fi;
U7: v2 = call; goto U8; 
U8val: 
if	:: true -> memory[val] = v; goto U8;
	:: true -> goto U9val;
fi;
U8: goto U9;
U9val: 
if	:: true -> memory[val] = v; goto U9;
	:: true -> v3 = memory[head]; goto U10val;
fi;
U9: v3 = memory[head]; goto U10;
U10val: 
if	:: true -> memory[val] = v; goto U10;
	:: true -> goto U11valv0;
fi;

U10: goto U11v0;
U11valv0: 
if	:: true -> memory[val] = v; goto U11v0;
	:: true -> v4 = v3; goto U12valv0; 
fi;
U11v0: 
if	:: true -> memory[v0] = v3; goto U11;
	:: true -> v4 = v3; goto U12v0; 
fi;
U12valv0: memory[val] = v; goto U12v0;
U11: v4 = v3; goto U12; 
U12v0: memory[v0] = v3; goto U12;
U12:  CAS(v1 , v4 , v2, v5 ); goto U14;
//U13: %6 = (%5  == %4 )
U14: 
if	:: v5 -> goto U15;
	:: else -> goto U9;
fi;
U15: skip; //RET  void
}


//returns the pointer to the value
inline pop(retval){
 short head, v0, v1, v2, v3, v4, v5, cmp, next;
 
O0: getelementptr(this, 0, head) 
O1: v0 = this; 
//O2: goto O3;
O3: v1 = memory[head];
O4: cmp = (v1  == NULL);
O5: 
if	:: cmp -> retval = NULL; goto O13;
	:: else -> goto O6;
fi;

O6: getelementptr(v1, 1, next); 
O7: v2 = memory[next];
O8: v3 = v1;
O9: v4 = v2;
O10: CAS(v0 , v3 , v4, v5 );
//O11: v6 = (v5  == v3 )
O12: 
if	:: v5 -> retval = v1; goto O13;
	:: else -> goto O3;
fi;
O13: skip;//retval = phi([null , do.body(PC:5)], [%1 , if.end(PC:12)])
 
}





proctype process1(){
	short result;
	push(111);
	push(222);
	push(333);
	//push(444);
	//pop(result);
	pop(result);
	pop(result);
	pop(result);
}

proctype process2(){
	short result;
	pop(result);
	pop(result);
	pop(result);
	//pop(result);
	//push(555);
	push(666);
	push(777);
	push(888);
}


init{
atomic{
	alloca(0, this)
	

	run process1();
	run process2();
	}
}
#define MEM_SIZE 20	//size of memory
#define NULL 0
#define I32  0 		// = {0};
#define Ptr  0
#define Stack  0 	//= {0};
#define Node  1	//= {0,1};
#define BUFF_SIZE 16 	//size of Buffer

byte this; 		//Stack instance pointer
short memUse = 1;
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
#include "../x86_tso_buffer.pml"
chan channelT1 = [0] of {mtype, short, short, short};
chan channelT2 = [0] of {mtype, short, short, short};

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
	//need c_Code here, but for now we could use this to statically define used addresses
	targetRegister = memUse;
	memUse = memUse + type + 1;
	assert(memUse < MEM_SIZE);
	}
}




inline push(v) {
short call, val, head, next, v0,v1,v2,v3,v4,v5;
invoke:
  alloca(Node, call);
  val = call;
  write(val,v); 
  getelementptr(this,0,head); 
  getelementptr(call,1,next); 
  v0 = next;
  v1 = this; 
  v2 = call;
  goto body;

body:                                          
  read(head,v3); //v3 = memory[head]; 
  write(v0,v3); //memory[v0] = v3; 
  v4 = v3;
  cas(v1,v4,v2,v5);
  if 	:: v5 -> goto doend;
	:: else -> goto body;
  fi;

doend: 
  skip;
}



inline pop(retval)  {
short head,v0,v1,cmp,next,v2,v3,v4,v5;
entry:
  getelementptr(this,0,head); 
  v0 = this;

body:
  read(head,v1); //v1 = memory[head];
  cmp = (v1 == NULL);
if 	:: cmp -> retval = NULL; goto ret;
	:: else -> goto ifend;
fi;

ifend:
  getelementptr(v1,1,next); 
  read(next,v2); //v2 = memory[next];
  v3 = v1;
  v4 = v2;
  cas(v0,v3,v4,v5); //%5 = cmpxchg i32* %0, i32 %3, i32 %4 seq_cst
if	:: v5 ->  goto ret1;
	:: else -> goto body;
fi;


ret1:
read(v1, retval); //retval = memory[v1];
ret:
skip;
}

proctype process1(chan ch){
	short returnvalue;
	push(111);
	push(222);
	push(333);
	push(444);
	pop(returnvalue);
	pop(returnvalue);
	pop(returnvalue);
	pop(returnvalue);
	//assert(returnvalue == 333);
}

proctype process2(chan ch){
	short returnvalue;
	pop(returnvalue);
	pop(returnvalue);
	pop(returnvalue);
	pop(returnvalue);
	push(555);
	push(666);
	push(777);
	push(888);
}



init{
atomic{
	alloca(Stack, this)
	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	
	}
}

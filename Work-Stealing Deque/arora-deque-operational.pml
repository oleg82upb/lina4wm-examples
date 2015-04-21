#define BUFF_SIZE 6 	//size of Buffer
#define MEM_SIZE 30	//size of memory
 
//-----------------------------------------------------------------------------------------------------------------------------------------------
//Types for LLVM, actually their length in size of pointers and values
#define Queue  1 	//= {0,1}; (head and tail)
#define Node  1	//= {0,1};
#define I32  0 		// = {0};
#define Ptr  0
#define ABORT -256
#define Age 1


short memUse = 1; 	//shows to the next free cell in memory
short bot, age, deq;
short res1,res2;
bit done1 = false, done2 = false;

//------------------------------------------------------------------------------------------------------
#include "x86_tso_buffer.pml"
//------------------------------------------------------------------------------------------------------


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

//-------------------------------------------------------------------------------------------

inline pushBottom(elem)
{
	short v0,v1,v2,idx,inc;
	read(bot, v0);
	read(v0, v1);
	read(deq, v2);
	getelementptr(v2,v1,idx);
	write(idx, elem);				
	inc = v1 + 1;
	write(v0, inc);					//LP
}


inline popTop(retval) {
short v0,v1,v2,v3,idx,shr,cmp,v4,v5,add5,v6;

entry:
	read(age, v0);
	read(v0, v1);
	read(bot, v2);
	read(v2, v3);
	shr = (v0 % 100); //ashr i32 %1, 16
  	cmp = (v3 > shr);
if	:: cmp -> goto  ifend;
	:: else -> retval = -1; goto ret;
fi;

ifend:
  read(deq,v4); 
  getelementptr (4, shr, idx);
  read(idx,v5); 
  add5 = v1 + 1; //TODO evtl muss es 101 sein 2^16
  cas(v0,v1, add5, v6)
if	:: v6 -> retval = v5;
	:: else -> retval = -2;
fi;
ret: skip;
}

inline popBottom(retval) {
short v0,v1,v2,v3,idx,shr,cmp, cmp1,v4,v5,v6,v8, dec,and,add,cmp5 ;
entry:
  read(bot,v0);
  read(v0, v1);
  cmp = (v1 == 0);
if	:: cmp -> retval = -1; goto ret;
	:: else -> goto ifend;
fi;

ifend:
  dec = v1 - 1;
  write(v0, dec);
  read(deq, v2);
  getelementptr(v2,dec,idx);
  read(idx,v3);
  read(age,v4);
  mfence();
  read(v4,v5);
  shr = v5 % 100; //%shr = ashr i32 %5, 16
  cmp1 = dec > shr;
  
  if	:: cmp1 -> retval = v3; goto ret;
  		:: else -> v8 = v4; goto ifend3;
  fi;

ifend3:
  write(v0, 0);
  and = v5- (v5%100); //v1 first two digits remain, the last two are 00
  add = and + 100;		//tag increment
  cmp5 = (dec == shr);
if	:: cmp5 -> goto ifthen6;
	:: else -> goto ifend9;
fi;

ifthen6:
  cas(v4,v5,add,v6);
if	:: v6 -> retval = v3; goto ret;
	:: else -> goto ifthen10;
fi; 

ifthen10:
  read(age,v8);

ifend9: 
  write(v8,add);
  retval = -1;

ret: skip;            
}





//---------------------------------------------------------------------------------------------------------------------------------------
proctype process1(chan ch){
	pushBottom(111);
	mfence();
	popBottom(res1);
	done1 = true;
	assert(
		!(done1&&done2)
		|| ((res1==111&&res2<0) || (res1<0&&res2==111))
	);
}

proctype process2(chan ch){
	popTop(res2);
	done2 = true;
	assert(
		!(done1&&done2)
		|| ((res1==111&&res2<0) || (res1<0&&res2==111))
	);
}


init{
atomic{
	alloca(Ptr, bot);	//int*
	alloca(Ptr, memory[bot]);
	alloca(Ptr, age);	//int*
	alloca(Ptr, memory[age]);
	alloca(Ptr, deq);
	//alloca(Ptr, memory[deq]);	
	alloca(10, memory[deq]);
	

	run process1(channelT1);
	run bufferProcess(channelT1);
	run process2(channelT2);
	run bufferProcess(channelT2);
	//run process3(channelT3);
	//run bufferProcess(channelT3);
	}
}

	
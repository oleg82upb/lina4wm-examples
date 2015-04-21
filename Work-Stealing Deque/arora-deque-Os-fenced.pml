#define MEM_SIZE 15	//size of memory
#define NULL 0
#define I32  0 		// = {0};
#define Ptr  0
#define QLength 6

#define EMPTY 0
#define ABORT -2
#define MYNULL -1

short memory[MEM_SIZE];
short memUse = 1; 	//shows to the next free cell in memory
short bot, age, deq;
short res1,res2;
bit done1 = false, done2 = false;

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

inline cas(adr, old, new, result)
{
	atomic{
	if 	:: memory[adr] == old -> memory[adr] = new; result = true;
		:: else -> result = false;
	fi;
	}
}

//TODO make sure loading writing of age as replaced by a two slot write
inline pushBottom(elem){ 
short v0,v1,v2, idx, inc;

P0: v0 = memory[bot];
P1: v1 = memory[v0];
P2: v2 = memory[deq];
P3: getelementptr(v2, v1, idx); 
P4: goto P5idx;

P5idx: 
if 	:: true -> memory[idx] = elem; goto P5;
	:: true -> inc = v1  + 1; goto P6idx; 
fi;

P5: inc = v1  + 1; goto P6;

P6idx: 
if	:: true -> memory[idx] = elem; goto P6;
	:: true -> goto P7idxv0;
fi;

P6: skip;
P7idxv0: memory[idx] = elem; goto P7v0;
P7v0: memory[v0] = inc;
P7: skip;
}

inline popTop(retval){ 
short v0, v1, v2, v3, v4, idx, v5, v6, shr, add5, cmp; 

D0: v0 = memory[age];
D1: v1 = memory[v0];
D2: v2 = memory[bot];
D3: v3 = memory[v2];
D4: shr = v1 % 100;
D5: cmp = (v3 > shr);
D6: if :: cmp -> goto D7;
	:: else -> retval = MYNULL; goto D15;
fi;
D7: v4 = memory[deq];
D8: getelementptr(v4, shr, idx); 
D9: v5 = memory[idx]; 
D10: add5 = v1 + 1;		//2^16 originally
D11: cas( v0, v1, add5 , v6);
//D12: v7 = (v6  == v1 )
D13: if :: v6 -> retval = v5;
		:: else -> retval = ABORT;
	fi; 
//D14: goto L_15;
D15: skip;
}


inline popBottom(retval){ 
short v0,v1,cmp, dec, idx, v2, v3, v4, v5, v6, cmp1, cmp5, add, and, shr; 

O0: v0 = memory[bot];
O1: v1 = memory[v0];
O2: cmp = (v1 == 0 );
O3: 
if	:: cmp -> retval = MYNULL; goto O28;
	:: else -> goto O4;
fi;
O4: dec = v1  -1; 
O5: skip;
O6v0: 
if	:: true -> memory[v0] = dec; goto O6;
	:: true -> v2 = memory[deq]; goto O7v0;
fi;
O6: v2 = memory[deq]; goto O7;

O7v0: 
if	:: true -> memory[v0] = dec; goto O7;
	:: true -> getelementptr(v2, dec, idx); goto O8v0; 
fi;

O7: getelementptr(v2, dec, idx); goto O8; 

O8v0: 
if	:: true -> memory[v0] = dec; goto O8;
	:: true -> v3 = memory[idx]; goto O9v0;
fi;

O8: v3 = memory[idx]; goto O9;

O9v0: 
if	:: true -> memory[v0] = dec; goto O9;
	:: true -> v4 = memory[age]; goto O10v0;
fi;

O9: v4 = memory[age]; goto O10;

O10v0: memory[v0] = dec; goto O10;
O10: skip; //fence

O11: v5 = memory[v4]; 
//----------------------
O12: shr = v5 % 100; // age.top 
O13: cmp1 = (dec > shr );
//-------------------------------
O14: 
if	:: cmp1 -> retval = v3; goto O28;
	:: else -> goto O15;
fi;

O15: skip;
//------------------------
O16: and = v5- (v5%100); //v1 first two digits remain, the last two are 00    				newtop = 0; //%and = %5  & 65535 
O17: add = and + 100;		//tag increment													newtag = v5tag + 1; //%add = %and  + 1
//-------------------------
O18: cmp5 = (dec == shr);
O19: 
if	:: cmp5 -> goto O20;
	:: else -> goto O25;
fi;


O16v0: 
if	:: true -> memory[v0] = 0; goto O16;
	:: true -> and = v5- (v5%100); goto O17v0; 
fi;

O17v0: 
if	:: true -> memory[v0] = 0; goto O17;
	:: true -> add = and + 100; goto O18v0;
fi;
 
O18v0: 
if	:: true -> memory[v0] = 0; goto O18;
	:: true -> cmp5 = (dec == shr); goto O19v0;
fi;

O19v0: 
if	:: true -> memory[v0] = 0; goto O19;
	:: cmp5 -> goto O20v0;
	:: !cmp5 -> goto O25v0;
fi;

O20v0: memory[v0] = 0; goto O20;

O20: cas(v4 , v5, add, v6);

//O21: v7 = (v6  == %5 )
O22: 
if	:: v6 -> retval = v3; goto O28;
	:: else -> goto O24;
fi;

//O23: v_.pre = memory[ @age]; obsolete as @age is not changing anyway
O24: goto O25;

O25: skip; //phi([%.pre , if.then6.if.end9_crit_edge(PC:24)], [%4 , if.end3(PC:25)]) obsolete as well
O26: goto O27v8;

O25v0:
if	:: true -> memory[v0] = 0; goto O25;
	:: true -> goto O26v0; //phi([%.pre , if.then6.if.end9_crit_edge], [%4 , if.end3(PC:19)])
fi;
O26v0:
if	:: true -> memory[v0] = 0; goto O26;
	:: true -> goto O27v0v8;
fi;


O27v0v8:
if	:: true -> memory[v0] = 0; goto O27v8;
	:: true -> retval = MYNULL; goto O28v0v8;
fi;

O27v8: 
if	:: true -> memory[v4] = add; goto O27;
	:: true -> retval = MYNULL;; goto O28v8;
fi;

O27: retval = MYNULL; goto O28;

O28v0v8: 
if	:: true -> memory[v0] = 0; goto O28v8;
	:: true -> goto O29v0v8; //phi([-1 , if.end9(PC:27)], [-1 , entry], [%3 , if.end], [%3 , if.then6])
fi;



O28v8:
if	:: true -> memory[v4] = add; goto O28;
	:: true -> goto O29v8; //phi([-1 , if.end9(PC:28)], [-1 , entry], [%3 , if.end], [%3 , if.then6])
fi;

O29v0v8: memory[v0] = 0; goto O29v8;

O29v8: memory[v4] = add; goto O29;

//return
O28: skip;
O29: skip;
O30: skip;
}


proctype process1(){
	pushBottom(111);
	popBottom(res1);
	done1 = true;
	assert(
		!(done1&&done2)
		|| ((res1==111&&res2<0) || (res1<0&&res2==111))
	);
}

proctype process2(){
	popTop(res2);
	done2 = true;
	assert(
		!(done1&&done2)
		|| ((res1==111&&res2<0) || (res1<0&&res2==111))
	);
}


init{
atomic{
	alloca(Ptr, bot);	//int**
	alloca(Ptr, memory[bot]); //int*
	alloca(Ptr, age);	//int** 
	alloca(Ptr, memory[age]); //int* 
	alloca(Ptr, deq);	//int**
	alloca(QLength, memory[deq]); //int*
	//alloca(QLength, memory[memory[deq]]);  //array starting at deq*
	//bot and age are initially 0 anyway, no initialization necessary
	

	run process1();
	run process2();
	}
}

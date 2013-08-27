
#define EMPTY 0
#define RESERVED 1
#define FULL 2
#define LOOKUP 1
#define INSERT 2
#define DELETE 3
#define INSERTPAIR 4
#define INV 1
#define RET 2
#define HISTLENG 12
#define EVL 4
c_code{
	int myfun(char a[][EVL]) 
	{
		FILE * pFile;
		pFile = fopen ("history.history","a+");
		if (pFile!=NULL)
		{
			int k = 0, l = 0;
			for(k; k < HISTLENG; k++) 
			{
				l = 0;
				//fprintf(pFile, "%d: ", k);
			    for(l; l < EVL; l++) 
			    {
			    	if(a[k][l] != NULL)
			    	{
			        	fprintf(pFile, "%d " , a[k][l]);
			        } else
			        {	
			        	fprintf(pFile, "- ");
			        }
			    }
			    fprintf(pFile, ", ");
			}
		  //fputs ("fopen example",pFile);
		  fprintf(pFile,"%s","\n");
		  fclose (pFile);
		}
		else
		{	int err = 1 / 0;
		}
		
		return 1;
	}
}

#define N 2
typedef matrix{byte slot [3]}
typedef event{byte h [EVL]}
//slot ::= (short: element, {EMPTY,RESERVED,FULL}: status, PID:lock)
//short arr[N];
matrix arr [N];
event history [HISTLENG];
hidden byte c = 0;

bit iEnd=0,i2End=0, lEnd=0,l2End=0, dEnd=0,d2End=0, ipEnd=0, 
successI1=0,successI2=0,successL1=0,successL2=0,successD1=0,successD2=0;
short iI1=0, fI1=0, iI2=0, fI2=0, iL1=0, iL2=0, iD1=0, iD2=0;


inline put(invret,type, inout)
{
atomic{
history[c].h[0] = invret;
history[c].h[1] = _pid;
history[c].h[2] = type;
history[c].h[3] = inout;
c++;
}
}
inline putIP(invret,type, in1, in2)
{
atomic{
history[c].h[0] = invret;
history[c].h[1] = _pid;
history[c].h[2] = type;
history[c].h[3] = in1;
history[c].h[4] = in2;
c++;
}
}


inline lock(sl)
{
	do ::
	atomic{
		if
		  :: arr[sl].slot[2] == 0 -> arr[sl].slot[2] = _pid; break;
		  :: else -> skip;
		fi;
	}
	od;
}

inline unlock(sl)
{
	atomic{
	assert(arr[sl].slot[2] == _pid);
	arr[sl].slot[2] = 0;
	}
}

inline findSlot(slf, f)
{
	atomic{
	slf = -1;
	
	for (f : 0 .. N-1) {
		//lock(f);
		if
			:: arr[f].slot[1] == EMPTY 
				-> arr[f].slot[1] = RESERVED; 
				slf = f; 
				//unlock(f); 
				break;
			:: else -> skip; 
		fi;
		//unlock(f);
	}
	f = 0;
	}
}

inline lookUp(x, result, i, eb)
{
atomic{
	printf("call lookUp");
	put(INV, LOOKUP,x);
	result = 0;
	}
	
	for (i : 0 .. N-1) {
		atomic{
		//lock(i);
		if
			:: arr[i].slot[1] == FULL && arr[i].slot[0] == x  
				-> result = 1; 
			//	unlock(i); 
				break;
			:: else -> skip; 
		fi;
		//unlock(i);
		}
	}
	
	atomic{
	i = 0;
	put(RET, LOOKUP,result);
	printf("ret lookUp");
	eb = 1;
	}
}

inline insert(x, result, i, f, eb)
{
atomic{
	put(INV, INSERT, x);
	printf("call ins");
	result = 0;
	}
	
	findSlot(i, f);
	if 
		:: i != -1 ->
			arr[i].slot[0] = x;
			atomic{
			//lock(i);
			arr[i].slot[1] = FULL;
			//unlock(i);
			result = 1;
			}
			
		:: else -> skip;
	fi;
	atomic{
	i = 0;
	put(RET, INSERT,result);
	printf("ret ins");
	eb = 1;
	}
}

inline insertPair(x, y, result)
{
atomic{
	putIP(INV, INSERTPAIR,x, y);//TODO two inputs
	printf("call insPair");
	result = 0;
	}
	findSlot(i, f);
	if
		:: i != -1 -> 
		findSlot(j, f);
		if 
			:: i == -1 ->
				arr[i].slot[1] = EMPTY;
			:: else ->
				arr[i].slot[0] = x;
				arr[j].slot[0] = y;
				atomic{
				lock(i);
				lock(j);
				arr[i].slot[1] = FULL;
				arr[j].slot[1] = FULL;
				unlock(i);
				unlock(j);
				}
				result = 1;
		fi;
		:: else -> skip;
	fi;
	atomic{
	i = 0;
	j = 0;
	put(RET, INSERTPAIR,result);
	printf("ret insPar");
	}
}

inline delete(x, result, i, eb)
{
	atomic{
	printf("call del");
	put(INV, DELETE,x);
	result = 0;
	}
	for (i : 0 .. N-1) {
		
		atomic{
		//lock(i);
		if
			:: arr[i].slot[1] == FULL && arr[i].slot[0] == x  
				-> arr[i].slot[1] = EMPTY;
			//	unlock(i); 
				result = 1; 
				break;
			:: else -> skip; 
		fi;
		//unlock(i);
		}
	}
	
	atomic{
	i = 0;
	put(RET, DELETE,result);
	printf("ret del");
	eb = 1;
	}
}




proctype insertP(int x)
{
	insert(x, successI1, iI1, fI1, iEnd);
}

proctype insertP2(int x)
{
	insert(x, successI2, iI2,fI2, i2End);
}

proctype deleteP(int x)
{
	delete(x,successD1, iD1, dEnd);
}

proctype deleteP2(int x)
{
	delete(x,successD2, iD2, d2End);
}

proctype lookupP(int x)
{	
	lookUp(x, successL1, iL1, lEnd);
}

proctype lookupP2(int x)
{	
	lookUp(x, successL2, iL2, l2End);
}

proctype insertpairP(int x, y)
{	
	short i = 0, j = 0, f= 0;	
	bit success;
	insertPair(x, y, success);
//end: skip;
	ipEnd = 1;
}

init{
atomic{
//	atomic{
//	bit success;
//	short i = 0, f= 0;
//	insert(2, success);
//	insert(3, success);
//	}
	run insertP(2);
	run insertP2(3);
	run deleteP(2);
	run lookupP(2);
	run deleteP2(3);
	//run lookupP2(3);
	//run insertpairP(x,3);
	}
}

inline checkAssertion()
{
assert(!(
history[0].h[0] == 1 &&
history[0].h[1] == 2 &&
history[0].h[2] == 2 && 
history[0].h[3] == 2 &&
//history[0].h[4] == 0 &&

history[1].h[0] == 1 &&
history[1].h[1] == 5 &&
history[1].h[2] == 4 && 
history[1].h[3] == 2 &&
history[1].h[4] == 3 &&

history[2].h[0] == 2 &&
history[2].h[1] == 5 &&
history[2].h[2] == 4 && 
history[2].h[3] == 1 &&
//history[2].h[4] == 0 &&

history[3].h[0] == 2 &&
history[3].h[1] == 2 &&
history[3].h[2] == 2 && 
history[3].h[3] == 1 &&
//history[3].h[4] == 0 &&

history[4].h[0] == 1 &&
history[4].h[1] == 4 &&
history[4].h[2] == 1 && 
history[4].h[3] == 2 &&
//history[4].h[4] == 0 &&

history[5].h[0] == 1 &&
history[5].h[1] == 3 &&
history[5].h[2] == 3 && 
history[5].h[3] == 2 &&
//history[5].h[4] == 0 &&

history[6].h[0] == 2 &&
history[6].h[1] == 4 &&
history[6].h[2] == 1 && 
history[6].h[3] == 0 &&
//history[6].h[4] == 0 &&

history[7].h[0] == 2 &&
history[7].h[1] == 3 &&
history[7].h[2] == 3 && 
history[7].h[3] == 1 
//history[7].h[4] == 0 &&
));
}
active proctype check()
{
//insertP@end && deleteP@end && lookupP@end;
iEnd 
&& dEnd 
&& lEnd
&& i2End && 
d2End 
//&& l2End 
//&& ipEnd && l1End 
-> 
c_code{myfun(now.history);};
//true;
//checkAssertion();
}
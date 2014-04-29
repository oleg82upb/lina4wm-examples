#define QSIZE 5


typedef array { short v[QSIZE] }; 
array queue[2];
bit ebit = 0, dbit = 0;
short 	last[2];
short i = 0;

// Enq and Deq both perform their actions atomically and hence should be linearizable
inline Enq(lbit, element)
{
	atomic{
	queue[lbit].v[last[lbit]] = element;
	last[lbit]++;
	}
}


// result = -1 means queue is empty
inline Deq(lbit, result)
{
			atomic{
			if 
			:: last[lbit] == 0 -> result = -1;	//queue is empty, wait
			:: else -> {
				result = queue[lbit].v[0];
				//cleanup
				for (i : 1 .. last[lbit]-1) {
					queue[lbit].v[i-1] = queue[lbit].v[i];
				} 
				//remove duplicate tail
				last[lbit]--;
				queue[lbit].v[last[lbit]] = 0;
				i = 0;
				
				}
			fi;
			}
}

inline CAS(var, old, new, result)
{
	atomic{ 
	if 
		:: var == old -> {var = new; result = 1;}
		:: else -> result = 0;
	fi;
	} 
}


//actual QC enqueue and dequeue operations
inline enqueue(element)
{
	bit success,lbit; 
	atomic{success = 0; lbit = 0;}
	do 
		::  success -> goto finEnq;
		:: else -> {
			lbit = ebit;
			CAS(ebit, lbit, 1-lbit, success);
		}
	od;
finEnq: Enq(lbit, element);;
}

inline dequeue(result)
{
	bit success,lbit; 
	atomic{success = 0; lbit = 0;}
	do 
		::  success -> goto finDeq;
		:: else -> {
			lbit = dbit;
			CAS(dbit, lbit, 1-lbit, success);
		}
	od;
finDeq: Deq(lbit, result);
}


proctype process1(){
	
	short result;
	enqueue(111);
	enqueue(222);
	dequeue(result);
	printf("\n %d \n", result);
	dequeue(result);
	printf("\n %d \n", result);
	enqueue(333);
	
}

proctype process2(){
	
	short result;
	dequeue(result);
	printf("\n %d \n", result);
	assert(result != 333);
}

proctype process3(){
	
	Enq(1, 111);
}



init{
atomic{
last[0] = 0;
last[1] = 0;
	run process1();
	run process2();
}
}


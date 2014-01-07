#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)
#define fence() __sync_synchronize ()
#include "stdlib.h"
#include "stdio.h"
#include "unistd.h"
#include <sys/ipc.h>
#include <sys/shm.h>
#include <time.h>


#define EMPTY 0
#define ABORT -2
#define ARR_SIZE 100
#define MYNULL -1

unsigned int *top, *bot;

//age.top: 		age >> 16
//age.tag: 		age & 0xFFFF;
//combine by 	age = (top << 16 ) | tag;
int *age;
int *deq;

void push(int elem){   //pushBottom
	unsigned int localBot = *bot;
	//printf("lb: %d \n", localBot);
	deq[localBot] = elem;
	//printf("deq(lb): %d \n", deq[localBot]);
	localBot++;
	//printf("lb: %d \n", localBot);
	*bot = localBot;
	//printf("bot: %d \n\n", *bot);
}

int dequeue(){				//steal or dequeue
	int oldAge = *age;
	unsigned int localBot = *bot;
	//printf("bot: %d\n", localBot);
	//printf("oldAge.top: %d\n", (oldAge>>16));
	if (localBot <= (oldAge>>16))	//oldAge.top
	{
		return MYNULL;
	}
	int elem = deq[oldAge >> 16] ;	//oldAge.top
	int newAge = oldAge;
	newAge = (((newAge >> 16) + 1) << 16) | (newAge & 0xFFFF);		//increment newAge.top

	if (CAS(age, oldAge, newAge))
	{
		return elem;
	}
	return ABORT;
}


int pop(){
	unsigned int localBot = *bot;
	if( localBot == 0)
	{
		return MYNULL;
	}
	localBot--;
	*bot = localBot;

	int elem = deq[localBot];
	//printf("elem: %d \n", elem);
	int oldAge = *age;

	if ( localBot > (oldAge >> 16))
	{
		return elem;
	}
	*bot = 0;

	//newAge.top = 0;
	//newAge.tag = oldAge.tag + 1;
	int newAge = (0 << 16) | ((oldAge & 0xFFFF) + 1);

	if (localBot == (oldAge>>16))
	{

		if (CAS(age, oldAge, newAge))
		{
			return elem;
		}
	}
	*age = newAge;
	return MYNULL;


}

int main(int argc, char** argv)
{
	int *p1Observed, *p1Finished, *p2Observed, *p2Finished;
	int *run, *testFinished;
	int key = 2405;
	int shID1 = shmget(key, 4*ARR_SIZE, IPC_CREAT | 0666);
	int shID2 = shmget(key+1, 4, IPC_CREAT | 0666);
	int shID3 = shmget(key+2, 4, IPC_CREAT | 0666);
	int shID4 = shmget(key+3, 4, IPC_CREAT | 0666);
	int shID5 = shmget(key+4, 4, IPC_CREAT | 0666);
	int shID6 = shmget(key+5, 4, IPC_CREAT | 0666);
	int shID7 = shmget(key + 6, 4, IPC_CREAT | 0666);
	int shID8 = shmget(key + 7, 4, IPC_CREAT | 0666);
	int shID9 = shmget(key + 8, 4, IPC_CREAT | 0666);
	int shID10 = shmget(key + 9, 4, IPC_CREAT | 0666);
	int shID11 = shmget(key + 10, 4, IPC_CREAT | 0666);
	deq = (int*)shmat(shID1, (void*)0, 0);
	top = shmat(shID2, 0, 0);
	*top = 0;
	bot = shmat(shID3, 0, 0);
	*bot = 0;
	age = shmat(shID4, 0, 0);
	*age = 0;
	int *finished = shmat(shID5, 0, 0);
	*finished = 0;
	int *parentDone = shmat(shID6, 0, 0);
	*parentDone = 0;

	p1Observed = shmat(shID10, 0, 0);
	*p1Observed = 0;
	p2Observed = shmat(shID11, 0, 0);
	*p2Observed = 0;
	p1Finished = shmat(shID7, 0, 0);
	*p1Finished = 0;
	p2Finished = shmat(shID8, 0, 0);
	*p2Finished = 0;
	testFinished = shmat(shID9, 0, 0);
	*testFinished = 0;

	if (shID1 < 0 || shID2 < 0 || shID3 < 0 || shID4 < 0 || shID5 < 0
			|| shID6 < 0 || shID7 < 0 || shID8 < 0 || shID9 < 0 || shID10 < 0
			|| shID11 < 0)
	{
		printf("shmget failed\n");
		perror("shmget error");
		return -1;
	}

	printf("top: %p, bot: %p, age: %p, deq: %p \n", top, bot, age, deq);


	int r = -1;
	int random;
	int pid = fork();
	printf("fork1 %d with %d\n", getpid(), pid);
	if (pid == 0)
	{
		//stealer
		while (1)
		{ //printf("p1");
			while (*p1Finished)
			{
				usleep(1);
				if (*testFinished)
				{
					return 0;
				}
			}
			fence();
			//usleep(50);
			*p1Observed = dequeue();
			*p1Finished = 1;
		}
	}
	else
	{
		pid = fork();
		printf("fork2 %d with %d\n", getpid(), pid);

		if(pid == 0)
		{
			//producer (not really) and consumer
			while (1)
			{
				push(667);
				while (*p2Finished)
				{
					usleep(1);
					if (*testFinished)
					{
						return 0;
					}
				}
				fence();

				*p2Observed = pop();
				*p2Finished = 1;
			}
		}
		else
		{

			int cnt = 0, cnt2 = 0, elem = 666, popCnt = 0, deqCnt = 0;
			//observer
			while (cnt < 100000)
			{
				*p2Finished = 0;
				*p1Finished = 0;

				//*run = 1;
				fence();
				while(!*p1Finished || !*p2Finished)
				{
					usleep(1);
					//busy wait
				}
				//done, reset their flags and values

				//push(666);//usually done by popping process
				//check observed values
				fence();
				cnt++;
				int p1 = *p1Observed, p2 = *p2Observed;
				//printf("p1 = %d p2 = %d\n",p1,p2);
				if(p1 == p2 && p1 != -1)
				{
					//failure due to tso
					cnt2++;
				}
				if (p1 > -1)
				{
					popCnt++;
				}
				if (p2 > -1)
				{
					deqCnt++;
				}
			}
			printf("\n test runs: %d\n test fails: %d\n deqs %d\n pops %d\n", cnt, cnt2, deqCnt, popCnt);
		}
	}

	*testFinished  = 1;

	if(*parentDone)
	{
		printf("");
	}

	shmctl(shID1, IPC_RMID, 0);
	shmctl(shID2, IPC_RMID, 0);
	shmctl(shID3, IPC_RMID, 0);
	shmctl(shID4, IPC_RMID, 0);
	shmctl(shID5, IPC_RMID, 0);
	shmctl(shID6, IPC_RMID, 0);
	shmctl(shID7, IPC_RMID, 0);
	shmctl(shID8, IPC_RMID, 0);
	shmctl(shID9, IPC_RMID, 0);
	shmctl(shID10, IPC_RMID, 0);
	shmctl(shID11, IPC_RMID, 0);


	printf("end %d\n", getpid());
	return 0;
}

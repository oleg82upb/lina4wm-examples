/*
*---------------------------------------------------------------------
*author: Annika Mütze muetze.annika@gmail.com
*date: June 2013
*Subject:spinlock C-Implementation
*---------------------------------------------------------------------
*/
#include "stdlib.h"
#include "stdio.h"
#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)


#define LOCK 1
#define UNLOCK 0

int *ptrX;
*ptrX = 1;

void aquire()
{
	while(1)
	{
		LOCK;
		if (CAS(&ptrX,1,0))
		{
			UNLOCK;
			//return;
		}
		UNLOCK;
		while (*ptrX==0);
	} 	
}	
void release()
{
	*ptrX=1;
}

void tryaquire()
{
	LOCK;
	if(CAS(&ptrX,1,0))
	{
		UNLOCK;
		//return 1;
	}
	UNLOCK;
	//return 0;
}

int main(int argc, char** argv){
	
	printf("x: %d\n",*ptrX);
	//aquire();
	//printf("x: %d\n",*ptrX);
	return 0;
}

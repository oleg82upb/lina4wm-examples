/*
*---------------------------------------------------------------------
*author: Annika Mütze muetze.annika@gmail.com
*date: June 2013
*Subject:spinlock C-Implementation
*---------------------------------------------------------------------
*/

#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)

#include "stdlib.h"
#include "stdio.h"

static int ptrX = 1;


void aquire()
{
	while(1)
	{
		if (CAS(&ptrX,1,0))
		{
			return;
		}
		while (ptrX==0);
	} 	
}	
void release()
{
	ptrX=1;
}

int tryaquire()
{
	if(CAS(&ptrX,1,0))
	{
		return 1;
	}
	return 0;
}

int main(int argc, char** argv){

	return 0;
}

#include <stdlib.h>
/*
 * burnsMutex.cpp
 *
 *  Created on: Jan 23, 2013
 *      Author: oleg
 */


bool f0 = 0, f1 = 0;
int i = 0;

void p1_aq()
{
		f0 = 1;
		//need fence here
		while (f1 != 0)
		{
			//wait
		}
}
void p1_rel()
{
	f0 = 0;
}

void p2_aq()
{
retry:	while (f0 != 0)
		{
			//wait
		}
		f1 = 1;
		//need fence here
		if(f0 != 0)
		{
			f1 = 0;
			goto retry;
		}
		//else critical section
}

void p2_rel()
{
	f1 = 0;
}

int main () {

}

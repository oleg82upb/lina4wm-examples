#include <stdlib.h>
/*
 * burnsMutex.cpp
 *
 *  Created on: Jan 23, 2013
 *      Author: oleg
 */


bool f0 = 0, f1 = 0;
int i = 0;

void p1()
{
	while (1)
	{
		f0 = 1;
		//need fence here
		while (f1 != 0)
		{
			//wait
		}
		//critical section
		//dummy action
		i++;
		f0 = 0;
	}
}

void p2()
{
	while (1)
	{
		while (f0 != 0)
		{
			//wait
		}
		f1 = 1;
		//need fence here
		if(f0 == 0)
		{
			//critical section
			//dummy action
			i++;
		}
		f1 = 0;

	}

}

int main () {

}

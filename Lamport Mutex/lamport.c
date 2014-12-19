#include <stdlib.h>
#include <stdbool.h>
#define N 2

bool choosing[N] = {0,0};
int number[N] = {0,0};


int max()
{
	int max = 0;
	for (int i = 0; i < N; i++)
	{
		if(max < number[i])
		{
			max = number[i];
		}
	}
	return max;
}

void proci(int i)
{
L1:	choosing[i] = 1;
	number[i] = 1 + max();
    choosing[i] = 0;

	for (int j = 0; j < N; j++)
	{
		// Wait until thread j receives its number:
		while (choosing[j])
		{ /* nothing */ }
		// Wait until all threads with smaller numbers or with the same
		// number, but with higher priority, finish their work:
		while ((number[j] != 0)
				&& (number[j] < number[i] || (number[j] == number[i] && j < i)))
		{ /* nothing */
		}
	}

    //critical section
    number[i] = 0;
    goto L1;
}



int main () {

}


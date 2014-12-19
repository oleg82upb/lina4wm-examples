#include <stdlib.h>
#include <stdbool.h>

bool flag[2] = {0,0};
int turn = 0;

void p0()
{
	flag[0] = 1;
	turn = 1;
	while (flag[1] && turn == 1)
	{
		// busy wait
	}

	// critical section
	flag[0] = 0;
}

void p1()
{
	flag[1] = 1;
	turn = 0;
	while (flag[0] && turn == 0)
	{
		// busy wait
	}

	// critical section
	flag[1] = 0;
}

int main () {

}


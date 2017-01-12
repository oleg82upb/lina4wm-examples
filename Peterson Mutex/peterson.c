#include <stdlib.h>
#include <stdbool.h>

bool *flag0 = 0;
bool *flag1 = 0;
bool *turn = 0;

void p0()
{
	*flag0 = 1;
	__sync_synchronize ();
	*turn = 1;
	__sync_synchronize ();
	while (*flag1 == 1 && *turn == 1)
	{
		// busy wait
	}

	// critical section
	*flag0 = 0;
}

void p1()
{
	*flag1 = 1;
	__sync_synchronize ();
	*turn = 0;
	__sync_synchronize ();
	while (*flag0 == 1 && *turn == 0)
	{
		// busy wait
	}

	// critical section
	*flag1 = 0;
}

int main () {

}


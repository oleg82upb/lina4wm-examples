#include <stdlib.h>

flag[2] = {0,0};
int turn = 0;

void p0()
{
	flag[0] = 1;
	while (flag[1])
	{
		if (turn != 0)
		{
			flag[0] = 0;
			while (turn != 0)
			{
				// busy wait
			}
			flag[0] = 1;
		}
	}

	// critical section
	turn = 1;
	flag[0] = 0;
}

void p1()
{
	flag[1] = 1;
	   while (flag[0]) {
	      if (turn != 1) {
	         flag[1] = 0;
	         while (turn != 1) {
	           // busy wait
	         }
	         flag[1] = 1;
	      }
	   }

	   // critical section
	   turn    = 0;
	   flag[1] = 0;
}

int main () {

}


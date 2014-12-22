#include <stdlib.h>
#include <stdbool.h>

bool *flag0 = 0;
bool *flag1 = 0;
bool *turn = 0;

void p0()
{
	*flag0 = 1;
	while (*flag1)
	{
		if (*turn != 0)
		{
			*flag0 = 0;
			while (*turn != 0)
			{
				// busy wait
			}
			*flag0 = 1;
		}
	}

	// critical section
	*turn = 1;
	*flag0 = 0;
}

void p1()
{
	*flag1 = 1;
	   while (*flag0) {
	      if (*turn != 1) {
	         *flag1 = 0;
	         while (*turn != 1) {
	           // busy wait
	         }
	         *flag1 = 1;
	      }
	   }

	   // critical section
	   *turn    = 0;
	   *flag1 = 0;
}

int main () {

}


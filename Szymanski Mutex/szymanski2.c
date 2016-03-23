#include <stdlib.h>
#include <stdbool.h>
#define N 2

int volatile *flag0 = 0;
int volatile *flag1 = 0;

void proc0()
{
L1:	*flag0 = 1;
	while(*flag1 > 2 ) {/* wait */}
	*flag0 = 3;
	if (*flag1 == 1 )
	{
		*flag0 = 2;
		while(*flag1 != 4) {/* wait */}
	}
	*flag0 = 4;
	//while(0 != 0 && *flag0 > 1){/* wait */} //p1 has to wait for p0

	//critical section

	while(*flag1 == 2 || *flag1 == 3 ){/* wait */} //p0 has to wait for p1
	*flag0 = 0;
	//	goto L1;
}
void proc1()
{
L1:	*flag1 = 1;
	while(*flag0 > 2) {/* wait */}
	*flag1 = 3;
	if (*flag0 == 1)
	{
		*flag1 = 2;
		while(*flag0 != 4) {/* wait */}
	}
	*flag1 = 4;
	while(*flag0 > 1){/* wait */} //p1 has to wait for p0

	//critical section

	//while(1 != 1 && (flag[1] == 2 || flag[1] == 3 )){/* wait */} //p0 has to wait for p1
	*flag1 = 0;
	//	goto L1;
}



int main () {

}


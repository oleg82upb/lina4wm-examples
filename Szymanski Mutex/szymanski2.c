#include <stdlib.h>
#include <stdbool.h>
#define N 2

bool flag[N] = {0,0};

void proci(int i)
{
L1:	flag[i] = 1;
	while(flag[0] > 2 || flag[1] > 2 ) {/* wait */}
	flag[i] = 3;
	if (flag[0] == 1 || flag[1] == 1 )
	{
		flag[i] = 2;
		while(flag[0] == 4 || flag[1] == 4) {/* wait */}
	}
	flag[i] = 4;
	while(i != 0 && flag[0] > 1){/* wait */} //p1 has to wait for p0

	//critical section

	while(i != 1 && (flag[1] == 2 || flag[1] == 3 )){/* wait */} //p0 has to wait for p1
	flag[i] = 0;
	goto L1;
}




int main () {

}


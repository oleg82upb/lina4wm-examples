#include <stdlib.h>
#define N 2

flag[N] = {0,0};

void proci(int i)
{
	flag[i] = 1;
	while(!allFlags123()) {/* wait */}
	flag[i] = 3;
	if (existFlag(1))
	{
		flag[i] = 2;
		while(!existFlag(4)) {/* wait */}
	}
	flag[i] = 4;
	while(allLowerIn01(i)){/* wait */}

	//critical section

	while(allHigherIn014(i)){/* wait */}
	flag[i] = 0;
}

int allHigherIn014(int i)
{
	for (int j = i + 1; j < N; j++)
	{
		if (flag[j] != 0 && flag[j] != 1 && flag[j] != 4)
			return 0;
	}
	return 1;
}

int existFlag(int i)
{
	for (int j = 0; j < N; j++)
	{
		if (flag[j] == i)
			return 1;
	}
	return 0;
}

int allLowerIn01(int i)
{
	for (int j = 0; j < i; j++)
	{
		if (flag[j] != 0 && flag[j] != 1)
			return 0;
	}
	return 1;
}

int allFlags123()
{
	for (int j = 0; j < N; j++)
	{
		if (flag[j] == 3 || flag[j] == 4)
			return 0;
	}
	return 1;
}


int main () {

}


#include <stdio.h>
#include <stdlib.h>

#define cas(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)
#define ABORT -1
#define OK 1
int volatile *glb = 0, *x = 0, *y = 0;
int lx1= 0,ly1=0,lx2= 0,ly2=0;


/**
TMBegin:
1 while ((loc = glb) & 1){ }

TMRead(addr):
1 tmp = *addr;
2 if (glb != loc)
3   abort();
4 return tmp;


TMWrite(addr, val):
	if (!(loc & 1))
	 	if (!cas(&glb, loc, loc+1))
	 		abort();
		loc++;
	*addr = val;

TMEnd:
if (loc & 1) glb++;
*/

int proc11() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite x := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*x = 1;

	//TMRead ly := y;
	tmp = *y;
	if (*glb != loc) {
		return ABORT;
	}
	ly1 = tmp;
	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int proc21()
{
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite y := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*y = 1;

	//TMRead lx := x;
	tmp = *x;
	if (*glb != loc) {
		return ABORT;
	}
	lx2 = tmp;
	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}


int proc12() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite x := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*x = 1;

	//TMRead lx := x;
	tmp = *x;
	if (*glb != loc) {
		return ABORT;
	}
	lx1 = tmp;

	//TMRead ly := y;
	tmp = *y;
	if (*glb != loc) {
		return ABORT;
	}
	ly1 = tmp;
	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int proc22()
{
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite y := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*y = 1;

	//TMRead ly := y;
	tmp = *y;
	if (*glb != loc) {
		return ABORT;
	}
	ly2 = tmp;

	//TMRead lx := x;
	tmp = *x;
	if (*glb != loc) {
		return ABORT;
	}
	lx2 = tmp;
	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int proc13() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite x := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*x = 1;

	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int proc23() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMWrite y := 1;
	if (!(loc & 1)) {
		if (!cas(glb, loc, loc + 1)) {
			return ABORT;
		}
		loc++;
	}
	*y = 1;

	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int proc33() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------
	//TMRead lx := x;
	tmp = *x;
	if (*glb != loc) {
		return ABORT;
	}
	lx1 = tmp;

	//TMRead ly := y;
	tmp = *y;
	if (*glb != loc) {
		return ABORT;
	}
	ly1 = tmp;


	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}


int proc43() {
	int loc, tmp;
	//TMBegin
	do {
		loc = *glb;
	} while (loc & 1);
	//----------------------------

	//TMRead ly := y;
	tmp = *y;
	if (*glb != loc) {
		return ABORT;
	}
	ly2 = tmp;

	//TMRead lx := x;
	tmp = *x;
	if (*glb != loc) {
		return ABORT;
	}
	lx2 = tmp;
	//----------------------------
	//TMend
	if (loc & 1) {
		__sync_synchronize ();
		(*glb)++;
	}
	return OK;
}

int main(int argc, char** argv){

	return 0;
}

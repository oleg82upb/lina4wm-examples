/*
*---------------------------------------------------------------------
*author: Annika Mütze muetze.annika@gmail.com
*date: Oktober 2013
*Subject:workstealing queue (Chase-Lev) C-Implementation
*---------------------------------------------------------------------
*/
#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)
#include "stdlib.h"

#define EMPTY 42
#define ABORT 1334

/*Typ declaration which allows metadata for queue*/
typedef struct{
	long size;
	int *ap;
} item_t;

long top, bottom;
item_t *wsq = NULL;

/*expand if Array has just one empty slot left*/	
item_t* expand(){
	int newsize = wsq->size * 2;
	int * newitems = (int*) malloc (newsize*sizeof(int));
	item_t* newq = (item_t*) malloc(sizeof(item_t));
	long i;
	for(i = top; i<bottom; i++){
		newitems[i % newsize] = wsq->ap[i % wsq->size];
	}
	newq->size = newsize;
	newq->ap = newitems;
	wsq = newq;
	return newq;
}


void push (int task){
	long b = bottom;
	long t = top;
	item_t* q = wsq;
	if(b-t >= q->size-1){
		q = expand();
	}
	q->ap[b % q->size] = task;		//q->size muss  != 0 sein!
	bottom = b + 1;
}

int take(){
	long b = bottom -1;
	item_t* q = wsq;
	bottom = b;
	long t = top;
	if(b < t){
		bottom = t;
		return EMPTY;
	}
	int task;
	task = q->ap[b % q->size];
	if (b > t){
		return task;
	}
	if (!CAS(&top, t, t+1)){
		return EMPTY;
	}
	bottom = t+1;
	return task;
}


int steal(){
	long t = top;
	long b = bottom;
	item_t* q = wsq;
	if (t >= b){
		return EMPTY;
	}
	int task;
	task = q->ap[t % q->size];
	if(!CAS(&top, t, t+1)){
		return ABORT;
	}
	return task;
}

int main(int argc, char** argv){
	wsq = malloc(sizeof(item_t));
	wsq->size = 1;
	wsq->ap = NULL;
	
	/*
		int i;
		push(65);
		for(i=0; i<wsq->size;i++){
			printf("Queue[%d]: %d\n", i,wsq->ap[i]);
		}
	*/
	free(wsq);
	return 0;
}

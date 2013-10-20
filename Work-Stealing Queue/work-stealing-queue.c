/*
*---------------------------------------------------------------------
*author: Annika Mütze muetze.annika@gmail.com
*date: Oktober 2013
*Subject:workstealing queue C-Implementation
*---------------------------------------------------------------------
*/
#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)

#include "stdlib.h"
#include "stdio.h"

#define EMPTY 42
#define ABORT 1334

void fence (char* text){
	printf("%s \n", text);
}

typedef struct{
	long size;
	int *ap;
} item_t;

long top, bottom;
item_t *wsq = NULL;
	
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
	fence("store-store");
	wsq = newq;
	printf("Ich bin am Ende von expand!\n");
	return newq;
}


void push (int task){
	long b = bottom;
	long t = top;
	printf("b: %ld\n, t: %ld\n",b,t);
	item_t* q = wsq;
	printf("q->size: %ld\n", q->size);
	printf("nach der Pointer zuweisung\n");
	if(b-t >= q->size-1){
		printf("Ich bin im if statement\n");
		q = expand();
	}
	printf("if ende oder kein if\n");
	q->ap[b % q->size] = task;		//q->size muss  != 0 sein!
	fence("store-store");
	bottom = b + 1;
}

int take(){
	long b = bottom -1;
	item_t* q = wsq;
	bottom = b;
	fence("store-load");
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
	fence("load-load");
	long b = bottom;
	fence("load-load");
	item_t* q = wsq;
	if (t >= b){
		return EMPTY;
	}
	int task;
	task = q->ap[t % q->size];
	fence("load-store");
	if(!CAS(&top, t, t+1)){
		return ABORT;
	}
	printf("Ich bin am Ende von steal()\n");
	return task;
}

int main(int argc, char** argv){
	wsq = malloc(sizeof(item_t));
	wsq->size = 1;
	wsq->ap = NULL;
	
	//printf("wsq->size: %ld\n", wsq->size); 
	
	int bla, blub;
	push(65);
	push(45);
	push(23);
	printf("push fertig\n");
	bla = take();
	printf("take: %d\n",bla);
	blub = steal();
	printf("steal: %d\n",blub);

	free(wsq);
	return 0;
}

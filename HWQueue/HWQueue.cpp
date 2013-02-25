#include <stdio.h>
#include <stdlib.h>


// Since bpl doesn't need array initialization
const int length = 20;

struct queue{
       int back;
       int items[length];
};

int inc(queue*);
void store(queue*, int, int);
int read(queue*);
int swap(queue*, int, int);

void enqueue(queue*, int);
void dequeue(queue*);


int main(int argc, char *argv[]){
    return 0;
}


/* this function increments the back-element and returns the old value */
/* atomic function */
int inc(queue *q){
    int r = q->back;
    q->back++;
    return r;
}

/* atomic function */
void store(queue *q, int newvalue, int index){
     q->items[index]=newvalue;
}

/* atomic function */
int read(queue *q){
    return q->back;
}

/* atomic function */
int swap(queue *q, int value, int index){
    int r = q->items[index];
    q->items[index] = value;
    return r;
}


/* --- NON atomic functions --- */

void enqueue(queue *q, int newvalue){
     int i = inc(q);
     store(q,newvalue,i);
}

void dequeue(queue *q){
     int range, i;
     
     while(true){
          range = read(q);
          range--;
          i = 1;
          while(i<=range){
               if(swap(q, 0, i) != 0)
                    return;
               i++;
          }
     }     
}

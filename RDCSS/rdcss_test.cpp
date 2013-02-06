#include<stdio.h>
#include<stdlib.h>
#include<typeinfo>

using namespace std;

typedef unsigned int  WORD; // 2bytes

struct stDescriptor{
       WORD *a1,*a2;     // a1 control address; a2 data address
       WORD o1,o2,n2;    // o1 expected value; o2 old value; n2 new value
};

WORD CAS1(WORD*,WORD,WORD);
WORD RDCSS(stDescriptor*);
WORD Read(WORD);
void Complete(stDescriptor*);
void printdesc(stDescriptor*);

int main(int argc, char *argv[]){
    WORD x = 10;
    WORD y = 20;
    stDescriptor *s = new stDescriptor();
    s->a1 = &x;
    s->a2 = &y;
    s->o1 = 10;
    s->o2 = 20;
    s->n2 = 30;
    printdesc(s);
    RDCSS(s);
    printdesc(s);
    fflush(stdin);
    getchar();
    return 0;
}

void printdesc(stDescriptor *s){
     printf(" a1: %d\n", s->a1);
     printf(" a2: %d\n", s->a2);
     printf("*a1: %d\n", *s->a1);
     printf("*a2: %d\n", *s->a2);
     printf(" o1: %d\n", s->o1);
     printf(" o2: %d\n", s->o2);
     printf(" n1: %d\n\n", s->n2);
}


WORD RDCSS(stDescriptor *d) {
WORD r;
do {
   r = CAS1((d->a2), d->o2, (WORD)d); /* C1*/
   if (typeid(r)==typeid(stDescriptor)) 
      Complete((stDescriptor*)r); /* H1*/
   } while (typeid(r)==typeid(stDescriptor)); /* B1*/
   if (r == d->o2) 
      Complete(d);
   return r;
}

WORD Read (WORD *addr) {
WORD r;
do {
   r = *addr; /* R1*/
   if (typeid(r)==typeid(stDescriptor)) 
      Complete((stDescriptor*)r); /* H2*/
   } while (typeid(r)==typeid(stDescriptor)); /* B2*/
   return r;
}

void Complete (stDescriptor *d) {
WORD v;
v = *(d->a1); /* R2*/
if (v==d->o1) 
   CAS1(d->a2, (WORD)d, d->n2); /* C2*/
else 
   CAS1(d->a2, (WORD)d, d->o2); /* C3*/
}

WORD CAS1(WORD *a, WORD o, WORD n){ 
//     return __sync_val_compare_and_swap(&(d->a2), d->o2, (WORD)d)
     WORD old = *a;
     if (old == o) 
        *a = n;
     return old;
}

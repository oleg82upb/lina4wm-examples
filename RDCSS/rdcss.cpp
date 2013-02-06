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
    return __sync_val_compare_and_swap(a, o, n);
}

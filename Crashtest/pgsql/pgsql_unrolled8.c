/* Adapted from PGSQL benchmark from http://link.springer.com/chapter/10.1007%2F978-3-642-37036-6_28 */

#include <stdbool.h>
#include <assert.h>
#include <pthread.h>


volatile _Bool latch1 = true;
volatile _Bool flag1  = true;
volatile _Bool latch2 = false;
volatile _Bool flag2  = false;


void* worker_1()
{
    //assert(!latch1 || flag1);
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
    latch1 = false;
    if(flag1) {
      flag1 = false;
      flag2 = true;
      __sync_synchronize ();
      latch2 = true;
    }
  return NULL;
}

void* worker_2()
{
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
    //assert(!latch2 || flag2);
    latch2 = false;
    if(flag2) {
      flag2 = false;
      flag1 = true;
      __sync_synchronize ();
      latch1 = true;
    }
  return NULL;
}

int main() {
  return 0;
}
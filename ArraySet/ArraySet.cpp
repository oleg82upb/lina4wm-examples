/*
ArraySet Implementation
bpl: unknown
cpp: Thomas Haarhoff (thha@mail.upb.de)
*/
/**///   indicates boogiepl code not translated to cpp

#include <stdio.h>
#include <stdlib.h>

const int arrayinit=10;

typedef int KeySpace;
typedef KeySpace keyType[arrayinit];
keyType key;

/**///const unique null: KeySpace;
/**///axiom null == 0;

int length=0;

///* Preprocessors */
//bool Member(KeySpace);
//void Insert(KeySpace);
//void Delete(KeySpace);

bool Member(KeySpace x)
{
    int i;
    int mylength;
    KeySpace v;
/**///  assume x > 0;
    i=0;
    mylength = length;
    while(i<mylength){
      while(i!=mylength){
        i=i+1;
        v=key[i];
        if(v==x){
          return true;
        }
      }
      mylength = length;
    }
    return false;
}

void Insert(KeySpace x)
{
    int i;
    int mylength;
    bool added;
    int holes[length];
    int nholes;
    KeySpace v;
/**///  assume x > 0;
    added = false;
    nholes = 0;
    mylength = length;
    i=1;
    while(i<=mylength){
      v=key[i];
      if(v==0){
        nholes =nholes +1;
        holes[nholes]=i;
      }
      i=i+1;
    }
    while(!added && nholes > 0){
        added = __sync_bool_compare_and_swap(&key[holes[nholes]], 0, x);      
        nholes = nholes -1;
    }
    while(!added) {
/**///    atomic-open
      {
        length = length+1;
        i=length;
      }
/**///    atomic-close
        added = __sync_bool_compare_and_swap(&key[i],0,x);
    }
/**///  assert added;
}

////// Delete-Precedure replaced, because of malfunction. //////
//Old Code:
/*
procedure Delete(x: KeySpace)
{
  var mylength, i: int;
  var todo: [int]int;
  var gen: [int]int;
  var ntodo: int;
  var removed: bool;
  var v: KeySpace;
  var g: int;

  assume x > 0;

  ntodo := 0;

  mylength := length;
  i := 1;
  while(i <= mylength) {
    g := gen[i];
    v := key[i];
    if(v == null) { 
      ntodo := ntodo + 1;
      todo[ntodo] := i;
      gen[ntodo] := g;
    }
    i := i + 1;
  }

  i := 0;
  while(i <= ntodo) {
    atomic {
      removed := (gen[todo[i]] == gen[i]);
      if(removed) {
        key[todo[i]] := null;
	gen[todo[i]] := gen[todo[i]] + 1;
      }
    }
    i := i + 1;
  }

  assert removed;
}
*/


void Delete(KeySpace x)
{
    int i;
    int mylength;
    mylength = length;
    bool removed;
    i=1;
    while(!removed && i<=mylength) {
       __sync_bool_compare_and_swap(&key[i],x,0);
       i=i+1;
    }
}
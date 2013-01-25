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
typedef int genType[arrayinit];
keyType key;
genType gen;

/**///const unique null: KeySpace;
/**///axiom null == 0;

int length=0;

/* Preprocessors */
bool Member(KeySpace);
void Insert(KeySpace);
void Delete(KeySpace);


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
/**/// atomic open
    {
        added =(key[holes[nholes]]==0);
        if(added) {
          key[holes[nholes]] = x;
        }
    }
/**/// atomic-close
      nholes = nholes -1;
    }
    while(!added) {
/**///    atomic-open
      {
        length = length+1;
        i=length;
      }
/**///    atomic-close
/**///    atomic-open
      {
        added =(key[i]==0);
        if(added) {
          key[i]=x;
        }
      }
/**///    atomic-close
    }
/**///  assert added;
}

void Delete(KeySpace x)
{
    int i;
    int mylength;
    int todo[length];
    int gen[length];
    int ntodo;
    bool removed;
    KeySpace v;
    int g;
/**///  assume x > 0;
    ntodo = 0;
    mylength = length;
    i=1;
    while(i<=mylength) {
      g=gen[i];
      v=key[i];
      if(v==0){
        ntodo = ntodo+1;
        todo[ntodo]=i;
        gen[ntodo] = g;
      }
      i=i+1;
    }
    i=0;
    while(i<=ntodo) {
/**///    atomic-open
      {
        removed = (gen[todo[i]]==gen[i]);
        if(removed){
          key[todo[i]]=0;
          gen[todo[i]]=gen[todo[i]]+1;
        }
      }
/**///    atomic-close
      i=i+1;
    }
/**///  assert removed;
}

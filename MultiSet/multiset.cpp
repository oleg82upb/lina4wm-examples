#include <stdio.h>
#include <stdlib.h>
const int length = 20;
enum Status {empty, reserved, full};
struct Slot{
       int elt;
       Status stt;
       bool bLock;
       
        bool lock(){
//               return __sync_bool_compare_and_swap(bLock,false,true);
               if(bLock == true)
                  return false;
               bLock = true;
               return true;
           }
        void unlock(){
               bLock = false;
           }
};

Slot M[length];

bool lookup(int);
int findslot(int);
bool insertpair(int,int);


int main(int argc, char *argv[]){
    return 0;
}

bool lookup(int x){
     int i;
     for(i = 0; i< length;i++){
           M[i].lock();
           if(M[i].elt==x && M[i].stt== full){
                M[i].unlock();
                return true;
           }
           M[i].unlock();
     }
     return false;
}

/* atomic function ... */
int findslot(int x){    // why x? never used
    int i;
    for(i = 0; i< length; i++){
         if(M[i].stt==empty){
              M[i].stt=reserved;
              return i;
         }
    }     
    return length;
}

bool insertpair(int x,int y){
     int i = findslot(x);
     if( i == length )
         return false;
         
     int j = findslot(y);
     if( j == length ){
         M[i].stt = empty;
         return false;
     }
     M[i].elt = x;
     M[j].elt = y;
     
     M[i].lock();
     M[j].lock();
     M[i].stt = full;
     M[j].stt = full;
     M[i].unlock();
     M[j].unlock();
     return true;
}

/*
* Anmerkungen zum Algorithmus:
*  - Es müssen mindestens 2 Elemente in der Liste sein bevor sie verwendet werden kann.
*  - Keine der 3 Funktionen(locate, add, remove) kann verwendet werden, wenn die Liste weniger als 2 Elemente hat.
*  - Alle Elemente müssen mit den Operationen <, >, == und != vergleibar sein und müssen paarweise die < Beziehung
*     - Daraus tolgt: Alle Elemente müssen disjunkt sein.
*     - Und: Alle Elemente werden in dieser Liste in aufsteigender Reihenfolge angeordnet.
*  - Der Alorithmus verwendet Locks, die die gesamte Liste ab einer gewissen Stelle sperren.
*  - Neu einzufügende Elemente müssen zwischen dem ersten und letzen Element einzuordnen sein.
*  - Das erste und letze Element dürfen nicht gelöscht werden.
*/

#include <stdio.h>
#include <stdlib.h>


struct stNode{
       int iValue;
       bool bLock;
       stNode *ptNext;
       void eInit(int iVal, bool bLoc){
               iValue = iVal;
               bLock = bLoc;
               ptNext = NULL;
           }
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


stNode* locate(int);
bool insert(int);
bool remove(int);
void init();


stNode *Head;
stNode *Tail;


int main(int argc, char *argv[]){
    init();
    printf("insert -1 = %d\n",insert(-1));
    printf("insert 5 = %d\n",insert(5));
    printf("insert 10 = %d\n",insert(10));
    printf("insert 20 = %d\n",insert(20));
    printf("remove 8 = %d\n",remove(8));
    printf("remove 10 = %d\n",remove(10));
    printf("insert 1 = %d\n",insert(1));
    printf("insert 10 = %d\n",insert(10));
    printf("insert 100 = %d\n",insert(100));
    printf("remove 1 = %d\n",remove(1));
    printf("remove 10 = %d\n",remove(10));
    printf("remove 100 = %d\n",remove(100));
    stNode *start = Head;
    do{
        printf("\nelement: %d",start->iValue);
        start=start->ptNext;
    }while(start->iValue<500);
    printf("\nelement: %d\n",start->iValue);
    fflush(stdin);
    getchar();
    return 0;
}


void init(){
    Head = new stNode;
    Head->eInit(-2147483648LL,false);
    Tail = new stNode;
    Tail->eInit(2147483647,false);
    Head->ptNext=Tail;
    Tail->ptNext=NULL;
}


/*
*  Anpassungen
*  - "return pred, curr" wird zu "return pred". Da locks auf pred und curr existieren,
     kann nach dem Aufruf sicher auf "pred.next"(curr) zugegriffen werden.
*/
stNode* locate (int x){
          stNode *pred = Head;
          Head->lock();
          stNode *curr = pred->ptNext;
          curr->lock();
          while(curr->iValue < x){
             pred->unlock();
             pred = curr;
             curr = curr->ptNext;
             curr->lock();
          }
          return pred;
}

bool insert(int iIns){
     bool result = false;
     stNode *left = locate(iIns);
     stNode *right = left->ptNext;
     if(right->iValue != iIns){
        stNode *mid;
        mid=new stNode;
        mid->eInit(iIns, false);
        mid->ptNext = right;
        left->ptNext = mid;
        result = true;
     }
     left->unlock();
     right->unlock();
     return result;
}

bool remove(int iDel){
     bool result = false;
     stNode *left = locate(iDel);
     stNode *del = left->ptNext;
     stNode *right = del->ptNext;
     if(del->iValue == iDel){
         left->ptNext = right;
         left->unlock();
         del->unlock();
         return true;
     }     
     left->unlock();
     del->unlock();
     return result;
}

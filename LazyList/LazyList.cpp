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
       bool bMark;
       stNode *ptNext;
       void eInit(int iVal, bool bLoc){
               iValue = iVal;
               bLock = bLoc;
               bMark = false;
               ptNext = NULL;
           }
           bool lock(){
               return __sync_bool_compare_and_swap(&bLock,false,true);
           }
           void unlock(){
               bLock = false;
           }               
};


stNode* locate(int);
bool insert(int);
bool remove(int);
bool validate(stNode*, stNode*);
bool contains(int);
void init();


stNode *Head;
stNode *Tail;



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
*  - im Algorithmus des Papers ist für den Fall das validate() fehlschlägt kein "return" vorgesehen.
     Es wurde ein "return NULL" ergänzt.
*/
stNode* locate (int x){
          stNode *pred = Head;
          stNode *curr = pred->ptNext;
          while(curr->iValue < x){
             pred = curr;
             curr = curr->ptNext;
          }
          pred->lock();
          curr->lock();
          if(validate(pred,curr)){
             return pred;
          }
          pred->unlock();
          curr->unlock();
          return NULL;
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
     return false;
}

bool remove(int iDel){
     stNode *left = locate(iDel);
     stNode *del = left->ptNext;
     stNode *right = del->ptNext;
     if(del->iValue == iDel){
         del->bMark =true;
         left->ptNext = right;
         left->unlock();
         del->unlock();
         return true;
     }     
     left->unlock();
     del->unlock();
     return false;
}
bool validate(stNode *pred, stNode *curr){
     if(!pred->bMark && !curr->bMark &&pred->ptNext ==curr)
          return true;
     return false;
}
bool contains(int iCon){
     stNode *curr = Head;
     while(curr->iValue < iCon)
          curr=curr->ptNext;
     if(curr->bMark)
          return false;
     return true;
}

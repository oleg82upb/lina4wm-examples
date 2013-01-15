#include <stdio.h>
#include <stdlib.h>
#define CAS(_ptr, _old, _new)  __sync_bool_compare_and_swap(_ptr, _old, _new)

class Node
{
public:
		Node():val (0) {};
		  int val;
		  Node *next;
};

class MSQueue {
public:
	Node * volatile head, * volatile tail;
	MSQueue();
	void enqueue(int);
	bool dequeue(int*);
};

MSQueue::MSQueue()
{
	Node *node = new Node();
	node->next = NULL;
	head = node;
	tail = node;
}

void MSQueue::enqueue(int value)
{
	Node *node, *localTail, *next;
	node = new Node;
	node->val = value;
	node->next = NULL;
	do {
		localTail = tail;
		next = localTail->next;
		if(localTail == tail)
		{
			if(next == NULL)
			{
				if (CAS(&localTail->next, next, node))
				{
					break;
				}
			}
			else
			{
				CAS(&tail, localTail, next);
			}
		}
	}while (1);
	CAS(&tail, localTail, node);
}

bool MSQueue::dequeue(int *value)
{
	Node *localHead, *localTail, *next;
	do {
		localHead = head;
		localTail = tail;
		next = localHead->next;
		if(localHead == head)
		{
			if(localHead == localTail)
			{
				if(next == NULL)
				{
					return 0;
				}
				CAS(&tail, localTail, next);
			}
			else
			{
				*value = next->val;
				if(CAS(&head, localHead, next))
				{
					break;
				}
			}
		}
	}while (1);
	//free(localHead)
	return 1;
}

int main(void)
{
//	MSQueue *q = new MSQueue();
//	q->enqueue(5);
//	q->enqueue(2);
//	q->enqueue(3);
//	int v1,v2,v3,v4;
//	bool b1, b2, b3, b4;
//	b1 = q->dequeue(&v1);
//	b2 = q->dequeue(&v2);
//	b3 = q->dequeue(&v3);
//	b4 = q->dequeue(&v4);
//	printf( "\nDeq1: %d %d\n", v1, b1 );
//	printf( "Deq2: %d %d\n", v2, b2 );
//	printf( "Deq3: %d %d\n", v3 , b3);
//	printf( "Deq4: %d %d\n", v4, b4 );
	return 0;
}

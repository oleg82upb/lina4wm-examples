#include <stdlib.h>
//implementation following Treiber Stack design
class Node
{
public:
		Node():val (0) {};
		  int val;
		  Node *next;
};

class Stack {
public:
	Node * volatile head;
	Stack();
	void push(int);
	Node* pop();
};

Stack::Stack(): head (NULL){};

void Stack::push(int v)
{
	Node *n, *ss;												
	n = new Node;												//U1
	n->val = v;													//U2
	do {
		ss = head;												//U3
		n->next = ss;											//U4
	}while (0 == __sync_bool_compare_and_swap(&head, ss, n));	//U5
}

Node* Stack::pop()
{
	Node *ss, *ssn;
	do {
		ss = head; 												//O1
		if(ss == NULL)											//O2
		{
			return NULL;										//O3
		}
		ssn = ss->next;											//O4
	}while (0 == __sync_bool_compare_and_swap(&head, ss, ssn));	//O5
	return ss;													//O6
}

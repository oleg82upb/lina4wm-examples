/* 	author: Annika Mütze
*	Date: June 2013
	Subject: seqlock 
*/

#include <stdio.h>

int x1 = 0;
int x2 = 0;
int c = 0;

void write( int word1, int word2){
	c++;
	x1 = word1;
	x2 = word2;
	c++;
}

void read(int *word){
	int c0 = 0;
	do{
		do{
			c0 = c;
		}while( c0 %2);
		word[0] = x1;
		word[1] = x2;
	}while(c != c0);
	
}	

int main(int argc, char** arv){
	int word[2] = {0,0};		
	write(2,3);
	printf(" x1: %d\n x2: %d\n c: %d\n", x1,x2,c);
	read(word);	
	printf("readausgabe: %d, %d\n", word[0], word[1]); 
	return 0;
}

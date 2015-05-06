
#include <stdio.h>
int main(int argc, char *argv[]){
int  N;
int  I;

scanf("%d",&N);
I= 2;
while( I <= N ) {

while( N % I == 0 ) {

N= N / I;
printf("%d ",I);
}
I= I + 1;
}
return 0;
}


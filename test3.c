
#include <stdio.h>
int main(int argc, char *argv[]){
int  N;
int  SQRT;

scanf("%d",&N);
SQRT= 0;
while( SQRT * SQRT <= N ) {

SQRT= SQRT + 1;
}
SQRT= SQRT - 1;
printf("%d",SQRT);
return 0;
}

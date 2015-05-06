
#include <stdio.h>
int main(int argc, char *argv[]){
int  N1;
int  N2;
int  NEXT;
int  MAX;

scanf("%d",&MAX);
N1= 0;
N2= 1;
printf("%d ",N1);
while( N2 < MAX ) {

printf("%d ",N2);
NEXT= N1 + N2;
N1= N2;
N2= NEXT;
}
return 0;
}

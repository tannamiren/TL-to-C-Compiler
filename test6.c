
#include <stdio.h>
int main(int argc, char *argv[]){
int  SMALLER;
int  BIGGER;
int  TEMP;

scanf("%d",&BIGGER);scanf("%d",&SMALLER);
 if( SMALLER > BIGGER) {

TEMP= SMALLER;
SMALLER= BIGGER;
BIGGER= TEMP;
}
while( SMALLER > 0 ) {

BIGGER= BIGGER - SMALLER;
 if( SMALLER > BIGGER) {

TEMP= SMALLER;
SMALLER= BIGGER;
BIGGER= TEMP;
}
}
printf("%d ",BIGGER);
return 0;
}
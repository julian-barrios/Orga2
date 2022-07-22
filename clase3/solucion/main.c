#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

int main (void){
	uint32_t x;
	product_2_f(&x, 583,521.44);
	printf("%d\n", x);
	printf("Esperado = 303997\n");
	return 0;    
}



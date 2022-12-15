#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <argp.h>

#include "utils.h"
#include "ej2.h"

void imprimirPuntero(const int16_t *ptr, unsigned sz) {
  	printf( "Valores: \n" );
  	for( size_t i = 0; i < sz; ++i ) {
    	printf( "%d \n", ptr[i] );
  	}
}


int main (int argc, char *argv[]) {

	unsigned size = 7;
	
	int16_t* entrada = (int16_t*) malloc(2*size*sizeof(int16_t));
	
	entrada[0] = 1;
	entrada[1] = 2;
	entrada[2] = 3;
	entrada[3] = 12;
	entrada[4] = 14;
	entrada[5] = 9;
	entrada[6] = 3;
	entrada[7] = 5;
	entrada[8] = 15;
	entrada[9] = 10;
	entrada[10] = 11;
	entrada[11] = 1;
	entrada[12] = 20;
	entrada[13] = 17;

	int16_t* salida = filtro(entrada, size);

	unsigned sz = size+1;

	imprimirPuntero(salida, sz);

	free(entrada);

	return 0;  
}


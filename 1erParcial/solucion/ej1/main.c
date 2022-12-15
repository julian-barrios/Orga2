#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

extern char** agrupar(msg_t* msgArr, size_t msgArr_len);

int main (void){
	
	msg_t msj1;
	
	char str1[] = "Hola ";
	msj1.text = malloc(4);

	msj1.text = str1;
	msj1.text_len = 5;
	msj1.tag = 0;

	msg_t msj2;
	
	char str2[] = "Chau";
	msj2.text = malloc(4);

	msj2.text = str2;
	msj2.text_len = 4;
	msj2.tag = 1;

	msg_t msj3;
	
	char str3[] = "mundo!";
	msj3.text = malloc(6);

	msj3.text = str3;
	msj3.text_len = 6;
	msj3.tag = 0;
	
	msg_t msg_arr[3] = {msj1, msj2, msj3};
	
    agrupar(msg_arr, 3);


	return 0;      
}



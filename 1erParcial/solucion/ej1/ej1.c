#include "ej1.h"

int long_total(msg_t* msgArr, size_t msgArr_len, int k){
    int res = 0;
    for(size_t i = 0; i < msgArr_len; i++){
        if((msgArr[i]).tag == k){
            res += msgArr[i].text_len ;
        }
    }
    return res;
}


char** agrupar_c(msg_t* msgArr, size_t msgArr_len){
    char** res = malloc(MAX_TAGS*sizeof(char*));
    for(size_t i = 0; i < MAX_TAGS; i++){
        int k = 0;
        int longitud = long_total(msgArr, msgArr_len, i);
        char* concatenacion = malloc(longitud);
        for(size_t j = 0; j < msgArr_len; j++){
            if((int) i == msgArr[j].tag){
                for(size_t u = 0; u < msgArr[j].text_len; u++){
                    concatenacion[k]= *(msgArr[j].text + u);
                    k++;
                }
            }
        }
        res[i] = concatenacion;
    }
    return res;
}
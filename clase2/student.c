#include "student.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>


void printStudent()
{
    student_t student;
    uint32_t* studentDir = (uint32_t*) &student;

    for (int i=(9-1); i>=0; --i){
        studentDir[i] = stack->pop(stack);
    }

    char* nombre = (char*)&studentDir[0];

    uint32_t dni = studentDir[6];
    uint8_t* calificaciones = (uint8_t*)&studentDir[7];

    int16_t concept = studentDir[8];
    
    printf("Nombre: %s \n", nombre);
    printf("Dni: %d \n", dni);
    printf("Calificationes: %d, %d, %d\n", calificaciones[0], calificaciones[1], calificaciones[2]);
    printf("Concepto: %d \n", concept);
}

void printStudentp()
{
    studentp_t student;
    uint32_t* studentDir = (uint32_t*) &student;

    for (int i=(8-1); i>=0; --i){
        studentDir[i] = stack->pop(stack);
    }
    
    char* nombre = student.name;

    uint32_t dni =  student.dni;

    uint8_t* calificaciones = student.califications;

    int16_t concept = student.concept;

    printf("Nombre: %s \n", nombre);
    printf("Dni: %d \n", dni);
    printf("Calificationes: %d, %d, %d\n", calificaciones[0], calificaciones[1], calificaciones[2]);
    printf("Concepto: %d \n", concept);
}

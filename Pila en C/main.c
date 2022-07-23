#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "student.h"

stack_t *stack;

int main()
{
    stack = createStack(100);

    student_t stud1 = {
        .name = "Steve Balmer",
        .dni = 12345678,
        .califications = {3,2,1},
        .concept = -2,
    };

    studentp_t stud2 = {
        .name = "Linus Torvalds",
        .dni = 23456789,
        .califications = {9,7,8},
        .concept = 1,
    };

    uint32_t *studp;

    // Hint: ver 'createFrame'

    stack->createFrame(stack);         //+2
    
    // Push student stud2

    uint32_t studentParts = 1+((sizeof(studentp_t)-1) / sizeof(uint32_t));
    uint32_t* studentDir = (uint32_t*) &stud2;

    for (int i=0; i<studentParts; ++i){
        stack->push(stack, studentDir[i]);      //+10
    }    

    // Push random value
    uint32_t value = 42;
    stack->push(stack,value);                   //+11

    // Push student stud1
    stack->createFrame(stack);                         //+13

    studentParts = sizeof(student_t) / sizeof(uint32_t);
    studentDir = (uint32_t*) &stud1;

    for (int i=0; i<studentParts; ++i){
        stack->push(stack, studentDir[i]);      //+22
    }

    // Print student st1 y st2

    void (*prStudpt)() = printStudent;
    myCall(stack, prStudpt);                    //+10

    uint32_t valor = stack->pop(stack);
    printf("Valor: %d \n",  valor);

    printf("------------------------- \n");

    // A qué apunta el esp???

    prStudpt = printStudentp;
    myCall(stack, prStudpt);

    free(stack->_stackMem);
    free(stack); // Alcanza?

    return 0;
}

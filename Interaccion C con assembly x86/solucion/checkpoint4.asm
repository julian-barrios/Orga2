extern malloc
extern free
extern fprintf

section .data
Null: DB "NULL", 0
form_str: DB "%s", 0

free_dir: dq free
fprintf_dir dq fprintf
malloc_dir: dq malloc

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
    push rbp
    mov rbp, rsp
    push r9
    push r8

    .ciclo_strCmp:
        mov r9b, [rdi]
        mov r8b, [rsi]
        cmp r9b, 0
        je .termino_a
        cmp r8b, 0
        je .b_menor
        cmp r9b, r8b
        jl .a_menor
        jg .b_menor
        inc rdi
        inc rsi
        jmp .ciclo_strCmp

    .termino_a:
        cmp r8b, 0
        je .terminaron_ambas
        jmp .a_menor

    .a_menor:
        mov rax, 1
        jmp .fin_strCmp

    .b_menor:
        mov rax, -1
        jmp .fin_strCmp
    
    .terminaron_ambas:
        mov rax, 0
        jmp .fin_strCmp

    .fin_strCmp:
    pop r8
    pop r9
    pop rbp 
    ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r14
    push r13
    push r12
    
    mov r12, rdi
    call strLen
    mov rdi, rax
    mov r14, rax
    inc rdi
    call [rel malloc_dir]

    .ciclo_strClone:
        mov r13b, [r12]
        cmp r13b, 0
        je .fin_strClone
        mov [rax], r13b
        inc rax
        inc r12
        jmp .ciclo_strClone

    .fin_strClone:
        mov byte [rax], 0
        sub rax, r14

    pop r12
    pop r13
    pop r14
    add rsp, 8
    pop rbp
    ret

; void strDelete(char* a)
strDelete:
    call [rel free_dir]
    ret

; void strPrint(char* a, FILE* pFile)
strPrint:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    mov r13, rsi
    call strLen
    cmp rax, 0
    jne .no_vacia

    mov rdi, rsi
    mov rsi, Null
    mov QWORD rax, 0
    call [rel fprintf_dir]
    jmp .fin_strPrint

    .no_vacia:
    mov rdi, rsi
    mov rsi, form_str
    mov rdx, r12
    mov QWORD rax, 0
    call [rel fprintf_dir]

    .fin_strPrint:
    pop r13
    pop r12
    pop rbp
    ret


; uint32_t strLen(char* a)
strLen:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r10

    xor rax, rax

    .ciclo_strLen:
    mov r10b, [rdi]
    cmp r10b, 0
    je .fin_strLen
    inc rax
    inc rdi
    jmp .ciclo_strLen

    .fin_strLen:
    pop r10
    add rsp, 8
    pop rbp
    ret
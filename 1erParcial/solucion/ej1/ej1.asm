global agrupar
extern malloc
extern free

extern long_total

%define MAX_TAGS 4
%define OFFSET_TEXT 0
%define OFFSET_TEXT_LEN 8
%define OFFSET_TAG 16
%define SIZE_MSG 24


;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;char** agrupar_c(msg_t* msgArr, size_t msgArr_len) 
; msgArr[rdi], msgArr[rsi]

agrupar:

    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

    mov rbx, rdi
    mov r12, rsi

    mov di, MAX_TAGS*8
    call malloc
    mov rbp, rax

    xor r13, r13 ; variable i

    cicloExterno:

        xor r14, r14 ; variable j
        xor r15, r15 ; guardo la concatenacion

        cmp r13b, MAX_TAGS
        jz fin

        mov rdi, rbx
        mov rsi, r12
        mov rdx, r13
        call long_total

        mov dil, al

        call malloc
        mov r15, rax

        mov rax, rbp

        xor r9, r9      ;índice para moverme dentro de la concatenacion
        xor r10, r10    ;registro para guardar cada letra a copiar
        xor r11, r11    ;índice para moverme dentro del texto de entrada que estoy copiando
        mov rcx, rbx

        cicloInterno:
            xor r8, r8
            
            cmp r12b, r14b
            jz aumentari
            
            cmp r13d, [rcx + OFFSET_TAG]
            jz guardarConcatenacion

            jmp seguir

            guardarConcatenacion:
                mov r8, [rcx + OFFSET_TEXT]

                concatenar:

                    cmp r11d, [rcx + OFFSET_TEXT_LEN]
                    jz seguir                              ;copio todas las letras

                    mov r10b, [r8+r11]
                    mov [r15+r9], r10b
                    inc r11b
                    inc r9b
  
                    jmp concatenar


            seguir:
                xor r11, r11
                add rcx, SIZE_MSG
                inc r14
                jmp cicloInterno

        
        aumentari:
            mov [rax], r15

            add rbp, 8
            inc r13b
            jmp cicloExterno


        fin:
        sub rbp, 8
        inc r14b
        cmp r14b, MAX_TAGS
        jnz fin        

        mov rax, rbp


        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp
        ret


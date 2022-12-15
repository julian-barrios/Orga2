extern malloc
global filtro

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;int16_t* filtro (const int16_t* entrada, unsigned size)
filtro:
    push rbp
    mov rbp, rsp
    push rbx
    push r12

    mov rbx, rdi
    mov r12, rsi

    imul rsi, 4
    sub rsi, 12

    mov rdi, rsi 
    call malloc


    sub r12, 3
    pxor xmm1, xmm1
    xor r9, r9

    ciclo:

        cmp r12, r9
        jz .fin
        
        movdqu xmm0, [rbx]                  ; xmm0 = L3 | R3 | L2 | R2 | L1 | R1 | L0 | R0

        psraw xmm0, 2                       ; xmm0 = L3/4 | R3/4 | L2/4 | R2/4 | L1/4 | R1/4 | L0/4 | R0/4

        pshufhw xmm0, xmm0, 11011000b       ; xmm0 = L3/4 | L2/4 | R3/4 | R2/4 | L1/4 | R1/4 | L0/4 | R0/4
        pshuflw xmm0, xmm0, 11011000b       ; xmm0 = L3/4 | L2/4 | R3/4 | R2/4 | L1/4 | L0/4 | R1/4 | R0/4

        phaddsw xmm0, xmm1                  ; xmm0 = 0 | 0 | 0 | 0 | (L3+L2)/4 | (R3+R2)/4 | (L1+L0)/4 | (R1+R0)/4 
        
        pshuflw xmm0, xmm0, 11011000b       ; xmm0 = 0 | 0 | 0 | 0 | (L3+L2)/4 | (L1+L2)/4 | (R3+R2)/4 | (R1+R0)/4

        phaddsw xmm0, xmm1                  ; xmm0 = 0 | 0 | 0 | 0 | 0 | 0 | (L3+L2+L1+L0)/4 | (R3+R2+R1+R0)/4

        movd [rax], xmm0                    ; [rax] = 0 | 0 | 0 | 0 | 0 | 0 | (L3+L2+L1+L0)/4 | (R3+R2+R1+R0)/4



        add r9, 1
        add rbx, 4
        add rax, 4

        jmp ciclo

    
    .fin:
        imul r9, 4
        sub rax, r9
        
        pop r12
        pop rbx
        pop rbp 
        ret


extern malloc
global filtro

;########### SECCION DE DATOS
section .data
shuffle:
    db 0, 1, 8, 9, 2, 3, 10, 11, 4, 5, 12, 13, 6, 7, 14, 15
shuffle2:
    db 0, 1, 14, 15, 2, 3, 12, 13, 4, 5, 10, 11, 6, 7, 8, 9

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;int16_t* operaciones_asm (const int16_t* entrada, unsigned size)
filtro:
    push rbp
    mov rbp, rsp
    push rbx
    push r12

    mov rbx, rdi
    mov r12, rsi

    mov edi, esi

    imul edi, 2
    call malloc


    xor r9, r9
    xor r10, r10

    
    movdqu xmm3, [shuffle]
    movdqu xmm4, [shuffle2]


    .ciclo:
        cmp r12, r10
        je .fin

        movdqu xmm0, [rbx] ; xmm0 = e[i+7] | e[i+6] | e[i+5] | e[i+4] | e[i+3] | e[i+2] | e[i+1] | e[i]

        movdqu xmm1, xmm0 ; xmm1 =  e[i+7] | e[i+6] | e[i+5] | e[i+4] | e[i+3] | e[i+2] | e[i+1] | e[i]

        pshufb xmm0, xmm3 ; xmm0 = e[i+7] | e[i+3] | e[i+6] | e[i+2] | e[i+5] | e[i+1] | e[i+4] | e[i]

        pshufb xmm1, xmm4 ; xmm1 = e[i+4] | e[i+3] | e[i+5] | e[i+2] | e[i+6] | e[i+1] | e[i+7] | e[i]

        movdqu xmm2, xmm0 ; xmm2 = e[i+7] | e[i+3] | e[i+6] | e[i+2] | e[i+5] | e[i+1] | e[i+4] | e[i]

        phsubw xmm0, xmm1 ; xmm0 = e[i+3]-e[i+4] | e[i+2]-e[i+5] | e[i+1]-e[i+6] | e[i]-e[i+7] | e[i+3]-e[i+7] | e[i+2]-e[i+6] | e[i+1]-e[i+5] | e[i]-e[i+4]

        phaddw xmm1, xmm2 ; xmm1 = e[i+3]+e[i+7] | e[i+2]+e[i+6] | e[i+1]+e[i+5] | e[i]+e[i+4] | e[i+3]+e[i+4] | e[i+2]+e[i+5] | e[i+1]+e[i+6] | e[i]+e[i+7] 

        pmullw xmm0, xmm1 ; xmm0 = low((e[i+3]-e[i+4])*(e[i+3]+e[i+7])) | low((e[i+2]-e[i+5])*(e[i+2]+e[i+6])) | low((e[i+1]-e[i+6])*(e[i+1]+e[i+5])) | low((e[i]-e[i+7])*(e[i]+e[i+4])) | low((e[i+3]+e[i+4])*(e[i+3]-e[i+7])) | low((e[i+2]+e[i+5])*(e[i+2]-e[i+6])) | low((e[i+1]+e[i+6])*(e[i+1]-e[i+5])) | low((e[i]+e[i+7])*(e[i]-e[i+4]))


        movdqu [rax + r9], xmm0
        add rbx, 16
        add r9, 16
        add r10, 8
        jmp .ciclo


    .fin:
        pop r12
        pop rbx
        pop rbp
        ret


;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
complex_sum_z:
    push rbp
    mov rbp, rsp

    xor rax, rax

    add eax, [rdi+24]
    dec rsi


	.cycle:			; etiqueta a donde retorna el ciclo que itera sobre arr
		cmp rsi, 0
		je .fin

	    add rdi, 32
    	add eax, [rdi+24]

		dec rsi
		jmp .cycle
	
	.fin:
	pop rbp
	ret
	
;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[?], arr_length[?]
packed_complex_sum_z:
    push rbp
    mov rbp, rsp

    xor rax, rax

    add eax, [rdi+20]

    dec rsi


	.cycle:			; etiqueta a donde retorna el ciclo que itera sobre arr
		cmp rsi, 0
		je .fin

	    add rdi, 24
    	add eax, [rdi+20]

		dec rsi
		jmp .cycle
	
	.fin:
	pop rbp
	ret


;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx],
; f2[xmm1], x3[rcx], f3[xmm2], x4[r8], f4[xmm3], x5[r9], f5[xmm4],
; x6[?], f6[xmm5], x7[?], f7[xmm6], x8[?], f8[xmm7], x9[?], f9[?]
product_9_f:

	;prologo 
	push rbp
	mov rbp, rsp
	sub rsp, 0x40

	;mov r9d ,DWORD [rbp+0x10]
	;mov r9d ,DWORD [rbp+0x18]
	;mov r9d ,DWORD [rbp+0x20]
	;mov r9d ,DWORD [rbp+0x28]
	;movss xmm0, DWORD [rbp+0x30]
	
	;convertimos los flotantes de cada registro xmm en doubles
	cvtps2pd xmm0, xmm0
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm2, xmm2
	cvtps2pd xmm3, xmm3
	cvtps2pd xmm4, xmm4
	cvtps2pd xmm5, xmm5
	cvtps2pd xmm6, xmm6
	cvtps2pd xmm7, xmm7
	
	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	mulpd xmm0, xmm1
	mulpd xmm0, xmm2
	mulpd xmm0, xmm3
	mulpd xmm0, xmm4
	mulpd xmm0, xmm5
	mulpd xmm0, xmm6
	mulpd xmm0, xmm7

	movss xmm1, DWORD [rbp+0x30]
	cvtps2pd xmm1, xmm1
	mulpd xmm0, xmm1

	; convertimos los enteros en doubles y los multiplicamos por xmm0. 
	movq xmm1, rsi
	cvtdq2pd xmm1, xmm1			;x1
	mulpd xmm0, xmm1

	movq xmm1, rdx
	cvtdq2pd xmm1, xmm1			;x2
	mulpd xmm0, xmm1

	movq xmm1, rcx
	cvtdq2pd xmm1, xmm1			;x3
	mulpd xmm0, xmm1

	movq xmm1, r8
	cvtdq2pd xmm1, xmm1			;x4
	mulpd xmm0, xmm1

	movq xmm1, r9
	cvtdq2pd xmm1, xmm1			;x5
	mulpd xmm0, xmm1

	mov r9d ,DWORD [rbp+0x10]
	movq xmm1, r9
	cvtdq2pd xmm1, xmm1			;x6
	mulpd xmm0, xmm1

	mov r9d ,DWORD [rbp+0x18]
	movq xmm1, r9
	cvtdq2pd xmm1, xmm1			;x7
	mulpd xmm0, xmm1

	mov r9d ,DWORD [rbp+0x20]
	movq xmm1, r9
	cvtdq2pd xmm1, xmm1			;x8
	mulpd xmm0, xmm1

	mov r9d ,DWORD [rbp+0x28]
	movq xmm1, r9
	cvtdq2pd xmm1, xmm1			;x9
	mulpd xmm0, xmm1

	; epilogo 
	movsd [rdi], xmm0
	add rsp, 0x40
	pop rbp
	ret


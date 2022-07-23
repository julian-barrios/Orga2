extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]
alternate_sum_4:
	;prologo
	push rbp
	mov rbp , rsp
					; COMPLETAR 
					;recordar que si la pila estaba alineada a 16 al hacer la llamada
					;con el push de RIP como efecto del CALL queda alineada a 8
	mov rax, rdi
	sub rax, rsi
	add rax, rdx
	sub rax, rcx

	pop rbp
	
	;epilogo
	; COMPLETAR 

	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c: 

	;prologo
    push rbp ; alineado a 16
    mov rbp,rsp
	push rbx
	push r12

	mov rbx, rdx
	mov r12, rcx

	call restar_c

	mov rdi, rax
	mov rsi, rbx

	call sumar_c

	mov rdi, rax
	mov rsi, r12

	call restar_c

	;epilogo
	pop r12
	pop rbx
	pop rbp
    ret 



; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]

alternate_sum_4_simplified:
	mov rax, rdi
	sub rax, rsi
	add rax, rdx
	sub rax, rcx
	ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[?], x2[?], x3[?], x4[?], x5[?], x6[?], x7[?], x8[?]
alternate_sum_8:
	;prologo

	push rbp
	mov rbp , rsp

	mov rax, rdi
	sub rax, rsi
	add rax, rdx
	sub rax, rcx
	add rax, r8
	sub rax, r9
	add rax, [rbp+0x10]
	sub rax, [rbp+0x18]

	;epilogo
	pop rbp

	ret
	

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[?], x1[?], f1[?]
product_2_f:

	xor r10, r10
	mov r10d, esi
	movq xmm1, rsi
	cvtsi2ss xmm1, rsi
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm0, xmm0

	mulsd xmm0, xmm1
	cvtsd2ss xmm0, xmm0
	cvtss2si r10d, xmm0
	;movq rax, xmm0

	mov [rdi], r10d

	ret


%define OFFSET_NEXT  0
%define OFFSET_SUM   8
%define OFFSET_SIZE  16
%define OFFSET_ARRAY 24

extern malloc

;campo tipo        tamaño     offset      alineación

;next  lista_t*    8 bytes   0  bytes    8 bytes
;sum   uint32_t    4 bytes   8  bytes    4 bytes
;size  uint64_t    8 bytes   16 bytes    8 bytes
;array uint32_t*   8 bytes   24 bytes    8 bytes


;TOTAL 			   32 bytes 			 8 bytes


;La estructura ‘lista_t‘ tiene 4 bytes de padding.


BITS 64

section .text


; uint32_t proyecto_mas_dificil(lista_t*)
;
; Dada una lista enlazada de proyectos devuelve el `sum` más grande de ésta.
;
; - El `sum` más grande de la lista vacía (`NULL`) es 0.
;
global proyecto_mas_dificil
proyecto_mas_dificil:

	xor rcx, rcx
	xor rdx, rdx

	.ciclo:
		cmp rdi, 0
		je .fin

		mov ecx, [rdi + OFFSET_SUM]
		cmp ecx, edx

		ja .esMayor

		jmp .seguir

		.esMayor:
			mov edx, ecx

		.seguir:
			mov rdi, [rdi + OFFSET_NEXT]
			jmp .ciclo

	.fin:
		mov eax, edx 

	ret

; void tarea_completada(lista_t*, size_t)
;
; Dada una lista enlazada de proyectos y un índice en ésta setea la i-ésima
; tarea en cero.
;
; - La implementación debe "saltearse" a los proyectos sin tareas
; - Se puede asumir que el índice siempre es válido
; - Se debe actualizar el `sum` del nodo actualizado de la lista
;
global marcar_tarea_completada
marcar_tarea_completada:

	xor r8, r8
	xor r10, r10

	.ciclo:
		cmp rdi, 0
		je .fin

		mov rcx, [rdi + OFFSET_SIZE]
		add r8, rcx
		
		cmp r8, rsi

		jbe .seguir

		sub r8, rcx
		mov r9, [rdi + OFFSET_ARRAY]

		.esta_en_este_arreglo:
			sub rsi, r8
			mov r10, [r9 + 4*rsi]
			mov dword [r9 + 4*rsi], 0
			sub [rdi + OFFSET_SUM], r10
			jmp .fin
			

	.seguir:
		mov rdi, [rdi + OFFSET_NEXT]
		jmp .ciclo


	.fin:
	ret

; uint64_t* tareas_completadas_por_proyecto(lista_t*)
;
; Dada una lista enlazada de proyectos se devuelve un array que cuenta
; cuántas tareas completadas tiene cada uno de ellos.
;
; - Si se provee a la lista vacía como parámetro (`NULL`) la respuesta puede
;   ser `NULL` o el resultado de `malloc(0)`
; - Los proyectos sin tareas tienen cero tareas completadas
; - Los proyectos sin tareas deben aparecer en el array resultante
; - Se provee una implementación esqueleto en C si se desea seguir el
;   esquema implementativo recomendado
;
global tareas_completadas_por_proyecto
tareas_completadas_por_proyecto:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14 

	mov rbx, rdi
	mov r12, rsi

	call lista_len

	mov rdi, rax
	imul rdi, 8

	call malloc

	xor r13, r13
	xor r14, r14

	mov r13, rax

	.ciclo:
		cmp rbx, 0
		je .fin

		mov rdi, [rbx + OFFSET_ARRAY]
		mov rsi, [rbx + OFFSET_SIZE]

		call tareas_completadas 

		mov [r13 + r14], rax

		mov rbx, [rbx + OFFSET_NEXT]
		add r14, 8
		jmp .ciclo


 
	.fin:
		mov rax, r13

	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

; uint64_t lista_len(lista_t* lista)
;
; Dada una lista enlazada devuelve su longitud.
;
; - La longitud de `NULL` es 0
;
lista_len:

	xor r9, r9

	.ciclo:
		cmp	rdi, 0
		je .fin

		inc r9
		mov rdi, [rdi + OFFSET_NEXT]
		jmp .ciclo


	.fin: 
		mov rax, r9

	ret

; uint64_t tareas_completadas(uint32_t* array, size_t size) {
;
; Dado un array de `size` enteros de 32 bits sin signo devuelve la cantidad de
; ceros en ese array.
;
; - Un array de tamaño 0 tiene 0 ceros.
tareas_completadas:

	xor r8, r8
	xor r9, r9

	.ciclo:
		cmp rsi, r8
		je .fin

		cmp dword [rdi], 0
		je .aumentar

		jmp .seguir

		.aumentar:
			inc r9

		.seguir:
		add rdi, 4
		inc r8
		jmp .ciclo

		
	.fin:
		mov rax, r9

	ret
_isr100:
	
    pushad

	mov eax, [esp + 44]   ; esp de nivel 3 de la tarea pasada por parámetro
	mov bx, [eax]		  ; ebx = task_sel	
	mov esi, [eax + 4]	  ; esi = phy	
	mov edi, [eax + 8]	  ; edi = virt	

	; pusheo los parámetros para llamar a la función mmu_map_page implementada en el taller. Primero mapeo la página para la tarea actual.
	; como quiero que la página solo se pueda leer y sea para una tarea de usuario, attrs = 5.

	mov eax, cr3
	mov ecx, 5

	push ecx			  ; atributos
	push esi 			  ; phy	
	push edi 			  ; virt	
	push eax			  ; cr3	
	
	call mmu_map_page

	pop eax

	; obtengo el cr3 de la tarea pasada por parámetro y vuelvo a llamar a la función mmu_map_page para esta tarea.

	push bx			 ; task_sel	
	call obtener_cr3
	pop bx

	push eax  			 ; cr3 de la tarea pasada por parámetro. Los demás parámetros ya estaban pusheados a la pila.
	call mmu_map_page
	pop eax

	; Para que la tarea pasada por parámetro realice la ejecución en la nueva página necesito modificar el eip almacenado en su tss. 
	; Además para reiniciar su pila, pido una nueva página libre de kernel para la pila de nivel 0, e igualo el esp al ebp para su pila de nivel 3.

	push bx							; task_sel
	call modificar_retorno_pila 
	pop bx

	mov [esp + 56], ebp              ; reinicio la pila de nivel 3 de la tarea actual
	mov [esp + 44], edi				 ; modifico la dirección de retorno para que cuando haga iret retorne ahí

    pop edi
	pop esi
	pop ecx

    popad

	iret

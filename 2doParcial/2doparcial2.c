uint32_t obtener_cr3(int16_t task_sel){
	uint16_t i = task_sel >> 3;
	gdt_entry_t tss_desc = gdt[i];
	uint32_t dir_base = ((uint32_t)(tss_desc.base_32_24) << 24) + ((uint32_t)(tss_desc.base_23_16 << 16)) + ((uint32_t)(tss_des.base_15_0));
	tss_t* tss = (tss_t*) dir_base;
	uint32_t cr3 = tss->cr3;
	return cr3;
}

void modificar_retorno_pila(uint16_t task_sel, uint32_t task_curr_sel, uint32_t virt){
	
	// Modifico la pila y el eip de la tarea pasada por parámetro
	uint16_t i = task_sel >> 3;
	gdt_entry_t tss_desc = gdt[i];
	uint32_t dir_base = ((uint32_t)(tss_desc.base_32_24) << 24) + ((uint32_t)(tss_desc.base_23_16 << 16)) + ((uint32_t)(tss_des.base_15_0));
	tss_t* tss = (tss_t*) dir_base;
	tss->eip = virt;
	tss->esp0 = mmu_next_free_kernel_page();
	tss->esp = tss->ebp
}


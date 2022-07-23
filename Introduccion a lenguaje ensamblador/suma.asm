section .data

global _init
_init:

  num1 db 0xFF
  num2 db 0x0A

section .text
  global _start
_start:

  xor rax, rax
  xor rbx, rbx

  mov rax, [num1]
  mov rbx, [num2]
  add rax, rbx

  mov rax, 60
  mov rdi, 0
  syscall

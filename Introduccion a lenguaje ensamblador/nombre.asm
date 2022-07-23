section .data
msg db 'Julián', 0xa, 0xd, "Barrios", 0xa, 0xd, "718/18", 0xa
len equ $ - msg

section .text
  global _start
_start:
  mov edx,len
  mov ecx,msg
  mov ebx,1
  mov eax,4
  int 0x80
  mov eax,1
  int 0x80

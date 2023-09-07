#define ASM_FILE 1
#include "multiboot2.h"

#define KPG_RESERVE (0x1000 * (1 + 1024))

.section .multiboot
  multiboot_header:
    multiboot_magic_header:
      .long MULTIBOOT2_HEADER_MAGIC
      .long MULTIBOOT_ARCHITECTURE_I386
      .long multiboot_header_end - multiboot_header
      .long -(MULTIBOOT2_HEADER_MAGIC + MULTIBOOT_ARCHITECTURE_I386 + (multiboot_header_end - multiboot_header))
      .align 8

    multiboot_term_header:
      .short MULTIBOOT_HEADER_TAG_END
      .short 0
      .long 8
  multiboot_header_end:
  
  stack_bottom:
    .align 0x1000
  stack_top:

.section .kpg
  .skip KPG_RESERVE, 0

.section .boot.text
  .globl start, _start
  _start:
  start:
    cli

    movl $stack_top, %esp

    pushl $0
    popf

    pushl %ebx
    pushl %eax
    call mbi_parse

    loop:
      hlt
      jmp loop
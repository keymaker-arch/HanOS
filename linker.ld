ENTRY(start)

SECTIONS
{
  . = 0x100000;

  .multiboot BLOCK(4k) : {
    *(.multiboot)
  }
  . = . + SIZEOF(.multiboot);

  .kpg : {
    *(.kpg)
  }
  . = . + SIZEOF(.kpg);

  .text BLOCK(4k) : {
    *(.boot.text)
    *(.text)
  }

  .rodata BLOCK(4k) : {
    *(.rodata)
  }

  .bss BLOCK(4k) : {
    *(.bss)
  }
}
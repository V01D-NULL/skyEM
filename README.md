# libasm
Libasm is a tiny libc, but for assembly.
You can expect "functions" (labels) such as strlen, printf, scanf, putc, and more.

NOTE:
    libasm is only meant to run in VM's or real hardware. (Meaning it will act as a bootsector in real mode, and a basic OS in 32 / 64 bit mode) - Support for Linux userland libasm is not planned, but it might happen someday.

- Why am I doing this?
    - Just for fun, and to get better at x86 assembly

Supported modes:
    16 bit (real mode)
    
Goals:
    Support for 32 bit mode (Protected mode), possibly 64 bit mode (long mode)

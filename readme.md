```bash
# on 32-bit mode
$ as file.s -o output.o
$ ld output.o -o executable

# on 64-bit mode
$ as --32 file.s -o output.o
$ ld -m elf_i386 output.o -o executable

$ ./executable
$ echo $?
```

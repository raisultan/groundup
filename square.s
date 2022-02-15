# 12^2

.section .data

.section .text

.globl _start
_start:
pushl $12  # push argument
call square  # call the func
addl $4, %esp  # move the stack pointer back
movl %eax, %ebx

movl $1, %eax  # call the kernel
int $0x80  # exit


.type square, @function
square:
pushl %ebp  # push base pointer to stack
movl %esp, %ebp  # make stack pointer the base pointer

movl 8(%ebp), %eax  # put the argument in %eax
movl 8(%ebp), %ebx  # put the argument in %ebx once again, to multiply later

imull %ebx, %eax

movl %ebp, %esp  # restore base pointer and return
popl %ebp

ret

# 5!

.section .data

.section .text

.globl _start
_start:
pushl $5  # push the argument
call factorial  # call the func
addl $4, %esp  # move the stack pointer back
movl %eax, %ebx  # move the result to %ebx as status code

movl $1, %eax  # move 1 to %eax to trigger the kernel
int $0x80


.type factorial, @function
factorial:
pushl %ebp  # restore %ebp to its prior state before returning
movl %esp, %ebp  # save stack pointer to %ebp

movl 8(%ebp), %ebx  # copy argument to %ebx
movl 8(%ebp), %eax  # copy argument to %eax

start_loop:
decl %ebx  # %ebx -= 1

cmpl $1, %ebx  # if %ebx's value is 1, then exit
je loop_exit

imull %ebx, %eax  # multiply %eax to %ebx, and store result in %eax
                  # so %eax, always has result and we decreas %ebx each time
jmp start_loop  # start over

loop_exit:  # exit, with restoring stack pointer and getting read of %ebp value
movl %ebp, %esp
popl %ebp

ret


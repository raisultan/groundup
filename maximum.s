# finds the maximim number of a set of data items

# registers:
# %edi - holds the index of the data item being examined
# %ebx - largest data item found so far
# %eax - current data item

# data_items - memory location that contains the item data
# A 0 is used to terminate the data

.section .data

data_items:  # label to refer to start of the items
.long 3, 67, 34, 222, 45, 89, 91, 22, 10, 8, 42, 0
# .long takes 4 bytes of memory for each element, 48 bytes

.section .text

.globl _start
_start:
movl $0, %edi  # move 0 into the index register
movl data_items(, %edi, 4), %eax  # load the first byte of data
movl %eax, %ebx  # since this is the first item, %eax is the biggest

start_loop:
cmpl $0, %eax  # check to see if we've hit the end
je loop_exit  # jump if equal

incl %edi  # load next value
movl data_items(, %edi, 4), %eax

cmpl %ebx, %eax  # compare values
jle start_loop  # jump to loop beginning if the new one isn't bigger

movl %eax, %ebx  # move the value as the largest
jmp start_loop  # jump to loop beginning

loop_exit:
# %ebx is the status code for the exit system call
# and it already has the maximum nuber
movl $1, %eax  # 1 is the exit() syscall
int $0x80  # trigger the kernel

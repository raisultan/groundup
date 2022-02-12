# 2^3 + 5^2

# Everything in the main program is stored in registers,
# so the data section doesn't have anything

# note: this is 64-bit mode, for that we use pushl and popl
#       in 32-bit mode would use pushl and popl
.section .data

.section .text

.globl _start
_start:
pushl $3  # push second argument
pushl $2  # push first argument
call power  # call the function
addl $8, %esp  # move the stack pointer back
pushl %eax  # save the first answer before
            # calling the next function

pushl $2  # push second argument
push $5  # push first argument
call power  # call the function
addl $8, %esp  # move the stack pointer back

popl %ebx  # the second answer is already in %eax
           # we saved the first answer onto the stack,
           # so now we can just pop it out into %ebx

addl %eax, %ebx  # add them together
                 # the result is in %ebx

movl $1, %eax  # exit (%ebx is returned)
int $0x80



# function that is used to compute the value of a number to a power
# INPUT: first arg - the base number;
#        second arg - the power to raise it to
# NOTES: the power must be 1 or greater
# VARS: %ebx - holds the base number
#       %ecx - holds the power
#       -4(%ebp) - holds the current result
#       %eax is used for temporary storeage

.type power, @function
power:
pushl %ebp  # save old base pointer
movl %esp, %ebp  # make stack pointer the base pointer
subl $4, %esp  # get room for our local storage

movl 8(%ebp), %ebx  # put first argument in %eax
movl 12(%ebp), %ecx  # put second argument in %ecx

movl %ebx, -4(%ebp)  # store current result

loop_start:
cmpl $1, %ecx  # if the power is 1, we are done
je end_power

movl -4(%ebp), %eax  # move the current result into %eax
imull %ebx, %eax  # multiply the current result by the base number

movl %eax, -4(%ebp)  # store the current result

decl %ecx  # decrease the power
jmp loop_start  # run for the next power

end_power:
movl -4(%ebp), %eax  # return value goes in %eax
movl %ebp, %esp  # restore the stack pointer
popl %ebp  # restore the base pointer
ret

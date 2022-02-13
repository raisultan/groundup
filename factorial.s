# 4! - factorial of 4

.section .data

# has no global data

.section .text

.globl _start
.globl factorial  # this is needed unless we want to share
                  # this func among other programs

_start:
pushl $4  # the factorial takes on argument - the 
          # number we want a factorial of. So it,
          # gets pushed

call factorial  # run the factorial func
addl $4, %esp   # scrubs the parameter that was pushed on the stack
movl %eax, %ebx  # factorial returns the answer in %eax, but
                 # we want it in %ebx to send it as our exit status

movl $1, %eax  # call the kernel's exit function
int $0x80



.type factorial, @function
factorial:
pushl %ebp  # standard function stuff - we have to
            # restore %ebp to its prior state before
            # returning, so we have to push it

movl %esp, %ebp  # this is because we don't want to modify
                 # the stack pointer, so we use %ebp

movl 8(%ebp), %eax  # this moves the first argument to %eax
                    # 4(%ebp) holds the return address, and
                    # 8(%ebp) holds the first parameter

cmpl $1, %eax  # if the number is 1, that is our base case,
               # and we simply return (1 is already in %eax as the return value)
je end_factorial

decl %eax  # otherwise, decrease the value
pushl %eax  # push it for our call to factorial
call factorial  # call factorial
movl 8(%ebp), %ebx  # %eax has the return value, so we
                    # reload our parameter into %ebx

imull %ebx, %eax  # multiply that by the result of the last call to factorial (in %eax)
                  # the answer is stored in %eax, which is good since that's where return values go

end_factorial:
movl %ebp, %esp  # standard function return stuff - we have to restore %ebp and %esp to where
popl %ebp        # they were before the function started return to the function (this pops the
                 # return value, too)
ret

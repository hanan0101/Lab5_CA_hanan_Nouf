.data
n:      .word 5      # Input number for which factorial is calculated

.text
.globl _start
_start:
    la a0, n         # Load address of n
    lw a0, 0(a0)     # Load the value of n into x10 (a0)
    
    jal ra, fact     # Call factorial function
    
    # Print result
    mv a1, a0        # Move result to a1
    li a0, 1         # Print integer syscall
    ecall
    
    # Exit program
    li a0, 10        # Exit syscall
    li a1, 0         # Exit code 0
    ecall

fact:
    addi sp, sp, -16    # Allocate stack space
    sd ra, 8(sp)        # Save return address (x1)
    sd a0, 0(sp)        # Save argument (x10)
    
    addi t0, a0, -1     # t0 = n-1 (x5 = x10-1)
    bge t0, x0, L1    # if (n-1 >= 0) goto L1
    
    # Base case (n <= 1)
    li a0, 1            # Return 1
    addi sp, sp, 16     # Restore stack pointer
    jal ra   # Return
    
L1:
    addi a0, a0, -1     # n = n-1
    jal ra, fact        # Recursive call
    
    mv t1, a0           # Save factorial result (x6 = x10)
    ld a0, 0(sp)      
    ld ra, 8(sp)     
    addi sp, sp, 16     # Restore stack pointer
    
    mul a0, a0, t1      # n * factorial(n-1)  
    jalr ra

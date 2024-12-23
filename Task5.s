    .data
n:      .word 3         
result: .word 0         

    .text
    .globl _start
foo:
    addi sp, sp, -8     
    sw ra, 0(sp)      
    sw s0, 4(sp)        
    
    mv s0, a0            
    
    bne s0, x0, Next     # If i != 0, next
    
    li a0, 0             # Base case: if i == 0, return 0 (a = 0)
    j Epilogue           #Epilogue to restore and return
    
Next:
    addi a0, s0, -1      # j = i - 1
    jal ra, foo          # foo(j)
    
    add a0, s0, a0       # a = i + j 

Epilogue:
    lw ra, 0(sp)         # Restore return address
    lw s0, 4(sp)         # Restore s0
    addi sp, sp, 8       
    jr ra

_start:
    la a0, n           
    lw a0, 0(a0)       )
    
    jal ra, foo       
    la t0, result        
    sw a0, 0(t0)         # Store the result
    #print 
    li a0, 1           
    la a0, result    
    lw a0, 0(a0)      
    ecall                # Make syscall to print the result
    
    # Exit program
    li a0, 10        
    li a1, 0          
    ecall             

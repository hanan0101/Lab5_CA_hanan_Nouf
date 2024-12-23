.data
array: .word 7, 3, 2, 9, 5, 1, 4, 6, 8  # Array elements

.text
.globl _start
_start:
    la s0, array                # load addrss s0
    li s1, 9                  
    jal sortArray         
    li t0, 0                   
    jal printArray             
    li a0, 10                  
    ecall                       # Exit the program

# sortArray procedure (Bubble sort)
sortArray:
    addi sp, sp, -16            # allocate space on the stack
    sw ra, 12(sp)            
    sw s0, 8(sp)                
    sw s1, 4(sp)               
    li t0, 0                
    
outer_loop:
    sub t1, s1, t0              # t1 = size - i
    addi t1, t1, -1             # t1 = size - i - 1
    li t2, 0                    # Initialize inner loop index j = 0

inner_loop:
    bge t2, t1, next_outer      # If j >= size - 1 - i, exit 
    slli t3, t2, 2              # t3 = j * 4 
    add t4, s0, t3              # t4 = arr[j]
    lw a1, 0(t4)                
    lw a2, 4(t4)             
    bge a2, a1, skip_swap       # If arr[j] <= arr[j+1]
    
    
    sw a2, 0(t4)                # arr[j] = arr[j+1]
    sw a1, 4(t4)                # arr[j+1] = a1
skip_swap:
    addi t2, t2, 1              #  j++
    j inner_loop                

next_outer:
    addi t0, t0, 1              #i++
    blt t0, s1, outer_loop      # If i < size

    lw ra, 12(sp)             
    lw s0, 8(sp)              
    lw s1, 4(sp)              
    addi sp, sp, 16             # Deallocate stack space
    jr ra                     

printArray:
    bge t0, s1, printEnd    
    slli t1, t0, 2            
    add t2, s0, t1             
    lw a1, 0(t2)            
    jal print_value        
    addi t0, t0, 1              #i++
    j printArray                # Repeat print loop

printEnd:
    jr ra                       # Return to caller

print_value:
    li a0, 1                    # for print integer
    ecall                     
    li a0, 11                   #print character (space)
    li a1, 32                   # ASCII value for space
    ecall                    
    jr ra                    

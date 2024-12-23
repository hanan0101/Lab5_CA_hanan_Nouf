.text
main:
    li a0, 5
    jal factorial
    li a0, 1
    ecall
    li a0, 10
    ecall

factorial:
    addi sp, sp, -4
    sw ra, 0(sp)
    li t0, 1

fact_loop:
    beq a0, x0, end_fact
    mul t0, t0, a0
    addi a0, a0, -1
    j fact_loop

end_fact:
    mv a0, t0
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

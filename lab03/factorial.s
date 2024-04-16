.globl factorial

.data
n: .word 8

.text
main:
    la t0, n          # $t0 = &n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit


# if n == 0 return 1
# return n * factorial(n - 1)

factorial:
    # YOUR CODE HERE
    bne a0, x0, else 
    addi a0, x0, 1
    jr ra
else:
    addi sp, sp, -8
    sw ra, 4(sp)   # ret address
    sw a0, 0(sp)    # n
    addi a0, a0, -1
    jal ra, factorial 
    lw t0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    mul a0, a0, t0
    jr ra

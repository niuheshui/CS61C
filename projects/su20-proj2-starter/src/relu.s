.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================

# void rule(int *a, int n) {
#   for (int i = 0; i < n; i++) {
#     if (a[i] < 0) a[i] = 0;
#   }
# }

relu:
    # Prologue
    mv t0, x0   # i = 0

loop_start:
    bge t0, a1, loop_end 
    slli t1, t0, 2  # i *= 4
    add t1, t1, a0  # a + i * 4
    lw t2, 0(t1)    # a[i]
    bge t2, x0, loop_continue
    sw x0, 0(t1)
    
loop_continue:
    addi t0, t0, 1
    jal x0, loop_start

loop_end:

    # Epilogue

    ret

# RISC-V(32-bits) gcc 11.4.0
# relu:
#   ble a1,zero,.L1
#   slli a1,a1,2
#   add a4,a0,a1
# .L4:
#   lw a5,0(a0)
#   bge a5,zero,.L3
#   sw zero,0(a0)
# .L3:
#   addi a0,a0,4
#   bne a0,a4,.L4
# .L1:
#   ret

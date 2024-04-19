.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================


# int argmax(int *a, int n) {
#   int max_val = a[0];
#   int max_idx = 0;
#   for (int i = 1; i < n; i++) {
#     if (a[i] > max_val) {
#       max_val = a[i];
#       max_idx = i;
#     }
#   }
#   return max_idx;
# }



argmax:

     # check
     addi  t0, x0, 1
     bge   a1, t0, init
     addi  a1, x0, 7
     jal   ra, exit2

init:

    # Prologue
    lw    t0, 0(a0)     # max_val
    mv    t1, x0        # max_idx
    addi  t3, x0, 1     # i

loop_start:
    bge   t3, a1, loop_end
    slli  t4, t3, 2
    add   t4, t4, a0
    lw    t4, 0(t4)     # a[i]
    bge   t0, t4, loop_continue
    mv    t0, t4 
    mv    t1, t3

loop_continue:
    addi  t3, t3, 1
    jal   x0, loop_start

loop_end:
    mv a0, t1
    # Epilogue


    ret


#  RISC-V (32-bit) gcc 11.4.0
#  argmax:
#    li a5,1
#    lw a2,0(a0)
#    ble a1,a5,.L5
#    addi a5,a0,4
#    li a4,1
#    li a0,0
#  .L4:
#    lw a3,0(a5)
#    addi a5,a5,4
#    ble a3,a2,.L3
#    mv a0,a4
#    mv a2,a3
#  .L3:
#    addi a4,a4,1
#    bne a1,a4,.L4
#    ret
#  .L5:
#    li a0,0
#    ret

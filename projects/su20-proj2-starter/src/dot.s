.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================

# int dot(int *v0, int *v1, int n, int stp0, int stp1) {
#   if (n < 1)    exit2(5);
#   if (stp0 < 1) exit2(6);
#   if (stp1 < 1) exit2(6);
# 
#   int res = v0[0] * v1[0];
# 
#   for (int i = 1; i < n; i++) {
#     res += v0[i * stp0] * v1[i * stp1];
#   }
# 
#   return res;
# }

dot:
    # Prologue

    li    t0, 1

    bge   a2, t0, check_stp0
    addi  a1, x0, 5
    jal   ra, exit2
check_stp0:
    bge   a3, t0, check_stp1
    addi  a1, x0, 6
    jal   ra, exit2
check_stp1:
    bge   a4, t0, init
    addi  a1, x0, 6
    jal   ra, exit2

init:
    lw    t0, 0(a0)  
    lw    t1, 0(a1)
    mul   t0, t0, t1  # res
    li    t1, 1       # i

loop_start:
    bge   t1, a2, loop_end
    slli  t2, t1, 2   # i * 4
    # v0[i * stp0]
    mul   t3, t2, a3  # i * 4 * stp0
    add   t3, a0, t3  
    lw    t3, 0(t3)
    # v1[i * stp1]
    mul   t4, t2, a4
    add   t4, a1, t4  
    lw    t4, 0(t4)

    mul   t3, t3, t4 

    add   t0, t0, t3
    addi  t1, t1, 1 
    jal   x0, loop_start

loop_end:
    # Epilogue
    mv a0, t0
    ret


matmul:
  addi sp,sp,-64
  sw s0,56(sp)
  sw s3,44(sp)
  sw s6,32(sp)
  sw s7,28(sp)
  sw s8,24(sp)
  sw s10,16(sp)
  sw s11,12(sp)
  sw ra,60(sp)
  sw s1,52(sp)
  sw s2,48(sp)
  sw s4,40(sp)
  sw s5,36(sp)
  sw s9,20(sp)
  mv s6,a1
  mv s3,a0
  mv s10,a2
  mv s7,a3
  mv s0,a4
  mv s11,a5
  mv s8,a6
  ble a1,zero,.L2
  ble a2,zero,.L2
.L3:
  ble s0,zero,.L4
  ble s11,zero,.L4
  bne s10,s0,.L15
.L6:
  ble s6,zero,.L1
  slli s9,s10,2
  li s5,0
  li s4,0
.L8:
  ble s11,zero,.L11
  slli s0,s5,2
  mv s2,s7
  add s0,s8,s0
  li s1,0
.L9:
  mv a1,s2
  mv a4,s11
  li a3,1
  mv a2,s10
  mv a0,s3
  call dot
  sw a0,0(s0)
  addi s1,s1,1
  addi s2,s2,4
  addi s0,s0,4
  bne s11,s1,.L9
.L11:
  addi s4,s4,1
  add s5,s5,s11
  add s3,s3,s9
  bne s6,s4,.L8
.L1:
  lw ra,60(sp)
  lw s0,56(sp)
  lw s1,52(sp)
  lw s2,48(sp)
  lw s3,44(sp)
  lw s4,40(sp)
  lw s5,36(sp)
  lw s6,32(sp)
  lw s7,28(sp)
  lw s8,24(sp)
  lw s9,20(sp)
  lw s10,16(sp)
  lw s11,12(sp)
  addi sp,sp,64
  jr ra
.L4:
  li a1,3
  li a0,1
  call exit2
  beq s10,s0,.L6
  j .L15
.L2:
  li a1,2
  li a0,1
  call exit2
  j .L3
.L15:
  li a1,4
  li a0,1
  call exit2
  j .L6


# RISC-V (32-bit) gcc 11.4.0
# dot:
#   lw a7,0(a1)
#   mv a6,a0
#   lw a0,0(a0)
#   li a5,1
#   mul a0,a0,a7
#   ble a2,a5,.L1
#   slli a3,a3,2
#   slli a4,a4,2
#   add a6,a6,a3
#   add a1,a1,a4
#   li a7,1
# .L3:
#   lw a5,0(a6)
#   lw t1,0(a1)
#   addi a7,a7,1
#   add a6,a6,a3
#   mul a5,a5,t1
#   add a1,a1,a4
#   add a0,a0,a5
#   bne a2,a7,.L3
# .L1:
#   ret

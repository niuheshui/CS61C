.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================


# void matmul(int *m0, int h0, int w0, 
#             int *m1, int h1, int w1,
#             int *d) {
# 
#   if (h0 < 1 || w0 < 1) exit2(2);
#   if (h1 < 1 || w1 < 1) exit2(3);
#   if (w0 != h1)         exit2(4);
# 
#   for (int i = 0; i < h0; i++) {
#     for (int j = 0; j < w1; j++) {
#       d[i*w1+j] = dot(m0+i*w0, m1+j, w0, 1, w1);
#     }
#   }
# }



#matmul:
#
#
#    # Error checks
#    ble   a1, zero, m1_err
#    ble   a2, zero, m1_err 
#    ble   a4, zero, m2_err
#    ble   a5, zero, m2_err 
#    bne   a2, a4, m12_err
#
#
#
#
#
#
#    # Prologue
#
#
#outer_loop_start:
#
#
#
#
#inner_loop_start:
#
#
#
#
#
#
#
#
#
#
#
#
#inner_loop_end:
#
#
#
#
#outer_loop_end:
#
#
#    # Epilogue
#    
#    
#    ret
#
#m1_err:
#    li    a1, 2 
#    jal   ra, exit2
#m2_err:
#    li    a1, 3
#    jal   ra, exit2
#m12_err:
#    li    a1, 4
#    jal   ra, exit2


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


#matmul:
#  # Error checks
#  ble   a1, zero, m1_err
#  ble   a2, zero, m1_err 
#  ble   a4, zero, m2_err
#  ble   a5, zero, m2_err 
#  bne   a2, a4, m12_err
#
#  ble a1,zero,.L18
#  addi sp,sp,-32
#  mv a4,a0
#  sw s1,24(sp)
#  slli a0,a5,2
#  slli s1,a2,2
#  sw s0,28(sp)
#  sw s2,20(sp)
#  sw s3,16(sp)
#  sw s4,12(sp)
#  mv s3,a1
#  mv s4,a6
#  mv t4,a2
#  mv s2,a3
#  mv s0,a5
#  addi t3,a4,4
#  add a6,a4,s1
#  add t6,a3,a0
#  li t2,0
#  li t0,0
#  li t5,1
#.L8:
#  slli t1,t2,2
#  add t1,s4,t1
#  mv a7,s2
#  ble s0,zero,.L13
#.L11:
#  lw a2,-4(t3)
#  lw a5,0(a7)
#  mul a2,a2,a5
#  ble t4,t5,.L9
#  add a3,a7,a0
#  mv a5,t3
#.L10:
#  lw a4,0(a5)
#  lw a1,0(a3)
#  addi a5,a5,4
#  add a3,a3,a0
#  mul a4,a4,a1
#  add a2,a2,a4
#  bne a5,a6,.L10
#.L9:
#  sw a2,0(t1)
#  addi a7,a7,4
#  addi t1,t1,4
#  bne a7,t6,.L11
#.L13:
#  addi t0,t0,1
#  add t2,t2,s0
#  add t3,t3,s1
#  add a6,a6,s1
#  bne s3,t0,.L8
#  lw s0,28(sp)
#  lw s1,24(sp)
#  lw s2,20(sp)
#  lw s3,16(sp)
#  lw s4,12(sp)
#  addi sp,sp,32
#  jr ra
#.L18:
#  ret
#m1_err:
#    li    a1, 2 
#    jal   ra, exit2
#m2_err:
#    li    a1, 3
#    jal   ra, exit2
#m12_err:
#    li    a1, 4
#    jal   ra, exit2

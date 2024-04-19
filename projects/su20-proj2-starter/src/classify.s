.globl classify

.text
#classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

	# =====================================
    # LOAD MATRICES
    # =====================================
    # Load pretrained m0
    # Load pretrained m1
    # Load input matrix
    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    # Print classification
    # Print newline afterwards for clarity
#    ret


classify:
  addi sp,sp,-80
  sw s2,64(sp)
  sw ra,76(sp)
  sw s0,72(sp)
  sw s1,68(sp)
  sw s3,60(sp)
  sw s4,56(sp)
  sw s5,52(sp)
  sw s6,48(sp)
  sw s7,44(sp)
  sw s8,40(sp)
  sw s9,36(sp)
  li a5,5
  mv s2,a1
  beq a0,a5,.L2
  li a1,49
  li a0,1
  call exit2
.L2:
  lw a0,4(s2)
  addi a2,sp,12
  addi a1,sp,8
  call read_matrix
  mv s6,a0
  lw a0,8(s2)
  addi a2,sp,20
  addi a1,sp,16
  call read_matrix
  mv s5,a0
  lw a0,12(s2)
  addi a2,sp,28
  addi a1,sp,24
  call read_matrix
  lw s3,28(sp)
  lw s8,8(sp)
  mv s4,a0
  mul s0,s8,s3
  slli a0,s0,2
  call malloc
  lw a4,24(sp)
  lw a2,12(sp)
  mv s1,a0
  mv a6,a0
  mv a5,s3
  mv a3,s4
  mv a1,s8
  mv a0,s6
  call matmul
  mv a1,s0
  mv a0,s1
  call relu
  lw s7,16(sp)
  mul s9,s3,s7
  slli a0,s9,2
  call malloc
  lw a2,20(sp)
  mv a6,a0
  mv a5,s3
  mv a4,s8
  mv s0,a0
  mv a3,s1
  mv a0,s5
  mv a1,s7
  call matmul
  lw a0,16(s2)
  mv a3,s3
  mv a2,s7
  mv a1,s0
  call write_matrix
  mv a1,s9
  mv a0,s0
  call argmax
  mv s2,a0
  mv a1,a0
  li a0,1
  call print_int
  li a1,10
  li a0,1
  call print_char
  mv a0,s6
  call free
  mv a0,s5
  call free
  mv a0,s4
  call free
  mv a0,s1
  call free
  mv a0,s0
  call free
  lw ra,76(sp)
  lw s0,72(sp)
  lw s1,68(sp)
  lw s3,60(sp)
  lw s4,56(sp)
  lw s5,52(sp)
  lw s6,48(sp)
  lw s7,44(sp)
  lw s8,40(sp)
  lw s9,36(sp)
  mv a0,s2
  lw s2,64(sp)
  addi sp,sp,80
  jr ra

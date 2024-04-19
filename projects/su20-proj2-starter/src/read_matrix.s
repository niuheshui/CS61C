.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================


# int* read_matrix(char* filename, int* rows, int* columns) {
#   int fd = fopen(filename, 0);
#   if (fd == -1) exit2(50);
# 
#   int r;
# 
#   r = fread(fd, rows, 4);
#   if (r != 4)  exit2(51);
# 
#   r = fread(fd, columns, 4);
#   if (r != 4)  exit2(51);
# 
#   int size = *rows * *columns * 4;
# 
#   int* ret = malloc(size);
# 
#   r = fread(fd, ret, size);
#   if (r != size)  exit2(51);
# 
#   r = fclose(fd);
#   if (r == -1)  exit2(52);
# 
#   return ret;
# }



#read_matrix:
#    
#
#    # Prologue
#    addi  sp, sp, -4
#    sw    ra, 0(sp)
#
#    addi  sp, sp, -4
#    sw    s0, 0(sp)
#
#    addi  sp, sp, -4
#    sw    s1, 0(sp)
#
#    addi  sp, sp, -4
#    sw    s2, 0(sp)
#
#    addi  sp, sp, -4
#    sw    s3, 0(sp)
#
#    addi  sp, sp, -4
#    sw    s4, 0(sp)
#
#    mv  s0, a1  # rows
#    mv  s1, a2  # columns
#
#
#    mv  a1, a0
#    mv  a2, x0
#    jal ra, fopen
#
#    li  a5, -1
#    beq a0, a5, fopen_err
#    mv  s2, a0  # fd
#
#    # fread(fd, rows, 4)
#    mv  a1, s2
#    mv  a2, s0 
#    li  a3, 4
#    jal ra, fread
#
#    li  a5, 4
#    bne a0, a5, fread_err 
#
#
#    # fread(fd, columns, 4)
#    mv  a1, s2
#    mv  a2, s1 
#    li  a3, 4
#    jal ra, fread
#
#    li  a5, 4
#    bne a0, a5, fread_err 
#
#    lw  t0, 0(s0)
#    lw  t1, 0(s1)
#    mul s3, t0, t1 # size
#    slli s3, s3, 2
#
#    # malloc(size)
#    mv  a0, s3
#    jal ra, malloc
#    beq a0, x0, malloc_err
#    mv  s4, a0  # ret
#
#    # fread(fd, ret, size)
#    mv  a1, s2
#    mv  a2, s4
#    mv  a3, s3
#    jal ra, fread
#    bne a0, s3, fread_err
#
#    # fclose(fd)
#    mv  a1, s2
#    jal ra, fclose
#    li  t0, -1
#    beq a0, t0, fclose_err
#
#
#    mv a0, s4
#
#
#    # Epilogue
#    lw    s4, 0(sp)
#    addi  sp, sp, 4
#
#    lw    s3, 0(sp)
#    addi  sp, sp, 4
#
#    lw    s2, 0(sp)
#    addi  sp, sp, 4
#
#    lw    s1, 0(sp)
#    addi  sp, sp, 4
#
#    lw    s0, 0(sp)
#    addi  sp, sp, 4
#
#    lw    ra, 0(sp)
#    addi  sp, sp, 4
#
#
#    ret
#
#malloc_err:
#    li    a1, 48
#    jal   ra, exit2
#
#fopen_err:
#    li    a1, 50
#    jal   ra, exit2
#
#fread_err:
#    li    a1, 51
#    jal   ra, exit2
#
#fclose_err:
#    li    a1, 52
#    jal   ra, exit2


read_matrix:
  addi sp,sp,-16
  sw s0,8(sp)
  sw s2,0(sp)
  mv s0,a1
  mv s2,a2
  mv a1,a0
  li a2,0
  li a0,1
  sw s1,4(sp)
  sw ra,12(sp)
  call fopen
  li a5,-1
  mv s1,a0
  beq a0,a5,.L10
.L2:
  li a3,4
  li a4,0
  mv a2,s0
  mv a1,s1
  li a0,1
  call fread
  li a5,4
  beq a0,a5,.L3
  li a1,51
  li a0,1
  call exit2
.L3:
  li a3,4
  li a4,0
  mv a2,s2
  mv a1,s1
  li a0,1
  call fread
  li a5,4
  beq a0,a5,.L4
  li a1,51
  li a0,1
  call exit2
.L4:
  lw a5,0(s2)
  lw s0,0(s0)
  mul s0,s0,a5
  slli s0,s0,2
  mv a0,s0
  call malloc
  mv s2,a0
  beq a0,zero,.L11
.L5:
  mv a3,s0
  srai a4,s0,31
  mv a2,s2
  mv a1,s1
  li a0,1
  call fread
  beq s0,a0,.L6
  li a1,51
  li a0,1
  call exit2
.L6:
  mv a1,s1
  li a0,1
  call fclose
  li a5,-1
  beq a0,a5,.L12
  lw ra,12(sp)
  lw s0,8(sp)
  lw s1,4(sp)
  mv a0,s2
  lw s2,0(sp)
  addi sp,sp,16
  jr ra
.L10:
  li a1,50
  li a0,1
  call exit2
  j .L2
.L12:
  li a0,1
  li a1,52
  call exit2
  lw ra,12(sp)
  lw s0,8(sp)
  lw s1,4(sp)
  mv a0,s2
  lw s2,0(sp)
  addi sp,sp,16
  jr ra
.L11:
  li a1,48
  li a0,1
  call exit2
  j .L5

.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================

# void write_matrix(char* filename, int* src, 
#                   int rows, int columns) {
# 
#   int fd = fopen(filename, 1);
#   if (fd == -1)   exit2(53);

#   int r = fwrite(fd, &rows, 1, 4);
#   if (r != 1)   exit2(54);

#   r = fwrite(fd, &columns, 1, 4);
#   if (r != 1)   exit2(54);

#   int size = rows * columns;
#   r = fwrite(fd, src, size, 4);
#   if (r != size)  exit2(54);
# 
#   r = fclose(fd);
#   if (r == -1)    exit2(55);
#   
# }


#write_matrix:
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
#    mv  s0, a2  # rows
#    mv  s1, a3  # columns
#    mv  s3, a1  # src
#
#    # fopen(filename, 1);
#    mv  a1, a0
#    li  a2, 1
#    jal ra, fopen
#
#    li  a5, -1
#    beq a0, a5, fopen_err
#    mv  s2, a0  # fd
#
#    mul s4, s0, s1
#
#    # write rows
#    addi sp, sp, -4
#    sw   s0, 0(sp)
#    mv   a1, s2
#    mv   a2, sp 
#    li   a3, 1
#    li   a4, 4
#    jal  ra, fwrite
#    addi sp, sp, 4
#
#    li a2, 1
#    bne  a0, a2, fwrite_err
#
#    # write columns
#    addi sp, sp, -4
#    sw   s1, 0(sp)
#    mv   a1, s2
#    mv   a2, sp 
#    li   a3, 1
#    li   a4, 4
#    jal  ra, fwrite
#    addi sp, sp, 4
#    li a2, 1
#    bne  a0, a2, fwrite_err
#
#    # write src
#    mv  a1, s2
#    mv  a2, s3
#    mv  a3, s4
#    li  a4, 4
#    jal ra, fwrite
#    bne s4, a0, fwrite_err
#
#    # write '\n'
#    addi sp, sp, -4
#    li   t0, '\n'
#    sw   t0, 0(sp)
#    mv   a1, s2
#    mv   a2, sp 
#    li   a3, 1
#    li   a4, 1
#    jal  ra, fwrite
#    addi sp, sp, 4
#
#    li a2, 1
#    bne  a0, a2, fwrite_err
#    
#
#
#    # fclose(fd)
#    mv  a1, s2
#    jal ra, fclose
#    li  t0, -1
#    beq a0, t0, fclose_err
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
#    ret
#
#fopen_err:
#    li    a1, 53
#    jal   ra, exit2
#
#fwrite_err:
#    li    a1, 54
#    jal   ra, exit2
#
#fclose_err:
#    li    a1, 55
#    jal   ra, exit2


write_matrix:
  addi sp,sp,-32
  sw s1,20(sp)
  sw a2,12(sp)
  mv s1,a1
  li a2,1
  mv a1,a0
  sw s0,24(sp)
  sw ra,28(sp)
  sw a3,8(sp)
  call fopen
  li a5,-1
  mv s0,a0
  beq a0,a5,.L9
.L2:
  li a3,1
  li a4,4
  addi a2,sp,12
  mv a1,s0
  call fwrite
  li a5,1
  beq a0,a5,.L3
  li a1,54
  call exit2
.L3:
  li a3,1
  li a4,4
  addi a2,sp,8
  mv a1,s0
  call fwrite
  li a5,1
  beq a0,a5,.L4
  li a1,54
  li a0,1
  call exit2
.L4:
  lw a4,8(sp)
  mv a2,s1
  lw s1,12(sp)
  mul s1,s1,a4
  mv a1,s0
  mv a3,s1
  li a4, 4
  call fwrite
  beq s1,a0,.L5
  li a1,54
  call exit2
.L5:
  mv a1,s0
  call fclose
  li a5,-1
  beq a0,a5,.L10
  lw ra,28(sp)
  lw s0,24(sp)
  lw s1,20(sp)
  addi sp,sp,32
  jr ra
.L9:
  li a1,53
  call exit2
  j .L2
.L10:
  li a1,55
  call exit2
  lw ra,28(sp)
  lw s0,24(sp)
  lw s1,20(sp)
  addi sp,sp,32
  jr ra

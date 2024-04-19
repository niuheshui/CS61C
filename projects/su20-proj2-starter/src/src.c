/* Type your code here, or load an example. */
typedef unsigned long long size_t;

int fopen(int, char*, int);
int fread(int, int, void*, size_t);
int fwrite(int, int, void*, size_t, size_t);
int fclose(int, int);
void* malloc(int);
void exit2(int, int);
void print_str(int, char*);
void print_int(int, int);
void print_char(int, char);
void free(void*);


#define fopen(a1, a2) fopen(1, (a1), (a2))
#define fread(a1, a2, a3) fread(1, (a1), (a2), (a3))
#define fwrite(a1, a2, a3, a4) fwrite(1, (a1), (a2), (a3), (a4))
#define fclose(a1) fclose(1, (a1))
#define exit2(a1) exit2(1, (a1))
#define print_str(a1) print_str(1, (a1))
#define print_char(a1) print_char(1, (a1));
#define print_int(a1) print_int(1, (a1));

/*
int* read_matrix(char* filename, int* rows, int* columns) {
  int fd = fopen(filename, 0);
  if (fd == -1) exit2(50);

  int r;

  r = fread(fd, rows, 4);
  if (r != 4)  exit2(51);

  r = fread(fd, columns, 4);
  if (r != 4)  exit2(51);

  int size = *rows * *columns * 4;

  int* ret = malloc(size);
  if (ret == 0)  exit2(48);

  r = fread(fd, ret, size);
  if (r != size)  exit2(51);

  r = fclose(fd);
  if (r == -1)  exit2(52);

  return ret;
}
*/

/*
void write_matrix(char* filename, int* src, 
                  int rows, int columns) {

  int fd = fopen(filename, 1);
  if (fd == -1)   exit2(53);
                                             
  int r = fwrite(fd, &rows, 1, 4);
  if (r != 1)   exit2(54);
                                             
  r = fwrite(fd, &columns, 1, 4);
  if (r != 1)   exit2(54);
                                             
  int size = rows * columns;
  r = fwrite(fd, src, size, 4);
  if (r != size)  exit2(54);

  r = fclose(fd);
  if (r == -1)    exit2(55);
  
}
*/

int dot(int *, int *, int, int, int);
void relu(int *a, int n);
int argmax(int*, int);
int* read_matrix(char* filename, int* rows, int* columns);
void write_matrix(char* filename, int* src,  int rows, int columns);
void matmul(int *m0, int h0, int w0, 
            int *m1, int h1, int w1,
            int *d);

int classify(int argc, char** argv, int f) {

    if (5 != argc) exit2(49);

    int r0, c0;
    int* m0 = read_matrix(argv[1], &r0, &c0);

    int r1, c1;
    int* m1 = read_matrix(argv[2], &r1, &c1);

    int ri, ci;
    int* mi = read_matrix(argv[3], &ri, &ci);

    int rd = r0, cd = ci;
    int* md = malloc(rd * cd * 4);
    matmul(m0, r0, c0, mi, ri, ci, md);
    relu(md, rd * cd);

    int rd2 = r1, cd2 = cd;
    int* md2 = malloc(rd2 * cd2 * 4);
    matmul(m1, r1, c1, md, rd, cd, md2);

    write_matrix(argv[4], md2, rd2, cd2);

    int max = argmax(md2, rd2 * cd2);
    
        print_int(max);
        print_char('\n');

    free(m0);
    free(m1);
    free(mi);
    free(md);
    free(md2);

    return max;
}

/*
void matmul(int *m0, int h0, int w0, 
            int *m1, int h1, int w1,
            int *d) {

  if (h0 < 1 || w0 < 1) exit2(2);
  if (h1 < 1 || w1 < 1) exit2(3);
  if (w0 != h1)         exit2(4);

  for (int i = 0; i < h0; i++) {
    for (int j = 0; j < w1; j++) {
      d[i*w1+j] = dot(m0+i*w0, m1+j, w0, 1, w1);
    }
  }
}
*/


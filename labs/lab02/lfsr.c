#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

#define get_bit(x, n) (((x) >> n) & 1)

static inline void set_bit(uint16_t * x,
             uint16_t n,
             uint16_t v) {

  if (v) { *x |= v << n; } 
  else   { *x &= -1U ^ (1U << n); }

}

void lfsr_calculate(uint16_t *reg) {

    /* YOUR CODE HERE */
  uint16_t b0 = get_bit(*reg, 0),
           b2 = get_bit(*reg, 2),
           b3 = get_bit(*reg, 3),
           b5 = get_bit(*reg, 5);

  uint16_t next_msb = (b5 ^ (b3 ^ (b2 ^ b0)));
  *reg >>= 1;
  set_bit(reg, 15, next_msb);
}


/* memory.c */

#include "memory.h"
#include "rom.h"

/* 2k ram (0x0000 - 0x07ff) */
byte ram[RAM_SIZE] __attribute__ ((aligned (256)));

/* clear all ram */
void mem_reset() {
  word i;
  for (i = 0; i < RAM_SIZE; i++) ram[i] = 0;
}


/* mem_c64.h - memory interface for C64 emulator */
/* by Brian Huffman 11-30-00 */

/* memory management is described on page 260 of the C64 PRG */

#ifndef MEMORY_H
#define MEMORY_H

#include <Arduino.h>

#define RAM_SIZE 1024
extern byte ram[RAM_SIZE];

/***************************************/
/* static inline function declarations */
/***************************************/

inline byte mem_read_zero_page(byte address) {
  return ram[address];
}

inline void mem_write_zero_page(byte address, byte value) {
  ram[address] = value;
}

inline byte stack_read(byte address) {
  return (ram + 256)[address];
}

inline word stack_read_16(byte address) {
  return word(stack_read(address + 1), stack_read(address));
}

inline void stack_write(byte address, byte value) {
  (ram+256)[address] = value;
}

/*****************************/
/* other function prototypes */
/*****************************/

extern byte mem_read(word address);
extern word mem_read_16(word address);
extern void mem_write(word address, byte value);

extern void mem_reset();

// RAM:  0000 0xxx xxxx xxxx
// VIA1: 0001 1000 0000 xxxx
// VIA2: 0001 1100 0000 xxxx
// ROM:  11xx xxxx xxxx xxxx

#endif


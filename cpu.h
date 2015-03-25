/* 6510.h - processor emulation for C64 emulator */
/* by Brian Huffman 11-29-00 */

#ifndef CPU_H
#define CPU_H

#include <Arduino.h>

void cpu_main (long cycles);

void cpu_reset (void);
void cpu_irq (void);
void cpu_nmi (void);
//void cpu_brk (void);

struct cpu_state {
  word pc;
  byte a;
  byte x;
  byte y;
  byte s;
  byte p;
};

word cpu_get_pc (void);

unsigned long cpu_get_regs (void);

void cpu_get_state (struct cpu_state*);

/* Requires a buffer of at least 51 bytes */
void cpu_sprintf_state (char *buffer);

#endif

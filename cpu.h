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

word cpu_get_pc (void);

#endif

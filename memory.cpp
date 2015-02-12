/* memory.cpp */

#include "memory.h"
#include "rom.h"

/* 2k ram (0x0000 - 0x07ff) */
byte ram[RAM_SIZE];

/* clear all ram */
void mem_reset() {
  for (word i = 0; i < 0x0800; i++) ram[i] = 0;
}

/******************* MEMORY READ *************************/

byte mem_read(word address) {
  if (address < RAM_SIZE) {
    return ram[address];
  }
  else if (address >= 0xc000) {
    return read_rom(address);
  }
  /*
  else if ((address & 0xfff0) == 0x1800) {
    return mem_read_via1(address & 0x0f);
  }
  else if ((address & 0xfff0) == 0x1c00) {
    return mem_read_via2(address & 0x0f);
  }
  */
  // disconnected memory returns all 1s.
  else return 0xff;
}

word mem_read_16(word address) {
  if (address < RAM_SIZE-1) {
    return word(ram[address+1], ram[address]);
  }
  else if (address > 0xc000 && address < 0xffff) {
    return word(read_rom(address + 1), read_rom(address));
  }
  else {
    return word(mem_read(address + 1), mem_read(address));
  }
}

void mem_write(word address, byte value) {
  if (address < RAM_SIZE) {
    ram[address] = value;
  }
  /*
  else if ((address & 0xfff0) == 0x1800) {
    mem_write_via1(addr & 0x0f, value);
  }
  else if ((address & 0xfff0) == 0x1c00) {
    mem_write_via2(addr & 0x0f, value);
  }
  */
  // otherwise nothing happens
}


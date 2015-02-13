#ifndef ROM_H
#define ROM_H

#include <Arduino.h>
#include <avr/pgmspace.h>

extern const byte dos1541[16384] PROGMEM;

inline static byte read_rom(word address) {
  return pgm_read_byte( &(dos1541[address & 0x3fff]) );
}

#endif

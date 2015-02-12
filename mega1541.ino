#include <avr/pgmspace.h>

#include "rom.h"
#include "memory.h"
#include "cpu.h"

////////////////////////////////////////////////////////////

void setup() {
  // put your setup code here, to run once:
  mem_reset();
  cpu_reset();
}

void loop() {
  // put your main code here, to run repeatedly:
  cpu_main(1000);
}

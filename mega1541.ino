#include <avr/pgmspace.h>

extern "C" {
#include "rom.h"
#include "memory.h"
#include "cpu.h"
}

////////////////////////////////////////////////////////////

void setup() {
  // put your setup code here, to run once:
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW

  Serial.begin(57600);
  mem_reset();
  cpu_reset();
}

extern "C" void debug_println (char *buffer) {
  Serial.println(buffer);
}

extern "C" void debug_print (char *buffer) {
  Serial.print(buffer);
}

void loop() {
  // put your main code here, to run repeatedly:
  char buffer[64];
  unsigned long time1 = micros();
  cpu_main(100000);
  unsigned long time2 = micros();
  unsigned long delta = time2 - time1;
  Serial.println(delta);
  cpu_sprintf_state(buffer);
  Serial.println(buffer);
}

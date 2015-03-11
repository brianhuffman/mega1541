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

void loop() {
  struct cpu_state state;
  // put your main code here, to run repeatedly:
  unsigned long time1 = micros();
  cpu_main(100000);
  unsigned long time2 = micros();
  unsigned long delta = time2 - time1;
  Serial.println(delta);
  cpu_get_state(&state);
  Serial.println("PC=$" + String(cpu_get_pc(), HEX) +
                 " A=$" + String(state.a, HEX) +
                 " X=$" + String(state.x, HEX) +
                 " Y=$" + String(state.y, HEX) +
                 " S=$" + String(state.s, HEX) +
                 " P=B" + String(state.p, BIN));
}

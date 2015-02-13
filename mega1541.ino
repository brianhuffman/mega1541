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
  // put your main code here, to run repeatedly:
  unsigned long time1 = micros();
  cpu_main(1000000);
  unsigned long time2 = micros();
  unsigned long delta = time2 - time1;
  Serial.println(delta);
  //Serial.println(cpu_state_string());
  delay(500);
}


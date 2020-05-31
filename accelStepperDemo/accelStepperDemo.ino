// Bounce.pde
// -*- mode: C++ -*-
//
// Make a single stepper bounce from one limit to another
//
// Copyright (C) 2012 Mike McCauley
// $Id: Random.pde,v 1.1 2011/01/05 01:51:01 mikem Exp mikem $
#include <AccelStepper.h>
#include <ESP8266WiFi.h>


int delayValue = 0;
int maxdelay = 200;
// Define a stepper and the pins it will use
AccelStepper stepper(AccelStepper::HALF4WIRE, D2,D0,D1,D3); // Defaults to AccelStepper::FULL4WIRE (4 pins) on 2, 3, 4, 5
void setup()
{  
  WiFi.mode(WIFI_OFF); 
  // Change these to suit your stepper if you want
  stepper.setMaxSpeed(5000);
  //stepper.setAcceleration(20);
  //stepper.moveTo(500);
  Serial.begin(9600);
}
void loop()
{
   //handleSerial();
   stepper.move(1);
   stepper.runToPosition();
   delay(1766.5);
   //delay(delayValue);
}

void handleSerial() {
 while (Serial.available() > 0) {
   char incomingCharacter = Serial.read();
   Serial.println(delayValue);
   switch (incomingCharacter) {
     case '0':
      delayValue = 0;
      if (delayValue >= maxdelay)
         delayValue = maxdelay;
      break;
     case '-':
      delayValue = delayValue - 100;
      if (delayValue >= maxdelay)
         delayValue = maxdelay;
      break;
     case '+':
      delayValue = delayValue + 100;
      if (delayValue <= 0)
         delayValue = 0;
      break;
    }
 }
}

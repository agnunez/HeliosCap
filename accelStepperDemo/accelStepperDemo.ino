// Bounce.pde
// -*- mode: C++ -*-
//
// Make a single stepper bounce from one limit to another
//
// Copyright (C) 2012 Mike McCauley
// $Id: Random.pde,v 1.1 2011/01/05 01:51:01 mikem Exp mikem $
#include <AccelStepper.h>
#include <ESP8266WiFi.h>
  
// Define a stepper and the pins it will use
AccelStepper stepper(AccelStepper::HALF4WIRE, D0,D1,D2,D3); // Defaults to AccelStepper::FULL4WIRE (4 pins) on 2, 3, 4, 5
void setup()
{  
  WiFi.mode(WIFI_OFF); 
  // Change these to suit your stepper if you want
  stepper.setMaxSpeed(100);
  stepper.setAcceleration(20);
  //stepper.moveTo(500);
}
void loop()
{
   stepper.move(1);
   stepper.runToPosition();
   delay(1766.5);
}

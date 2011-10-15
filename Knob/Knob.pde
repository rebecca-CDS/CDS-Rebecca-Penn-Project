// Based on File > Examples > Servo > Knob
// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

// reference code from http://ardx.org/CODE12S

// Matthew L Beckler http://www.mbeckler.org/microcontrollers/rgb_led/

// referenced codes above, some parts used from them, but do different things in my code than in theirs.

#include <Firmata.h>

#include <Servo.h> 

Servo servo1;  // create servo object to control first servo 
Servo servo2;  // create servo object to control second servo
Servo servo3;  // create servo object to control third servo

int pr1 = 1;  // analog pin used to connect the photoresistor 1
int pr2 = 2;  // analog pin used to connect the photoresistor 2
int pr3 = 3;  // analog pin used to connect the photoresistor 3

int reference;  // above this value there is lots of light, below there is someone blocking it

int val1;    // variable to read the value from the analog pin for photoresistor 1
int val2;    // variable to read the value from the analog pin for photoresistor 2
int val3;    // variable to read the value from the analog pin for photoresistor 3

boolean pathClosed1 = true;
boolean pathClosed2 = true;
boolean pathClosed3 = true;

//int redPin = 10;
//int greenPin = 11;
//int bluePin = 12;

// lights all fully on
//int redVal = 255;
//int blueVal = 255;
//int greenVal = 255;

void setup() 
{ 
  
  // read in reference
  
  reference = analogRead(pr1);

  Firmata.setFirmwareVersion(0, 1);
  Firmata.begin(57600);

  //Serial.begin(9600);
  //Serial.print("reference: "); Serial.println(reference);

 // analogWrite(redPin, redVal);
 // analogWrite(greenPin, greenVal);
 // analogWrite(bluePin, blueVal);

} 

void loop() { 
delay(1000);
 

  val1 = analogRead(pr1);         // reads the value of the potentiometer (value between 0 and 1023) 
  //Serial.println(val);
  val2 = analogRead(pr2);
  val3 = analogRead(pr3);

// send firmata state
// reference
Firmata.sendAnalog(0, reference);

// FIRMATA FOR 1
Firmata.sendAnalog(1, val1);
int openValue1 = pathClosed1 ? 1 : 0;
Firmata.sendAnalog(2, openValue1);

// FIRMATA FOR 2
Firmata.sendAnalog(3, val2);
int openValue2 = pathClosed2 ? 1 : 0;
Firmata.sendAnalog(4, openValue2);

// FIRMATA FOR 3
Firmata.sendAnalog(5, val3);
int openValue3 = pathClosed3 ? 1 : 0;
Firmata.sendAnalog(6, openValue3);



// VAL FOR 1
  if (val1 > reference - 30) { // when light is high
    if (pathClosed1 == false) {
      closePath1();
    }
  }
  else if (val1 < reference + 50) { // if someone standing there
    if (pathClosed1 == true) {
      openPath1();
    }
  }

// VAL FOR 2
 if (val2 > reference - 30) { // when light is high
    if (pathClosed2 == false) {
      closePath2();
    }
  }
  else if (val2 < reference + 50) { // if someone standing there
    if (pathClosed2 == true) {
      openPath2();
    }
  }

// VAL FOR 3
 if (val3 > reference - 30) { // when light is high
    if (pathClosed3 == false) {
      closePath3();
    }
  }
  else if (val3 < reference + 50) { // if someone standing there
    if (pathClosed3 == true) {
      openPath3();
    }
  }

}

//SERVO 1
void closePath1() {
  // spin servo
  servo1.attach(9);  // attaches the servo on pin 9 to the servo object 
  //Serial.println("closing");
  servo1.write(0);  //  servo spins full speed for 700 milliseconds
  delay(700);
  servo1.write(90);  // servo stops
  servo1.detach();
  pathClosed1 = true;  
}

void openPath1() {
  // spin servo
  servo1.attach(9);  // attaches the servo on pin 9 to the servo object 
  //Serial.println("opening");
  servo1.write(180);  // servo spins full speed for 700 milliseconds
  delay(700);
  servo1.write(90);  // servo stops
  servo1.detach();
  pathClosed1= false; 

}

//SERVO 2
void closePath2() {
  // spin servo
  servo2.attach(10);  // attaches the servo on pin 10 to the servo object 
  //Serial.println("closing");
  servo2.write(0);  // servo spins full speed for 700 milliseconds
  delay(700);
  servo2.write(90);  // servo stops
  servo2.detach();
  pathClosed2 = true;  
}

void openPath2() {
  // spin servo
  servo2.attach(10);  // attaches the servo on pin 10 to the servo object 
  //Serial.println("opening");
  servo2.write(180);  // servo spins full speed for 700 milliseconds
  delay(700);
  servo2.write(90);  // servo stops
  servo2.detach();
  pathClosed2= false; 

}
//SERVO 3
void closePath3() {
  // spin servo
  servo3.attach(11);  // attaches the servo on pin 11 to the servo object 
  //Serial.println("closing");
  servo3.write(0);  // servo spins full speed for 700 milliseconds
  delay(700);
  servo3.write(90);  // servo stops
  servo3.detach();
  pathClosed3 = true;  
}

void openPath3() {
  // spin servo
  servo3.attach(11);  // attaches the servo on pin 11 to the servo object 
  //Serial.println("opening");
  servo3.write(180);  // servo moves full speed for 700 milliseconds
  delay(700);
  servo3.write(90);  // servo stops
  servo3.detach();
  pathClosed3= false; 

}

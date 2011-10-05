// Based on File > Examples > Servo > Knob
// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

// reference code from http://ardx.org/CODE12S

// Matthew L Beckler http://www.mbeckler.org/microcontrollers/rgb_led/

// referenced codes above, some parts used from them, but do different things in my code than in theirs.

#include <Firmata.h>

#include <Servo.h> 

Servo myservo;  // create servo object to control a servo 

int potpin = 0;  // analog pin used to connect the potentiometer

int reference;  // above this value there is lots of light, below there is someone blocking it

int val;    // variable to read the value from the analog pin

boolean pathClosed = true;

int redPin = 10;
int greenPin = 11;
int bluePin = 12;

// lights all fully on
int redVal = 255;
int blueVal = 255;
int greenVal = 255;

void setup() 
{ 
  
  // read in reference
  
  reference = analogRead(potpin);

  Firmata.setFirmwareVersion(0, 1);
  Firmata.begin(57600);

  //Serial.begin(9600);
  //Serial.print("reference: "); Serial.println(reference);

  analogWrite(redPin, redVal);
  analogWrite(greenPin, greenVal);
  analogWrite(bluePin, blueVal);

} 

//wait until trigger

//trigger right 500

//wait until light

//reverse


void loop() { 
delay(1000);
 

  val = analogRead(potpin);         // reads the value of the potentiometer (value between 0 and 1023) 
  //Serial.println(val);

// send firmata state
// reference
Firmata.sendAnalog(0, reference);
Firmata.sendAnalog(1, val);
int openValue = pathClosed ? 1 : 0;
Firmata.sendAnalog(2, openValue);




  // cut
  if (val > reference - 30) { // when light is high
    if (pathClosed == false) {
      closePath();
    }
  } 
  else if (val < reference + 50) { // if someone standing there
    if (pathClosed == true) {
      openPath();
    }
  }




  // waits for the servo to get there   
} 

void closePath() {
  // spin servo
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  //Serial.println("closing");
  myservo.write(0);
  // set servo to 0
  delay(500);
  myservo.write(90);
  myservo.detach();
  pathClosed = true;  
}

void openPath() {
  // spin servo
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  //Serial.println("opening");
  myservo.write(180);
  // move servo to 90 degrees 
  delay(500);
  myservo.write(90);
  myservo.detach();
  pathClosed= false; 

}




// Based on File > Examples > Servo > Knob
// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

// reference code from http://ardx.org/CODE12S

// Matthew L Beckler http://www.mbeckler.org/microcontrollers/rgb_led/

// referenced codes above, some parts used from them, but do different things in my code than in theirs.


#include <Servo.h> 

Servo myservo;  // create servo object to control a servo 

int potpin = 0;  // analog pin used to connect the potentiometer

int cutoff = 50;  // above this value there is lots of light, below there is someone blocking it

int val;    // variable to read the value from the analog pin

int redPin = 10;
int greenPin = 11;
int bluePin = 12;

// lights all fully on
int redVal =255;
int blueVal = 255;
int greenVal = 255;

void setup() 
{ 
  Serial.begin(9600);
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  
  analogWrite(redPin, redVal);
  analogWrite(greenPin, greenVal);
  analogWrite(bluePin, blueVal);

} 

//wait until trigger

//trigger right 500

//wait until light

//reverse


void loop() { 
  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
  Serial.println(val); 
 while (val>cutoff){
   val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
   Serial.println(val); 
 }
 
 // cut
 if (val < cutoff) {
   myservo.write(180);
  // move servo to 90 degrees 
    delay(500);
     myservo.write(90);
    delay(400);
 } 
 
  while(val < cutoff){
    val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
    Serial.println(val); 
  }
  
  if (val > cutoff) {
   myservo.write(0);
  // set servo to 0
   delay(500);
   myservo.write(90);
   delay(400);
 }
 
                        // waits for the servo to get there 
  
} 

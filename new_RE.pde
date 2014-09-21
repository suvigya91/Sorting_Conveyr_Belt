#include <Servo.h>

Servo servo1;  // top servo
Servo servo2; // base servo
Servo servo3;  //middle servo
int var=0;
int sflag=0;

void setup()
{
  servo1.attach(11);  //blue wire--- top Motor attaches the servo1 on pin 11 to the servo object
  servo2.attach(9);  //Red wire--- Base Motor attaches the servo2 on pin 9 to the servo object
  servo3.attach(10); //yellow wire--- middle motor
  pinMode(13, OUTPUT);      // attaches the servo3 on pin 10 to the servo object
  pinMode(8,OUTPUT);
  servo1.write(180);
  delay(200);
  servo2.write(90);
  delay(200);
  servo3.write(160);
  delay(200);
  Serial.begin(9600);
  digitalWrite(8, HIGH); //run conveyor   // set the LED on
  digitalWrite(13, HIGH); //run conveyor   // set the LED on
 }

void loop()
{
// Serial.flush();
// if(Serial.available())
// {
  //digitalWrite(8, HIGH); //run conveyor   // set the LED on
  //delay(1000);              // wait for a second
  //digitalWrite(8, LOW); //stop conveyor   // set the LED off
  //delay(1000);              // wait for a second
  var=0; 
  var=Serial.read();
         if (var>0)
        {
          digitalWrite(8, LOW); //stop conveyor   // set the LED off
          delay(20);
          digitalWrite(13, LOW); //stop conveyor   // set the LED off
  //a red color object is detected
          //place object on left side 
          if (var==1)
            {
             redpick();
             sflag=10;
            } 
     
     //a blue color object is detected
     //place object on right side
     else if (var==2)
            {
              bluepick();
              sflag=10;
            } 
     
     //a black color object is detected
     //do not pick up the object, let it go straight on conveyor
    /* else if (var==3)
            {
             digitalWrite(13, HIGH);    // set the LED off
             delay(2000);    
             digitalWrite(13, LOW);          // wait for a second
             delay(2000);    
            } 
  */
digitalWrite(8, HIGH); //run conveyor   // set the LED on
delay(20);
digitalWrite(13, HIGH); //run conveyor   // set the LED on
 
} //ending of var>0 condition
  
 //Serial.write(sflag); 
 //sflag=0;    
// }//ending of serial.available
   
}//ending of main function

void redpick(void)
{
              servo1.write(100);
              delay(1000);
              servo3.write(160);
              delay(500);
              servo2.write(180);
              delay(1000);
              servo1.write(180);
              delay(1000);
              servo2.write(90);
              delay(1000);
}
void bluepick(void)
{
              servo1.write(100);
              delay(1000);
              servo3.write(160);
              delay(500);
              servo2.write(0);
              delay(1000);
              servo1.write(180);
              delay(1000);
              servo2.write(90);
              delay(1000);
}

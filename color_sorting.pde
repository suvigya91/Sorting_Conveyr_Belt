// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

#include <Servo.h> 
 
Servo myservobase;  // create servo object to control a servo 
Servo myservotop;
int f=1;
void setup() 
{ 
  pinMode(4,OUTPUT);
  myservobase.attach(9);
  myservotop.attach(6); 
} 
 
void loop() 
{
  //digitalWrite(4,HIGH);
  //delay(500);
  //digitalWrite(4,LOW);
  if(f==1)
  {
  redpick();
  bluepick();
  redpick();
  bluepick();
  f=0;
  }
} 
void redpick(void)
{
  myservotop.write(60);
  delay(1000);
  myservobase.write(179);
  delay(1000);
  myservotop.write(179);
  delay(1000);
  myservobase.write(80);
  delay(3000);
}
void bluepick(void)
{
  myservotop.write(60);
  delay(1000);
  myservobase.write(0);
  delay(1000);
  myservotop.write(179);
  delay(1000);
  myservobase.write(80);
  delay(3000);
}

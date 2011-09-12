import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;

void setup()
{
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);

dOut = new DataOut(this, "http://www.pachube.com/api/35206.xml", "Your_API_Key_HERE"); 

dOut.addData(0,"CapacitiveSensor");
dOut.addData(1,"timer");

}

void draw()
{
  myValue = arduino.analogRead(0);
  //println(myValue);
  if ((millis() - lastUpdate) > 10000){
    println("ready to PUT: ");
    dOut.update(0, myValue);
    dOut.update(1, millis());
    int response = dOut.updatePachube();
    println(response);
    lastUpdate = millis();
    }   
}



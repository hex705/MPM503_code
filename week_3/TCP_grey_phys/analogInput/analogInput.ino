
#include <Glue.h>


Glue messageToServer;

int dial;


void setup() {
  Serial.begin(9600);
  messageToServer.create();
}


void loop(){
  
      dial = analogRead(0) / 4;
      
          // float output = map ( dial, 0, 1024, 0, 255 );
          // analogWrite( 6, output );
  
      messageToServer.clear();
      messageToServer.add("dial"); // string prefix
      messageToServer.add( dial );   // actual value
     
      Serial.println( messageToServer.getPackage()) ;
          
  
  
}


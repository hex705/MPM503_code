
#include <Glue.h>

Glue messageToServer;          // GLUE builds MESSAGES

int dialValue;

void setup() {
  Serial.begin(9600);          //  if you are only TALKING you need to start SERIAL (compare with analogOUTPUT)
  messageToServer.create();    //  create your GLUE message -- this sets aside some memory
}


void loop(){
  
      dialValue = analogRead(A0) / 4;    // GET ANLOG VALUE and divide by 4
                                         // because reading is 10bit, writing is 8bit
      
      // assemble a message with GLUE
      messageToServer.clear();                   // clear the old message
      messageToServer.add("Arduino dialValue");  // string prefix
      messageToServer.add( dialValue );          // add the actual value (int)
     
      // send the message with SERIAL
      Serial.println( messageToServer.getPackage()) ;
          
}


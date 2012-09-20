#include <Scissors.h>


Scissors messageFromClient;

int dialValue;
int ledPIN = 6;


void setup() {
  messageFromClient.begin(19200);   // NOTE HOW THIS STARTS!!!
  pinMode ( ledPIN, OUTPUT);
}


void loop(){
  
 
      if (messageFromClient.update() > 0) { // have a new message? 
       
          dialValue = messageFromClient.getInt(1);
       
      }
      
      
        analogWrite( ledPIN, dialValue ); 
        
}


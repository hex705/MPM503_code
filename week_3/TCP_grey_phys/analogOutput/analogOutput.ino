#include <Scissors.h>


Scissors messageFromClient;

int dialValue;
int ledPIN = 6;


void setup() {
  messageFromClient.begin(9600);   // NOTE HOW THIS STARTS!!!
  pinMode ( 6, OUTPUT);
}


void loop(){
  
 
      if (messageFromClient.update() > 0) { // have a new message?
       
       
        dialValue = messageFromClient.getInt(1);
       
        analogWrite( 6 , dialValue );    
      }
      
        
  
}


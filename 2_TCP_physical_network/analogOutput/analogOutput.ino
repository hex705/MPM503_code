  #include <Scissors.h>
  
  
  Scissors messageFromClient;        // SCISSORS parse messages
  
  int dialValue;               // variable to hold the incoming DIAL value 
  int ledPIN = 6;                    // CONNECT LED to this PIN
  
  
  void setup() {
    messageFromClient.begin(19200);   // NOTE HOW THIS STARTS!!!  -- we need to tell SCISSORS where to find messages!
                                      // this starts the serial port at BAUD 19200
    pinMode ( ledPIN, OUTPUT);        // make the LED pin an output
  }
  
  
  void loop(){
    
   
        if (messageFromClient.update() > 0) {         // poll the SCISSOR object -- any new MESSAGES (returns element count)
        
            dialValue = messageFromClient.getInt(1);  // extract ELEMENT 1 from MESSAGE -- ELEMENT(1) is an INT
         
        }
        
        
          analogWrite( ledPIN, dialValue );           // set our LED brightness to the VALUE from the CLIENT
          
  }


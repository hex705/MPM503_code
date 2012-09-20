/*
 * 
 * teleClient_n
 * 
 * simple teleClient -- connects to teleServer to obtain sensor data
 *
 *
 * based on server example in Shiffman -- learning processing
 *
 * 
 */

// import the needed libraries
import processing.net.* ;
import processing.serial.*;


Client teleClient ;
String serverIP = "127.0.0.1";  // where is the server?
int    serverPORT = 12345;      // on which port is it listening?

Serial clientSerialPort;

Scissors parseMessagesFromServer;


Glue messageToArduino = new Glue();


int greyValueFromServer ; 

PFont f;

void setup(){
  
  size( 700,700 );
  background(67);
  
  // start client to get messages
  teleClient = new Client( this, serverIP, serverPORT );
  parseMessagesFromServer = new Scissors( teleClient );
  
  // start the serial port
  // List all the available serial ports
  println(Serial.list());  
  // start serial to talk to Arduino
   clientSerialPort = new Serial(this, Serial.list()[6], 19200);  // match baud
  
  f = createFont( "Arial",  18,  true );
  textFont (f, 18);
 
}

void draw(){
 
    if (  parseMessagesFromServer.update() > 0 ) {   //  polls port and returns number of values returned
        
        background(67);
        
        greyValueFromServer = parseMessagesFromServer.getInt(1);  // get int from position 1
        
        // draw and fill rectangle with data from server
        fill(greyValueFromServer);  
        rect(width/2-300,height/2-300,600,600);
        
        // put text at bottom
        fill(255);
        textAlign(RIGHT);
        text( greyValueFromServer, 650 , 670 );
        
        // pass the value to Arduino
         messageToArduino.clear();                            // clear the last message so that we start fresh
         messageToArduino.add( "sam i am \n" );              // add a prefix to our message -- it tells you who is talking
         messageToArduino.add( "no I am not" );  
         
         messageToArduino.add(  greyValueFromServer );       // add the selected fill to our message
      
     
         String messageToSend = messageToArduino.getPackage();     // get the message
         messageToArduino.debug();                            // debug message to screen ( un/comment )
         clientSerialPort.write( messageToSend );               // send message to all clients with '.write'
        
    }
    
  // YOUR CODE HERE
  
} // end draw






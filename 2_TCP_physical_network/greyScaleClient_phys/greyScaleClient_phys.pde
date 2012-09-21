/*
 * 
 * teleClient_n
 * 
 * simple teleClient -- connects to teleServer to obtain sensor data passes it to ARDUINO
 *
 * all messages are parsed and assembled with SCISSORS and GLUE
 *
 * based on server example in Shiffman -- learning processing
 *
 * 
 */


import processing.net.* ;        // import the net library

Client teleClient ;              // declare a CLIENT object
String serverIP = "127.0.0.1";   // set to MATCH the IP of the SERVER (where is the server?)
int    serverPORT = 12345;       // set to MATCH the PORT on which the SERVER is listening?

Scissors parseMessagesFromServer;  // create a SCISSORS object to parse INCOMING messages from SERVER



import processing.serial.*;   // import the serial library
Serial clientSerialPort;      // setup a Serial PORT

Glue messageToArduino = new Glue();  // create a GLUE OBJECT to to help assemble OUTGOING SERIAL messages



int greyValueFromServer ;   // variable to store the value originating in the arduino and coming from the SERVER
PFont f;

void setup(){
  
  size( 700,700 );
  background(67);
  
  // start client to get messages
  teleClient = new Client( this, serverIP, serverPORT );     // connect client to SERVER IP and SERVER PORT
  parseMessagesFromServer = new Scissors( teleClient );      // attach parser (SCISSORS) to the CLIENT
  
  // start the serial port
  println(Serial.list());  // List all the available serial ports

  // connect this sketch to the USB port of your Arduino at specified BAUD
  clientSerialPort = new Serial(this, Serial.list()[99], 19200);  // match baud and PORT 
  
  f = createFont( "Arial",  18,  true );
  textFont (f, 18);
 
}

void draw(){
 
    if (  parseMessagesFromServer.update() > 0 ) {   //  polls CLIENT and returns number of ELEMENTS in MESSAGEs
        
        background(67);
        
        greyValueFromServer = parseMessagesFromServer.getInt(1);  // extract ELEMENT one (1) from the MESSAGE -- it is an INT
        
        // draw and fill rectangle with data from server
        fill(greyValueFromServer);  
        rect(width/2-300,height/2-300,600,600);
        
        // put text at bottom
        fill(255);
        textAlign(RIGHT);
        text( greyValueFromServer, 650 , 670 );
        
        // use GLUE to build a new message to be passed to local Arduino
         messageToArduino.clear();                         // start fresh :: clear the last OUTGOING message
         messageToArduino.add( "teleClient" );             // add a prefix to our message -- BE POLITE -- tell recipient who is talking
         
         
         messageToArduino.add(  greyValueFromServer );       // add the VALUE frm teh SERVER to our OUTGOING message
      
     
         String messageToSend = messageToArduino.getPackage();     // put the WHOLE message in a STRING
           //messageToArduino.debug();                             // debug message to screen ( un/comment )
         clientSerialPort.write( messageToSend );                  // use SERIAL method .write() to send a message to local ARDUINO
        
    }
    
  // YOUR CODE HERE
  
} // end draw






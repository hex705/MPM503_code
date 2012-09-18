

/**
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


Client teleClient ;
String serverIP = "127.0.0.1";  // where is the server?
int    serverPORT = 12345;      // on which port is it listening?

Scissors parse;
Glue clientPayload = new Glue();

// variable to hold values from server
int greyValueFromServer;


// font for value
PFont valueFont;


void setup(){
  
  size( 700,700 );
  background(67);
  
  teleClient = new Client( this, serverIP, serverPORT );
  parse = new Scissors(teleClient);
  
  valueFont = createFont( "Arial",  18,  true );
  textFont (valueFont, 18);
 
 
}

void draw(){
  

 
    // go see if we have any messages   
    if ( parse.update() > 0 ) {   //  polls port and returns number of values returned

        // show us the whole message
        println(parse.debug());
        
        // draw the message
        background(67);
        
        // use scissors to get the value from the server
        greyValueFromServer = parse.getInt(1);  // get int from position 1
        
        // draw the square using the server color
        stroke(255);
        fill(greyValueFromServer);  
        rect(width/2-300,height/2-300,600,600);
        
        // output the value as text 
        fill(255);
        textAlign(RIGHT);
        text( greyValueFromServer, 650 , 670 );
    }
        
  // YOUR CODE HERE
  
} // end draw



// use mousePressed event handler to send messages back to the server
void mousePressed(){
  
    // some local feedback -- outline in red
  background(255,0,0);
    delay(500);    
    // select color
    int reply = 0;
    if (greyValueFromServer > 127) { reply = 255; }
     
    clientPayload.clear();
    clientPayload.add("Your name here");
    clientPayload.add(reply);
    
    teleClient.write(clientPayload.getPackage());
      
}


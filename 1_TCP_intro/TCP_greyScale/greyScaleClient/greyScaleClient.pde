

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

PFont f;


void setup(){
  
  size( 700,700 );
  background(67);
  
  teleClient = new Client( this, serverIP, serverPORT );
  parse = new Scissors(teleClient);
  
  f = createFont( "Arial",  18,  true );
  textFont (f, 18);
 
}

void draw(){
 
    if ( parse.update() > 0 ) {   //  polls port and returns number of values returned
        
        background(67);
        
        int greyValueFromServer = parse.getInt(1);  // get int from position 1
        
        fill(greyValueFromServer);  
        rect(width/2-300,height/2-300,600,600);
        
        fill(255);
        textAlign(RIGHT);
        text( greyValueFromServer, 650 , 670 );
    }
    
  // YOUR CODE HERE
  
} // end draw






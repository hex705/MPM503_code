

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
  
  size( 750,750 );
  background(67);
  
  teleClient = new Client( this, serverIP, serverPORT );
  parse = new Scissors(teleClient);
  
  f = createFont( "Arial",  18,  true );
  textFont (f, 18);
  teleClient.write("*steve,23");
}

void draw(){
 
    if ( parse.update() > 0 ) {   //  polls port and returns number of values returned
        
        background(67);
        
        int remoteRed   = parse.getInt(1);
        int remoteGreen = parse.getInt(2);
        int remoteBlue  = parse.getInt(3);
        
        fill(color( remoteRed, remoteGreen, remoteBlue ));  
        rect(width/2-300,height/2-300,600,600);
        
        fill(255);
        textAlign(RIGHT);
        String colors =  ( remoteRed +", "  + remoteGreen+", " + remoteBlue);
        text( colors , 675 , 700 );
    }
    
  // YOUR CODE HERE
  
} // end draw



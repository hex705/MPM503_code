/**
 
 *  PROCESSING CODE 
 
 * Interface for grey scale color selection
 * Communication based on broadcast server example in Shiffman -- learning processing
 *
 * 
 */


// import the needed libraries
import processing.net.*;

// setup Server Variables
Server teleServer;
int serverPORT = 12345;

// create new message with Glue
Glue payload = new Glue();

// create a message parser with Scissors
Scissors parseClientMessages;

// create a slider
Slider greySlider;
int selectedFill ;  // store the currently selected color from slider

// create fonts for screen based feedback 
PFont clientIPs;
int clientListOffset = 20;

PFont clientNames;



void setup() {

  // environment
  size( 490, 600 );
  background( 67 );

  // fonts
  clientIPs   = createFont( "Arial", 18, true );
  clientNames = createFont( "Arial", 12, true );

  // instantiate server
  teleServer = new Server( this, serverPORT );  // Start a simple server on a port -- in this case port = 12345
  
  // instantiate a parse for messages from clients
  parseClientMessages   = new Scissors ( teleServer );

  // define the slider for interface
  greySlider =  new Slider(width-60, 90, 40, 200, 0, 255, GREYSCALE, true);
  greySlider.setField(color(200, 200, 200));

  // draw intitial client feedback box
  fill( 0);
  stroke(200);
  rect (width - 70, 450, 60, 100);
 
  stroke (255, 0, 0);
  line (width-70, 450, width-10, 550);   //diagonal line in red
  
  stroke(255);
  fill(g.backgroundColor);
  rect ( width - 115, 560, 105, 35);  // text box
}


void draw() {
  
  // get new fill color from slider
  selectedFill = greySlider.update();

  // draw the display box in upper right corner (display what we selected)
  fill( selectedFill );
  stroke(200);
  rect (width - 70, 10, 60, 60);


  //build our message
  payload.clear();                           // clear the last message so that we start fresh
  payload.add( "Slider server says:" );             // add a prefix to our message -- it tells you who is talking
  payload.add(  selectedFill );             // add the selected fill to our message

  String messageToSend = payload.getPackage();   // get the message
  // payload.debug();                               // debug message to screen ( un/comment )
  teleServer.write( messageToSend );             // send message to all clients with '.write'


  // check for clients talking to the server
  didAClientSaySomething();
  
  
}


// check from client messages to server -- Scissors object parses messages
void didAClientSaySomething() {

  // parse client messages is a Scissors object
  if ( parseClientMessages.update() > 0) {

    // show us what the client said
    parseClientMessages.debug();

    // extract the data value from the client message
    int talkBackfromClient =  parseClientMessages.getInt(1); 

    // display the client reply COLOR as a rectangle 
    fill( talkBackfromClient );
    stroke(200);
    rect (width - 70, 450, 60, 100);

    // show client name
    // screen maintenance -- erase the client name area
    stroke(255);
    fill(g.backgroundColor);
    rect ( width - 115, 560, 105, 35);
  
    textFont (clientNames);
    fill(255);
    textAlign(CENTER);
    text (parseClientMessages.getString(0), width - 60, 580);
  }  // if update
  
}


// function that listens for connects and displays them as they come in

void serverEvent(Server teleServer, Client client) {

  
  String newClientMessage = ( "New Client Connected " + client.ip() );  // concatenate message
  //println( newClientMessage );  // debug only

  // set the font for the message
  fill( 255 );
  textFont( clientIPs );
  textAlign(LEFT);

  text( newClientMessage, 20, clientListOffset );

  clientListOffset += 24; // move down for next test to display
}



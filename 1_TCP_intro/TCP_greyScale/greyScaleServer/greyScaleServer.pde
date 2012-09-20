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
   
  // create a slider
  Slider greySlider;
  int selectedFill ;  // store the currently selected color from slider
  
  PFont f;
  int clientListOffset = 20;
    
  void setup()  {
    
    size( 490, 600 );
    background( 67 );
    
    f = createFont( "Arial",  18,  true );
    textFont (f, 18);
    
    // instantiate server
    teleServer = new Server( this, serverPORT );  // Start a simple server on a port -- in this case port = 12345
 
    // define the slider for interface
    greySlider =  new Slider(width-60, 90, 40, 200, 0, 255, GREYSCALE, true);
    greySlider.setField(color(200,200,200));
    
  }
  
  
  void draw() {
  
    // get new fill color from slider
    selectedFill = greySlider.update();
    
    // draw the display box in upper right corner (display what we selected)
    fill( selectedFill );
    stroke(200);
    rect (width - 70, 10,60,60);
    
    //build our message
    
      payload.clear();                            // clear the last message so that we start fresh
      payload.add( "Server says:" );              // add a prefix to our message -- it tells you who is talking
      payload.add(  selectedFill );             // add the selected fill to our message
      
     
      String messageToSend = payload.getPackage();     // get the message
      payload.debug();                              // debug message to screen ( un/comment )
      teleServer.write( messageToSend );               // send message to all clients with '.write'
    
  }
  

  
  
  // function that listens for connects and displays them as they come in
  
    void serverEvent(Server teleServer, Client client){
     String newClientMessage =  ( "New Client Connected " );
     
    newClientMessage += client.ip() ;  // concatenate message
    //println( newClientMessage );  // debug only
      
    // set the font for the message
    fill( 255 );
    textFont( f );
    textAlign(LEFT);
    
    text( newClientMessage,  20,  clientListOffset );
    
    clientListOffset += 24; // move down for next test to display
    
  }
    
 



  /**
   
   *  PROCESSING CODE 
  
   * Interface for grey scale color selection
   * Communication based on broadcast server example in Shiffman -- learning processing
   *
   * 
   */

  
  // import the needed libraries
  import processing.net.*;
  import processing.serial.*;
  
  
  // setup Server Variables
  Server teleServer;
  int serverPORT = 12345;
  
  // setup a Serial PORT
  Serial serverSerialPort;
 
  // create new SERVER message with Glue
  Glue serverMessage = new Glue();
  
  // create a parser for messages from Arduino (serial messages)
  Scissors serialParser;
  int greyValueFromArduino;
   
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
    
    
    // start the serial port
    // List all the available serial ports
    println(Serial.list());  
    // connect this sketch to the USB port or your Arduino at specified BAUD
    serverSerialPort = new Serial(this, Serial.list()[8], 9600);  // match baud
    
    // attach the serial parser to teh serial stream
    serialParser = new Scissors( serverSerialPort);
    
    
    // instantiate server
    teleServer = new Server( this, serverPORT );  // Start a simple server on a port -- in this case port = 12345
 
 
    // define the slider for interface
    greySlider =  new Slider(width-60, 90, 40, 200, 0, 255, GREYSCALE, true);
    greySlider.setField(color(200,200,200));
    
  }
  
  
  void draw() {
  
     // get new fill color from ARDUINO
     if ( serialParser.update() > 0 ) {   //  polls port and returns number of values returned
         // println("from arduino : " + serialParser.getRaw() );   // for debug purposes
        greyValueFromArduino = serialParser.getInt(1);  // get int from position 1
        greySlider.update( greyValueFromArduino ); // 
       
     }  // end check serial
    
    
    // draw the display box in upper right corner (display what we selected)
    fill( greyValueFromArduino );
    stroke(200);
    rect (width - 70, 10,60,60);
    
    
    
    // build our outgoing serverMessage
    
      serverMessage.clear();                            // clear the last message so that we start fresh
      serverMessage.add( "Server says:" );              // add a prefix to our message -- it tells you who is talking
      serverMessage.add(  greyValueFromArduino );       // add the selected fill to our message
      
     
      String messageToSend = serverMessage.getPackage();     // get the message
       // serverMessage.debug();                            // debug message to screen ( un/comment )
      teleServer.write( messageToSend );               // send message to all clients with '.write'
    
  }
  

  
  
  // function that listens for connects and displays them as they come in
  
    void serverEvent(Server teleServer, Client client){
   
    String newClientMessage = ( "New Client Connected " + client.ip() );  // concatenate message
    //println( newClientMessage );  // debug only
      
    // set the font for the message
    fill( 255 );
    textFont( f );
    textAlign(LEFT);
    
    text( newClientMessage,  20,  clientListOffset );
    
    clientListOffset += 24; // move down for next test to display
    
  }
    
 

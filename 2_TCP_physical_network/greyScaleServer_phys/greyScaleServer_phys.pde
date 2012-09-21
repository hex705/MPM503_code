

  /**
   
   *  PROCESSING CODE 
  
   * greyScaleServer -- receives a MESSAGE from and ARDUINO visualizes that MESSAGE locally and 
   * passes that message to connected SERVERS.
   *
   * 
   */


  import processing.serial.*;  // import the serial library
  Serial serverSerialPort;     // setup a Serial PORT
 
  Scissors serialParser;       // create a SCISSORS object to parse INCOMING SERIAL messages from Arduino 
  int greyValueFromArduino;    // variable to store the value from arduino
  
  
  import processing.net.*;     // import the net library
  
  // setup Server Variables
  Server teleServer;           //  declare the server object
  int serverPORT = 12345;      //  define a PORT for the server
  
  Glue serverMessage;          // declare the  GLUE object to help assemble OUTGOING SERVER messages
  
   
 
  Slider greySlider;          // this SLIDER will DISPLAY the value from ARDUINO
   
  
  PFont clientFont;            // font for displaying connected clients
  int clientListOffset = 20;
    
  void setup()  {
    
    size( 490, 600 );
    background( 67 );
    
    clientFont = createFont( "Arial",  18,  true );
    textFont (clientFont, 18); 
    
    // start the serial port
    println(Serial.list());   // List all the available serial ports
   
    // connect this sketch to the USB port of your Arduino at specified BAUD
    serverSerialPort = new Serial(this, Serial.list()[99], 9600);  // match baud and PORT
    
    // attach the serial parser (SCISSORS) to the serial PORT
    serialParser = new Scissors( serverSerialPort ); 
    
   
    // instantiate server
    teleServer = new Server( this, serverPORT );  // Start a simple server on a serverPORT ( 12345 )
    serverMessage = new Glue();                   // instatiate the GLUE object for serverMessages 
 
 
    // define the slider for interface
    greySlider =  new Slider(width-60, 90, 40, 200, 0, 255, GREYSCALE, true);
    greySlider.setField(color(200,200,200));
    
  }
  
  
  void draw() {
  
     // use SCISSORS to extract the new fill VALUE from ARDUINO
     if ( serialParser.update() > 0 ) {   //  polls SERIAL port and returns number of ELEMENTS in MESSAGE
          //  println("from arduino : " + serialParser.getRaw() );   // for debug purposes
        greyValueFromArduino = serialParser.getInt(1);             // get our INT from position 1
        greySlider.update( greyValueFromArduino );                 // set the SLIDER
       
     }  // end check serial
    
    
    // draw the display box in upper right corner (display what we selected)
    fill( greyValueFromArduino );
    stroke(200);
    rect (width - 70, 10,60,60);
    
    
    
    // use GLUE to build our outgoing serverMessage  -- two ELEMENTS 
    
      serverMessage.clear();                            // clear the last message so that we start fresh
      serverMessage.add( "Server says:" );              // add a TEXT prefix to our message -- it tells you who is talking
      serverMessage.add(  greyValueFromArduino );       // add the selected fill (INT) to our message
      
     
      String messageToSend = serverMessage.getPackage();     // put the WHOLE message in a STRING
       // serverMessage.debug();                            // debug message to screen ( un/comment )
      teleServer.write( messageToSend );                    // use SERVER method .write() to send message to client(s)
    
  }
  

  
  
  // function that listens for connects and displays them as they come in
  
    void serverEvent(Server teleServer, Client client){
   
    String newClientMessage = ( "New Client Connected " + client.ip() );  // concatenate message
    //println( newClientMessage );  // debug only
      
    // set the font for the message
    fill( 255 );
    textFont( clientFont );
    textAlign(LEFT);
    
    text( newClientMessage,  20,  clientListOffset );
    
    clientListOffset += 24; // move down for next test to display
    
  }
    
 


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
   
  int localRed,localGreen, localBlue ;  // currently selected color
  Slider r,gr,b;
  
   
  PFont f;
  int clientListOffset = 275;
    
    
  void setup()  {
    
      size( 385, 750 );
      background( 67 );
      
      f = createFont( "Arial",  18,  true );
      textFont (f, 18);
      
      // instantiate server
      teleServer = new Server( this, serverPORT );  // Start a simple server on a port -- in this case port = 12345
   
      // define the slider for interface
      r =  new Slider(width - 360, 20, 100, 200, 0, 255, color(255,0,0),  false);
      gr = new Slider(width - 240, 20, 100, 200, 0, 255, color(0,255,0),  false);
      b =  new Slider(width - 120 , 20, 100, 200, 0, 255, color(0,0,255), false);
    
  }
  
  
  void draw() {
  
    // get new fill color
    localRed = r.update();
        localGreen = gr.update();
            localBlue = b.update();
    
  
    //build the message
      payload.clear();               // start fresh
      
      payload.add( "Steve says:" );              // add a String prefix to the message
      
      payload.add( localRed  ); // add a string
        payload.add( localGreen  ); // add a string
          payload.add( localBlue ); // add a string
     
      String messageToSend = payload.getPackage();  // get the message
     // println( payload.debug() );                   // send message to screen ( un/comment )
      teleServer.write( messageToSend );            // send message to all clients
    
  }
  

  
  
  // function that listens for connects and displays them as they come in
  
    void serverEvent(Server teleServer, Client client){
   
        String newClientMessage = ( "New Client Connected " + client.ip() );  // concatenate message
        println( newClientMessage );  // debug only
          
          delay(5000);
        // set the font for the message
        fill( 255 );
        stroke(255);
        textFont( f );
        textAlign(LEFT);
        
        text( newClientMessage,  20,  clientListOffset );
        
        clientListOffset += 24; // move down for next test to display
    
  }
    
 

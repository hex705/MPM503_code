TCP_rgb

This example builds upon the TCP_greyScale example and extends our use of SCISSORS and GLUE. In this example MESSAGES with THREE elements are sent from server to client(s).

Recall:

GLUE enables the building of MESSAGES by GLUEing ELEMENTS together.

SCISSORS cut MESSAGES into their original ELEMENTs.


In this example the rgbSERVER selects RED,GREEN and BLUE values with sliders.  The server packages these elements into complete messages with GLUE.

rgbClients connect to the greyScaleSERVER at the SERVER IP and PORT.  CLIENTS receive r,g,b-slider values from the server and mix them into a single-colour large square.


As with all examples so far, this system can operate as a point to point network that allows one way conversations (a CRUSH) with single clients or BROADCASTS when MANY clients connect.







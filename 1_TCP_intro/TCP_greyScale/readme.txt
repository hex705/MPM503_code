TCP_greyScale

This example build upon the TCP_basic example and is our first introduction to SCISSORS and GLUE.  In this example messages with ONE element are sent from server to clients.

RECALL:

GLUE enables the building of MESSAGES by GLUEing ELEMENTS together.

SCISSORS cut MESSAGES into their original ELEMENTs.



In this example the greyScaleSERVER selects a grey value with a slider.  The server packages its messages to clients with GLUE.

greyScaleClients connect to the greyScaleSERVER at the SERVER IP and PORT.  CLIENTS receive slider values from the server and set the grey value of a large square to match.  CLIENTS use SCISSORS to parse incoming messages.


This can operate as a point to point network that allows one way conversations (a CRUSH) when a single client connects.  It is a ONE to MANY system (a BROADCAST) when lots connect.





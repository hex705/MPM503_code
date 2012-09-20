TCP_basic

This is a simple example (take from Processing) that shows the frame work for server and client.

In this example the basicSERVER sketch counts repeatedly from 0-255.  It sets its background to the value of the count. 

basicCLIENTS connect to the SERVER at the SERVER IP and PORT.  CLIENTS receive count values from the server and set their background to the value received.


This can operate as a point to point network that allows one way conversations (a CRUSH) when a single client connects.  It is a ONE to MANY system (a BROADCAST) when lots connect.





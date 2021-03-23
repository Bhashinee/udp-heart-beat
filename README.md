## UDP Heartbeat Monitor

This project has 2 parts.
 1. UDP Server
 2. UDP Heartbeat Client

 ### UDP Server
 This is a UDP echo server. And if receives a particular health check datagram it sends a response saying that it is up running.

 ### UDP Heartbeat Client
 This is the main part of this project which checks whether the UDP server is up and running at the moment. 

 #### Configurations
 You can add necessary configurations in the Config.toml file.
 - interval - The time interval which the health check should run.
 - passes - Number of times which the server should acknowledge the client to say that it is up and running.
 - retryCount - How many times the server should retry.
 - runCount - How many times the program for health check should run.

 #### How to run and test
 - First, you have to run the UdpServer.
 - Then run the UdpHeartbeat module
 - This will send health check messages to the server to check if the server is up and running. And will wait for 3 seconds until a message is received. If it returns and udp:Error will notify saying that the server is down.
 - To test, shut down the server and after a while and check the error message printed in the console.



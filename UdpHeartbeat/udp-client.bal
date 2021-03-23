import ballerina/io;
import ballerina/log;
import ballerina/udp;

configurable int retryCount = ?;
configurable int passes = ?;

public function runHealthCheck() returns error? {

    udp:Client socketClient = check new (config = {timeout: 3});

    string msg = "health-check";

    udp:Datagram healthCheckDatagram = {
        remoteHost: "localhost",
        remotePort: 8080,
        data: msg.toBytes()
    };

    int i = 0;
    int noPasses = 0;

    while i < retryCount {
        check socketClient->sendDatagram(healthCheckDatagram);
        io:println("Health check datagram was sent to the remote host.");

        udp:Error|readonly & udp:Datagram result = socketClient->receiveDatagram();
        if result is udp:Error {
            log:printError("-------Server has shut down------");
            break;
        } else {
            string status = check string:fromBytes(result.data);
            if (status == "up") {
                io:println("Received: ", status);
                noPasses = noPasses + 1;
                if (noPasses >= passes) {
                    log:printInfo("-------Server is up and running------");
                    break;
                }
            }
            i = i + 1;
        }
    }
}

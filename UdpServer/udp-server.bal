import ballerina/io;
import ballerina/udp;

service on new udp:Listener(8080) {
    remote function onDatagram(readonly & udp:Datagram datagram, udp:Caller caller) returns udp:Datagram|error? {
        io:println("Received by listener: ", string:fromBytes(datagram.data));
        string healthCheck = check string:fromBytes(datagram.data);
        if (healthCheck == "health-check") {
            udp:Error? reply = caller->sendBytes("up".toBytes());
        } else {
            return datagram;
        }
    }
}

%Function to connect to a drone with an address: 
function result=ConnectCrazyzmq(socketcomm,Address)
connectcmd=['{"version": 1,"cmd": "connect","uri": "',Address,'"}'];
zmq.core.send(socketcomm, uint8(connectcmd));
pause(3)
result=char(zmq.core.recv(socketcomm,20000,'ZMQ_DONTWAIT'));
end
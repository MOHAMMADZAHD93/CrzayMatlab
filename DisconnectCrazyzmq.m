function result=DisconnectCrazyzmq(socketcomm,Address)
connectcmd=['{"version": 1,"cmd": "disconnect","uri": "',Address,'"}'];
zmq.core.send(socketcomm, uint8(connectcmd));
pause(2);
result=char(zmq.core.recv(socketcomm,20000,'ZMQ_DONTWAIT'));
end
%SET A LOG and start it
function [resultset,resultstart,str1,str2]=SetStartlogcCrazy(socketcomm,socketlog,period)
period=num2str(period);
LOgconf=['{"version": 1,"cmd": "log","action": "create","name": "Test log block","period": ',period,',"variables": ["stabilizer.pitch","stabilizer.roll","stabilizer.yaw"]}'];
zmq.core.send(socketcomm, uint8(LOgconf));
pause(2);
resultset=char(zmq.core.recv(socketcomm,20000,'ZMQ_DONTWAIT'));
%Start it: 
StartLOgConfig='{"version": 1,"cmd": "log","action": "start","name": "Test log block"}';
zmq.core.send(socketcomm, uint8(StartLOgConfig));
pause(2); 
resultstart=char(zmq.core.recv(socketcomm,20000,'ZMQ_DONTWAIT'));
str1=char(zmq.core.recv(socketlog,20000,'ZMQ_DONTWAIT'));
pause(1);
str2=char(zmq.core.recv(socketlog,20000,'ZMQ_DONTWAIT'));
pause(1);
end

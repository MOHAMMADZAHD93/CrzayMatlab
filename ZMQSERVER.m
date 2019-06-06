%This function is to start the ZMQ client and to create a socket for the
%Request commands, and the log
function [socketcomm,socketlog,socketparam,socketconn,socketcont]...
=ZMQSERVER()
%Start the zmq server:
system('start cmd.exe @cmd /k "cfzmq -d"')
%Command socket: 
%The command messages are implemented as server/client, where each 
%request to the server is answered with a response. Each message 
%to the server contains version, command and fields related to the 
%command, Each response from the server will contain version and status,
% where status 0 means everything was ok. This makes all the calls on 
%this port synchronous, where the server will not reply until the 
%action is completed or it fails. 
contextcomm = zmq.core.ctx_new();
socketcomm  = zmq.core.socket(contextcomm, 'ZMQ_REQ');
addresscomm = 'tcp://127.0.0.1:2000';
zmq.core.connect(socketcomm, addresscomm);
%Log socket: 
%This socket is used for sending log configuration events as well...
%as log data. The events that are sent is for creating, ...
%starting, stopping and deleting a configuration. For every started ...
%configuration the log data will be sent over this socket.
contextlog = zmq.core.ctx_new();
socketlog  = zmq.core.socket(contextlog, 'ZMQ_SUB');
addresslog = 'tcp://127.0.0.1:2001';
zmq.core.connect(socketlog, addresslog);
zmq.core.setsockopt(socketlog,'ZMQ_SUBSCRIBE','');
%Param Socket:
%This socket is used to broadcast parameter updates done on the...
%command socket. 
contextparam = zmq.core.ctx_new();
socketparam  = zmq.core.socket(contextparam, 'ZMQ_SUB');
addressparam = 'tcp://127.0.0.1:2002';
zmq.core.connect(socketparam, addressparam);
zmq.core.setsockopt(socketparam,'ZMQ_SUBSCRIBE','');
%Connection socket: 
%This socket is used to broadcast changes in the connection state as ...
%events. Connecting the Crazyflie is a synchronous call to the command...
% socket, but for instance a lost connection will be asynchronous and...
% boardcasted on this socket. 
contextconn = zmq.core.ctx_new();
socketconn  = zmq.core.socket(contextconn, 'ZMQ_SUB');
addressconn = 'tcp://127.0.0.1:2003';
zmq.core.connect(socketconn, addressconn);
zmq.core.setsockopt(socketconn,'ZMQ_SUBSCRIBE','');
%Control socket
%Control commands can be sent at any time after the Crazyflie...
%has been connected and has the following scaling/format: 
contextcont = zmq.core.ctx_new();
socketcont  = zmq.core.socket(contextcont, 'ZMQ_PUSH');
addresscont = 'tcp://127.0.0.1:2004';
zmq.core.connect(socketcont, addresscont);
end
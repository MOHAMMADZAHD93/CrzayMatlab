%Function to send commands to the Crazyflie:
function sendcommandsCrazy(socketcont,Thrust,roll,pitch,yaw)
Msg=['{"version": 1,"roll": ',num2str(roll),',"pitch": ',num2str(pitch),...
',"yaw": ',num2str(yaw),',"thrust": ',num2str(Thrust),'}'];
zmq.core.send(socketcont, uint8(Msg));
end
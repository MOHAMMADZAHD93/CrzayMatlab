function Data=logdataCrazy(socketlog)
Str=char(zmq.core.recv(socketlog,20000,'ZMQ_DONTWAIT'));
Key= '"stabilizer.roll":';
Index = strfind(Str, Key);
roll= sscanf(Str(Index(1) + length(Key):end), '%g', 1);
Key= '"stabilizer.pitch":';
Index = strfind(Str, Key);
pitch = sscanf(Str(Index(1) + length(Key):end), '%g', 1);
Key= '"stabilizer.yaw":';
Index = strfind(Str, Key);
yaw= sscanf(Str(Index(1) + length(Key):end), '%g', 1);
Data=[roll;pitch;yaw]; 
end
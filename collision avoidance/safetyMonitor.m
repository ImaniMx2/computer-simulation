function [ flag ] = safetyMonitor( in1, in2 )
% in1, in2: Data Structure that stores information about the aircraft
%       (x, y): Current Location of the aircraft
%       (xd, yd): Destination of aircraft
%       theta: Current direction of motion
%       m: Message from neighbouring aircraft 
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%
% flag: true if the safety is voilated and false otherwise.


% if in range of 2d flag is true
% 2d raange is when in.x-1 < in1.x < in.x + 1 ||  in.y-1 < in1.y < in.y + 1 
if(in1.x == in2.x && in1.y == in2.y )
    flag = true;
else
    flag =false;
end

% if in range of 2q input messages to the air craft
% 2q raange is when in.x-1 < in1.x < in.x + 1 ||  in.y-1 < in1.y < in.y + 1 
if(in2.x-2 < in1.x ||  in1.x < in2.x + 2 || in2.y-2 < in1.y || in1.y < in2.y +2 )
    in1.m.x= in2.x;
    in1.m.xd= in2.xd;
    in1.m.y= in2.y;
    in1.m.yd= in2.yd;
    in1.m.theta= in2.theta;

    in2.m.x= in1.x;
    in2.m.xd= in1.xd;
    in2.m.y= in1.y;
    in2.m.yd= in1.yd;
    in2.m.theta= in1.theta;
else
    in1.empty;
    in2.empty;
end


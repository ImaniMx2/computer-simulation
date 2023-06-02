function [ px, py  ] = prevpos( x, y, theta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    px = x;
    py = y;
    
    if(theta == 0 || theta == 360)
        px = x - 1;
    elseif(theta == 90)
        py = y - 1;
    elseif(theta == 180)
        px = x + 1;
    elseif(theta == 270)
        py = y + 1; 
    end


end


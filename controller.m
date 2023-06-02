 function [ out, state ] = controller( in, state )
% Takes flight parameters of an aircraft and outputs the direction control

% in: Data Structure that stores input information for the aircraft
% controller. 
%       (in.x, in.y): Current Location of the aircraft
%       (in.xd, in.yd): Destination of aircraft
%       in.theta: Current direction of motion
%       in.m: Message from neighbouring aircraft 
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%           - To access data (say x) from in.m, use in.m.x
%
% out : Data Structure that stores the output information from the aircraft
%       out.val: +1, 0, -1 ( +1 - turn left, 0 - go straight, -1 - turn right)
% 
% state: 
%       any state used by the controller
%       mode 0 = initial
%       mode 1 = need to go straigt
%       mode 2 = need to go right
%       mode 3 = need to go left
%      


% Initialize state
if (isempty(state))
    state.mode = 0; 
end

%set mode
% destination is on the top right
if(in.x < in.xd && in.y < in.yd)
    if(in.theta == 90 || in.theta == 0)
        state.mode = 1;
    elseif(in.theta == 180 )
        state.mode = 2;
    elseif(in.theta == 270) 
        state.mode = 3;
    end
% destination above
elseif(in.x == in.xd && in.y < in.yd)
    if(in.theta == 90)
        state.mode = 1;
    elseif(in.theta == 180)
        state.mode = 2;
    elseif(in.theta == 0 ||in.theta == 270) 
        state.mode = 3;
    end
     
%top left
elseif(in.x > in.xd && in.y < in.yd)
    if(in.theta == 90 ||in.theta == 180)
        state.mode = 1;
    elseif(in.theta == 270)
        state.mode = 2;
    elseif(in.theta == 0) 
        state.mode = 3;
    end 
% destination is to the right
elseif(in.x < in.xd && in.y == in.yd)
    if(in.theta == 0)
        state.mode = 1;
    elseif(in.theta == 180 ||in.theta == 90)
        state.mode = 2;
    elseif(in.theta == 270) 
        state.mode = 3;
    end    
% destination is to the left   
elseif(in.x > in.xd && in.y == in.yd)
    if(in.theta == 180)
        state.mode = 1;
    elseif(in.theta == 270 ||in.theta == 0)
        state.mode = 2;
    elseif(in.theta == 90) 
        state.mode = 3;
    end    

%destination is in the bottom left 
elseif(in.x > in.xd && in.y > in.yd)
    if(in.theta == 270 ||in.theta == 180 )
        state.mode = 1;
    elseif(in.theta == 0)
        state.mode = 2;
    elseif(in.theta == 90) 
        state.mode = 3;
    end    
%destination below 
elseif(in.x == in.xd && in.y > in.yd)
    if(in.theta == 270 )
        state.mode = 1;
    elseif(in.theta == 90 ||in.theta == 0)
        state.mode = 2;
    elseif(in.theta == 180) 
        state.mode = 3;
    end   
%destination is to the bottom right
elseif(in.x < in.xd && in.y > in.yd)
    if(in.theta == 270 ||in.theta == 0)
        state.mode = 1;
    elseif(in.theta == 90 )
        state.mode = 2;
    elseif(in.theta == 180) 
        state.mode = 3;
    end    
end


% collision avoidance 

if(isempty(in.m) == false)
    dist1 = sqrt((in.xd-in.x)^2 +(in.yd-in.y)^2);%distance from airplane 1 to destination
    dist2 = sqrt((in.m.xd-in.m.x)^2 +(in.m.yd-in.m.y)^2);%distance from airplane 2 to destination
    if(dist1 < dist2)
        state.mode = state.mode;
    elseif(dist1 == dist2)
        %top right move and bottom left stays the same
        if(in.m.x == in.x +1 && in.m.y == in.y +1)
            if(in.m.theta == 180 && in.theta == 90)
                state.mode = 2;% 
            elseif(in.m.theta == 270 && in.theta == 0)
                state.mode = 3;% 
            end
        %top moves bottom stays the same
        elseif(in.m.x == in.x && in.m.y == in.y +1)
            if(in.m.theta == 270 && in.theta == 90)
                if(in.xd >in.x)
                    state.mode = 2; % plane goes straight
                else
                    state.mode = 3; % plane goes right
                end
            end 
        %top left moves 
        elseif(in.m.x == in.x-1 && in.m.y == in.y +1 )
            if(in.m.theta == 270 && in.theta == 180)
                state.mode = 2; % plane goes right
        
            elseif(in.m.theta == 0 && in.theta == 90)
                state.mode = 3; % plane goes left
            end
        elseif(in.m.x == in.x +1 && in.m.y == in.y )
            if(in.m.theta == 0 && in.theta == 180)
                if(in.yd > in.y)
                    state.mode = 2; % plane goes right
                else
                    state.mode = 3;
                end
            end
      
        
        end        
       
    
        
    else
    %other plane is at the top rigt]
    % t 
        if(in.m.x == in.x +1 && in.m.y == in.y +1)
            if(in.m.theta == 180 && in.theta == 90)
                state.mode = 2;% 
            elseif(in.m.theta == 270 && in.theta == 0)
                if(in.m.y == in.y)
                    state.mode = 1;
                else 
                    state.mode = 3;%
                end
            end
    %other plane is at the top 
        elseif(in.m.x == in.x && in.m.y == in.y +2)
            if(in.m.theta == 270 && in.theta == 90)
                if(in.xd >in.x)
                    state.mode = 2; % plane goes straight
                else
                    state.mode = 3; % plane goes right
                end
            end
    %other plane is at the top left
        elseif(in.m.x == in.x-1 && in.m.y == in.y +1 )
            if(in.m.theta == 270 && in.theta == 180)
                state.mode = 2; % plane goes right
        
            elseif(in.m.theta == 0 && in.theta == 90)
                state.mode = 3; % plane goes left
            end
        
    %other plane is at the left
         elseif(in.m.x == in.x -1 && in.m.y == in.y )
            if(in.m.theta == 0 && in.theta == 180)
                if(in.yd <in.y)
                    state.mode = 3; % plane goes left
                else
                    state.mode = 2;
                end
                
            end
    %other plane is at the bottom left
        elseif(in.m.x == in.x-1 && in.m.y == in.y -1 )
            if(in.m.theta == 0 && in.theta == 270)
                state.mode = 2; % plane goes right
            
            elseif(in.m.theta == 90 && in.theta == 180)
                state.mode = 3; % plane goes left
            end
        
%other plane is at the bottom
        elseif(in.m.x == in.x && in.m.y == in.y-2 )
            if(in.m.theta == 270 && in.theta == 90)
                if(in.xd> in.x)
                    state.mode = 2; % plane goes right
                else
                    state.mode =3;
                end
     
            end
        
%other plane is at the bottom right
        elseif(in.m.x == in.x+1 && in.m.y == in.y -1 )
            if(in.m.theta == 0 && in.theta == 90)
                state.mode = 2; % plane goes right
           
            elseif(in.m.theta == 270 && in.theta == 180)
                state.mode = 3; % plane goes straight-. left
            
            end
%other plane is at the right
        elseif(in.m.x == in.x +2 && in.m.y == in.y )
            if(in.m.theta == 0 && in.theta == 180)
                if(in.yd > in.y)
                    state.mode = 2; % plane goes right
                else
                    state.mode = 3;
                end
            end
        end
    end
end

 

    

if (state.mode == 0)
        out.val = 0;
    elseif (state.mode == 1)

        out.val = 0;
    
    elseif (state.mode == 2)
        out.val = -1;    
   
    elseif (state.mode == 3)
        out.val = +1;
 end
    
end
% Code to generate controller output


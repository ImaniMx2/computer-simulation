% Parameters
initialPosition = [0, 0];    % Initial position [x, y]
destination = [10, 2];    % Destination [x, y]
initialSpeed = 1;           % Initial speed (units per time step)
acceleration = 0;            % Acceleration (units per time step squared)
timeStep = 15;                % Time step (seconds)

% Calculate the direction vector towards the destination
direction = destination - initialPosition;
direction = direction / norm(direction); % Normalize the vector

directionx=0;
directiony=0;
% Initialize variables
position = initialPosition;
speed = initialSpeed * direction;

% Simulation loop
while norm(destination - position) > 0.1
   if initialPosition < destination
       directionx = 1
   else
       directionx = -1

   if initialPosition[0]< destination[0]
       directionx = 1
   else
       directionx = -1
    % Calculate the new speed vector using acceleration
    speed = speed + acceleration * direction;
    
    % Calculate the new position using the current speed
    position = position + speed * timeStep;
    
    % Display the current position
    disp(['Position: [', num2str(position), ']']);
end

% Display the final position
disp(['Destination reached! Final position: [', num2str(position), ']']);


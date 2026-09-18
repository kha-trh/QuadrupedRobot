clear; clc; close;

% port at which your arduino is connected

port = 'COM5';

% model of your arduino board

board = 'Mega2560';

% creating arduino object with servo library

arduino_board = arduino(port, board, 'Libraries', 'Servo');

% creating servo motor object

pinMode1 = 'D8';
servo_motor1 = servo(arduino_board, pinMode1);

pinMode2 = 'D9';
servo_motor2 = servo(arduino_board, pinMode2);

% loop to rotate servo motor from 0 to 180

% for angle = 0:0.2:1
% 
%    writePosition(servo_motor, angle);
% 
%    current_position = readPosition(servo_motor);
% 
%    current_position = current_position * 180;   
% 
%    % print current position of servo motor
% 
%    fprintf('Current position is %d\n', current_position);   
% 
%    % small delay is required so that servo can be positioned at the
% 
%    % angle told to it.
% 
%    pause(1);
% 
% end

% bring back motor to 0 angle position

theta1 = 120;
d1 = theta1/180;

theta2 = -60;
d2 = (90 - theta2)/180;

writePosition(servo_motor1, d1);
writePosition(servo_motor2, d2);
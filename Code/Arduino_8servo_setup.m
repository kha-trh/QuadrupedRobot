function [servo_motor1, servo_motor2, servo_motor3, servo_motor4, servo_motor5, servo_motor6, servo_motor7, servo_motor8] = Arduino_8servo_setup(board, port, pin1, pin2, pin3, pin4, pin5, pin6, pin7, pin8)
% model of your arduino board
name_board = board;
% port at which your arduino is connected
connection_port = port;
% creating arduino object with servo library
arduino_board = arduino(connection_port, name_board, 'Libraries', 'Servo');
% creating servo motor object
pinMode1 = pin1;
pinMode2 = pin2;
pinMode3 = pin3;
pinMode4 = pin4;
pinMode5 = pin5;
pinMode6 = pin6;
pinMode7 = pin7;
pinMode8 = pin8;

servo_motor1 = servo(arduino_board, pinMode1);
servo_motor2 = servo(arduino_board, pinMode2);
servo_motor3 = servo(arduino_board, pinMode3);
servo_motor4 = servo(arduino_board, pinMode4);
servo_motor5 = servo(arduino_board, pinMode5);
servo_motor6 = servo(arduino_board, pinMode6);
servo_motor7 = servo(arduino_board, pinMode7);
servo_motor8 = servo(arduino_board, pinMode8);
end

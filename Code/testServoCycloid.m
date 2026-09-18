clear; clc; close;

% arduino setup 3 servo

[servo_motor1, servo_motor2, servo_motor3, servo_motor4, servo_motor5, servo_motor6, servo_motor7, servo_motor8] = Arduino_8servo_setup('Mega2560', 'COM5', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9');

% code

xo = 40;
xf = 120;

tf = 2;

for t = 0:0.1:tf
    
    [xx_ru, zz_ru] = Cycloid(t, xo, xf, land, tf);

    [t1_ru, t2_ru] = IK_right_side_up(xx_ru, -90, zz_ru);
    

    d1_ru = (180 - t1_ru)/180;
    d2_ru = (t2_ru + 90)/180;
    
    writePosition(servo_motor3, d1_ru);
    writePosition(servo_motor4, d2_ru);

end
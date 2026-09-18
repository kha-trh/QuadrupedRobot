clear; clc; close;

% arduino setup 3 servo

[servo_motor1, servo_motor2, servo_motor3, servo_motor4, servo_motor5, servo_motor6, servo_motor7, servo_motor8] = Arduino_8servo_setup('Mega2560', 'COM5', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9');

% code

% goc right up IK

xx_ru = 75;
yy_ru = -90;
zz_ru = -113;

[t1_ru, t2_ru] = IK_right_side_up(xx_ru, yy_ru, zz_ru);

d1_ru = (180 - t1_ru)/180;
d2_ru = (t2_ru + 90)/180;

% goc right up FK

theta1_ru = 120;
theta2_ru = -60;

do1_ru = (180 - theta1_ru)/180;
do2_ru = (theta2_ru + 90)/180;

[x_ru, y_ru, z_ru] = FK_right_side_up(theta1_ru, theta2_ru);
disp('ru = ')
disp(x_ru)
disp(y_ru)
disp(z_ru)

% goc right down IK

xx_rd = -85;
yy_rd = -90;
zz_rd = -113;

[t1_rd, t2_rd] = IK_right_side_down(xx_rd, yy_rd, zz_rd);

d1_rd = (180 - t1_rd)/180;
d2_rd = (t2_rd + 90)/180;

% goc right down FK

theta1_rd = 120;
theta2_rd = -60;

do1_rd = (180 - theta1_ru)/180;
do2_rd = (theta2_ru + 90)/180;

[x_rd, y_rd, z_rd] = FK_right_side_down(theta1_rd, theta2_rd);
disp('rd = ')
disp(x_rd)
disp(y_rd)
disp(z_rd)

% goc left up IK

xx_lu = 75;
yy_lu = 90;
zz_lu = -113;

[t1_lu, t2_lu] = IK_left_side_up(xx_lu, yy_lu, zz_lu);

d1_lu = t1_lu/180;
d2_lu = (90 - t2_lu)/180;

% goc left up FK

theta1_lu = 120;
theta2_lu = -60;

do1_lu = theta1_lu/180;
do2_lu = (90 - theta2_lu)/180;

[x_lu, y_lu, z_lu] = FK_left_side_up(theta1_lu, theta2_lu);
disp('lu = ')
disp(x_lu)
disp(y_lu)
disp(z_lu)

% goc left down IK

xx_ld = -85;
yy_ld = 90;
zz_ld = -113;

[t1_ld, t2_ld] = IK_left_side_down(xx_ld, yy_ld, zz_ld);

d1_ld = t1_ld/180;
d2_ld = (90 - t2_ld)/180;

% goc left down FK

theta1_ld = 120;
theta2_ld = -60;

do1_ld = theta1_lu/180;
do2_ld = (90 - theta2_lu)/180;

[x_ld, y_ld, z_ld] = FK_left_side_down(theta1_ld, theta2_ld);
disp('ld = ')
disp(x_ld)
disp(y_ld)
disp(z_ld)

% chay servo

writePosition(servo_motor1, d1_rd);
writePosition(servo_motor2, d2_rd);

writePosition(servo_motor3, d1_ru);
writePosition(servo_motor4, d2_ru);

writePosition(servo_motor5, d1_lu);
writePosition(servo_motor6, d2_lu);

writePosition(servo_motor7, d1_ld);
writePosition(servo_motor8, d2_ld);


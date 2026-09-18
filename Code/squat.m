clear; clc; close;

% arduino setup 3 servo

[servo_motor1, servo_motor2, servo_motor3, servo_motor4, servo_motor5, servo_motor6, servo_motor7, servo_motor8] = Arduino_8servo_setup('Mega2560', 'COM5', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9');

% code

Pf_ru = [60; -120];
Po_ru = [60; -90];

Pf_ld = [-100; -120];
Po_ld = [-100; -90];

Pf_lu = [60; -120];
Po_lu = [60; -90];

Pf_rd = [-100; -120];
Po_rd = [-100; -90];


to = 0;
tf = 1.5;
ck = 3;
solan = 10;

for t = 0:0.15:35
    i = fix(t/ck);

    if(t <= (tf + (ck*i)))

        [xx_ru, zz_ru] = TrajectoryPlanning2(t, Po_ru, Pf_ru, to+ck*i, tf);
        [xx_ld, zz_ld] = TrajectoryPlanning2(t, Po_ld, Pf_ld, to+ck*i, tf);
        [xx_lu, zz_lu] = TrajectoryPlanning2(t, Po_lu, Pf_lu, to+ck*i, tf);
        [xx_rd, zz_rd] = TrajectoryPlanning2(t, Po_rd, Pf_rd, to+ck*i, tf);

    else       
        [xx_ru, zz_ru] = TrajectoryPlanning2(t, Pf_ru, Po_ru, tf+ck*i, tf);
        [xx_ld, zz_ld] = TrajectoryPlanning2(t, Pf_ld, Po_ld, tf+ck*i, tf);
        [xx_lu, zz_lu] = TrajectoryPlanning2(t, Pf_lu, Po_lu, tf+ck*i, tf);
        [xx_rd, zz_rd] = TrajectoryPlanning2(t, Pf_rd, Po_rd, tf+ck*i, tf);
        
    end
    if(t > ck*solan)
        xx_ru = Po_ru(1);
        zz_ru = Po_ru(2);

        xx_ld = Po_ld(1);
        zz_ld = Po_ld(2);

        xx_lu = Po_lu(1);
        zz_lu = Po_lu(2);

        xx_rd = Po_rd(1);
        zz_rd = Po_rd(2);
    end
        [t1_ru, t2_ru] = IK_right_side_up(xx_ru, -90, zz_ru);
        [t1_ld, t2_ld] = IK_left_side_down(xx_ld, 90, zz_ld);

        [t1_lu, t2_lu] = IK_left_side_up(xx_lu, 90, zz_lu);
        [t1_rd, t2_rd] = IK_right_side_down(xx_rd, -90, zz_rd);

        d1_ru = (180 - t1_ru)/180;
        d2_ru = (t2_ru + 90)/180;

        d1_ld = t1_ld/180;
        d2_ld = (90 - t2_ld)/180;

        d1_rd = (180 - t1_rd)/180;
        d2_rd = (t2_rd + 90)/180;

        d1_lu = t1_lu/180;
        d2_lu = (90 - t2_lu)/180;

        writePosition(servo_motor1, d1_rd);
        writePosition(servo_motor2, d2_rd);
        
        writePosition(servo_motor3, d1_ru);
        writePosition(servo_motor4, d2_ru);
        
        writePosition(servo_motor5, d1_lu);
        writePosition(servo_motor6, d2_lu);
        
        writePosition(servo_motor7, d1_ld);
        writePosition(servo_motor8, d2_ld);
end
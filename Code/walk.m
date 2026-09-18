clear; clc; close;

% arduino setup 3 servo

[servo_motor1, servo_motor2, servo_motor3, servo_motor4, servo_motor5, servo_motor6, servo_motor7, servo_motor8] = Arduino_8servo_setup('Mega2560', 'COM5', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9');

% code

xo_ru = 60;
xf_ru = 100;
land_ru  = -120;

xo_ld = -100;
xf_ld = -60;
land_ld  = -120;

xo_lu = 60;
xf_lu = 100;
land_lu  = -120;

xo_rd = -100;
xf_rd = -60;
land_rd  = -120;

tf = 2;
total = 4;
i = 0;

for t = 0:0.1:2
    xx_ru = xo_ru;
    zz_ru = land_ru;

    xx_ld = xo_ld;
    zz_ld = land_ld;

    xx_lu = xo_lu;
    zz_lu = land_lu;

    xx_rd = xo_rd;
    zz_rd = land_rd;

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

out = Delay(500);

while(i <= 10)

    i = i + 1;

    for t = 0:0.1:total
    
        [xx_ru, zz_ru] = Cycloid2(t, xo_ru, xf_ru, land_ru, tf, total);
        [xx_ld, zz_ld] = Cycloid2(t, xo_ld, xf_ld, land_ld, tf, total);
    
        [t1_ru, t2_ru] = IK_right_side_up(xx_ru, -90, zz_ru);
        [t1_ld, t2_ld] = IK_left_side_down(xx_ld, 90, zz_ld);
    
        d1_ru = (180 - t1_ru)/180;
        d2_ru = (t2_ru + 90)/180;
    
        d1_ld = t1_ld/180;
        d2_ld = (90 - t2_ld)/180;
    
        writePosition(servo_motor3, d1_ru);
        writePosition(servo_motor4, d2_ru);
        
        writePosition(servo_motor7, d1_ld);
        writePosition(servo_motor8, d2_ld);
    
    end
    
    out1 = Delay(500);
    
    for t = 0:0.1:total
    
        [xx_lu, zz_lu] = Cycloid2(t, xo_lu, xf_lu, land_lu, tf, total);
        [xx_rd, zz_rd] = Cycloid2(t, xo_rd, xf_rd, land_rd, tf, total);
    
        [t1_lu, t2_lu] = IK_right_side_up(xx_lu, -90, zz_lu);
        [t1_rd, t2_rd] = IK_left_side_down(xx_rd, 90, zz_rd);
    
        d1_rd = (180 - t1_rd)/180;
        d2_rd = (t2_rd + 90)/180;
    
        d1_lu = t1_lu/180;
        d2_lu = (90 - t2_lu)/180;
    
        writePosition(servo_motor5, d1_lu);
        writePosition(servo_motor6, d2_lu);
        
        writePosition(servo_motor1, d1_rd);
        writePosition(servo_motor2, d2_rd);
    
    end

end

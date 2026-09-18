clc;clear;close;

figure('Name','Workspace')

subplot(2, 2, 1)
for theta1_LU = 60:1:120
    for theta2_LU = -90:1:90
        [x_LU, y_LU, z_LU] = FK_left_side_up(theta1_LU,theta2_LU);
        plot(x_LU, z_LU, '.', Color='b');
        hold on
        grid on
    end
end
title("LeftUpLeg")

subplot(2, 2, 2)
for theta1_RU = 60:1:120
    for theta2_RU = -90:1:90
        [x_RU, y_RU, z_RU] = FK_right_side_up(theta1_RU,theta2_RU);
        plot(x_RU, z_RU, '.', Color='r');
        hold on
        grid on
    end
end
title("RightUpLeg")

subplot(2, 2, 3)
for theta1_LD = 60:1:120
    for theta2_LD = -90:1:90
        [x_LD, y_LD, z_LD] = FK_left_side_down(theta1_LD,theta2_LD);
        plot(x_LD, z_LD, '.', Color='g');
        hold on
        grid on
    end
end
title("LeftDownLeg")

subplot(2, 2, 4)
for theta1_RD = 60:1:120
    for theta2_RD = -90:1:90
        [x_RD, y_RD, z_RD] = FK_right_side_down(theta1_RD,theta2_RD);
        plot(x_RD, z_RD, '.', Color='y');
        hold on
        grid on
    end
end
title("RightDownLeg")

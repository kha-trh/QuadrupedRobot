clear; close; clc;
tf = 2;
t = 0:0.01:tf;
theta = 2*pi*t/tf;

po = 60;
pf = 100;

a = (pf - po)/(2*pi);
land  = -120;

for theta1 = 60:1:120
    for theta2 = -90:1:90
        [x, ~, z] = FK_left_side_up(theta1,theta2);
        plot(x, z, '.', Color='b');
        hold on
        grid on
    end
end

hold on

x = a*(theta - sin(theta)) + po(1);
y = a*(1 - cos(theta)) + land;
plot(x, y, LineWidth=2)
grid on


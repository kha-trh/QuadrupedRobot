clc; clear; close;
total = 4;
tf = 2;
xo = 60;
xf = 120;
land  = -120;
a = [];
b = [];

figure(1)
for theta1 = 60:1:120
    for theta2 = -90:1:90
        [x, y, z] = FK_left_side_up(theta1,theta2);
        plot(x, z, '.', Color='b');
        hold on
        grid on
    end
end

hold on

for t = 0:0.01:total
    [x, y] = Cycloid2(t, xo, xf, land, tf, total);
    a = [a; x];
    b = [b; y];
end

t = 0:0.01:total;
plot(a, b, '.', Color='r', LineWidth=2)
grid on

figure(2)
subplot(3,1,1)
plot(a, b, '.', Color='r', LineWidth=2), grid on, xlabel('x move'), ylabel('y move')
subplot(3,1,2)
plot(t, a, '.', Color='b', LineWidth=2), grid on, xlabel('time (second)'), ylabel('x move')
subplot(3,1,3)
plot(t, b, '.', Color='g', LineWidth=2), grid on, xlabel('time (second)'), ylabel('y move')
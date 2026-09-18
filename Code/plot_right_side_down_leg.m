function out = plot_right_side_down_leg(theta1, theta2)

[d1, d2, l1] = robot_data;

i = constant;

x1 = -d1;
y1 = -d2;
z1 = i*d2;

x2 = l1*cosd(theta1) - d1;
y2 = - d2 - i*l1*sind(theta1);
z2 = i*d2 - l1*sind(theta1);

[xee, yee, zee] = FK_right_side_down(theta1, theta2);

plot3([0, x1, x2, xee], [0, y1, y2, yee], [0, z1, z2, zee], "-o", LineWidth=2, Color='#D95319') % cam

xlim([-200 200])
ylim([-200 200])
zlim([-200 200])

grid on

out = 0;

end
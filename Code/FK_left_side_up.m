function [x, y, z] = FK_left_side_up(theta1, theta2)

[d1, d2, l1, l2] = robot_data;

i = constant;

x = d1 + l2*cosd(theta1 + theta2) + l1*cosd(theta1);
y = d2 + i*l2*sind(theta1 + theta2) + i*l1*sind(theta1);
z = i*d2 - l2*sind(theta1 + theta2) - l1*sind(theta1);

end
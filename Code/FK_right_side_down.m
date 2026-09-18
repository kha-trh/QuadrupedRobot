function [x, y, z] = FK_right_side_down(theta1, theta2)

[d1, d2, l1, l2] = robot_data;

i = constant;

x = l2*cosd(theta1 + theta2) - d1 + l1*cosd(theta1);
y = - d2 - i*l2*sind(theta1 + theta2) - i*l1*sind(theta1);
z = i*d2 - l2*sind(theta1 + theta2) - l1*sind(theta1);

end
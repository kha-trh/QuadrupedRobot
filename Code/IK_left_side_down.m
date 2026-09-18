function [theta1, theta2] = IK_left_side_down(x, y, z)

[d1, d2, l1, l2] = robot_data;

i = constant;

xw = x*(i + 1) + d1*(i + 1);
yzw = d2*(i - 1) - (z - y);

a = 2*l1*(i + 1)*xw;
b = 2*l1*(i + 1)*yzw;
c = xw^2 + yzw^2 + l1^2*(i + 1)^2 - l2^2*(i + 1)^2;

theta1 = atan2d(b, a) + atan2d(sqrt(a^2+b^2-c^2), c);

c12 = (xw - l1*(i + 1)*cosd(theta1))/l2*(i + 1);
s12 = (yzw - l1*(i + 1)*sind(theta1))/l2*(i + 1);

theta2 = atan2d(s12, c12) - theta1;

end
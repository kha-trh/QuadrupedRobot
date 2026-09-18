function [x, y] = Cycloid(t, xo, xf, land, tf)
theta = 2*pi*t/tf;
a = (xf - xo)/(2*pi);
x = a*(theta - sin(theta)) + xo;
y = 2/5*(1 - cos(theta)) + land;
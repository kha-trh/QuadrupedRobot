function [x, y] = Cycloid2(t, xo, xf, land, tf, total)
if(t < total/2)
theta = 2*pi*t/tf;
a = (xf - xo)/(2*pi);
x = a*(theta - sin(theta)) + xo;
y = (1 - cos(theta)) + land;
else
Pf_ru = [xo; land];
Po_ru = [xf; land];
[x, y] = TrajectoryPlanning2(t, Po_ru, Pf_ru, total/2, tf);
end
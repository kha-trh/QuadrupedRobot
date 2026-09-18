function [x, y] = TrajectoryPlanning(t, Po, Pf, vo, vf, to, tf)
xo = Po(1);
yo = Po(2);
xf = Pf(1);
yf = Pf(2);

vxo = vo(1);
vyo = vo(2);
vxf = vf(1);
vyf = vf(2);

A = [1    0        0      0          0    0     0      0;
     0    1        0      0          0    0     0      0;
     1    tf       tf^2   tf^3       0    0     0      0;
     0    1      2*tf   3*tf^2       0    0     0      0;
     0    0        0      0          1    0     0      0;
     0    0        0      0          0    1     0      0;
     0    0        0      0          1    tf    tf^2   tf^3;
     0    0        0      0          0    1   2*tf   3*tf^2];

B = [xo; vxo; xf; vxf; yo; vyo; yf; vyf];

X = inv(A)*B;

a0 = X(1,1); 
a1 = X(2,1);
a2 = X(3,1);
a3 = X(4,1);

b0 = X(5,1); 
b1 = X(6,1);
b2 = X(7,1);
b3 = X(8,1);

x = a0 + a1*(t - to) + a2*(t - to)^2 + a3*(t - to)^3;
y = b0 + b1*(t - to) + b2*(t - to)^2 + b3*(t - to)^3;
end
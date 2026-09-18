function [x, y] = TrajectoryPlanning2(t, Po, Pf, to, tf)

xo = Po(1);
yo = Po(2);

xf = Pf(1);
yf = Pf(2);

% X

A = [0        0        0        0      0    1;
     tf^5     tf^4     tf^3     tf^2   tf   0;
     0        0        0        0      1    0;
   5*tf^4   4*tf^3   3*tf^2   2*tf     0    0;
     0        0        0        2      0    0;
  20*tf^3  12*tf^2   6*tf       0      0    0;];

B = [xo; (xf - xo); 0; 0; 0; 0];

C = inv(A)*B;

a1 = C(1,1); 
a2 = C(2,1);
a3 = C(3,1);
a4 = C(4,1);
a5 = C(5,1);
a6 = C(6,1);

x = a1*(t - to)^5 + a2*(t - to)^4 + a3*(t - to)^3 + a4*(t - to)^2 + a5*(t - to) + a6;

% Y

D = [0        0        0        0      0    1;
     tf^5     tf^4     tf^3     tf^2   tf   0;
     0        0        0        0      1    0;
   5*tf^4   4*tf^3   3*tf^2   2*tf     0    0;
     0        0        0        2      0    0;
  20*tf^3  12*tf^2   6*tf       0      0    0;];

E = [yo; (yf - yo); 0; 0; 0; 0];

F = inv(D)*E;

b1 = F(1,1); 
b2 = F(2,1);
b3 = F(3,1);
b4 = F(4,1);
b5 = F(5,1);
b6 = F(6,1);

y = b1*(t - to)^5 + b2*(t - to)^4 + b3*(t - to)^3 + b4*(t - to)^2 + b5*(t - to) + b6;

end
function T = TransMatrix(a, alpha, d, theta)
t11 = cos(theta); t12 = -sin(theta); t13 = 0; t14 = a;

t21 = sin(theta)*cos(alpha); t22 = cos(theta)*cos(alpha); t23 = -sin(alpha); t24 = -sin(alpha)*d;

t31 = sin(theta)*sin(alpha); t32 = cos(theta)*sin(alpha); t33 = cos(alpha); t34 = cos(alpha)*d;

t41 = 0; t42 = 0; t43 = 0; t44 = 1;

T = [t11 t12 t13 t14;
     t21 t22 t23 t24;
     t31 t32 t33 t34;
     t41 t42 t43 t44];
end
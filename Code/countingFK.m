clear; close; clc;

%% set he so

syms theta1 theta2 d1 d2 l1 l2

%% chan 1 - right up

t01_1 = TransMatrix(d1, pi/2, d2, -theta1);
t12_1 = TransMatrix(l1, 0, 0, -theta2);

p3ee_1 = [l2; 0; 0; 1];

t02_1 = simplify(t01_1*t12_1);
pee_1 = simplify(t02_1*p3ee_1);

disp('---------- chan 1 ----------')

disp('t01_1 = ')
disp(t01_1(:,4))

disp('t02_1 = ')
disp(t02_1(:,4))

disp('pee_1 = ')
disp(pee_1)

%% chan 2 - left up

t01_2 = TransMatrix(d1, -pi/2, d2, theta1);
t12_2 = TransMatrix(l1, 0, 0, theta2);

p3ee_2 = [l2; 0; 0; 1];

t02_2 = simplify(t01_2*t12_2);
pee_2 = simplify(t02_2*p3ee_2);

disp('---------- chan 2 ----------')

disp('t01_2 = ')
disp(t01_2(:,4))

disp('t02_2 = ')
disp(t02_2(:,4))

disp('pee_2 = ')
disp(pee_2)

%% chan 3 - right down

t01_3 = TransMatrix(-d1, pi/2, d2, -theta1);
t12_3 = TransMatrix(l1, 0, 0, -theta2);

p3ee_3 = [l2; 0; 0; 1];

t02_3 = simplify(t01_3*t12_3);
pee_3 = simplify(t02_3*p3ee_3);

disp('---------- chan 3 ----------')

disp('t01_3 = ')
disp(t01_3(:,4))

disp('t02_3 = ')
disp(t02_3(:,4))

disp('pee_3 = ')
disp(pee_3)

%% chan 4 - left down

t01_4 = TransMatrix(-d1, -pi/2, d2, theta1);
t12_4 = TransMatrix(l1, 0, 0, theta2);

p3ee_4 = [l2; 0; 0; 1];

t02_4 = simplify(t01_4*t12_4);
pee_4 = simplify(t02_4*p3ee_4);

disp('---------- chan 4 ----------')

disp('t01_4 = ')
disp(t01_4(:,4))

disp('t02_4 = ')
disp(t02_4(:,4))

disp('pee_4 = ')
disp(pee_4)

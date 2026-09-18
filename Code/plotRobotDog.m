clc; clear; close;

theta1_ru = 120;
theta2_ru = -60;

theta1_lu = 120;
theta2_lu = -60;

theta1_rd = 120;
theta2_rd = -60;

theta1_ld = 120;
theta2_ld = -60;

xo = 0;
yo = 0;
zo = 0;

plot_dog(xo, yo, zo, theta1_ru, theta2_ru, theta1_lu, theta2_lu, theta1_rd, theta2_rd, theta1_ld, theta2_ld)
title('Quadruped Robot')
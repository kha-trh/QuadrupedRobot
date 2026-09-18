function out = plot_dog(xo, yo, zo, theta1_ru, theta2_ru, theta1_lu, theta2_lu, theta1_rd, theta2_rd, theta1_ld, theta2_ld)

[d1, d2, l1] = robot_data;

d3 = 20;

i = constant;

centre = [xo; yo; zo];

%% right up - chan 1

x1_ru = d1;
y1_ru = -d2;
z1_ru = i*d2;

x2_ru = d1 + l1*cosd(theta1_ru);
y2_ru = - d2 - i*l1*sind(theta1_ru);
z2_ru = i*d2 - l1*sind(theta1_ru);

[xee_ru, yee_ru, zee_ru] = FK_right_side_up(theta1_ru, theta2_ru);

%% doi chan 1

x1_ru = x1_ru + centre(1,:);
y1_ru = y1_ru + centre(2,:);
z1_ru = z1_ru + centre(3,:);

x2_ru = x2_ru + centre(1,:);
y2_ru = y2_ru + centre(2,:);
z2_ru = z2_ru + centre(3,:);

xee_ru = xee_ru + centre(1,:);
yee_ru = yee_ru + centre(2,:);
zee_ru = zee_ru + centre(3,:);

%% plot chan 1

plot3([x1_ru, x2_ru, xee_ru], [y1_ru, y2_ru, yee_ru], [z1_ru, z2_ru, zee_ru], "-o", LineWidth=2, Color='#7E2F8E') % tim
hold on

%% left up - chan 2

x1_lu = d1;
y1_lu = d2;
z1_lu = i*d2;

x2_lu = d1 + l1*cosd(theta1_lu);
y2_lu = d2 + i*l1*sind(theta1_lu);
z2_lu = i*d2 - l1*sind(theta1_lu);

[xee_lu, yee_lu, zee_lu] = FK_left_side_up(theta1_lu, theta2_lu);

%% doi chan 2

x1_lu = x1_lu + centre(1,:);
y1_lu = y1_lu + centre(2,:);
z1_lu = z1_lu + centre(3,:);

x2_lu = x2_lu + centre(1,:);
y2_lu = y2_lu + centre(2,:);
z2_lu = z2_lu + centre(3,:);

xee_lu = xee_lu + centre(1,:);
yee_lu = yee_lu + centre(2,:);
zee_lu = zee_lu + centre(3,:);

%% plot chan 2

plot3([x1_lu, x2_lu, xee_lu], [y1_lu, y2_lu, yee_lu], [z1_lu, z2_lu, zee_lu], "-o", LineWidth=2, Color='#A2142F') % do
hold on

%% right down - chan 3

x1_rd = -d1;
y1_rd = -d2;
z1_rd = i*d2;

x2_rd = l1*cosd(theta1_rd) - d1;
y2_rd = - d2 - i*l1*sind(theta1_rd);
z2_rd = i*d2 - l1*sind(theta1_rd);

[xee_rd, yee_rd, zee_rd] = FK_right_side_down(theta1_rd, theta2_rd);

%% doi chan 3

x1_rd = x1_rd + centre(1,:);
y1_rd = y1_rd + centre(2,:);
z1_rd = z1_rd + centre(3,:);

x2_rd = x2_rd + centre(1,:);
y2_rd = y2_rd + centre(2,:);
z2_rd = z2_rd + centre(3,:);

xee_rd = xee_rd + centre(1,:);
yee_rd = yee_rd + centre(2,:);
zee_rd = zee_rd + centre(3,:);

%% plot chan 3

plot3([x1_rd, x2_rd, xee_rd], [y1_rd, y2_rd, yee_rd], [z1_rd, z2_rd, zee_rd], "-o", LineWidth=2, Color='#D95319') % cam
hold on

%% left down - chan 4

x1_ld = -d1;
y1_ld = d2;
z1_ld = i*d2;

x2_ld = l1*cosd(theta1_ld) - d1;
y2_ld = d2 + i*l1*sind(theta1_ld);
z2_ld = i*d2 - l1*sind(theta1_ld);

[xee_ld, yee_ld, zee_ld] = FK_left_side_down(theta1_ld, theta2_ld);

%% doi chan 4

x1_ld = x1_ld + centre(1,:);
y1_ld = y1_ld + centre(2,:);
z1_ld = z1_ld + centre(3,:);

x2_ld = x2_ld + centre(1,:);
y2_ld = y2_ld + centre(2,:);
z2_ld = z2_ld + centre(3,:);

xee_ld = xee_ld + centre(1,:);
yee_ld = yee_ld + centre(2,:);
zee_ld = zee_ld + centre(3,:);

%% plot chan 4

plot3([x1_ld, x2_ld, xee_ld], [y1_ld, y2_ld, yee_ld], [z1_ld, z2_ld, zee_ld], "-o", LineWidth=2, Color='#77AC30') % xanh la
hold on

%% plot chieu cao

plot3([x1_ru, x1_ru], [y1_ru, y1_ru], [z1_ru, z1_ru + d3], "-o", LineWidth=2, Color='#EDB120') % vang
hold on

plot3([x1_lu, x1_lu], [y1_lu, y1_lu], [z1_lu, z1_lu + d3], "-o", LineWidth=2, Color='#EDB120')
hold on

plot3([x1_rd, x1_rd], [y1_rd, y1_rd], [z1_rd, z1_rd + d3], "-o", LineWidth=2, Color='#EDB120')
hold on

plot3([x1_ld, x1_ld], [y1_ld, y1_ld], [z1_ld, z1_ld + d3], "-o", LineWidth=2, Color='#EDB120')
hold on

%% plot than 1

plot3(centre(1,:), centre(2,:), centre(3,:), "o", LineWidth=2, Color='k') % den

plot3([x1_ru, x1_lu, x1_ld, x1_rd, x1_ru], [y1_ru, y1_lu, y1_ld, y1_rd, y1_ru], [z1_ru, z1_lu, z1_ld, z1_rd, z1_ru], "-o", LineWidth=2, Color='#0072BD') % xanh duong
hold on

%% plot than 2

plot3([x1_ru, x1_lu, x1_ld, x1_rd, x1_ru], [y1_ru, y1_lu, y1_ld, y1_rd, y1_ru], [z1_ru + d3, z1_lu + d3, z1_ld + d3, z1_rd + d3, z1_ru + d3], "-o", LineWidth=2, Color='#0072BD') % xanh duong
hold on

%% limit

xlim([-200 200])
ylim([-200 200])
zlim([-200 200])

grid on

out = 0;

end
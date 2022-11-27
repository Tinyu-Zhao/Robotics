clear all;
close all;
clc;

p = rand(1, 3); %待旋转点

quat = eul2quat([0.6, 0.4, 0.5]); %利用欧拉角构造四元数
q_quat = quaternion(quat);
p_quat = quaternion([0, p]);
re_quat = q_quat * p_quat * q_quat'; %利用四元数旋转
[w, a, b, c] = parts(re_quat); %得到四元数中四个数

theta = acos(quat(1)) * 2; %得到旋转弧度和所环绕的向量
kx = quat(2) / sin(theta/2);
ky = quat(3) / sin(theta/2);
kz = quat(4) / sin(theta/2);

K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K; %罗德里格斯公式
p1 = R * p'; %利用罗德里格斯公式计算的旋转后的点

dr = HelperDrawRotation;
figure;
dr.draw3DOrientation(gca, [quat(2:4)], theta*180/pi);

hold on;
plot3(p(1), p(2), p(3), 'bo')
plot3(p1(1), p1(2), p1(3), 'r*')
plot3(a, b, c, 'go');
axis equal;
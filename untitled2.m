p = [2, 0, 0]; %旋转前的点
param = [0, 1, 0, pi / 3]; %分别是kx,ky,kz,theta

kx = param(1);
ky = param(2);
kz = param(3);
theta = param(4);

K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K %罗德里格斯公式
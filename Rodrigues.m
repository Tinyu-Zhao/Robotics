function R = Rodrigues(Kxyz, theta)
%Kxyz为转轴的单位矢量，theta为绕转轴旋转的角度

kx = Kxyz(1); %Kxyz中的第一个元素
ky = Kxyz(2);
kz = Kxyz(3);

%有关单位矢量的斜对称矩阵
K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];

%eye(3) 3x3的单位矩阵
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K; %罗德里格斯公式

end

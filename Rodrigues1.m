function Rodrigues1(theta0)

quat = eul2quat(theta0); %利用三个欧拉角构造四元数
theta = acos(quat(1)) * 2;
%theta = acos(quat(1))*2;            %得到旋转弧度和所环绕的向量
kx = quat(2) / sin(theta/2);
ky = quat(3) / sin(theta/2);
kz = quat(4) / sin(theta/2);

K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K %罗德里格斯公式

end
%dr = HelperDrawRotation;
%figure;
%dr.draw3DOrientation(gca,[quat(2:4)],theta*180/pi);

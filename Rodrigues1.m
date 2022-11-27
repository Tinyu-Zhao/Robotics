function Rodrigues1(theta0)

quat = eul2quat(theta0); %��������ŷ���ǹ�����Ԫ��
theta = acos(quat(1)) * 2;
%theta = acos(quat(1))*2;            %�õ���ת���Ⱥ������Ƶ�����
kx = quat(2) / sin(theta/2);
ky = quat(3) / sin(theta/2);
kz = quat(4) / sin(theta/2);

K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K %�޵����˹��ʽ

end
%dr = HelperDrawRotation;
%figure;
%dr.draw3DOrientation(gca,[quat(2:4)],theta*180/pi);

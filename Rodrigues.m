function R = Rodrigues(Kxyz, theta)
%KxyzΪת��ĵ�λʸ����thetaΪ��ת����ת�ĽǶ�

kx = Kxyz(1); %Kxyz�еĵ�һ��Ԫ��
ky = Kxyz(2);
kz = Kxyz(3);

%�йص�λʸ����б�Գƾ���
K = [0, -kz, ky; ...
    kz, 0, -kx; ...
    -ky, kx, 0];

%eye(3) 3x3�ĵ�λ����
R = eye(3) + sin(theta) * K + (1 - cos(theta)) * K * K; %�޵����˹��ʽ

end

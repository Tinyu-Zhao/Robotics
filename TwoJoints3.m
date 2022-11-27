close all;
clear all;
global uLINK
NONE = 0;
BODY = 1;
RLEG_J0 = 2;
RLEG_J1 = 3;
RLEG_J2 = 4;
RLEG_J3 = 5;
RLEG_J4 = 6;
RLEG_J5 = 7;

uLINK(BODY).name = 'BODY';
uLINK(BODY).sister = NONE;
uLINK(BODY).child = RLEG_J0;
uLINK(BODY).mother = NONE;
uLINK(BODY).p = [0; 0; 4]; %����������ϵ�е�λ��
uLINK(BODY).R = [1, 0, 0; ... %��ת����(��̬)
                0, 1, 0; ...
                0, 0, 1];
uLINK(BODY).b = [0; 0; 0]; %P1���λ��ʸ��
uLINK(BODY).a = [0; 0; 0]; %P1�ؽ���ʸ��(������)
uLINK(BODY).q = 0; %�ؽڽ�,��Ϊ��0���������

uLINK(RLEG_J0).name = 'RLEG_J0';
uLINK(RLEG_J0).sister = 0;
uLINK(RLEG_J0).child = RLEG_J1;
uLINK(RLEG_J0).mother = BODY;
uLINK(RLEG_J0).p = [4; 0; 0];
uLINK(RLEG_J0).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J0).b = [0; -1; 0];
uLINK(RLEG_J0).a = [0; 0; 1];
uLINK(RLEG_J0).q = 0;

uLINK(RLEG_J1).name = 'RLEG_J1';
uLINK(RLEG_J1).sister = NONE;
uLINK(RLEG_J1).child = RLEG_J2;
uLINK(RLEG_J1).mother = RLEG_J0;
uLINK(RLEG_J1).p = [4; 0; 0];
uLINK(RLEG_J1).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J1).b = [0; 0; 0];
uLINK(RLEG_J1).a = [1; 0; 0];
uLINK(RLEG_J1).q = 0;

uLINK(RLEG_J2).name = 'RLEG_J2';
uLINK(RLEG_J2).sister = NONE;
uLINK(RLEG_J2).child = RLEG_J3;
uLINK(RLEG_J2).mother = RLEG_J1;
uLINK(RLEG_J2).p = [4; 0; 0];
uLINK(RLEG_J2).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J2).b = [0; 0; 0];
uLINK(RLEG_J2).a = [0; 1; 0];
uLINK(RLEG_J2).q = 0;

uLINK(RLEG_J3).name = 'RLEG_J3';
uLINK(RLEG_J3).sister = NONE;
uLINK(RLEG_J3).child = RLEG_J4;
uLINK(RLEG_J3).mother = RLEG_J2;
uLINK(RLEG_J3).p = [4; 0; 0];
uLINK(RLEG_J3).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J3).b = [0; 0; -2]; %b�����λ��ʸ��
uLINK(RLEG_J3).a = [0; 1; 0];
uLINK(RLEG_J3).q = 0;

uLINK(RLEG_J4).name = 'RLEG_J4';
uLINK(RLEG_J4).sister = NONE;
uLINK(RLEG_J4).child = RLEG_J5;
uLINK(RLEG_J4).mother = RLEG_J3;
uLINK(RLEG_J4).p = [4; 0; 0];
uLINK(RLEG_J4).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J4).b = [0; 0; -2];
uLINK(RLEG_J4).a = [0; 1; 0];
uLINK(RLEG_J4).q = 0;

uLINK(RLEG_J5).name = 'RLEG_J5';
uLINK(RLEG_J5).sister = NONE;
uLINK(RLEG_J5).child = NONE;
uLINK(RLEG_J5).mother = RLEG_J4;
uLINK(RLEG_J5).p = [0; 0; 0];
uLINK(RLEG_J5).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J5).b = [0; 0; 0];
uLINK(RLEG_J5).a = [1; 0; 0];
uLINK(RLEG_J5).q = 0;
xlim([-1, 6]), ylim([-1, 6])
ForwardKinematics(1)
Draw2D
% % �����仯�ĽǶ���֤���˶�ѧ

% for i = 1:10
%     theta = pi / i;
%     uLINK(RLEG_J2).q = -theta; %����RLEG_J2��ǰ��
%     uLINK(RLEG_J3).q = theta; %����RLEG_J3����
%     ForwardKinematics(1);
%     length1 = norm(uLINK(RLEG_J0).p - uLINK(RLEG_J3).p);
%     length2 = norm(uLINK(RLEG_J3).p - uLINK(RLEG_J4).p);
%     Draw2D
%     pause(0.03)
% end

uLINK(RLEG_J2).q = -pi / 50;
uLINK(RLEG_J3).q = -pi / 50;
ForwardKinematics(1);
Target.p = [2.7321; 0; 2.7321];
Target.R = [1, 0, 0; 0, 1, 0; 0, 0, 1];

Draw2D
q_given = [0, 3, 2, 4, 1; % position
        0, 1.0, 2.0, -2.0, -1.0; % varying velocity
        0, 1, 2, 3, 2, ]'; % varying acceleration
t_given = [0, 0.5, 1, 2, 2.5]'; % time
t = t_given(1):0.01:t_given(end); % time for interpolation

cubic_interpolation = CubicInterpolation('Cubic', q_given, t_given);
cubic_trajectory = zeros(length(t), 3); % N x 3 array: position, velocity, acceleration

for i = 1:length(t)
    cubic_trajectory(i, :) = cubic_interpolation.getPosition(t(i));
end

plot(t, cubic_trajectory(:, 1))

InverseKinematics(RLEG_J4, Target)
length1=zeros(length(t),1);
length2=zeros(length(t),1);
for i = 1:length(t)
    % Q(1, i) = uLINK(RLEG_J0).q;
    % Q(2, i) = uLINK(RLEG_J1).q;
    % Q(3, i) = uLINK(RLEG_J2).q;
    % Q(4, i) = uLINK(RLEG_J3).q;
    % Q(5, i) = uLINK(RLEG_J4).q;
    delete([Tui2,Tui3])
    Target.p(1) = t(i);
    Target.p(2) = -1;
    Target.p(3) = cubic_trajectory(i, 1);
    InverseKinematics(RLEG_J4, Target)
    length1(i) = norm(uLINK(RLEG_J0).p - uLINK(RLEG_J3).p);
    length2(i) = norm(uLINK(RLEG_J3).p - uLINK(RLEG_J4).p);
    Draw2D
    pause(0.06)
end

% % i = 1:length(x);
% % figure, plot(i, Q(1, i), i, Q(2, i), i, Q(3, i), i, Q(4, i), i, Q(5, i))

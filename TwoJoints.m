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
uLINK(BODY).p = [0; 0; 4]; %在世界坐标系中的位置
uLINK(BODY).R = [1, 0, 0; ... %旋转矩阵(姿态)
                0, 1, 0; ...
                0, 0, 1];
uLINK(BODY).b = [0; -1; 0]; %P1相对位置矢量
uLINK(BODY).a = [0; 0; 0]; %P1关节轴矢量(列向量)
uLINK(BODY).q = 0; %关节角,设为非0避免歧义节

uLINK(RLEG_J0).name = 'RLEG_J0';
uLINK(RLEG_J0).sister = 0;
uLINK(RLEG_J0).child = RLEG_J1;
uLINK(RLEG_J0).mother = BODY;
uLINK(RLEG_J0).p = [0; 0; 0];
uLINK(RLEG_J0).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J0).b = [0; 0; 0];
uLINK(RLEG_J0).a = [0; 0; 1];
uLINK(RLEG_J0).q = 0;

uLINK(RLEG_J1).name = 'RLEG_J1';
uLINK(RLEG_J1).sister = NONE;
uLINK(RLEG_J1).child = RLEG_J2;
uLINK(RLEG_J1).mother = RLEG_J0;
uLINK(RLEG_J1).p = [0; 0; 0];
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
uLINK(RLEG_J2).p = [0; 0; 0];
uLINK(RLEG_J2).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J2).b = [0; 0; -2];
uLINK(RLEG_J2).a = [0; 1; 0];
uLINK(RLEG_J2).q = 0;

uLINK(RLEG_J3).name = 'RLEG_J3';
uLINK(RLEG_J3).sister = NONE;
uLINK(RLEG_J3).child = RLEG_J4;
uLINK(RLEG_J3).mother = RLEG_J2;
uLINK(RLEG_J3).p = [0; 0; 0];
uLINK(RLEG_J3).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J3).b = [0; 0; -2]; %b的相对位置矢量
uLINK(RLEG_J3).a = [0; 1; 0];
uLINK(RLEG_J3).q = 0;

uLINK(RLEG_J4).name = 'RLEG_J4';
uLINK(RLEG_J4).sister = NONE;
uLINK(RLEG_J4).child = NONE;
uLINK(RLEG_J4).mother = RLEG_J3;
uLINK(RLEG_J4).p = [0; 0; 0];
uLINK(RLEG_J4).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(RLEG_J4).b = [0; 0; -2];
uLINK(RLEG_J4).a = [0; 1; 0];
uLINK(RLEG_J4).q = 0;

%特殊值验证正运动学,pi,pi/3,pi/4,pi/6
ForwardKinematics(1);
DrawAllJoints()
%连续变化的角度验证正运动学
% for i = 1:10
%     theta = pi / i;
%     uLINK(RLEG_J2).q = -theta; %控制RLEG_J2向前摆
%     uLINK(RLEG_J3).q = theta; %控制RLEG_J3向后摆
%     ForwardKinematics(1);
%     figure, DrawAllJoints()
%     pause(0.6)
% end

uLINK(RLEG_J2).q = -pi / 10;
uLINK(RLEG_J3).q = -pi / 10;
ForwardKinematics(1);
figure, DrawAllJoints()

Target.p = [2.7321; 0; 2.7321];
Target.R = [-0.866025403784439, 0, -0.500000000000000; 0, 1, 0; 0.500000000000000, 0, -0.866025403784439];

% theta = pi / 100;
% % uLINK(RLEG_J3).q = theta;
% % uLINK(LLEG_J3).q = theta;
% %figure, DrawAllJoints()
InverseKinematics(RLEG_J4, Target)
DrawAllJoints()
% % for i = 1:13
% %     X(1, i) = uLINK(i).p(1);
% %     Y(1, i) = uLINK(i).p(2);
% %     Z(1, i) = uLINK(i).p(3);
% % end

% %plot3(X, Y, Z)

R = 2;
cx = 0;
cy = 0;
n = 40;

[x, y] = Circle(R, cx, cy, n);
figure, DrawAllJoints()
Q(1:5, length(x)) = 0;

for i = 1:length(x)
    Q(1, i) = uLINK(RLEG_J0).q; %存储关节的角度
    Q(2, i) = uLINK(RLEG_J1).q;
    Q(3, i) = uLINK(RLEG_J2).q;
    Q(4, i) = uLINK(RLEG_J3).q;
    Q(5, i) = uLINK(RLEG_J4).q;
    Target.p(1) = x(i);
    Target.p(2) = y(i);
    Target.p(3) = 0;
    InverseKinematics(RLEG_J4, Target)
    hold on, DrawAllJoints();
    axis square, plot(i, Q(1, i))
    pause(0.1)
    xlim([-3,3])
    ylim([-3,3])
end

i = 1:length(x);
figure, plot(i, Q(1, i), i, Q(2, i), i, Q(3, i), i, Q(4, i), i, Q(5, i))

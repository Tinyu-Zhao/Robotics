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
LLEG_J0 = 8;
LLEG_J1 = 9;
LLEG_J2 = 10;
LLEG_J3 = 11;
LLEG_J4 = 12;
LLEG_J5 = 13;

uLINK(BODY).name = 'BODY';
uLINK(BODY).sister = NONE;
uLINK(BODY).child = LLEG_J0;
uLINK(BODY).mother = NONE;
uLINK(BODY).p = [0; 0; 0]; %����������ϵ�е�λ��
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
uLINK(RLEG_J0).p = [0; 0; 0];
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
uLINK(RLEG_J2).b = [0; 0; 0];
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
uLINK(RLEG_J3).b = [0; 0; -2]; %b�����λ��ʸ��
uLINK(RLEG_J3).a = [0; 1; 0];
uLINK(RLEG_J3).q = 0;

uLINK(RLEG_J4).name = 'RLEG_J4';
uLINK(RLEG_J4).sister = NONE;
uLINK(RLEG_J4).child = RLEG_J5;
uLINK(RLEG_J4).mother = RLEG_J3;
uLINK(RLEG_J4).p = [0; 0; 0];
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

uLINK(LLEG_J0).name = 'LLEG_J0';
uLINK(LLEG_J0).sister = RLEG_J0;
uLINK(LLEG_J0).child = LLEG_J1;
uLINK(LLEG_J0).mother = BODY;
uLINK(LLEG_J0).p = [0; 0; 0];
uLINK(LLEG_J0).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J0).b = [0; 1; 0];
uLINK(LLEG_J0).a = [0; 0; 1];
uLINK(LLEG_J0).q = 0;

uLINK(LLEG_J1).name = 'LLEG_J1';
uLINK(LLEG_J1).sister = NONE;
uLINK(LLEG_J1).child = LLEG_J2;
uLINK(LLEG_J1).mother = LLEG_J0;
uLINK(LLEG_J1).p = [0; 0; 0];
uLINK(LLEG_J1).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J1).b = [0; 0; 0];
uLINK(LLEG_J1).a = [1; 0; 0];
uLINK(LLEG_J1).q = 0;

uLINK(LLEG_J2).name = 'LLEG_J2';
uLINK(LLEG_J2).sister = NONE;
uLINK(LLEG_J2).child = LLEG_J3;
uLINK(LLEG_J2).mother = LLEG_J1;
uLINK(LLEG_J2).p = [0; 0; 0];
uLINK(LLEG_J2).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J2).b = [0; 0; 0];
uLINK(LLEG_J2).a = [0; 1; 0];
uLINK(LLEG_J2).q = 0;

uLINK(LLEG_J3).name = 'LLEG_J3';
uLINK(LLEG_J3).sister = NONE;
uLINK(LLEG_J3).child = LLEG_J4;
uLINK(LLEG_J3).mother = LLEG_J2;
uLINK(LLEG_J3).p = [0; 0; 0];
uLINK(LLEG_J3).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J3).b = [0; 0; -2];
uLINK(LLEG_J3).a = [0; 1; 0];
uLINK(LLEG_J3).q = 0;

uLINK(LLEG_J4).name = 'LLEG_J4';
uLINK(LLEG_J4).sister = NONE;
uLINK(LLEG_J4).child = LLEG_J5;
uLINK(LLEG_J4).mother = LLEG_J3;
uLINK(LLEG_J4).p = [0; 0; 0];
uLINK(LLEG_J4).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J4).b = [0; 0; -2];
uLINK(LLEG_J4).a = [0; 1; 0];
uLINK(LLEG_J4).q = 0;

uLINK(LLEG_J5).name = 'LLEG_J5';
uLINK(LLEG_J5).sister = NONE;
uLINK(LLEG_J5).child = NONE;
uLINK(LLEG_J5).mother = LLEG_J4;
uLINK(LLEG_J5).p = [0; 0; 0];
uLINK(LLEG_J5).R = [1, 0, 0; ...
                    0, 1, 0; ...
                    0, 0, 1];
uLINK(LLEG_J5).b = [0; 0; 0];
uLINK(LLEG_J5).a = [1; 0; 0];
uLINK(LLEG_J5).q = 0;

%����ֵ��֤���˶�ѧ,pi,pi/3,pi/4,pi/6
ForwardKinematics(1);
DrawAllJoints()
%�����仯�ĽǶ���֤���˶�ѧ
% for i = 1:10
%     theta = pi / i;
%     uLINK(RLEG_J2).q = -theta; %����RLEG_J2��ǰ��
%     uLINK(RLEG_J3).q = theta; %����RLEG_J3����
%     ForwardKinematics(1);
%     figure, DrawAllJoints()
%     pause(0.6)
% end

uLINK(LLEG_J2).q = -pi / 2;
uLINK(LLEG_J3).q = pi / 2;
ForwardKinematics(1);
figure, DrawAllJoints()

Target.p = uLINK(RLEG_J3).p;
Target.p(2) = abs(uLINK(RLEG_J3).p(2));
Target.R = uLINK(RLEG_J3).R;

theta = pi / 100;
% uLINK(RLEG_J3).q = theta;
% uLINK(LLEG_J3).q = theta;
%figure, DrawAllJoints()
InverseKinematics(LLEG_J4, Target)
figure, DrawAllJoints()
% for i = 1:13
%     X(1, i) = uLINK(i).p(1);
%     Y(1, i) = uLINK(i).p(2);
%     Z(1, i) = uLINK(i).p(3);
% end

%plot3(X, Y, Z)

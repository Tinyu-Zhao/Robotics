clear
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

uLINK(1).name = 'BODY';
uLINK(1).sister = NONE;
uLINK(1).child = RLEG_J0;
uLINK(1).mother = NONE;
uLINK(1).p = [0; 2; 5]; %在世界坐标系中的位置
uLINK(1).R = [1, 0, 0; ... %旋转矩阵(姿态)
    0, 1, 0; ...
    0, 0, 1];
uLINK(1).b = [0; 0; 0]; %P1相对位置矢量
uLINK(1).a = [0; 0; 0]; %P1关节轴矢量(列向量)
uLINK(1).q = pi / 2; %关节角,设为非0避免歧义节

uLINK(2).name = 'RLEG_J0';
uLINK(2).sister = LLEG_J0;
uLINK(2).child = RLEG_J1;
uLINK(2).mother = BODY;
uLINK(2).p = [0; -1; 5];
uLINK(2).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(2).b = [0; -1; 0];
uLINK(2).a = [0; 0; 1];
uLINK(2).q = pi / 2;

uLINK(3).name = 'RLEG_J1';
uLINK(3).sister = NONE;
uLINK(3).child = RLEG_J2;
uLINK(3).mother = RLEG_J0;
uLINK(3).p = [0; -1; 3];
uLINK(3).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(3).b = [0; 0; 0];
uLINK(3).a = [1; 0; 0];
uLINK(3).q = pi / 2;

uLINK(4).name = 'RLEG_J2';
uLINK(4).sister = NONE;
uLINK(4).child = RLEG_J3;
uLINK(4).mother = RLEG_J1;
uLINK(4).p = [0; 4; 5];
uLINK(4).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(4).b = [0; 0; 0];
uLINK(4).a = [0; 1; 0];
uLINK(4).q = pi / 2;

uLINK(5).name = 'RLEG_J3';
uLINK(5).sister = NONE;
uLINK(5).child = RLEG_J4;
uLINK(5).mother = RLEG_J2;
uLINK(5).p = [0; 4; 5];
uLINK(5).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(5).b = [0; -1; -2]; %b的相对位置矢量
uLINK(5).a = [1; 0; 0];
uLINK(5).q = pi / 2;

uLINK(6).name = 'RLEG_J4';
uLINK(6).sister = NONE;
uLINK(6).child = RLEG_J5;
uLINK(6).mother = RLEG_J3;
uLINK(6).p = [0; 0; 2];
uLINK(6).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(6).b = [0; -1; -4];
uLINK(6).a = [0; 1; 0];
uLINK(6).q = pi / 2;

uLINK(7).name = 'RLEG_J5';
uLINK(7).sister = NONE;
uLINK(7).child = NONE;
uLINK(7).mother = RLEG_J4;
uLINK(7).p = [0; 0; 0];
uLINK(7).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(7).b = [0; 0; 0];
uLINK(7).a = [1; 0; 0];
uLINK(7).q = pi / 2;

uLINK(8).name = 'LLEG_J0';
uLINK(8).sister = RLEG_J0;
uLINK(8).child = LLEG_J1;
uLINK(8).mother = BODY;
uLINK(8).p = [0; 5; 2];
uLINK(8).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(8).b = [0; 1; 0];
uLINK(8).a = [0; 0; 1];
uLINK(8).q = pi / 2;

uLINK(9).name = 'LLEG_J1';
uLINK(9).sister = NONE;
uLINK(9).child = LLEG_J2;
uLINK(9).mother = LLEG_J0;
uLINK(9).p = [0; 5; 0];
uLINK(9).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(9).b = [0; 0; 0];
uLINK(9).a = [1; 0; 0];
uLINK(9).q = pi / 2;

uLINK(10).name = 'LLEG_J2';
uLINK(10).sister = NONE;
uLINK(10).child = LLEG_J3;
uLINK(10).mother = LLEG_J1;
uLINK(10).p = [0; 5; 0];
uLINK(10).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(10).b = [0; 0; 0];
uLINK(10).a = [0; 1; 0];
uLINK(10).q = pi / 2;

uLINK(11).name = 'LLEG_J3';
uLINK(11).sister = NONE;
uLINK(11).child = LLEG_J4;
uLINK(11).mother = LLEG_J2;
uLINK(11).p = [0; 5; 0];
uLINK(11).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(11).b = [0; 1; -2];
uLINK(11).a = [0; 1; 0];
uLINK(11).q = pi / 2;

uLINK(12).name = 'LLEG_J4';
uLINK(12).sister = NONE;
uLINK(12).child = LLEG_J5;
uLINK(12).mother = LLEG_J3;
uLINK(12).p = [0; 5; 0];
uLINK(12).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(12).b = [0; 1; -4];
uLINK(12).a = [0; 1; 0];
uLINK(12).q = pi / 2;

uLINK(13).name = 'LLEG_J5';
uLINK(13).sister = NONE;
uLINK(13).child = NONE;
uLINK(13).mother = LLEG_J4;
uLINK(13).p = [0; 5; 0];
uLINK(13).R = [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];
uLINK(13).b = [0; 0; 0];
uLINK(13).a = [1; 0; 0];
uLINK(13).q = pi / 2;


Target.p = [0; 10; 0];
Target.R = [4, 0, 0; ...
    0, 4, 0; ...
    0, 0, 4];

%InverseKinematics(RLEG_J5, Target)

for i=1:13
    X(1,i)=uLINK(i).p(1);
    Y(1,i)=uLINK(i).p(2);
    Z(1,i)=uLINK(i).p(3);
end

plot3(X,Y,Z)
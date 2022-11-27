function ForwardKinematics(j)
%连杆的正运动学计算(根据关节角求位姿)，求每个连杆的位姿(旋转矩阵)
global uLINK

if j == 0
    return;
end

if j ~= 1
    i = uLINK(j).mother;
    uLINK(j).p = uLINK(i).R * uLINK(j).b + uLINK(i).p;
    uLINK(j).R = uLINK(i).R * Rodrigues(uLINK(j).a, uLINK(j).q);
end

ForwardKinematics(uLINK(j).child);
ForwardKinematics(uLINK(j).sister);
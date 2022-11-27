function ForwardKinematics(j)
%连杆的正运动学计算(根据关节角求位姿)，求每个连杆的位姿(旋转矩阵)
global uLINK
% persistent tmp;
% if isempty(tmp)
%     tmp = 1;
% end

if j == 0
    return;
end

if j ~= 1
    i = uLINK(j).mother;
    uLINK(j).p = uLINK(i).R * uLINK(j).b + uLINK(i).p;
    uLINK(j).R = uLINK(i).R * Rodrigues(uLINK(j).a, uLINK(j).q);
end

% if j == 2 || j == 8
%     tmp = tmp + 1;
%     if tmp == 4
%         j = j + 1;
%         tmp = 1;
%     end
% end

ForwardKinematics(uLINK(j).sister);
ForwardKinematics(uLINK(j).child);
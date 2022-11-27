function ForwardKinematics(j)
%速度的计算
global uLINK
if j == 0
    return;
end
if j ~= 1
    i = uLINK(j).mother;
    uLINK(j).v = uLINK(i).v + cross(uLINK(i).w, uLINK(i).R*uLINK.(b));
    uLINK(j).w = uLINK(i).w * Rodrigues(uLINK(j).a+uLINK(j).q);
end
ForwardKinematics(uLINK(j).sister);
ForwardKinematics(uLINK(j).child);
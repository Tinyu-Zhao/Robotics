function J = CalcJacobian(idx) %idx为由FindRout计算出的行向量
%计算雅可比(由idx中各个关节的微小位移和转动造成的总位移和转动)
global uLINK

jsize = length(idx); %idx中元素的个数即有多少个关节,雅可比矩阵大小=6 x 关节数
target = uLINK(idx(end)).p; %idx中的最后一个元素在∑W中的位置,即末端连杆的在∑W中的位置
J = zeros(6, jsize); %创建一个大小为6xjsize的全零矩阵

for n = 1:jsize
    j = idx(n); %idx中的第n个元素
    mom = uLINK(j).mother;
    a = uLINK(mom).R * uLINK(j).a; %∑W中第j个元素的关节轴矢量
    J(:, n) = [cross(a, target-uLINK(j).p); a]; %a与target-uLINK(j).p的叉积 [target-uLINK(j).p]为末端连杆到关节j的距离
    %[cross(a1, target-uLINK(j).p),cross(a2, target-uLINK(j).p)]
    %[             a1             ,             a2             ]
end 
function InverseKinematics(to, Target) %计算从指定关节to出发,到Target的逆运动学数值解
%逆运动学运算过程中，会不断调整从BODY到指定关节to之间的关节角，以到达目标Target
%逆运动学的数值解法:
%从指定关节出发,给定目标位置,假定一个关节角,用正运动学求解其位姿,
%计算此位姿距目标位姿的误差,并给一个新关节角(关节角修正量,由雅可比矩阵求的)减小误差,并不断重复

global uLINK
lambda = 0.9;
ForwardKinematics(1); %连杆的正运动学计算(根据关节角求位姿)，求每个连杆的位姿(旋转矩阵)
%由于1为BODY母连杆,可递归算出所有连杆的位姿
idx = FindRoute(to); %返回以躯干BODY为基准到的目标连杆to的编号
for n = 1:10
    J = CalcJacobian(idx); %计算由idx中各个关节的微小位移和转动造成的总位移和转动
    err = CalcVWerr(Target, uLINK(to)); %Target为选定的一个位置,包含位置p和姿态R; to为指定的关节
    if norm(err) < 1E-6 %如果误差足够小
        return; %跳过下列程序
    end
    dq = lambda * (J \ err); %求取关节角修正量Δq(2.70); x = J\err 是方程 J*x = err 的解
    for nn = 1:length(idx)
        j = idx(nn);
        uLINK(j).q = uLINK(j).q + dq(nn); %新关节角q=原始关节角q+关节角修正量Δq
    end
    ForwardKinematics(1); %所有连杆的正运动学计算
end
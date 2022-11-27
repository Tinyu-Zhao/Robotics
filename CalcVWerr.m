function err = CalcVWerr(Cref, Cnow)
%位置和姿态的误差计算函数
%计算从Cref 到Cnow的误差

perr = Cref.p - Cnow.p; %位置误差Δp
Rerr = Cnow.R^-1 * Cref.R;  %姿态误差ΔR
werr = Cnow.R * rot2omega(Rerr); %关节的变化 R*w
err = [perr; werr]; %返回误差列向量[位置误差Δp,姿态误差ΔR]
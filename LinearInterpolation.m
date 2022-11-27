classdef LinearInterpolation < handle

    properties %类属性名称
        name = 'linear interpolation';
        q_via = [];
        t_via = [];
    end

    methods
        % crate the objective
        % name: string
        % q_via: N x 3 array
        % t_via: N x 1 array
        function obj = LinearInterpolation(name, q_via, t_via)
            obj.name = name;
            obj.q_via = q_via;
            obj.t_via = t_via;

            if size(q_via(:, 1)) ~= length(t_via) %保证q_via和t_via的长度相等,即每个点都有其对应的坐标
                error('The q_via and t_via must have a same length');
            end

        end

        % 两点之间的线性插值相关计算
        % q0: 第一个数据点
        % q1: 第二个数据点
        % t0: 第一个数据点的时间
        % t1: 第二个数据点的时间
        % a0表示初始时刻的位置,a1表示斜率
        function [a0, a1] = linear(obj, q0, q1, t0, t1)

            if abs(t0 - t1) < 1e-6
                error('t0 and t1 must be different');
            end

            a0 = q0; %初始时刻的位置
            a1 = (q1 - q0) / (t1 - t0); %两点间的斜率
        end

        % 获取两个点之间的所有线性插值
        % t: 指定时间
        % q: 1 x 3 array, output of the interpolation at time t
        function q = getPosition(obj, t)

            %判断时间数组是否按顺序排列
            if (t < obj.t_via(1)) || (t > obj.t_via(end))
                error('The specific time error, time ranges error');
            end

            %查找前1个非0索引
            j = find(obj.t_via >= t, 1, 'first'); % find the index of t1

            if j == 1
                i = 1;
                j = 2;
            else
                i = j - 1;
            end

            % position
            q0 = obj.q_via(i, 1);
            t0 = obj.t_via(i);
            q1 = obj.q_via(j, 1);
            t1 = obj.t_via(j);
            [a0, a1] = obj.linear(q0, q1, t0, t1); %计算q0和q1的起始位置和斜率
            q(1, 1) = a0 + a1 * (t - t0); %

            % velocity
            q(1, 2) = a1;

            % acceleration
            q(1, 3) = 0; % for linear model, the acceleration is infinite, here we set to zero
        end

    end

end

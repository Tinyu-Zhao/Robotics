clear;
close all;

%% Specify the data point
% q_given = [0, 1.6, 3.2, 2, 4, 0.2, 1.2; % position
%         0, 0, 0, 0, 0, 0, 0; % zero velocity
%         0, 0, 0, 0, 0, 0, 0]'; % zero acceleration

q_given = [0, 1.6, 3.2, 2, 4, 0.2, 1.2; % position
        0, 1.0, 2.0, -2.0, -1.0, 0, 0; % varying velocity
        0, 1, 2, 3, 2, 1, 0]'; % varying acceleration

t_given = [0, 1, 3, 4.5, 6, 8, 10]'; % time

% time for interpolation
t = t_given(1):0.01:t_given(end);

%% ************************ Cubic interpolation ******************************
cubic_interpolation = CubicInterpolation('Cubic', q_given, t_given);
cubic_trajectory = zeros(length(t), 3); % N x 3 array: position, velocity, acceleration

for i = 1:length(t)
    cubic_trajectory(i, :) = cubic_interpolation.getPosition(t(i));
end

figure('position', [260, 200, 800, 600])
subplot(3, 1, 1)
hold on
plot(t_given, q_given(:, 1), 'ro')
plot(t, cubic_trajectory(:, 1), 'k')
hold off
grid on
title('Cubic interpolation')
xlabel('time')
ylabel('position')
xlim([t_given(1) - 1, t_given(end) + 1])
ylim([min(q_given(:, 1)) - 1, max(q_given(:, 1)) + 1])

subplot(3, 1, 2)
hold on
plot(t_given, q_given(:, 2), 'ro')
plot(t, cubic_trajectory(:, 2), 'k')
hold off
grid on
xlabel('time')
ylabel('velocity')
xlim([t_given(1) - 1, t_given(end) + 1])

subplot(3, 1, 3)
hold on
plot(t_given, q_given(:, 3), 'ro')
plot(t, cubic_trajectory(:, 3), 'k')
hold off
grid on
xlabel('time')
ylabel('acceleration')
xlim([t_given(1) - 1, t_given(end) + 1])

clear all;
clc;
close all;
fig = figure;
myinit;

ForwardKinematics(11)

% for i = 1:13
%     X(1, i) = uLINK(i).p(1);
%     Y(1, i) = uLINK(i).p(2);
%     Z(1, i) = uLINK(i).p(3);
%     plot(X, Y, 'LineWidth', 3)
% drawnow;
% pause(0.5);
% end

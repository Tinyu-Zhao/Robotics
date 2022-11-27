function [x, y] = Circle(R, cx, cy, nb_pts)
    % R为半径,(cx,cy)为圆心坐标,n为圆周上的点数
    alpha = 0:pi / nb_pts:2 * pi; %角度[0,2*pi]
    %R=2;%半径
    x = R * cos(alpha) + cx;
    y = R * sin(alpha) + cy;
    plot(cx, cy, 'r+', x, y);
    grid on;
    axis equal;
end

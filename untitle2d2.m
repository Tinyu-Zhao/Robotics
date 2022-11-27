x = 0:0.01:1;
n = 0:0.2:3;
nImages = length(n);
fig = figure;
filename = 'test1.gif';

for idx = 1:nImages
    y = x.^n(idx);
    plot(x, y, 'LineWidth', 3)

    frame = getframe(fig); % getframe：捕获坐标区或图窗作为影片帧
    im = frame2im(frame); % frame2im：从单个影片帧 F 返回真彩色 (RGB) 图像
    [A, map] = rgb2ind(im, 256); % rgb2ind：将 RGB 图像转换为索引图像

    if idx == 1
        % LoopCount：重复动画次数
        % DelayTime=1：每个动画图像的时滞为一秒
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 1);
    else
        % WriteMode=append：将多个图像添加到第一个图像中
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end

end

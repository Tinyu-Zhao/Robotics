x = 0:0.01:1;
n = 0:0.2:3;
nImages = length(n);
fig = figure;
filename = 'test1.gif';

for idx = 1:nImages
    y = x.^n(idx);
    plot(x, y, 'LineWidth', 3)

    frame = getframe(fig); % getframe��������������ͼ����ΪӰƬ֡
    im = frame2im(frame); % frame2im���ӵ���ӰƬ֡ F �������ɫ (RGB) ͼ��
    [A, map] = rgb2ind(im, 256); % rgb2ind���� RGB ͼ��ת��Ϊ����ͼ��

    if idx == 1
        % LoopCount���ظ���������
        % DelayTime=1��ÿ������ͼ���ʱ��Ϊһ��
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 1);
    else
        % WriteMode=append�������ͼ����ӵ���һ��ͼ����
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end

end

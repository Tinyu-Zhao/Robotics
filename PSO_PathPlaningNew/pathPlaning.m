function varargout = pathPlaning(varargin)
% Description: ������·���滮�û����� (����Ⱥ�㷨+Bezier)
% Author��Yang
% Version:0.0.1
% Others:
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pathPlaning_OpeningFcn, ...
                   'gui_OutputFcn',  @pathPlaning_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% --- ���漰���ݳ�ʼ������
function pathPlaning_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);
% ����axes��������ķ�Χ
set(handles.axes1,'XLim',[0 12000],'YLim',[0 12000]);
axis square
hold on
global lastPosi_Draw curenPosi_Draw   %����ԲʱԲ������ֹλ�õ�����
global draw_ok_flag                   %������ɱ�־
global barriers_num barriers_info_buf % �ϰ���ĸ��� �� �ϰ�����Ϣ����
global add_barrier_flag               % ���°�ť����ϰ���ı�־
global P0 P1                          % ·����������յ�
global PSO_barriers_num               % �Ż�ʱ���ϰ���ĸ���
global x_spots y_spots                % �ϰ���ĺ��������
global D_safe                         % ��ȫ����
global num_ba                         % �ϰ������������
lastPosi_Draw = zeros(1,2);
curenPosi_Draw = zeros(1,2);
draw_ok_flag = 0;
barriers_info_buf = zeros(20,3);
barriers_num = 0;
add_barrier_flag = 0;
P0 =zeros(1,2);%·������ʼ��
P1 =zeros(1,2);%·�����յ�
x_spots = [];
y_spots = [];
PSO_barriers_num = 0;
D_safe = 2;
num_ba = 0;
function varargout = pathPlaning_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- ��갴��ʱ�Ļص����� (�����ϰ���)
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
global lastPosi_Draw draw_ok_flag
global add_barrier_flag
if add_barrier_flag
    mouse_posi = get(gca,'CurrentPoint');
    if mouse_posi(1,1)>0 && mouse_posi(1,1)<12000 && mouse_posi(1,2)>0 && mouse_posi(1,2)<12000
        lastPosi_Draw(1,1) = mouse_posi(1,1);%��¼��갴�µ�λ��
        lastPosi_Draw(1,2) = mouse_posi(1,2);%
    end
    draw_ok_flag = 0;
end
% --- ��귢���ƶ�ʱ�Ļص�����.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
global draw_ok_flag lastPosi_Draw
global barriers_num barriers_info_buf
global add_barrier_flag
if ~draw_ok_flag && add_barrier_flag  %û����ӳɹ� ����ʾ
    cla
    % ����GUI��axes�ؼ�����
    axes(handles.axes1);
    set(handles.axes1,'XLim',[0 12000],'YLim',[0 12000]);
    theta = 0:2*pi/50:2*pi;
    %�����ϴε���ʷ����
    for index = 1:barriers_num
        x_dybamic=barriers_info_buf(index,2)+sin(theta)*barriers_info_buf(index,1);
        y_dybamic=barriers_info_buf(index,3)+cos(theta)*barriers_info_buf(index,1);
        plot(x_dybamic,y_dybamic,'*b');
        hold on
    end
    mouse_posi = get(gca,'CurrentPoint');
    
    r = sqrt((mouse_posi(1,1)-lastPosi_Draw(1,1))^2 + (mouse_posi(1,2)-lastPosi_Draw(1,2))^2);
    x_dybamic=lastPosi_Draw(1,1)+sin(theta)*r;
    y_dybamic=lastPosi_Draw(1,2)+cos(theta)*r;
    plot(x_dybamic,y_dybamic,'*b');
end
% --- �����������ֺ�Ļص�����
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
global curenPosi_Draw lastPosi_Draw draw_ok_flag
global barriers_num barriers_info_buf
global add_barrier_flag
if add_barrier_flag
    mouse_posi = get(gca,'CurrentPoint');
    if mouse_posi(1,1)>0 && mouse_posi(1,1)<12000 && mouse_posi(1,2)>0 && mouse_posi(1,2)<12000
        curenPosi_Draw(1,1) = mouse_posi(1,1);%��¼��갴�µ�λ��
        curenPosi_Draw(1,2) = mouse_posi(1,2);%
    end
        axes(handles.axes1);
        set(handles.axes1,'XLim',[0 12000],'YLim',[0 12000]);
        theta = 0:2*pi/50:2*pi;
        r = sqrt((curenPosi_Draw(1,1)-lastPosi_Draw(1,1))^2 + (curenPosi_Draw(1,2)-lastPosi_Draw(1,2))^2);
        x_dybamic=lastPosi_Draw(1,1)+sin(theta)*r;
        y_dybamic=lastPosi_Draw(1,2)+cos(theta)*r;
        plot(x_dybamic,y_dybamic,'*b');
        %��¼�ϰ������Ϣ(Բ������ �뾶)
        barriers_num = barriers_num+1;
        barriers_info_buf(barriers_num,1) = r;
        barriers_info_buf(barriers_num,2) = lastPosi_Draw(1,1);
        barriers_info_buf(barriers_num,3) = lastPosi_Draw(1,2);
        hold on
        draw_ok_flag = 1;
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% ����������ϰ���
global curenPosi_Draw lastPosi_Draw draw_ok_flag
global barriers_num barriers_info_buf
global add_barrier_flag
global x_spots y_spots % �ϰ���ĺ�������㡢
global PSO_barriers_num
global num_ba
add_barrier_flag = 0;
triangle_corner = ginput(3);
% line 1-2 ginput 1-2
axes(handles.axes1);

k1 = (triangle_corner(2,2)- triangle_corner(1,2))/(triangle_corner(2,1)- triangle_corner(1,1));
b1 = triangle_corner(2,2)-k1*triangle_corner(2,1);
x1 = triangle_corner(1,1):(triangle_corner(2,1)-triangle_corner(1,1))/50:triangle_corner(2,1);
y1 = k1.*x1+b1;

% line 1-3
k2 = (triangle_corner(3,2)- triangle_corner(1,2))/(triangle_corner(3,1)- triangle_corner(1,1));
b2 = triangle_corner(3,2)-k2*triangle_corner(3,1);
x2 = triangle_corner(3,1):(triangle_corner(1,1)-triangle_corner(3,1))/50:triangle_corner(1,1);
y2 = k2.*x2+b2;
% line 2-3
k3 = (triangle_corner(2,2)- triangle_corner(3,2))/(triangle_corner(2,1)- triangle_corner(3,1));
b3 = triangle_corner(2,2)-k3*triangle_corner(2,1);
x3 = triangle_corner(2,1):(triangle_corner(3,1)-triangle_corner(2,1))/50:triangle_corner(3,1);
y3 = k3.*x3+b3;

% plot lines
plot(x1,y1,'*b');
hold on

plot(x2,y2,'*b');
hold on

plot(x3,y3,'*b');
hold on

x1 = x1./100;
y1 = y1./100;

x2 = x2./100;
y2 = y2./100;

x3 = x3./100;
y3 = y3./100;
x_spots = [x_spots,x1];
y_spots = [y_spots,y1];

x_spots = [x_spots,x2];
y_spots = [y_spots,y2];

x_spots = [x_spots,x3];
y_spots = [y_spots,y3];

[m,n] = size(x_spots);
num_ba = num_ba+n


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% ��Ӿ����ϰ���
global curenPosi_Draw lastPosi_Draw draw_ok_flag
global barriers_num barriers_info_buf
global add_barrier_flag
global x_spots y_spots % �ϰ���ĺ�������㡢
global PSO_barriers_num
global num_ba
add_barrier_flag = 0;
corners = ginput(2);
% line 1-2 ginput 1-2
axes(handles.axes1);
y1 = corners(1,2):(corners(2,2)-corners(1,2))/20:corners(2,2);
[m n] = size(y1);
x1 = ones(1,n)*corners(1,1);

x2 = corners(1,1):(corners(2,1)-corners(1,1))/20:corners(2,1);
[m n] = size(x2);
y2 = ones(1,n)*corners(1,2);

y3 = corners(1,2):(corners(2,2)-corners(1,2))/20:corners(2,2);
[m n] = size(y3);
x3 = ones(1,n)*corners(2,1);

x4 = corners(1,1):(corners(2,1)-corners(1,1))/20:corners(2,1);
[m n] = size(x4);
y4 = ones(1,n)*corners(2,2);

plot(x1,y1,'*b');
hold on

plot(x2,y2,'*b');
hold on

plot(x3,y3,'*b');
hold on

plot(x4,y4,'*b');
hold on

x1 = x1./100;
y1 = y1./100;

x2 = x2./100;
y2 = y2./100;

x3 = x3./100;
y3 = y3./100;

x4 = x4./100;
y4 = y4./100;
x_spots = [x_spots,x1];
y_spots = [y_spots,y1];

x_spots = [x_spots,x2];
y_spots = [y_spots,y2];

x_spots = [x_spots,x3];
y_spots = [y_spots,y3];

x_spots = [x_spots,x4];
y_spots = [y_spots,y4];
% 
[m,n] = size(x_spots);
num_ba = num_ba+n

% --- �������¿�ʼ����ϰ���
function pushbutton1_Callback(hObject, eventdata, handles)
global add_barrier_flag
add_barrier_flag = 1;
% --- ��������ֹͣ����ϰ���
function endAddBarrier_Callback(hObject, eventdata, handles)
global add_barrier_flag
add_barrier_flag = 0;

% �˳�����
function exit_Callback(hObject, eventdata, handles)
button=questdlg('Are you sure to Exit��','Close message','Yes','No','Yes');
switch button
    case 'Yes'
        clear global
        clear
        close
    case 'No'
        return
end
% --- ��������ִ��·���滮������
function pushbutton3_Callback(hObject, eventdata, handles)
global P0 P1
N = 30;   %��Ⱥ��ģ
D = 4;    %��Ⱥά��
Iter_max = 50; 
c1 = 2;
c2 = 2;
v_max = 4;
W_max = 0.9;
W_min = 0.1;
%______________________________________________
Period = zeros(1,D);  % ��¼�ϴε�����������Ӧ��ֵ
n = 6;   % �ٶȱ�������
Iter_current = 0;  % ��ǰ����������ʼ��

%% -------------- ��ʼ����Ⱥ���壨λ�ú��ٶȣ�---------------------
x = randn(N,D);
v = randn(N,D);
%--------Compute Particle's fitness>>By the function of my_fitness------
P_best = zeros(1,N);
y =zeros(N,D);
for i = 1:N
    P_best(i) = my_fitness( x(i,:));  % ���弫ֵ
    y(i,:) = x(i,:);                  %���Ž��λ��
end
G_best = x(N,:);      % Global optimum ȫ�����Ž�
for i=1:(N-1)
    if my_fitness(x(i,:)) < my_fitness(G_best)
        G_best = x(i,:);
    end
end
%% Process of iteration. main code! 
h = waitbar(0,'Please wait...');
while Iter_current < Iter_max
    Iter_current = Iter_current+1;
    w = W_max-(W_max-W_min)./Iter_max.*Iter_current;
    for i=1:N
        v(i,:) = w.*v(i,:)+c1.*rand.*(y(i,:)-x(i,:))+c2.*rand.*(G_best-x(i,:));
        x(i,:) = x(i,:)+v(i,:);
        v(i,:) = check_v(v(i,:),v_max); % ������ӵ��ٶȣ����Ұ��ٶ�������v_max��-v_max֮��
        if my_fitness(x(i,:))<P_best(i)
            P_best(i) = my_fitness(x(i,:));
            y(i,:) = x(i,:);
        end
        if P_best(i)<my_fitness(G_best)
            Period = G_best;   % ��¼�ϴε��������Ž⣬Ϊ���Ż��ٶ�
            G_best = y(i,:);
%                     suoyou = [suoyou,G_best];
        end
        if my_fitness(G_best)<my_fitness(Period)
           v(i,:) = n.*v(i,:); 
        else
            v(i,:) = -n.*v(i,:);
        end
    end
        waitbar(Iter_current/Iter_max,h,['Please wait...',num2str(2*Iter_current),'%']);
end
close(h);
x11 = G_best(1)*100; x21 = G_best(3)*100;
y11 = G_best(2)*100; y21 = G_best(4)*100;
x0 = P0(1)*100;
y0 = P0(2)*100;
x1 = P1(1)*100;
y1 = P1(2)*100;
tt = 0:1/79:1;
x_t1 = (-x0+3.*x11-3.*x21+x1).*tt.^3+(3.*x0-6.*x11+3.*x21).*tt.^2+(-3.*x0+3.*x11).*tt+x0;
y_t1 = (-y0+3.*y11-3.*y21+y1).*tt.^3+(3.*y0-6.*y11+3.*y21).*tt.^2+(-3.*y0+3.*y11).*tt+y0;
        %% ����·�����ݺͳ�����Ϣ����
        plot(x_t1,y_t1,'.r')    %  ·������
        hold on
function [ f ] = my_fitness( x )
warning off
global x_pass x_spots y_spots num_ba P0 P1 D_safe
x_pass = x;
a1  = 1;
a2 = 1;
x0 = P0(1);
y0 = P0(2);
x1 = P1(1);
y1 = P1(2);
x11 = x(1); x21 = x(3);
y11 = x(2); y21 = x(4); 
tt = 0:1/99:1;
x_t1 = (-x0+3.*x11-3.*x21+x1).*tt.^3+(3.*x0-6.*x11+3.*x21).*tt.^2+(-3.*x0+3.*x11).*tt+x0;  
y_t1 = (-y0+3.*y11-3.*y21+y1).*tt.^3+(3.*y0-6.*y11+3.*y21).*tt.^2+(-3.*y0+3.*y11).*tt+y0;
% ---------------------����Լ��-----------------
d_min_oi = zeros(1,num_ba);
    for i=1:num_ba
        d_oi1 = sqrt((x_t1-x_spots(i)).^2+(y_t1-y_spots(i)).^2);
        d_min_oi(i) = min(d_oi1);
    end    
d_min = min(d_min_oi); % ��С����
     if d_min>D_safe
         f_safe = 0;                
     else
          f_safe =(1-d_min./D_safe).^2;
     end
% -----------------����Լ�� -------------------- 
%   �Ż����ֺ�������Ϊֱ�߶εĳ������
tt = 0:1/19:1;
x_suml = (-x0+3.*x11-3.*x21+x1).*tt.^3+(3.*x0-6.*x11+3.*x21).*tt.^2+(-3.*x0+3.*x11).*tt+x0;  
y_suml = (-y0+3.*y11-3.*y21+y1).*tt.^3+(3.*y0-6.*y11+3.*y21).*tt.^2+(-3.*y0+3.*y11).*tt+y0;
com_arr = [x_suml',y_suml'];
X = zeros(1,length(com_arr)-1);
for i=1:length(com_arr)-1
        X(i)=norm(com_arr(i,:)-com_arr(i+1,:));
end
L = sum(X(:));
L_min = sqrt((x1-x0)^2+(y1-y0)^2);
%     L = integral(@Tran_fcn,0,1);
f_len = (1-L_min/L)^2;
% -----------------�ܵķ�����Ϊ-----------------
f = a1*f_safe+a2*f_len;

function v = check_v( v,v_max)
v(v > v_max ) = v_max;
v(v < -v_max ) = -v_max;


% --- ѡ��·������ʼ��
function pushbutton4_Callback(hObject, eventdata, handles)
global x_spots y_spots % �ϰ���ĺ�������㡢
global barriers_num barriers_info_buf
global PSO_barriers_num
global num_ba
set_Start_End = ginput(2);
global P0 P1
P0(1,1) = set_Start_End(1,1)/100;
P0(1,2) = set_Start_End(1,2)/100;
P1(1,1) = set_Start_End(2,1)/100;
P1(1,2) = set_Start_End(2,2)/100;
if PSO_barriers_num~=barriers_num
    % ͳ���ϰ�����Ϣ
    theta = 0:2*pi/50:2*pi;
    [temp spot_num] = size(theta);
    %�����ϴε���ʷ����
    for index = 1:barriers_num
        x_dybamic=(barriers_info_buf(index,2)+sin(theta)*barriers_info_buf(index,1))./100;
        y_dybamic=(barriers_info_buf(index,3)+cos(theta)*barriers_info_buf(index,1))./100;
        x_spots = [x_spots,x_dybamic];
        y_spots = [y_spots,y_dybamic];
    end
    PSO_barriers_num = barriers_num;
    num_ba = length(x_spots);           %��¼�ϰ�����������    
end

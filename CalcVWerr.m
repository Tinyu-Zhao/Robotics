function err = CalcVWerr(Cref, Cnow)
%λ�ú���̬�������㺯��
%�����Cref ��Cnow�����

perr = Cref.p - Cnow.p; %λ����p
Rerr = Cnow.R^-1 * Cref.R;  %��̬��R
werr = Cnow.R * rot2omega(Rerr); %�ؽڵı仯 R*w
err = [perr; werr]; %�������������[λ����p,��̬��R]
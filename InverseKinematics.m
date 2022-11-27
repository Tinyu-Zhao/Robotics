function InverseKinematics(to, Target) %�����ָ���ؽ�to����,��Target�����˶�ѧ��ֵ��
%���˶�ѧ��������У��᲻�ϵ�����BODY��ָ���ؽ�to֮��Ĺؽڽǣ��Ե���Ŀ��Target
%���˶�ѧ����ֵ�ⷨ:
%��ָ���ؽڳ���,����Ŀ��λ��,�ٶ�һ���ؽڽ�,�����˶�ѧ�����λ��,
%�����λ�˾�Ŀ��λ�˵����,����һ���¹ؽڽ�(�ؽڽ�������,���ſɱȾ������)��С���,�������ظ�

global uLINK
lambda = 0.9;
ForwardKinematics(1); %���˵����˶�ѧ����(���ݹؽڽ���λ��)����ÿ�����˵�λ��(��ת����)
%����1ΪBODYĸ����,�ɵݹ�����������˵�λ��
idx = FindRoute(to); %����������BODYΪ��׼����Ŀ������to�ı��
for n = 1:10
    J = CalcJacobian(idx); %������idx�и����ؽڵ�΢Сλ�ƺ�ת����ɵ���λ�ƺ�ת��
    err = CalcVWerr(Target, uLINK(to)); %TargetΪѡ����һ��λ��,����λ��p����̬R; toΪָ���Ĺؽ�
    if norm(err) < 1E-6 %�������㹻С
        return; %�������г���
    end
    dq = lambda * (J \ err); %��ȡ�ؽڽ���������q(2.70); x = J\err �Ƿ��� J*x = err �Ľ�
    for nn = 1:length(idx)
        j = idx(nn);
        uLINK(j).q = uLINK(j).q + dq(nn); %�¹ؽڽ�q=ԭʼ�ؽڽ�q+�ؽڽ���������q
    end
    ForwardKinematics(1); %�������˵����˶�ѧ����
end
function J = CalcJacobian(idx) %idxΪ��FindRout�������������
%�����ſɱ�(��idx�и����ؽڵ�΢Сλ�ƺ�ת����ɵ���λ�ƺ�ת��)
global uLINK

jsize = length(idx); %idx��Ԫ�صĸ������ж��ٸ��ؽ�,�ſɱȾ����С=6 x �ؽ���
target = uLINK(idx(end)).p; %idx�е����һ��Ԫ���ڡ�W�е�λ��,��ĩ�����˵��ڡ�W�е�λ��
J = zeros(6, jsize); %����һ����СΪ6xjsize��ȫ�����

for n = 1:jsize
    j = idx(n); %idx�еĵ�n��Ԫ��
    mom = uLINK(j).mother;
    a = uLINK(mom).R * uLINK(j).a; %��W�е�j��Ԫ�صĹؽ���ʸ��
    J(:, n) = [cross(a, target-uLINK(j).p); a]; %a��target-uLINK(j).p�Ĳ�� [target-uLINK(j).p]Ϊĩ�����˵��ؽ�j�ľ���
    %[cross(a1, target-uLINK(j).p),cross(a2, target-uLINK(j).p)]
    %[             a1             ,             a2             ]
end 
function idx = FindRoute(to)
%����������Ϊ��׼��Ŀ������·��(���)
global uLINK

i = uLINK(to).mother;
if i == 1
    idx = (to);
else
    idx = [FindRoute(i), to]; 
    %idx = [FindRoute(i), to] == idx = [FindRoute(i) to]
end

%FindRoute(1)����
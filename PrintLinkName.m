function PrintLinkName(j)
%显示各连杆的名字
global uLINK

if j ~= 0
    fprintf('j=%d:%s\n', j, uLINK(j).name)
    PrintLinkName(uLINK(j).sister)
    PrintLinkName(uLINK(j).child)
end
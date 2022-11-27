function DrawJoints(P1, P2)
    plot3( [P1.p(1), P2.p(1)],[P1.p(2), P2.p(2)], [P1.p(3), P2.p(3)],"LineWidth",3)
    xlabel('x'), ylabel('y'), zlabel('z')
    %pause(0.1)
end

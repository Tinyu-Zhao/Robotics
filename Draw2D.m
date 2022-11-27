global uLINK
hold on
grid on
Tui0 = plot(uLINK(BODY).p(1), uLINK(BODY).p(3) + 1, 'ro', 'MarkerFaceColor', 'r');
Tui1 = plot([uLINK(BODY).p(1), uLINK(BODY).p(1)], [uLINK(RLEG_J0).p(3) + 1, uLINK(RLEG_J0).p(3)], "LineWidth", 8, 'Color', 'b');

Tui2 = plot([uLINK(RLEG_J0).p(1), uLINK(RLEG_J3).p(1)], [uLINK(RLEG_J0).p(3), uLINK(RLEG_J3).p(3)], "LineWidth", 3, 'Color', 'g')
Tui3 = plot([uLINK(RLEG_J3).p(1), uLINK(RLEG_J4).p(1)], [uLINK(RLEG_J3).p(3), uLINK(RLEG_J4).p(3)], "LineWidth", 3, 'Color', 'm');

% plot([uLINK(RLEG_J0).p(1), uLINK(LLEG_J0).p(1)], [uLINK(RLEG_J0).p(3), uLINK(LLEG_J0).p(3)], "LineWidth", 3)

% plot([uLINK(LLEG_J0).p(1), uLINK(LLEG_J3).p(1)], [uLINK(LLEG_J0).p(3), uLINK(LLEG_J3).p(3)], "LineWidth", 3)
% plot([uLINK(LLEG_J3).p(1), uLINK(LLEG_J4).p(1)], [uLINK(LLEG_J3).p(3), uLINK(LLEG_J4).p(3)], "LineWidth", 3)

%xlim([-1, 4]), ylim([-5, 2])
xlabel('X')
ylabel('Z')

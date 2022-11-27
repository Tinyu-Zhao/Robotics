function DrawAllJoints()
    global uLINK

    for i = 1:5
        DrawJoints(uLINK(1), uLINK(1 + 1))
        DrawJoints(uLINK(i), uLINK(i + 1))
        hold on;
    end

    % for i = 1:6
    %     DrawJoints(uLINK(1), uLINK(1 + 1))
    %     hold on;
    %     DrawJoints(uLINK(i), uLINK(i + 1))
    %     hold on;
    % end

    % DrawJoints(uLINK(1), uLINK(8))

    % for i = 8:12
    %     DrawJoints(uLINK(1), uLINK(1 + 1))
    %     hold on;
    %     DrawJoints(uLINK(i), uLINK(i + 1))
    %     hold on;
    % end
    set(gca, 'XDir', 'reverse');
    axis square
    view(-135, 11);
    %drawnow
end

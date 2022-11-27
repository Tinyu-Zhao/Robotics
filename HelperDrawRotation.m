classdef HelperDrawRotation
    %   This class is for internal use only. It may be removed in the future
    %HELPERDRAWROTATION - Class used for drawing figures in Rotation,
    %   Orientation and Quaternions example.

    %   Copyright 2017-2018 The MathWorks, Inc.

    properties (Constant, Hidden)
        LabelPos = 0.9;
        SubaxisScale = 0.9;
        ArcPos = 0.75;
    end
    methods (Static)
        function drawTeapotRotations
            % Teapot Rotation example
            f = figure;
            dr = getDR;

            ax = subplot(1, 3, 1);
            dr.drawTeapot(ax);
            xlim(ax, [-1.5, 1.5]);
            ylim(ax, [-1.5, 1.5]);
            zlim(ax, [0, 2]);

            title(ax, 'Teapot');
            view(ax, [5, 10]);
            doGrids(ax);

            ax = subplot(1, 3, 2);
            dr.drawRotatedTeapot(ax, [0, 0, 1], 45);
            title(ax, ['Teapot Rotated 45', char(176), ' around Z-axis']);
            xlim(ax, [-1.5, 1.5]);
            ylim(ax, [-1.5, 1.5]);
            zlim(ax, [0, 2]);
            view(ax, [5, 10]);
            doGrids(ax);

            ax = subplot(1, 3, 3);
            dr.drawRotatedTeapot(ax, [1, 0, 1], 15);
            title(ax, ...
                ['Teapot Rotated 15', char(176), 'around axis (1,0,1)']);
            xlim(ax, [-1.5, 1.5]);
            ylim(ax, [-1.5, 1.5]);
            zlim(ax, [-0.1, 2]);
            view(ax, [5, 10]);
            doGrids(ax);

            f.Position(3:4) = [1200, 300];
        end

        function draw2DPointRotation(ax)
            % 2D Point rotation example
            dr = getDR;
            dr.drawGlobalAxes(ax, {'x', 'y', 'z'});
            pt = [0.7, 0.5, 0];
            deg = 30;
            q = quaternion([deg, 0, 0], 'eulerd', 'ZYX', 'point');
            ptnew = rotatepoint(q, pt);
            dr.addPoint(ax, pt);
            dr.addPoint(ax, ptnew);
            dr.drawArc(ax, pt, ptnew, deg);


            % Annotate
            oldstr = sprintf('(%g, %g, %g)', pt);
            newstr = sprintf('(%.2g, %.2g, %.2g)', ptnew);
            text(ax, pt(1), pt(2), pt(3), oldstr);
            text(ax, ptnew(1), ptnew(2), ptnew(3), newstr, ...
                'HorizontalAlignment', 'right');
            view(ax, [0, 0, 1]);
            title(ax, 'Point Rotation');
            doGrids(ax);
        end

        function draw2DFrameRotation(ax)
            % 2D Frame rotation example
            dr = getDR;
            dr.drawGlobalAxes(ax, {'x_{original}', ...
                'y_{original}', ''});
            pt = [0.7, 0.5, 0];
            deg = 30;
            q = quaternion([deg, 0, 0], 'eulerd', 'ZYX', 'point');
            ptnew = rotateframe(q, pt);
            dr.addPoint(ax, pt);

            dr.drawRotatedAxesByEuler(ax, [deg, 0, 0], ...
                {'x_{rotated}', 'y_{rotated}', ''}, 1);

            % Annotate point
            oldstr = sprintf('(%g, %g, %g)', pt);
            newstr = sprintf('(%.2g, %.2g, %.2g)', ptnew);

            text(ax, pt(1), pt(2), pt(3), ...
                ['Coordinate in orignal frame ', newline, ...
                oldstr, newline, newline, ...
                'Coordinate in rotated frame ', newline, newstr], ...
                'HorizontalAlignment', 'right');

            view(ax, [0, 0, 1]);
            title(ax, 'Frame Rotation');
            doGrids(ax);

        end

        function draw3DOrientation(ax, rotax, rotangd)
            % 3D Orientation example
            dr = getDR;
            dr.drawGlobalAxes(ax, {'x_{parent}', 'y_{parent}', 'z_{parent}'});
            rotang = deg2rad(rotangd);
            rotax = rotax ./ norm(rotax);
            q = quaternion([cos(rotang./2), sin(rotang./2) .* rotax]);
            dr.drawRotatedAxesByQuaternion(ax, q, ...
                {'x_{child}', 'y_{child}', 'z_{child}'});
            dr.drawAxAngRot(ax, rotax, rotangd, 0.75);
            view(gca, [110, 13]);
            %             title(gca, ['Frame Rotation of 30' char(176) , ...
            %                 ' Around the Vector [1/3 2/3 2/3]']);
            doGrids(ax);
        end

        function drawEulerRotation(ax, euld)
            % Draw Frame rotation using Euler angles
            dr = getDR;
            dr.drawGlobalAxes(ax, {'x_{parent}', ...
                'y_{parent}', 'z_{parent}'});
            dr.drawRotatedAxesByEuler(ax, euld, ...
                {'x_{child}', 'y_{child}', 'z_{child}'}, 0.9);
            title(ax, ['Frame Rotation using Euler Angles of ', newline, ...
                num2str(euld(1)), char(176), 'Around Z-axis, ', ...
                num2str(euld(2)), char(176), 'Around Y-axis, ', ...
                num2str(euld(3)), char(176), 'Around Z-axis']);
            view(ax, [125, 10]);
            doGrids(ax);

        end
    end
    methods (Static, Hidden) % Helpers
        function ax = drawRotatedAxesByEuler(ax, euld, axlabel, scl)
            % Draw rotated set of axes by each Euler angle
            eul = deg2rad(euld);
            qz = quaternion([eul(1), 0, 0], 'euler', 'ZYX', 'frame');
            qy = quaternion([0, eul(2), 0], 'euler', 'ZYX', 'frame');
            qx = quaternion([0, 0, eul(3)], 'euler', 'ZYX', 'frame');
            x = [1, 0, 0];
            y = [0, 1, 0];
            z = [0, 0, 1];

            % 1st rotation about Z
            xr1 = rotatepoint(qz, x);
            yr1 = rotatepoint(qz, y);
            zr1 = z;

            % 2nd rotation about Y
            xr2 = rotatepoint(qy, xr1);
            yr2 = yr1;
            zr2 = rotatepoint(qy, zr1);

            % 3nd rotation about X
            yr3 = rotatepoint(qx, yr2);
            xr3 = xr2;
            zr3 = rotatepoint(qx, zr2);

            dr = getDR;

            %Draw axes. Only label last one.
            ap = dr.ArcPos;
            dr.drawAxis(ax, scl*xr1, ':', '', 'g', scl*xr1);
            dr.drawAxis(ax, scl*yr1, ':', '', 'r', scl*yr1);
            dr.drawAxis(ax, scl*zr1, ':', '', 'b', scl*zr1);
            dr.drawArc(ax, ap*y, ap*yr1, euld(1));
            dr.drawArc(ax, ap*x, ap*xr1, euld(1));


            dr.drawAxis(ax, scl*xr2, ':', '', 'g', scl*xr2);
            dr.drawAxis(ax, scl*yr2, ':', '', 'r', scl*yr2);
            dr.drawAxis(ax, scl*zr2, ':', '', 'b', scl*zr2);
            dr.drawArc(ax, ap*zr1, ap*zr2, euld(2));
            dr.drawArc(ax, ap*xr1, ap*xr2, euld(2));

            dr.drawAxis(ax, scl*xr3, '-', axlabel{1}, 'g', scl*xr3);
            dr.drawAxis(ax, scl*yr3, '-', axlabel{2}, 'r', scl*yr3);
            dr.drawAxis(ax, scl*zr3, '-', axlabel{3}, 'b', scl*zr3);
            dr.drawArc(ax, ap*yr2, ap*yr3, euld(3));
            dr.drawArc(ax, ap*zr2, ap*zr3, euld(3));

            view(ax, [1, 1, 1]);
        end

        function ax = drawRotatedAxesByQuaternion(ax, q, axlabel)
            % Draw axes rotated by a quaternion (frame rotation)
            x = [1, 0, 0];
            y = [0, 1, 0];
            z = [0, 0, 1];
            xr = rotatepoint(q, x);
            yr = rotatepoint(q, y);
            zr = rotatepoint(q, z);

            dr = getDR;
            %Draw axes. Only label last one.
            scl = dr.SubaxisScale;
            dr.drawAxis(ax, xr, '-', axlabel{1}, 'g', scl*xr);
            dr.drawAxis(ax, yr, '-', axlabel{2}, 'r', scl*yr);
            dr.drawAxis(ax, zr, '-', axlabel{3}, 'b', scl*zr);

        end

        function ax = drawGlobalAxes(ax, axlabel)
            % Draw X Y Z axes
            x = [1, 0, 0];
            y = [0, 1, 0];
            z = [0, 0, 1];
            dr = getDR;
            dr.drawAxis(ax, x, ':', axlabel{1}, 'g', x*dr.LabelPos);
            dr.drawAxis(ax, y, ':', axlabel{2}, 'r', y*dr.LabelPos);
            dr.drawAxis(ax, z, ':', axlabel{3}, 'b', z*dr.LabelPos);

            view([1, 1, 1]);
        end

        function verts = drawTeapot(~)
            % Draw a teapot
            [verts, faces, cindex] = teapotGeometry;
            verts = verts * 0.4;
            patch('Faces', faces, 'Vertices', verts, 'FaceVertexCData', ...
                cindex, 'FaceColor', 'interp');
        end

        function drawRotatedTeapot(ax, rotax, angd)
            % Draw a teapot rotated by angd (degrees) around rotax
            dr = getDR;
            ang = deg2rad(angd);
            q = quaternion([cos(ang/2), sin(ang/2) * rotax]);

            [verts, faces, cindex] = teapotGeometry;
            verts = verts * 0.4;
            vertR = rotatepoint(q, verts);

            patch('Faces', faces, 'Vertices', vertR, 'FaceVertexCData', ...
                cindex, 'FaceColor', 'interp');
            dr.drawAxAngRot(ax, rotax, angd, 1.3*max(vertR(:)));

        end

        function addPoint(ax, pt)
            hold(ax, 'on');
            plot3(pt(1), pt(2), pt(3), 'r*');
            hold(ax, 'off');
        end

        function drawAxis(ax, endpts, style, txt, color, txtloc)
            %Draw a single axis. If txt is '', then no text is added.
            %If txt is not empty, txtloc can be used if it is passed,
            %otherwise endpts is used.

            wd = 2;

            % Translate to "lines" colormap
            cm = lines;
            switch color
                case 'g'
                    color = cm(1, :);
                case 'r'
                    color = cm(2, :);
                case 'b'
                    color = cm(3, :);
            end

            line(ax, [0, endpts(1)], [0, endpts(2)], [0, endpts(3)], ...
                'LineWidth', wd, 'Color', color, 'LineStyle', style);

            if ~isempty(txt)
                if nargin < 6
                    tloc = 0.75 * endpts;
                else
                    tloc = txtloc;
                end
                text(ax, tloc(1), tloc(2), tloc(3), txt, 'FontSize', 20);
            end
        end

        function drawAxAngRot(ax, rotax, rotangd, scale)
            % Draw axis and angle of rotation
            hold(ax, 'on');
            pts = 20;
            dr = getDR;
            dr.drawAxis(ax, rotax*scale, '-', '', 'k');

            % It's much easier to draw the rotation arc around the x axis
            % and then swing it up to the axis of rotation.
            x = [1, 0, 0];
            bisector = x + rotax ./ norm(rotax); % Parallelogram Law

            offset = 0.1 * scale;
            start = [scale, 0, -offset];
            angspace = linspace(0, pi, pts).';
            qarc = quaternion([cos(angspace./2), sin(angspace./2) .* [1, 0, 0]]);
            arcX = rotatepoint(qarc, start);

            % Now rotate arcX up to the right spot.
            qbis = quaternion([cos(pi/2), sin(pi/2) * bisector]);
            arc = rotatepoint(qbis, arcX);
            plot3(ax, arc(:, 1), arc(:, 2), arc(:, 3), 'k-');

            arrowstart = arc(end-1, :);
            arrowend = arc(end, :);
            dr.drawArc(gca, arrowstart, arrowend, rotangd);

            hold(ax, 'off');
        end

        function drawArc(ax, start, stop, angdeg)
            %Draw an arc from start to stop in axes ax.
            %   angdeg is the angle label for the rotation

            hold(ax, 'on');
            pts = 20;

            dr = getDR;

            ang = acos(dot(start, stop)./(norm(start) .* norm(stop)));
            rotax = cross(start, stop);
            rotax = rotax ./ norm(rotax);

            angspace = linspace(0, ang, pts).';
            q = quaternion([cos(angspace./2), sin(angspace./2) .* rotax]);
            o = rotatepoint(q, start);
            plot3(ax, o(:, 1), o(:, 2), o(:, 3), 'k-');
            arrowstart = o(end-1, :);
            arrowend = o(end, :);
            dr.arrow(arrowstart, arrowend);
            half = pts / 2;
            text(ax, o(half, 1), o(half, 2), o(half, 3), ...
                sprintf('%4.1d%c', int32(angdeg), char(176)), ...
                'FontSize', 10);

            hold(ax, 'off');
        end

        function arrow(start, stop)
            % Draw an arrow with the tip at stop.
            % The direction of the arrow is the vector from
            % start to stop.

            ang = 60;
            h = 0.05;
            vec = stop - start;
            vec = h .* vec ./ norm(vec(:));
            newstart = stop - vec;

            halfbase = [h ./ tand(ang), 0, 0];
            top = stop;
            bottom1 = newstart + halfbase;
            bottom2 = newstart - halfbase;
            pts = [top; bottom1; bottom2];
            patch(pts(:, 1), pts(:, 2), pts(:, 3), 'k');
        end
    end


end

function dr = getDR
dr = HelperDrawRotation;
end

function doGrids(ax)
grid(ax, 'on');
grid(ax, 'minor');
end

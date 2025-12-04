function [] = plot_xyz(fnames,fignum,titles)
%PLOT_XYZ Summary of this function goes here
%   Detailed explanation goes here

last_T_idx = [5449,1793,2284];

for i = 1:length(fnames)
    T = readtable(fnames(i), "FileType", "text", "Delimiter", "|");
    x = T.x____X_____m - T.x____X_____m(1);
    y = T.x____Y_____m - T.x____Y_____m(1);
    z = T.x____Z_____m - T.x____Z_____m(1);
    t = T.x_real__time - T.x_real__time(1);

    t = t(1:last_T_idx(i));
    x = -x(1:last_T_idx(i));
    y = y(1:last_T_idx(i));
    z = z(1:last_T_idx(i));

    
    figure(fignum);
    
    % Plot x data (row 1, column i)
    subplot(3, length(fnames), i);
    plot(t, x, 'b-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('x [m]');
    title(titles(i));
    grid on;
    
    % Plot y data (row 2, column i)
    subplot(3, length(fnames), length(fnames) + i);
    plot(t, y, 'r-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('y [m]');
    title(titles(i));
    grid on;
    
    % Plot z data (row 3, column i)
    subplot(3, length(fnames), 2*length(fnames) + i);
    plot(t, z, 'g-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('z [m]');
    title(titles(i));
    grid on;

    fignum2=fignum+1;

    figure(fignum2);
    subplot(1,3,i)
    plot(x,z,Marker='.',LineStyle='none');
    xlabel('X-Pos (East) [m]');
    ylabel('Y-Pos (East) [m]');
    title(titles(i))
    grid on;

    fignum3=fignum+2;
    figure(fignum3);
    subplot(1,3,i)
    plot(t,y,Marker='.',LineStyle='none')
    xlabel('Time [s]');
    ylabel('Altitude (AGL) [m]')
    title(titles(i))
    grid on;
end

% Adjust spacing between subplots (only needs to be called once)
sgtitle("All Takeoff Tests");





end
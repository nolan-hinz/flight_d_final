function [] = plot_uvw(fnames,fignum,titles)
%PLOT_XYZ Summary of this function goes here
%   Detailed explanation goes here

for i = 1:length(fnames)
    T = readtable(fnames(i), "FileType", "text", "Delimiter", "|");
    x = T.x___vX___m_s - T.x___vX___m_s(1);
    y = T.x___vY___m_s - T.x___vY___m_s(1);
    z = T.x___vZ___m_s - T.x___vZ___m_s(1);
    t = T.x_real__time - T.x_real__time(1);
    
    figure(fignum);
    
    % Plot x data (row 1, column i)
    subplot(3, length(fnames), i);
    plot(t, x, 'b-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('u [m/s]');
    title(titles(i));
    grid on;
    
    % Plot y data (row 2, column i)
    subplot(3, length(fnames), length(fnames) + i);
    plot(t, y, 'r-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('v [m/s]');
    title(titles(i));
    grid on;
    
    % Plot z data (row 3, column i)
    subplot(3, length(fnames), 2*length(fnames) + i);
    plot(t, z, 'g-', 'LineWidth', 1.5);
    xlabel('Time');
    ylabel('w [m/s]');
    title(titles(i));
    grid on;
end

% Adjust spacing between subplots (only needs to be called once)
sgtitle("All Takeoff Tests");

end
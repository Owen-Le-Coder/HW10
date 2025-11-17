% DRAWBEAMFUNCTIONS
%   Draws four graphs, each one displaying a function related to the beam.
% 
% Syntax
%   [] = solveBeam(X, Z)
%
% Input arguments
%   X - A matrix of locations along the beam. [m]
%       nx by 1 matrix
%   Z - The matrix of solution components along the beam at the associated 
%       index of X, in the form [y, s, m, v].
%       nx by 4 matrix
%
% Authors
%   Group F
%

function [] = drawBeamFunctions(X, Z)
    theme light;

    subplot(2, 2, 1);
    y = Z(:, 1);
    plot(X, y, 'k', LineWidth=2)
    xlabel('Location [m]')
    ylabel('Displacement [m]')
    title('Displacement over Location')

    subplot(2, 2, 2);
    yline(0, Color=[0.3, 0.3, 0.3]);
    S = Z(:, 2);
    hold on;
    plot(X, S, 'g', LineWidth=2)
    hold off;
    xlabel('Location [m]')
    ylabel('Slope [m/m]')
    title('Slope over Location')
    

    subplot(2, 2, 3);
    M = Z(:, 3); % note: this is the flexural rigidity times the derivative of slope
    plot(X, M, 'b', LineWidth=2)
    xlabel('Location [m]')
    ylabel('Applied Bending Moment [N*m]')
    title('Bending Moment over Location')

    subplot(2, 2, 4);
    yline(0, Color=[0.3, 0.3, 0.3]);
    V = Z(:, 4);
    hold on;
    plot(X, V, 'r', LineWidth=2)
    hold off;
    xlabel('Location [m]')
    ylabel('Shear [N*m^2]')
    title('Shear over Location')

    %subplot(3, 2, [5, 6]);
    %plot(X, y, 'k', ...
    %     X, S, 'g', ...
    %     X, M, 'b', ...
    %     X, V, 'r')
 
end
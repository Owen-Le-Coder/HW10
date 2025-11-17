%==========================================================================
% Test script for HW10
%
% To execute, just type "testScript" into the command window (no inputs)
% Change the L, Q, and R values within this script to test different cases
%
% Note that Q and R are function handles so they work with Group I's solveBeam
% The periods are also necessary to work with Group I's solveBeam
%
% Calculates the values based on your inputs (in the script) and code
%
% The script also generates 4 charts:
% Top left: Deflection vs x-position
% Top right: Slope vs x-position
% Bottom left: Bending moment vs x-position
% Bottom right: Shear force vs x-position
%
% Author: Group I
% Version: Nov. 15, 2025
%==========================================================================

% Define the input parameters for the test case

L = 40; % meters (Beam span)

Q = @(x) -50 .* x; %Load stating @ 0 and increasing by specified amount until x = L
%Oriented so up is positive

R = @(x) 1.0e9 .* (1 + 0.05 .* x); %Flexual rigidity (start 0, increase to x = L)

[X, Z] = solveBeam(L, Q, R); %Calls solve beam

Y = Z(:, 1); % Deflection (m)
S = Z(:, 2); % Slope (rad)
M = Z(:, 3); % Moment (N*m)
V = Z(:, 4); % Shear (N)

% Display Results
[max_Y, idx_max_Y] = max(Y);
[min_Y, idx_min_Y] = min(Y);

fprintf('--- Beam Solver Results ---\n');
fprintf('Length L = %.1f m\n', L);
fprintf('Initial Slope S(0): %.4e rad\n', S(1));
fprintf('Initial Shear V(0) (Reaction Force): %.2f N\n', V(1));
fprintf('--------------------------------------------------\n');
fprintf('Maximum Deflection (Max |Y|): %.4e m (at x=%.2f m)\n', min_Y, X(idx_min_Y));
if abs(M) == M
    fprintf('Largest Bending Moment: %.2f N*m\n', max(M));
else
   fprintf('Largest Bending Moment (negative): %.2f N*m\n', min(M)); 
end
fprintf('Final Deflection Y(L): %.4e m (Should be ~0)\n', Y(end));
fprintf('Final Moment M(L): %.4e Nm (Should be ~0)\n', M(end));

    % Plot Results
    figure;

    % Top left plot
    subplot(2, 2, 1);
    plot(X, Y, 'LineWidth', 2);
    title('Deflection (y) vs. x');
    xlabel('x (m)');
    ylabel('y (m)');
    grid on;

    %Top right plot
    subplot(2, 2, 2);
    plot(X, S, 'LineWidth', 2);
    title('Slope (s) vs. x');
    xlabel('x (m)');
    ylabel('s (rad)');
    grid on;

    %Bottom left plot
    subplot(2, 2, 3);
    plot(X, M, 'LineWidth', 2);
    title('Bending Moment (m) vs. x');
    xlabel('x (m)');
    ylabel('M (N\cdotm)');
    grid on;


    %Bottom right plot
    subplot(2, 2, 4);
    plot(X, V, 'LineWidth', 2);
    title('Shear Force (v) vs. x');
    xlabel('x (m)');
    ylabel('V (N)');
    grid on;

    %Titles figure
    sgtitle('Beam Analysis Results (Non-Prismatic Beam)');
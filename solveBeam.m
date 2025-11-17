%==========================================================================
% solveBeam: Solves for the deflection, slope, moment, and shear of a
% simply supported, non-prismatic beam carrying a non-uniform distributed load.
%
% This function finds the initial slope (s(0)) and shear (v(0)) that 
% satisfy the boundary conditions y(L)=0 and M(L)=0.
%
% Usage:
%   [X, Z] = solveBeam(L, Q, R)
%
% Input variables:
%   L (scalar) - Length (span) of the beam [m].
%   Q (function handle) - Design load function Q(x) [N/m].
%                         ex. "@(x) 50 .* x"
%   R (function handle) - Flexural rigidity function R(x) [Nm^2].
%                         ex. "@(x) 1.0e9 .* (1 + 0.05 .* x)"
%
% Output variables:
%   X (nx x 1 matrix) - Matrix of locations along the beam [m].
%   Z (nx x 4 matrix) - Matrix of solution components: [y, s, m, v].
%                       where y=deflection, s=slope, m=moment, v=shear.
%
% Author: Group I
% Version: Nov. 13, 2025
%==========================================================================
function [X, Z] = solveBeam(L, Q, R)

    nx = 1001; % Use a large number of divisions for smooth output
    X = linspace(0, L, nx)';

    % Calculate Initial Guesses for S(0) and V(0)

    % Q(x) and R(x) are function handles
    try
        Q_avg = (1/L) * integral(Q, 0, L);
        R_avg = (1/L) * integral(R, 0, L);
    catch ME
        error('solveBeam:IntegralError', ...
            'Error during numerical integration of Q(x) or R(x): %s', ME.message);
    end

    % Estimate initial shear V(0)
    V0_guess = 0.5 * L * Q_avg;

    % Estimate initial slope S(0) 
    S0_guess = -(Q_avg * L^3) / (24 * R_avg);

    % Assemble the initial guess vector: [s(0); v(0)]
    lhs0 = [S0_guess; V0_guess];

    % Set up and Solve using fsolve (shooting method)

    objectiveFun = @(lhs) computeFinalDeflectionAndMoment(lhs, X, Q, R);

    options = optimoptions('fsolve', 'Display', 'off');

    % Call fsolve to find the correct initial slope and shear (lhs_final)
    [lhs_final] = fsolve(objectiveFun, lhs0, options);

    % Final ODE Solution with Correct Initial Conditions

    S0_final = lhs_final(1);
    V0_final = lhs_final(2);

    % Final initial condition vector z0 = [y(0), s(0), m(0), v(0)]
    z0_final = [0; S0_final; 0; V0_final];

    % Create the anonymous function wrapper for ode45 again
    odefun = @(x, z) computeDerivatives(x, z, Q, R);

    % Solve the ODE system one last time using the calculated initial conditions

    [~, Z] = ode45(odefun, X, z0_final, []); %ode45(odefun, TSPAN (the vector X), Y0, OPTIONS)

end
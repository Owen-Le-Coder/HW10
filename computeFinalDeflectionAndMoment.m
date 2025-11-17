%==========================================================================
% computeFinalDeflectionAndMoment: Objective function for the shooting method.
%
% Usage:
%   [result] = computeFinalDeflectionAndMoment(lhs, X, Q, R)
%
% Input variables:
%   lhs (2x1 matrix) - Initial guesses for slope and shear: lhs = [s(0); v(0)].
%   X (nx x 1 matrix) - Locations along the beam. nx is the number of
%   divisions used in solveBeam
%   Q (function handle) - Design load function Q(x) [N/m].
%   R (function handle) - Flexural rigidity function R(x) [Nm^2].
%
% Output variables:
%   result (2x1 matrix) - Final deflection and moment: result = [y(L); m(L)].
%
% Author: Group I
% Version: Nov. 13, 2025
%==========================================================================
function [result] = computeFinalDeflectionAndMoment(lhs, X, Q, R)

    % The initial conditions for the state vector z0 = [y(0), s(0), m(0), v(0)]
    z0 = [0; lhs(1); 0; lhs(2)];

    odefun = @(x, z) computeDerivatives(x, z, Q, R);

    % Solve the system of ODEs from x=0 to x=L using ode45.
    [~, Z] = ode45(odefun, X, z0, []); 

    % The final state is the last row of the solution matrix Z
    z_final = Z(end, :);

    % Extract the final deflection y(L) 
    final_deflection = max(z_final(1)); 
    
    % Extract the final moment m(L) 
    final_moment = z_final(3);

    % Assemble the result vector for fsolve: result = [y(L); m(L)]
    result = [final_deflection; final_moment];

end
%==========================================================================
% computeDerivatives: Calculates the first derivatives of the beam state vector
%
% This function implements the system of four first-order Ordinary Differential 
% Equations
%
% Usage:
%   [dzdx] = computeDerivatives(x, z, Q, R)
%
% Input variables:
%   x (scalar) - Location along the beam [m].
%   z (1x4 matrix) - The beam state vector at location x: z = [y, s, m, v]
%                    where y=deflection, s=slope, m=moment, v=shear.
%   Q (function handle) - Design load function Q(x) [N/m].
%   R (function handle) - Flexural rigidity function R(x) [Nm^2].
%
% Output variables:
%   dzdx (4x1 matrix) - The first derivative vector dz/dx 
%                       where dzdx = [dy/dx; ds/dx; dm/dx; dv/dx].
%
% Author: Group I 
% Version: Nov. 13, 2025
%==========================================================================
function [dzdx] = computeDerivatives(x, z, Q, R)

    % z(1) = y (deflection)
    % z(2) = s (slope, dy/dx)
    % z(3) = m (bending moment)
    % z(4) = v (shear)

    % Compute the values of Q(x) and R(x) at the current location x
    q_x = Q(x);
    r_x = R(x);
    
    % Calculate the derivatives (dz/dx) based on the governing equations:
    
    dy_dx = z(2); 
    
    ds_dx = z(3) / r_x;
    
    dm_dx = z(4);
    
    dv_dx = q_x;

    %Assemble the derivative vector (4x1 column vector)
    dzdx = [dy_dx; ds_dx; dm_dx; dv_dx];

end
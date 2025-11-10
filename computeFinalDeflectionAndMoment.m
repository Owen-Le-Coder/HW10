%--------------------------------------------------------------------------
%       lhs (2 × 1) matrix of initial slope and shear: lhs = [s(0); v(0)].
%
%       X (nx × 1) matrix of locations along the beam. X has units [m].
%
%       Q identifies the design load function [N/m]. Q is a function handle with signature q =
%       Q(x), where x is a scalar or a matrix. The returned q is the same size as x.
%
%       R identifies flexural rigidity function [Nm2]. R is a function handle with signature r =
%       R(x), where x is a scalar or a matrix. The returned r is the same size as x.
%
%   Results:
%       result (2 × 1) matrix of final deflection and moment: result = [y(L); m(L)].
%--------------------------------------------------------------------------
function [result] = computeFinalDeflectionAndMoment( lhs, X, Q, R )]

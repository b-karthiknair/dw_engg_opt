function [g, geq] = DWcon2(x)
% Two variable dynamic window problem 
% Computation of un-scaled constraints
% Design variables not scaled.

% Input:
%   x  : [1x2] row of design variables (vi and wi)
% Output:
%   g  : [1x6] row of inequality constraint values

% Assignment of design variables
vi = x(1);
wi = x(2);

% Constant parameter values
DWparams;

[xf, yf, thetaf ,dist, dist_angle, goal_angle] = DWanalysis(xi ,yi ,thetai, vi, wi, xg, yg, obstacles, delt, M);

% Scaled  constraints
% safe translational velocity constraint
g(1) = vi^2 - 2*(-a_lin_b(1)*dist); % v^2 < 2*a*dist 
% safe angular velocity constraint
g(2) = wi^2 - 2*(-a_ang_b(1)*dist);  
% attainable translational velocity in the d.w. assuming constant
% acceleration

g(3) = (va + t_interval * a_lin_b(1)) - vi;    % v > va - a*t

g(4) = vi - (va + t_interval * a_lin_b(2));    % v < va + at

% similarly, angular velocities
sign = 1;
if abs(wa) > 1e-6
    sign =  wa/abs(wa);
end
decc = a_ang_b(1) * sign;
acc =  a_ang_b(2) * sign;

g(5) = (wa + t_interval * decc) - wi;

g(6) = wi - (wa + t_interval *acc);

geq =[];
%end 
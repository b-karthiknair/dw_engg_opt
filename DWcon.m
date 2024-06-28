function [g, geq] = DWcon(x)
% Two variable dynamic window problem 
% Computation of scaled constraints
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

[xf, yf, thetaf ,dist, dist_angle, goal_angle] = DWanalysis(xi ,yi ,thetai, vi, wi, thetag, obstacles, delt, M);

% Scaled  constraints
% safe translational velocity constraint
g(1) = ((vi^2)/(2*(-a_lin_b(1))*dist))^0.5 - 1; % v^2 < 2*a*dist 
% safe angular velocity constraint
g(2) = ((wi^2)/(2*(-a_ang_b(1))*dist))^0.5 - 1;  

% attainable translational velocity in the d.w. assuming constant
% acceleration
g(3) = 1 - (vi/(va + t_interval * a_lin_b(1)));    % v > va - a*t
g(4) = (vi/(va + t_interval * a_lin_b(2))) - 1;    % v < va + at

% similarly, angular velocities
g(5) = 1 - (wi/(wa + t_interval * a_ang_b(1)));
g(6) = (wi/(wa + t_interval * a_ang_b(2))) - 1;

geq =[];
%end 
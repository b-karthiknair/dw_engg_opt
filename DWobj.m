function f = DWobj(x);
% Two variable dynamic window problem.
% Computation of objective function 
% Input:
%   x  : [1x2] row of design variables (vi and wi)
% Output:
%   f  : [1x1] scalar of objective function value

% Assignment of design variables
vi = x(1);
wi = x(2);

% Constant parameter values
DWparams;

% Analysis of current valve spring design.
thetaf = thetai;
[xf,yf,thetaf,dist,dist_angle,goal_angle]=DWanalysis(xi, yi, thetai, vi, wi, xg, yg, obstacles, delt, M);
f_goal = goal_angle;
% f_goal = (((xg-xf)^2+(yg-yf)^2)^0.5)/(xg^2+yg^2)^0.5;
f_dist = dist;
f_vel = vi;

 % Objective function (unscaled)
f = - (a*f_goal + b*f_dist + c*f_vel); 

%end 
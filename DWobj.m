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
[xf, yf, thetaf, dist, dist_angle, goal_angle] = DWanalysis(xi,yi,thetai,vi,wi,thetag,obstacles,delt,M)
f_goal = 1 - goal_angle/pi;
f_dist = dist/M;
f_vel = vi/v_max;

 % Objective function (unscaled)
f = a*f_goal + b*f_dist + c*f_vel;    
f = (a+b+c) - f;    % converting a maximization problem to a minimization problem
 
%end 
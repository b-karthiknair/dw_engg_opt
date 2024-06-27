function [g, geq] = DWcon(x)
% Two variable dynamic window problem 
% Computation of scaled constraints
% Design variables not scaled.

% Input:
%   x  : [1x2] row of design variables (vi and wi)
% Output:
%   g  : [1x6] row of inequality constraint values

% Assignment of designvariables
vi = x(1);
wi = x(2);

% Constant parameter values
DWparams;


% Analysis of current valve spring design.
[xf,yf,thetaf,dist,dist_angle,goal_angle]=DWanalysis(xi,yi,thetai,vi,wi,thetag,obstacles,delt,M);

% Scaled  constraint
g(1) = ((vi^2)/(2*(-a_lin_b(1))*dist)) - 1;

g(2) = ((wi^2)/(2*(-a_ang_b(1))*dist)) - 1;  % dist angle??

g(3) = 1 - (vi/(va + a_lin_b(1)));

g(4) = (vi/(va + a_lin_b(2))) - 1;

g(5) = 1 - (wi/(wa + a_ang_b(1)));
   
g(6) = (wi/(wa + a_ang_b(2))) - 1;

geq =[];
%end 
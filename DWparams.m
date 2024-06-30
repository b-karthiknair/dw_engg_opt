% SI-Units: m, N(ewtons), s
%**************************************************
% Assignment of fixed input parameters:
%   xi : Current x coordinate (m).
%   yi : Current y coordinate (m).
%   thetai : Current heading angle (rad).
%   thetag : Origin to goal angle (rad).
%   obstacles : List of (x,y) coordinates for obstacles (m,m).
%   delt : Time step (s).
%   M : Large distance to be set if there are no obstacles on the robot
%       trajectory (m).
xi = 0;
yi = 0;
thetai = 0;
va = 0;
wa = 0;
% xi = 1.0;
% yi = 2.0;
% thetai = 0.25*pi;
% va = 0.3;
% wa = 0.2*pi;
xg = 5;
yg = 4;
% thetag = atan2(yg,xg);
obstacles = [[1.2,4.1];[1.1,2.1];[2.9,6.1];[4.2,1.1]];
delt = 0.25;
t_interval = delt;
M = 10;
a = 2.0;
b = 0.2;
c = 0.2;
v_min = 0;
v_max = 0.95;
w_min = -pi/3;
w_max = pi/3;
a_lin_b = [-2.0, 0.5];
a_ang_b = [-pi/3, pi/3];
%end



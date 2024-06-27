% Input of design parameters of valve spring.

%**************************************************
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

xi = 1.0;
yi = 2.0;
thetai = 0.25*pi;
thetag = 0.4*pi;
obstacles = [[1.2,4.1];[1.1,2.1];[2.9,6.1];[4.2,1.1]];
delt = 0.25;
M = 10;
a = 2.0;
b = 0.2;
c = 0.2;
va = 0.3;
wa = 0.2*pi;
v_min = 0;
v_max = 0.9;
w_min = -pi/2;
w_max = pi/2;
a_lin_b = [-0.1,0.2];
a_ang_b = [-0.03,0.03];

%end
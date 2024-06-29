function [xf, yf, thetaf, dist, dist_angle, goal_angle] = ...
DWanalysis(xi, yi, thetai, vi, wi, xg, yg, obstacles, delt, M)
% Analysis of dynamic window.
%**************************************************
% SI-Units: m, s, rad
%**************************************************
% INPUT PARAMETERS:
%  Design varables:
%   vi  : Translational velocity (m/s).
%   wi  : Rotational velocity (rad/s).

% Fixed input parameters:
%   xi : Current x coordinate (m).
%   yi : Current y coordinate (m).
%   thetai : Current heading angle (rad).
%   theta_g : Origin to goal angle (rad).     TODO!!!!!
%   obstacles : List of (x,y) coordinates for obstacles (m,m).
%   delt : Time step (s).
%   M : Large distance to be set if there are no obstacles on the robot
%       trajectory (m).

% OUTPUT PARAMETERS
%   xf : Predicted x coordinate (m).
%   yf : Predicted y coordinate (m).
%   thetaf : Predicted heading angle (rad).
%   dist : Distance to nearest obstacle on the trajectory of the robot (m).
%   dist_angle : Angular distance to nearest obstacle on the trajectory of the robot (rad).
%   goal_angle : Angle between target heading and predicted heading (rad).

% LOCAL VARIABLES
%   no : Number of obstacles.
  % Normalise thetai (rad).
  thetai = mod(thetai,2*pi);
  thetaf = thetai;
  % Number of obstacles.
  [no, ~] = size(obstacles);

  % For wi = 0:
  if (wi == 0)
      % Predicted x coordinate (m).
      xf = xi + vi*cos(thetai)*delt;
      % Predicted y coordinate (m).
      yf = yi + vi*sin(thetai)*delt;      
  else
      % Predicted x coordinate (m).
      xf = xi - (vi/wi)*(sin(thetai) - sin(thetai + wi*delt));
      % Predicted y coordinate (m).
      yf = yi + (vi/wi)*(cos(thetai) - cos(thetai + wi*delt));
      % Predicted heading angle (rad).
      thetaf = thetai + wi*delt;
  end

  % Normalise
  thetaf = mod(thetaf, 2*pi); 

  % Distance to nearest obstacle on the trajectory (m).
  dist = M;
  dist_angle = M;

  for i = 1:no
      [dist_angle_temp, dist_temp] = onTraj(xi, yi ,thetai, vi, wi, obstacles(i, :), M);
      if dist_temp < dist
          dist = dist_temp;
          dist_angle = dist_angle_temp;
      end
  end

  % Target heading vector
  vecg = [xg-xf, yg-yf];
  vecg = vecg/(sum(vecg.^2))^0.5; % normalise
  
  % Actual heading vector
  veca = [cos(thetaf), sin(thetaf)];

  % Angle between target heading and predicted heading (m)
  angle_diff = acos(sum(vecg.*veca)); % acos returns in the range [0, pi]
  goal_angle = pi - angle_diff;
% end
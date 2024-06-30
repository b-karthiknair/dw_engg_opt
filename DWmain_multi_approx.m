% Two variable dynamic window problem 
% Visualization of .m (objective function) and .m (constraints).

DWparams;
dist_epsilon = 0.1; % Distance tolerance to goal
epsilon = 10^-6; % Radius of straight line
step_thresh = 100; % Maximum number of steps 

vi = 0.0;
wi = 0.0;


figure;
hold on;
steps = 0;
converged = 1;

tic;
while distance_xy([xi,yi],[xg,yg]) > dist_epsilon
    steps = steps + 1;
    if steps > step_thresh
        converged = 0;
        break;
    end
    DWparams;
    func_approx;
    loaded_data= load('approx_func.mat');
    approx_func = loaded_data.approx_func_estimated;
    % lower and upper bounds for the problem
    lb = [v_min, w_min]; 
    ub = [v_max, w_max]; 
    % linear inequality constraints
    A = []; 
    b = []; 
    % linear equality constraints
    Aeq = [];
    beq = [];
    % non-linear constraints
    nonlcon = @DWcon;
    % initial design point
    % x0 = [vi wi]; % uses vi wi from func_approx script
    
    [x, fval, exitflag, output, lambda] = fmincon(approx_func,[0.0,0.0], A, b, Aeq, beq, lb, ub, nonlcon);
    
    
    
    % arc plotting
    vi = x(1);
    wi = x(2);
    radius = vi/(wi+epsilon);
    
    [xf,yf,thetaf,dist,dist_angle,goal_angle] = ...
    DWanalysis(xi,yi,thetai,vi,wi,xg,yg,obstacles,delt,M);
    ed = edit_file('DWparams.m',xf,yf,thetaf,vi,wi);
    center = [xi-radius*sin(thetai),yi+radius*cos(thetai)];
    x0 = center(1);
    y0 = center(2);
    r = abs(radius);
    theta_start = atan2(yi-y0,xi-x0);
    theta_end = theta_start + wi*delt; % atan2(yf-y0,xf-x0)
    
    theta = linspace(theta_start,theta_end,100);
    x = r*cos(theta) + x0;
    y = r*sin(theta) + y0;
    
    % arc
    plot(x, y, 'LineWidth', 2);
    hold on;
    % plot(x0, y0, 'ro'); % center
    

end
elapsedTime = toc;


% obstacles
for j = 1:length(obstacles)
    plot(obstacles(j,1),obstacles(j,2),'bo');
end

plot(xg,yg,'go'); % goal

fprintf("%f seconds taken \n",elapsedTime);
if converged == 1
    fprintf("%d steps required \n",steps);
else
    fprintf("Did not converge to goal after %d steps \n",step_thresh);
end
fprintf("Average time per step is %f seconds \n",(elapsedTime/steps));

axis equal;
grid on;
hold off;

%end

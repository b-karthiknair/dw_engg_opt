% Two variable dynamic window problem 
% Visualization of .m (objective function) and .m (constraints).

DWparams;

vi = 0.0;
wi = 0.0;

figure;
hold on;
fs = [];
thetas = [];
for i = 1:10
    DWparams;
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
    x0 = [vi wi];
    % options = optimoptions("fmincon",...
    % "Algorithm","interior-point",...
    % "EnableFeasibilityMode",true,...
    % "SubproblemAlgorithm","cg");
    [x, fval, exitflag, output, lambda] = fmincon(@DWobj,x0,A,b,Aeq,beq,lb,ub,nonlcon);%,options);
    fs = cat(1,fs,fval);
    thetas = cat(1,thetas,thetaf);
    
    
    % arc plotting
    vi = x(1);
    wi = x(2);
    radius = vi/wi;
    
    [xf,yf,thetaf,dist,dist_angle,goal_angle] = ...
    DWanalysis(xi,yi,thetai,vi,wi,thetag,obstacles,delt,M);
    ed = edit_file('DWparams.m',xf,yf,thetaf,vi,wi);
    center = [xi-radius*sin(thetai),yi+radius*cos(thetai)];
    x0 = center(1);
    y0 = center(2);
    r = abs(radius);
    theta_start = atan2(yi-y0,xi-x0);
    theta_end = theta_start + wi*delt; % atan2(yf-y0,xf-x0)
    % if theta_start > theta_end
    %     theta_end = theta_end + 2*pi;
    % end
    theta = linspace(theta_start,theta_end,100);
    x = r*cos(theta) + x0;
    y = r*sin(theta) + y0;
    
    % arc
    plot(x, y, 'LineWidth', 2);
    hold on;
    plot(x0, y0, 'ro'); % center
    

end

% obstacles
for j = 1:length(obstacles)
    plot(obstacles(j,1),obstacles(j,2),'bo');
end

plot(xg,yg,'go'); % goal


axis equal;
grid on;
hold off;

%end

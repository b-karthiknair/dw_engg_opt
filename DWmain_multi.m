DWparams;

% Initial velocities
vi = 0.0;
wi = 0.0;

figure;
hold on;
fs = [];
thetas = [];

% Perform optimization for 10 iterations
for i = 1:10
    fprintf("%d, %d", xi, yi);

    DWparams;
    
    % Bounds for the problem
    lb = [v_min, w_min];
    ub = [v_max, w_max];
    
    % Constraints (empty for now)
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    
    % Non-linear constraints function
    nonlcon = @DWcon;
    
    % Initial design point
    x0 = [vi wi];
    
    % Optimization using fmincon (uncomment options if needed)
    [x, fval, exitflag, output, lambda] = fmincon(@DWobj, x0, A, b, Aeq, beq, lb, ub, nonlcon); %, options)
    
    % Evaluate constraints at the solution
    [g, geq] = DWcon(x);
    
    % Display constraint values
    fprintf('Constraint values at x = [%f, %f]:\n', x(1), x(2));
    fprintf('g(1) = %f (safe translational velocity constraint)\n', g(1));
    fprintf('g(2) = %f (safe angular velocity constraint)\n', g(2));
    fprintf('g(3) = %f (attainable translational velocity lower bound)\n', g(3));
    fprintf('g(4) = %f (attainable translational velocity upper bound)\n', g(4));
    fprintf('g(5) = %f (attainable angular velocity lower bound)\n', g(5));
    fprintf('g(6) = %f (attainable angular velocity upper bound)\n', g(6));
    
    % Update velocities
    vi = x(1);
    wi = x(2);
    
    % Arc plotting
    radius = vi / wi;
    [xf, yf, thetaf, ~, ~, ~] = DWanalysis(xi, yi, thetai, vi, wi, xg, yg, obstacles, delt, M);
    fs = [fs; fval];
    thetas = [thetas; thetaf];
    
    % Update DWparams.m file
    edit_file('DWparams.m', xf, yf, thetaf, vi, wi);
    
    % Plot arc
    center = [xi - radius * sin(thetai), yi + radius * cos(thetai)];
    x0 = center(1);
    y0 = center(2);
    r = abs(radius);
    theta_start = atan2(yi - y0, xi - x0);
    theta_end = theta_start + wi * delt;
    theta = linspace(theta_start, theta_end, 100);

    x_coord = r * cos(theta) + x0;
    y_coord = r * sin(theta) + y0;
    
    plot(x_coord, y_coord, 'LineWidth', 2);
    plot(x0, y0, 'ro'); % Center
end
% Plot obstacles and goal
for j = 1:length(obstacles)
    plot(obstacles(j, 1), obstacles(j, 2), 'bo');
end
plot(xg, yg, 'go'); % Goal

axis equal;
grid on;
hold off;

edit_file('DWparams.m', 0, 0, 0, 0, 0);

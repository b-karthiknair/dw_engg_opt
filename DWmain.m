% Two variable dynamic window problem 
% Visualization of .m (objective function) and .m (constraints).

% Initialization
clf, hold off, clear

DWparams;

% Combinations of design variables vi and wi 
vi = [v_min:0.02:v_max];
wi = [w_min:0.02:w_max];
r = 10;

% Preallocate matrices
fobj = zeros(length(wi), length(vi));
g1 = zeros(length(wi), length(vi));
g2 = zeros(length(wi), length(vi));
g3 = zeros(length(wi), length(vi));
g4 = zeros(length(wi), length(vi));
g5 = zeros(length(wi), length(vi));
g6 = zeros(length(wi), length(vi));

% Matrix of output values for combinations of design variables vi and wi: 
for j=1:1:length(wi)
  for i=1:1:length(vi)
    % Assignment of design variables:
    x(1) = vi(i);
    x(2) = wi(j);
 	 % Objective function
    f = DWobj(x);
    % Grid value of objective function:
    fobj(j,i) = f; 
     
    % Scaled constraints:
    g = DWcon(x);
    % Grid values of constraints:
    g1(j,i) = g(1);    % 
    g2(j,i) = g(2);    % 
    g3(j,i) = g(3);    % 
    g4(j,i) = g(4);    % 
    g5(j,i) = g(5);    % 
    g6(j,i) = g(6);    %
  end
end

% Contour plot of scaled dynamic window problem
% surfl(vi, wi, fobj);
contour(vi, wi, fobj)
xlabel('linear velocity vi (m/s)'), ylabel('angular velocity wi (rad/s)'), ...
   title('Figure: Dynamic window optimization problem')
hold on
contour(vi, wi, g1, [0.0 0.0])
contour(vi, wi, g1, [0.01 0.01],'--') % Infeasible region

contour(vi, wi, g2, [0.0 0.0])
contour(vi, wi, g2, [0.01 0.01],'--')   % Infeasible region

contour(vi, wi, g3, [0.0 0.0])
contour(vi, wi, g3, [0.01 0.01],'--')   % Infeasible region

contour(vi, wi, g4, [0.0 0.0])
contour(vi, wi, g4, [0.01 0.01],'--')   % Infeasible region

contour(vi, wi, g5, [0.0 0.0])
contour(vi, wi, g5, [0.01 0.01],'--')   % Infeasible region

contour(vi, wi, g6, [0.0 0.0])
contour(vi, wi, g6, [0.01 0.01],'--')   % Infeasible region

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
x0 = [0.0 0.0];

tic;
[x, fval, exitflag, output, lambda] = fmincon(@DWobj,x0,A,b,Aeq,beq,lb,ub,nonlcon);
elapsedTime = toc;
fprintf("time taken for solving exact function is %f seconds\n",elapsedTime);

% Plot the markers
plot(x0(1), x0(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot(x(1), x(2), 'go', 'MarkerSize', 10, 'LineWidth', 2);


grid

%end 

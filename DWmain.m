% Two variable dynamic window problem 
% Visualization of .m (objective function) and .m (constraints).

% Initialization
clf, hold off, clear

DWparams;

% Combinations of design variables vi and wi 
vi = [v_min:0.1:v_max];
wi = [w_min:0.1:w_max];
r = 10;

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

    % TEST: BARRIER FUNCTION
    
    %fobj(j,i) = f - (1/r)*sum(log(-g));

    %if isreal(fobj(j,i)) 
     %   if fobj(j,i) == Inf
      %      fobj(j,i) = 10;
       % end
    %else
     %   fobj(j,i) = 10;
    %end

  end
end

% Contour plot of scaled dynamic window problem
surfl(vi, wi, fobj);
%contour(vi, wi, fobj)
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
[x, fval, exitflag, output, lambda] = fmincon(@DWobj,x0,A,b,Aeq,beq,lb,ub,nonlcon);

% Plot the markers
plot(x0(1), x0(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot(x(1), x(2), 'go', 'MarkerSize', 10, 'LineWidth', 2);


grid

%end 

% Initialization
clf, hold off, clear

DWparams;

% Combinations of design variables vi and wi 
vi = [v_min:0.02:v_max];
wi = [-0.6, 0.6]; % Set wi values explicitly
r = 10;

% Preallocate matrix
fobj = zeros(length(wi), length(vi));

% Matrix of output values for combinations of design variables vi and wi: 
for j = 1:length(wi)
  for i = 1:length(vi)
    % Assignment of design variables:
    x(1) = vi(i);
    x(2) = wi(j);
    % Objective function
    f = DWobj(x);
    % Grid value of objective function:
    fobj(j,i) = f; 
  end
end

% Plot the objective function versus vi for each wi
figure;

for j = 1:length(wi)
  subplot(2, 1, j); % Create subplot
  plot(vi, fobj(j, :), 'DisplayName', sprintf('wi = %.2f', wi(j)));
  xlabel('Linear velocity vi (m/s)');
  ylabel('Objective function value');
  title(sprintf('Objective function vs Linear velocity for wi = %.2f', wi(j)));
  legend show;
  grid on;
end

hold off;

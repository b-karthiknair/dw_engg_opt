% initialization
% clf, clear; % removes variables when called for multiple steps
DWparams;
num_samples = 50;
var_range = [v_min, v_max; w_min, w_max];
display = 0; % toggle to 0 to disable plotting

% latin hypercube sampling for 2 variables
lhs_samples = lhsdesign(num_samples, 2);  % unscaled
% scaling the samples based on vi and wi
scaled_samples = zeros(num_samples, 2);
for i = 1:2
    scaled_samples(:, i) = var_range(i, 1) + (var_range(i, 2) - var_range(i, 1)) * lhs_samples(:, i);
end

% evaluate function with the scaled samples
func_eval = zeros(num_samples, 1);
for i = 1:num_samples
    func_eval(i) = DWobj(scaled_samples(i, :));
end

% defining the model function as a cubic polynomial
approx_func = @(b, x) b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,1).^2 + b(5)*x(:,2).^2 + ...
                      b(6)*x(:,1).^3 + b(7)*x(:,2).^3 + b(8)*x(:,1).*x(:,2) + ...
                      b(9)*x(:,1).^2.*x(:,2) + b(10)*x(:,1).*x(:,2).^2 + ...
                      b(11)*x(:,1).^4 + b(12)*x(:,2).^4 + b(13)*x(:,1).^3.*x(:,2) + ...
                      b(14)*x(:,1).*x(:,2).^3;

init_guess = ones(1, 14); % initial guess for the parameters

% non-linear least squares fitting
options = optimset('Display', 'off');
est_params = lsqcurvefit(approx_func, init_guess, scaled_samples, func_eval, [], [], options);
disp(est_params);

approx_func_estimated = @(x) est_params(1) + est_params(2)*x(1) + est_params(3)*x(2) + ...
                             est_params(4)*x(1)^2 + est_params(5)*x(2)^2 + est_params(6)*x(1)^3 + ...
                             est_params(7)*x(2)^3 + est_params(8)*x(1)*x(2) + ...
                             est_params(9)*x(1)^2*x(2) + est_params(10)*x(1)*x(2)^2 + ...
                             est_params(11)*x(1)^4 + est_params(12)*x(2)^4 + ...
                             est_params(13)*x(1)^3*x(2) + est_params(14)*x(1)*x(2)^3;

save('approx_func.mat', 'approx_func_estimated', '-mat');

% plotting both true and approx functions
[vi, wi] = meshgrid(linspace(v_min, v_max, 100), linspace(w_min, w_max, 100));

true_values = zeros(size(vi));
approx_values = zeros(size(vi));
for i = 1:numel(vi)
    true_values(i) = DWobj([vi(i), wi(i)]);
    approx_values(i) = approx_func(est_params, [vi(i), wi(i)]);
end


if display

    figure;
    subplot(1, 2, 1);
    surf(vi, wi, true_values);
    title('True Function');
    xlabel('vi');
    ylabel('wi');
    zlabel('f(vi, wi)');
    
    subplot(1, 2, 2);
    surf(vi, wi, approx_values);
    title('Estimated Function');
    xlabel('vi');
    ylabel('wi');
    zlabel('f(vi, wi)');
    
    sgtitle('True Function vs Estimated Function');

end 
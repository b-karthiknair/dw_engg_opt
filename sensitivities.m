
% Computation of gradients of objective function and constraints.


% Initialization
clf, hold off, clear

% Note: Constant parameter values are read within the functions DWobj and
% DWcon

% Design point for which gradients are computed 
x = [0.0 0.0];  
hxi = 1e-8;

% Forward finite diffence gradients of objective function and constraints

% Objective
fx = DWobj(x);
fx1plush = DWobj([x(1)+hxi, x(2)]);
fx2plush = DWobj([x(1), x(2)+hxi]);
dfdx1 = (fx1plush - fx)/hxi;
dfdx2 = (fx2plush - fx)/hxi;

% Constraints 
gx = DWcon(x);
gx1plush = DWcon([x(1)+hxi, x(2)]);
gx2plush = DWcon([x(1), x(2)+hxi]);
dgdx1 = (gx1plush - gx)./hxi;
dgdx2 = (gx2plush - gx)./hxi;


fx

[dfdx1;dfdx2]
%gx
%dgdx1 
%dgdx2 
%del_g = [dgdx1(4) dgdx1(1); dgdx2(4) dgdx2(1)]
%mu = -inv(del_g)*[dfdx1;dfdx2]
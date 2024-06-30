
% Computation of gradients of objective function and constraints.


% Initialization
clf, hold off, clear

% Note: Constant parameter values are read within the functions DWobj and
% DWcon

% Design point for which gradients are computed 
x = [0.024 0.004];  

% Forward finite diffence gradients of objective function and constraints
hx = logspace(-20,0,100); % vector of finite difference steps
for i=1:1:length(hx)

  % Finite diffence step
  hxi = hx(i);

  % Objective function
  fx = DWobj(x);
  fx1plush = DWobj([x(1)+hxi, x(2)]);
  fx2plush = DWobj([x(1), x(2)+hxi]);
  dfdx1(i) = (fx1plush - fx)/hxi;
  dfdx2(i) = (fx2plush - fx)/hxi;

  % Constraints 
  gx = DWcon(x);
  gx1plush = DWcon([x(1)+hxi, x(2)]);
  gx2plush = DWcon([x(1), x(2)+hxi]);
  dgdx1(i,:) = (gx1plush - gx)./hxi;
  dgdx2(i,:) = (gx2plush - gx)./hxi;

end


% Plotting finite difference gradients
% Objective
subplot(121)
semilogx(hx,dfdx1)
xlabel('Difference step hx'), ylabel('df/dx1'), title('Objective')

subplot(122)
semilogx(hx,dfdx2)
xlabel('Difference step hx'), ylabel('df/dx2'), title('Objective')

% Plotting finite difference gradients
% % Admissible velocities
% subplot(221)
% semilogx(hx,dgdx1(:,1))
% xlabel('Difference step hx'), ylabel('dg1/dx1'), title('Admissible linear velocity')
% 
% subplot(222)
% semilogx(hx,dgdx2(:,1))
% xlabel('Difference step hx'), ylabel('dg1/dx2'), title('Admissible linear velocity')
% 
% subplot(223)
% semilogx(hx,dgdx1(:,2)')
% xlabel('Difference step hx'), ylabel('dg2/dx1'), title('Admissible angular velocity') 
% 
% subplot(224)
% semilogx(hx,dgdx2(:,2)')
% xlabel('Difference step hx'), ylabel('dg2/dx2'), title('Admissible angular velocity') 

% Dynamic window linear
% subplot(221)
% semilogx(hx,dgdx1(:,3))
% xlabel('Difference step hx'), ylabel('dg3/dx1'), title('Dynamic window linear velocity (lower)')
% 
% subplot(222)
% semilogx(hx,dgdx2(:,3))
% xlabel('Difference step hx'), ylabel('dg3/dx2'), title('Dynamic window linear velocity (lower)')
% 
% subplot(223)
% semilogx(hx,dgdx1(:,4)')
% xlabel('Difference step hx'), ylabel('dg4/dx1'), title('Dynamic window linear velocity (upper)') 
% 
% subplot(224)
% semilogx(hx,dgdx2(:,4)')
% xlabel('Difference step hx'), ylabel('dg4/dx2'), title('Dynamic window linear velocity (upper)') 



% Dynamic window angular
% subplot(221)
% semilogx(hx,dgdx1(:,5))
% xlabel('Difference step hx'), ylabel('dg5/dx1'), title('Dynamic window angular velocity (lb)')
% 
% subplot(222)
% semilogx(hx,dgdx2(:,5))
% xlabel('Difference step hx'), ylabel('dg5/dx2'), title('Dynamic window angular velocity (lb)')
% 
% subplot(223)
% semilogx(hx,dgdx1(:,6)')
% xlabel('Difference step hx'), ylabel('dg6/dx1'), title('Dynamic window angular velocity (ub)') 
% 
% subplot(224)
% semilogx(hx,dgdx2(:,6)')
% xlabel('Difference step hx'), ylabel('dg6/dx2'), title('Dynamic window angular velocity (ub)') 


 

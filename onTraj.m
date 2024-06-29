function [dist_angle_temp,dist_temp] = onTraj(xi, yi, thetai, vi, wi, po, M)

epsilon = 10^(-6);
obstacle_radius = 1e-1;

dist_temp = M;
dist_angle_temp = M;

if wi^2 < epsilon 
    % straight line
    vec = [po(1)-xi, po(2)-yi];
    if vec(1)^2 < epsilon
        if vec(2)^2 < epsilon
            angle = thetai; % same point
        else
            angle = (-1)^(vec(2)<0)*pi/2; 
        end
    else
        angle = atan2(vec(2),vec(1));
    % angle = atan2(vec(2),vec(1)); %TODO
    end
    angle = mod(angle,2*pi);
    
    if (angle - thetai)^2 < epsilon
        dist_temp = distance_xy([xi,yi],po);
    end
   
else % circular trajectory

    radius = vi/wi;
    center = [xi-radius*sin(thetai),yi+radius*cos(thetai)];

    if (distance_xy(center,po) - abs(radius))^2 < obstacle_radius % on the trajectory
        vec1 = [xi-center(1), yi-center(2)];
        vec1 = vec1/(sum(vec1.^2))^0.5; % normalise
        vec2 = po - center;
        vec2 = vec2/(sum(vec2.^2))^0.5; % normalise
        dist_angle_temp = acos(sum(vec1.*vec2)); % dot product
        dist_angle_temp = mod(dist_angle_temp,2*pi); % normalise; smaller fraction of 2pi
        % reuse variables
        vec1 = [cos(thetai),sin(thetai)]; % unit vector in the direction of current heading
        vec2 = [po(1)-xi,po(2)-yi]; % vector in direction of obstacle
        vec2 = vec2/(sum(vec2.^2))^0.5; % normalise
        if sum(vec1.*vec2) < 0 % robot heading away from obstacle
            dist_angle_temp = 2*pi - dist_angle_temp;
        end
        dist_temp = abs(radius)*dist_angle_temp;
    end
end




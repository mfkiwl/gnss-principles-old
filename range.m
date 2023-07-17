
% perfect 2D range measurement assuming no noise, bias, or atmospheric delay

function rho = range(xr, yr, xs, ys)

    rho = sqrt((xr - xs)^2 + (yr - ys)^2);
end
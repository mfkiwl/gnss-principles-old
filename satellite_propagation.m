
function [x, y] = satellite_propagation(theta, r)

    x = r*cos(theta);
    y = r*sin(theta);
end
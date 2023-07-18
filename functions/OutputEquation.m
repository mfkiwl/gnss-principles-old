
function y_est = OutputEquation(x, u)

    y_est(1) = norm([x(1); x(2)] - [u(1); u(2)]) + x(3);
    y_est(2) = norm([x(1); x(2)] - [u(3); u(4)]) + x(3);
    y_est(3) = norm([x(1); x(2)] - [u(5); u(6)]) + x(3);
    y_est(4) = norm([x(1); x(2)] - [u(7); u(8)]) + x(3);
end
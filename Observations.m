
function observations = Observations(X_r, M, orbital_radius, noise, std_dev_sat_pos, receiver_clock_bias, dim)

    orbital_positions = orbital_radius*[cos(M); sin(M)] + noise*normrnd(0, std_dev_sat_pos, dim, 1);
    ranges = norm(X_r - orbital_positions) + noise*receiver_clock_bias;

    observations = [orbital_positions; ranges];

end

% for noisy observations set noise = 1, else noise = 0
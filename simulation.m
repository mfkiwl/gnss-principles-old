
rng(1);

%% space allocation

dim = 2;
n_sat = 4;

eta_sim = zeros(N,(dim+1)*n_sat);
eta_sim = zeros(N,(dim+1)*n_sat);

% orbital_positions = zeros(dim, n_sat);
% ranges = zeros(n_sat,1);
satellite_params = zeros(dim+1,n_sat);

%% artificial noise settings

% sigma_sim = 2; % standard deviation of estimated satellite position

% noise = normnrd(0,5, );

%% initial conditions

receiver_angle = deg2rad(25);  % starting receiver angle
X_r = Re*[cos(receiver_angle); sin(receiver_angle)];  % starting receiver location on earth

M0 = deg2rad([0; 10; 20; 30]);  % starting mean anomaly

%% ground truth simulation loop

M = M0;

for k=1:N
    % satellite parameters
    for i=1:n_sat
        satellite_params(:,i) = Observations(X_r, M(i), orbital_radius, 0, 0, 0, dim);
    end

    % write values
    xi_sim(k,:) = reshape(satellite_params,1,[]);

    % orbits propagation
    M_next = M + Mdot*T;
    M = M_next;
end

%% noisy simulation loop

M = M0;

for k=1:N
    % satellite parameters
    for i=1:n_sat
        satellite_params(:,i) = Observations(X_r, M(i), orbital_radius, 1, std_dev_sat_pos, receiver_clock_bias, dim);
    end

    % write values
    eta_sim(k,:) = reshape(satellite_params,1,[]);

    % orbits propagation
    M_next = M + Mdot*T;
    M = M_next;
end

%% ground truth plots 

figure
plot(xi_sim(:,1), xi_sim(:,2))
hold on
plot(xi_sim(:,4), xi_sim(:,5))
plot(xi_sim(:,7), xi_sim(:,8))
plot(xi_sim(:,10), xi_sim(:,11))

figure
plot(0:N-1, xi_sim(:,3))
hold on
plot(0:N-1, xi_sim(:,6))
plot(0:N-1, xi_sim(:,9))
plot(0:N-1, xi_sim(:,12))

%% noisy plots

figure
plot(eta_sim(:,1), eta_sim(:,2))
hold on
plot(eta_sim(:,4), eta_sim(:,5))
plot(eta_sim(:,7), eta_sim(:,8))
plot(eta_sim(:,10), eta_sim(:,11))

figure
plot(0:N-1, eta_sim(:,3))
hold on
plot(0:N-1, eta_sim(:,6))
plot(0:N-1, eta_sim(:,9))
plot(0:N-1, eta_sim(:,12))

%% comparison

figure
plot(xi_sim(:,1), xi_sim(:,2))
hold on
plot(eta_sim(:,1), eta_sim(:,2))
legend('truth', 'noisy')

figure
plot(0:N-1, xi_sim(:,3))
hold on
plot(0:N-1, eta_sim(:,3))
legend('truth', 'noisy')

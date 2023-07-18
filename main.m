
close all

%%

addpath('components', 'functions')

%% plot settings

set(0,'DefaultFigureWindowStyle','docked')
set(0, 'DefaultLineLineWidth', 1.5);
set(0,'defaultAxesFontSize',13)
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

%%

constants

%% sim settings

N = 60*2;  % sim time in sec
T = 1;  % sample time

receiver_angle = deg2rad(45);  % starting receiver angle
X_r = Re*[cos(receiver_angle); sin(receiver_angle)];  % starting receiver location on earth

%% stochastic settings

std_dev_sat_pos = 0;

receiver_clock_drift = 1e-5;  % constant clock error
receiver_clock_bias = c*receiver_clock_drift;

%% prep

simulation

%% ukf

u = [eta_sim(:,1), eta_sim(:,2), eta_sim(:,4), eta_sim(:,5), eta_sim(:,7), eta_sim(:,8), eta_sim(:,10), eta_sim(:,11)];
y = [eta_sim(:,3), eta_sim(:,6), eta_sim(:,9), eta_sim(:,12)];

n_x = dim+1;
n_y = n_sat;

x_est = zeros(N,n_x);
y_est = zeros(N,n_y);

ukf_settings

for k=2:N

    ukf_algorithm

    x_est(k,:) = x_corr;
    y_est(k,:) = OutputEquation(x_corr, u(k,:));
end

%% plot

figure
plot(0:N-1, y(:,1))
hold on
plot(0:N-1, y_est(:,1))
legend('truth', 'estimates')
title('ranges')

figure
yline(X_r(1))
hold on
plot(0:N-1, x_est(:,1))
legend('truth', 'estimates')
ylim([X_r(1)*0.5, X_r(1)*2])
title('x pos')

figure
yline(X_r(2))
hold on
plot(0:N-1, x_est(:,2))
legend('truth', 'estimates')
ylim([X_r(2)*0.5, X_r(2)*2])
title('y pos')

figure
yline(receiver_clock_bias)
hold on
plot(0:N-1, x_est(:,3))
legend('truth', 'estimates')
ylim([receiver_clock_bias*0.5, receiver_clock_bias*2])
title('receiver clock bias')

figure
plot(0:N-1, X_r(1) - x_est(:,1))
hold on
plot(0:N-1, X_r(2) - x_est(:,2))
legend('x', 'y')
title('Receiver Position Error')
ylim([-10, 10])
ylabel('position error (m)')
xlabel('time (s)')

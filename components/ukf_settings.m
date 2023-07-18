
%% constants

alpha = 1e-3;
beta = 2;
kappa = 0;

%% mean and covariance weights

lambda = n_x*(alpha^2 - 1);
eta = sqrt(n_x + lambda);

Wm = zeros(1,2*n_x+1);
Wc = zeros(1,2*n_x+1);
Wm(1) = lambda/(n_x + lambda);
Wc(1) = lambda/(n_x + lambda) + (1 - alpha^2 + beta);
for i=2:2*n_x+1
    Wm(i) = 1/(2*(n_x + lambda));
    Wc(i) = 1/(2*(n_x + lambda));
end

%% sigma points space allocation

X_corr = zeros(n_x, 2*n_x+1);
X_pred = zeros(n_x, 2*n_x+1);
Y_pred = zeros(n_y, 2*n_x+1);

%% space allocation

x_est = zeros(N,n_x);
y_est = zeros(N,n_y);
ukf_var = zeros(N,n_x);

innovation = zeros(N,n_y);
residual = zeros(N,n_y);

%% covariance matrices / tunable hyperparameters

% states
x_corr = zeros(n_x,1);
x_corr(1) = 0;
x_corr(2) = 0;
x_corr(3) = c;

% state uncertainty
P_corr = diag(zeros(1,n_x));
P_corr(1,1) = Re^2;
P_corr(2,2) = Re^2;
P_corr(3,3) = 1000;

% process uncertainty
Q = diag(zeros(1,n_x));
Q(1,1) = 1e-9;
Q(2,2) = 1e-9;
Q(3,3) = 1e-9;

% measurement uncertainty
R = diag(1e-10*ones(1,n_y));

%% first write

x_est(1,:) = x_corr';
y_est(1,:) = OutputEquation(x_corr, u(1,:));

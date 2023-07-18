
%% cholesky
[S_corr, con] = chol(P_corr, 'lower');
if con > 0
    disp('Cholesky error... recovering')
    S_corr = diag(sqrt(abs(diag(P_corr))));
end

%% sigma points
X_corr(:,1) = x_corr;
for i=1:n_x
    X_corr(:,i+1) = x_corr + eta*S_corr(:,i);
    X_corr(:,i+n_x+1) = x_corr - eta*S_corr(:,i);
end

%% prediction
for i=0:2*n_x
    X_pred(:,i+1) = StateEquation(X_corr(:,i+1));
end
x_pred = X_pred*Wm';
P_pred = (X_pred - x_pred)*diag(Wc)*(X_pred - x_pred)' + Q;

for i=0:2*n_x
    Y_pred(:,i+1) = OutputEquation(X_pred(:,i+1), u(k,:));
end
y_pred = Y_pred*Wm';

P_y = (Y_pred - y_pred)*diag(Wc)*(Y_pred - y_pred)' + R;
P_xy = (X_pred - x_pred)*diag(Wc)*(Y_pred - y_pred)';

%% correction
K = P_xy/P_y;

x_corr = x_pred + K*(y(k,:)' - y_pred);
P_corr = P_pred - K*P_y*K';
P_corr = 0.5*P_corr + 0.5*P_corr';

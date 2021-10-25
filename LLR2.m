function [val, beta, ln_val] = LLR2(problem)
%Calculate the Nadaraya-Watson estimator
% problem.X: N x d matrix (training samples)
% problem.Y: N x k matrix (response variables)
% problem.x0: 1 x d vector (target location)
% problem.h: 1 x 1 scalar (bandwidth)
% problem.eps: 1 x 1 scalar (for numerical stablity of inv)

constEPS = problem.eps;

N = size(problem.X, 1);
X_x0 = problem.X - repmat(problem.x0, N, 1); % different between X and X0
Xx = [ones(N, 1) X_x0];

d2_X_x0 = sum(X_x0.*X_x0, 2); % squared L2 (column vec)
kk = exp(-d2_X_x0/problem.h^2);
Wx = diag(kk);

T1 = Xx'*Wx*Xx;
% for numerical
T1 = T1 + constEPS*eye(size(T1,1));

T2 = Xx'*Wx*problem.Y;

val_llr = T1\T2;

val = val_llr(1);
beta = val_llr(2:end);
ln_val = sum(beta(:).*problem.x0(:)) + val;

end

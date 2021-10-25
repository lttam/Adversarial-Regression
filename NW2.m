function [val] = NW2(problem)

%Calculate the Nadaraya-Watson estimator
% problem.X: N x d matrix (training samples)
% problem.Y: N x k matrix (response variables)
% problem.x0: 1 x d vector (target location)
% problem.h: 1 x 1 scalar (bandwidth)

N = size(problem.X, 1);
X_x0 = problem.X - repmat(problem.x0, N, 1); % different between X and X0
d2_X_x0 = sum(X_x0.*X_x0, 2); % squared L2 (column vec)

kk = exp(-d2_X_x0/problem.h^2);
ww = kk/sum(kk);

val = sum(ww .* problem.Y); 

end


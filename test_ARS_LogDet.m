clear all; 
close all;
clc;

rng(0, 'v5uniform');

d = 2;
N = 50; 
X = randn(N, d);
Y = randn(N, 1);

h = 0.5;
%%
problem.X = X;
problem.Y = Y;
problem.h = h;

% Set the type of ambiguity set
problem.grad_f = @grad_f_KL2;
% problem.grad_f = @grad_f_W2;

% Set the function ell and its gradient
problem.ell = @l2;
problem.grad_ell = @grad_l2;

problem.beta = 0;
problem.rho = 0.1;

%%
nTest = 2;
xrange = zeros(nTest, d);
xrange(2, :) = randn(1, d);

predict = zeros(size(xrange, 1), 1);

options = nagd_settings('MaxIter', 50);

for i = 1:size(xrange, 1)
    problem.x0 = xrange(i, :);
    tic
    [beta, obj] = nesterov_agd2(problem, options);
    toc
    predict(i) = beta;
end

predict



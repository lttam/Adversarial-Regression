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

%%
nTest = 2;
xrange = zeros(nTest, d);
xrange(2, :) = randn(1, d);

predict = zeros(size(xrange, 1), 1);

for i = 1:size(xrange, 1)
    problem.x0 = xrange(i, :);
    tic
    predict(i) = NW2(problem);
    toc
end

predict



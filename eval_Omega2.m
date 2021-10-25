function [Omega] = eval_Omega2(X, x0, h)

%This function compute the nominal weighting matrix Omega using Gaussian
%kernel with bandwidth h
%Input 
% X: N x d matrix (training samples)
% x0: 1 x d vector (target location)
% h: 1 x 1 scalar (bandwidth)

Xx0 = [x0; X];
d2_XX = sqdistance(Xx0');
% for numerical
EPS = 1e-20;
d2_XX(abs(d2_XX)<EPS) = 0;
d2_XX = (d2_XX + d2_XX')/2;

Omega = exp(-d2_XX/h^2);

end


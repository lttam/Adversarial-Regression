function [V] = eval_V(beta_var,X,Y,loss_function)
% This function evaluates the matrix V(beta)
% Input:
% beta: p x 1 vector
% X: N x d matrix
% Y: N x k matrix
% loss_function: elementary loss functions

N = size(X, 1);
V = zeros(N+1, N+1);

for i = 1:N
    V(1, i+1) = loss_function(beta_var, X(i,:), Y(i,:));
    V(i+1, 1) = V(1, i+1);
end

end


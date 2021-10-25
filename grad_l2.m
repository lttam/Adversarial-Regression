function [l] = grad_l2(beta, x, y)
% Return the gradient of the L2 regression loss function for Nadaraya-Watson
% output: 2(beta - y)
    l = 2*(beta - y);
end



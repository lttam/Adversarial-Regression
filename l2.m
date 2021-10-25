function [l] = l2(beta, x, y)
% Return the L2 regression loss function for Nadaraya-Watson
% output: (beta - y)^2
    l = (beta - y)^2;
end


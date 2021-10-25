function [g, obj] = grad_f_W2(beta_var, Omega, problem)
% return the gradient for Wasserstein ambiguity set
    
    V = eval_V(beta_var, problem.X, problem.Y, problem.ell);
    I = eye(size(V));
    
    func = @(gamma) obj_func_W(gamma, Omega, V, I, problem.rho);
    options = optimoptions('fmincon','SpecifyObjectiveGradient',true,'Display', 'off');
    gamma_star = fmincon(func, abs(eigs(V,1))+1,[],[],[],[],abs(eigs(V,1)),inf, [], options);
    
    temp = inv_aux_W(gamma_star, I, V);
    Omega_star = gamma_star^2 * temp*Omega*temp;
    
    % Calculate the gradient
    g = 0;
    N = size(problem.X, 1);
    for i = 1:N
        g = g + Omega_star(1, i+1)*problem.grad_ell(beta_var, problem.X(i, :), problem.Y(i,:));
    end
    
    % Calculate the objective value
    obj = trace(Omega_star*V);
end


function [f, g] = obj_func_W(gamma, Omega, V, I, rho)

    if nargout == 1
        f = gamma*(rho - trace(Omega)) + gamma^2*trace((gamma*I - V)\Omega);
    else
        tmp = inv_aux_W(gamma, I, V);        
        % tr(AB) = tr(BA)
        Omega_tmp = Omega*tmp;
        f = gamma*(rho - trace(Omega)) + gamma^2*trace(Omega_tmp);  
        g = rho - trace(Omega - 2*gamma*Omega_tmp + gamma^2*Omega_tmp*tmp);
    end

end

function T = inv_aux_W(gamma, I, V)
% compute inv(gamma*I - V) by Woodbury matrix identity
% Get two largest absolute eigenvalues
[C, B] = eigs(V, 2); % V = cVec*bVal*cVec'

tmp = diag((-diag(B).^(-1) + (1/gamma)).^(-1));
T = I/gamma - gamma^(-2)*C*tmp*C'; 
end



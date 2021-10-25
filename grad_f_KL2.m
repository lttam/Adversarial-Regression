function [g, obj] = grad_f_KL2(beta_var, Omega, problem)
% return the gradient for KL ambiguity set

    % for numerical issue for sqrt(Omega) --> logdet
    EPS = 1e-10;    
    
    V = eval_V(beta_var, problem.X, problem.Y, problem.ell);
    
    % Compute the worst-case weighting matrix Omega_star     
    [Omega_V, Omega_D] = eig(Omega);
    % for numerical issue: machine precision for zeroes
    Omega_D(abs(Omega_D)<EPS) = 0; 
    Omega_half = Omega_V*sqrt(Omega_D)*Omega_V';
    
    D = Omega_half*V*Omega_half;
    I = eye(size(D));
    
    func = @(gamma) obj_func_KL(gamma, D, I, problem.rho);
    options = optimoptions('fmincon','SpecifyObjectiveGradient',true,'Display', 'off');
    gamma_star = fmincon(func, abs(eigs(D,1))+1,[],[],[],[],abs(eigs(D,1)),inf, [], options);
    
    Omega_star = (Omega_half/(I - D/gamma_star))*Omega_half;
    
    % Calculate the gradient
    g = 0;
    N = size(problem.X, 1);
    for i = 1:N
        g = g + Omega_star(1, i+1)*problem.grad_ell(beta_var, problem.X(i, :), problem.Y(i,:));
    end
    
    % Calculate the objective value
    obj = trace(Omega_star*V);
end

function value = logdet(A)
% Compute the log-determinant of A
    value = 2*sum(log(diag(chol(A, 'lower'))));
end

function [f, g] = obj_func_KL(gamma, D, I, rho)
    temp = logdet(I-D/gamma);
    f = gamma*rho - gamma*temp;
    if nargout > 1
        g = rho - temp - trace((I - D/gamma)\D)/gamma;
    end
end




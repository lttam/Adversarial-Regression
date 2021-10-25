function [beta_var, val_obj] = nesterov_agd2(problem, nagd_options)
% Run the Nesterov's accelerated gradient descent to solve the problem

% problem contains all the input parameters
% Using vectorize for Omega

    % copy the parameters of the algorithm
    armijo_max = nagd_options.armijo_max;
    MaxIter = nagd_options.MaxIter;
    tau = nagd_options.tau;
    
    val_obj = zeros(MaxIter,1);
    beta0 = problem.beta;
    beta_prime = beta0;
    t_last = 1;
    theta_last = 1;
    beta_last = beta0;
    
    Omega = eval_Omega2(problem.X, problem.x0, problem.h);
    
    for i = 1:MaxIter
        disp(['...@algIter: ' num2str(i)]);
        
        t = t_last;
        
        [g_prime, val_prime] = problem.grad_f(beta_prime, Omega, problem);
        
        if (norm(g_prime) < nagd_options.gradient_tol)
            fprintf('Algorithm terminates at iteration i = %d, gradient norm = %d.\n',i, norm(g_prime));
            break;
        end
        
        beta_var = beta_prime - t*g_prime;
        
        [g, val] = problem.grad_f(beta_var, Omega, problem);
        
        % Perform armijo search for step size
        armijo = 1;
        while ( (val - val_prime + (t/2)*norm(g_prime)^2 > -1e-10 ) && (armijo < armijo_max) )
            t = t*tau;
            beta_var = beta_prime - t*g_prime;
            [g, val] = problem.grad_f(beta_var, Omega, problem);
            armijo = armijo + 1;
        end
        
        val_obj(i) = val;
        if (armijo == 1)
            t_last = 10;
        else
            t_last = 10*t;
        end
        
        
        theta = (1 + (1 + 4*theta_last^2)^(0.5))/2;
        beta_prime = beta_var + ((theta_last - 1)/theta)*(beta_var - beta_last);
        
        beta_last = beta_var;
        theta_last = theta;

        % Restart
        % Function value scheme
        if ( i>1 && val_obj(i) > val_obj(i-1) )
            theta_last = 1;
        end
    end
    % end of iterative algorithm
    
    if (i<MaxIter)
        if i==1
            beta_var = beta_prime;
            val_obj = val_prime;
            fprintf('Initialized value satisfies the gradient norm constraint');
        else
            val_obj(i:MaxIter) = val_obj(i-1)*ones(MaxIter-i+1,1);
        end
    else
        fprintf('Iteration limit reached. gradient norm = %s.\n',norm(g));
    end
end


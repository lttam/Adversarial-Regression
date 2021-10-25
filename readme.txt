+++++ Code for the submission: +++++
"Adversarial Regression with Doubly Non-Negative Weighting Matrices"

===== + Requirement:
- Matlab Optimization Toolbox (for fmincon function)

===== + Details:
- datasets folder: contains all 8 datasets (X: #samples x #features, Y: label)

- nesterov_agd2.m: The Nesterov's accelerated gradient descent to solve the adversarial reweighting problem
- nagd_settings.m: parameter setting for the Nesterov's accelerated gradient descent (nesterov_agd2.m)

- l2, grad_l2: squared loss and its gradients for the adversarial reweighting problems

- grad_f_KL2: compute the gradient for adversarial reweighting problem with log-determinant ambiguity set
- grad_f_W2: compute the gradient for adversarial reweighting problem with Bures-Wasserstein ambiguity set

- eval_V: this function evaluates the matrix V(beta) of the adversarial reweighting schemes
- eval_Omega2: this function computes the nominal weighting matrix Omega using Gaussian kernel with bandwidth h

- NW2: Nadaraya-Watson estimate
- LLR2: locally linear regression estimate

- test_ARS_Bures.m / test_ARS_LogDet.m: toy examples for using the adversarial reweighting schemes
using Bures-Wasserstein uncertainty set, and using the log-determinant uncertainty set respectively.
- test_NW: toy example for Nadaraya-Watson estimate.

===== + For the baseline NWMetric [Noh et al., 2017]
- Code is available at: https://github.com/nohyung/Nadaraya-Watson-Regression-Metric





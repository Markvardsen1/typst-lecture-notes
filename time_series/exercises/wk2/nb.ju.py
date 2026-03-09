# %%
import numpy as np
from scipy import stats

# X = np.array([4.0, 4.0, 3.5, 4.0, 2.0, 2.5, 1.5])
# Y = np.array([1.0, 0.5, 2.0, 2.0, 3.5, 3.0, 4.0])
#
# # %%
# ## Printing sums of X and Y
# print(np.sum(X))
# print(np.sum(Y))
# print(np.sum(X**2))
# print(np.sum(X * Y))
#
# # %%
# # model achieved
# theta_0 = 5.781
# theta_1 = -1.138
#
#
# def y(x):
#     return theta_0 + theta_1 * x
#
#
# epsilon = Y - y(X)
# print(epsilon)
# print(epsilon**2)
#
# # %%
# # variance is then
# sigma_2 = (np.sum(epsilon**2)) / (len(Y) - 2)
# print(sigma_2)
# # sigma^2 = 0.245
#
# # %%
#

# %%

# 1. Input the data from Table 3.2 [4]
t = np.array([5 - 11])
y = np.array([1.0, 0.5, 2.0, 2.0, 3.5, 3.0, 4.0])
x_vals = np.array([4.0, 4.0, 3.5, 4.0, 2.0, 2.5, 1.5])

# %%

# 2. Set up the Design Matrix (x) and Observation Vector (Y) [1]
# We add a column of 1s to account for the intercept (theta_0)
N = len(y)
p = 2  # Number of parameters (intercept and slope)
X = np.column_stack((np.ones(N), x_vals))
Y = y.reshape(-1, 1)

# %%
# 3. Estimate Parameters (theta_hat) using Theorem 3.1 [1]
# theta_hat = (X^T * X)^-1 * X^T * Y
xtx = X.T @ X
xtx_inv = np.linalg.inv(xtx)
theta_hat = xtx_inv @ X.T @ Y

intercept, slope = theta_hat.flatten()
print(f"Model: Y_hat = {intercept:.3f} + ({slope:.3f}) * x")

# %%
# 4. Estimate Noise Variance (sigma_hat^2) using Theorem 3.4 [12]
residuals = Y - (X @ theta_hat)
sse = np.sum(residuals**2)
sigma_sq_hat = sse / (N - p)
sigma_hat = np.sqrt(sigma_sq_hat)

# %%
# 5. Predict for a new x value (e.g., x_8 = 0.5 from Exercise 3.1) [4]
x_new_val = 0.5
x_new = np.array([1, x_new_val])
y_pred = x_new @ theta_hat

# %%
# 6. Calculate 95% Prediction Interval using Theorem 3.10 & Eq 3.61 [2, 3]
# alpha = 0.05 for 95% confidence
alpha = 0.1
df = N - p
t_val = stats.t.ppf(1 - alpha / 2, df)  # This replaces the need for t-tables

# Scaling factor: sqrt(1 + x_new^T * (X^T * X)^-1 * x_new)
margin_sq = 1 + x_new.T @ xtx_inv @ x_new
margin_error = t_val * sigma_hat * np.sqrt(margin_sq)

lower_bound = y_pred - margin_error
upper_bound = y_pred + margin_error

print(f"\nPrediction for x = {x_new_val}: {y_pred:.3f}")
print(f"95% Prediction Interval: [{lower_bound:.3f}, {upper_bound:.3f}]")

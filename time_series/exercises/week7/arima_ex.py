import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
from statsmodels.tsa.arima_process import arma_generate_sample
from statsmodels.tsa.statespace.sarimax import SARIMAX
from scipy.signal import lfilter

# Set seed for reproducibility
np.random.seed(2)

# ----------------------------------------------------------------
# 1. Transfer Function Investigation
# ----------------------------------------------------------------
n = 500
x = np.concatenate([np.zeros(100), np.ones(n - 100)])

# y_t = 0.98 * y_{t-1} + x_t
y_pure = lfilter([1.0], [1.0, -0.98], x)
# Add AR(1) noise: phi = 0.7
ar_params = np.array([1, -0.7])
ma_params = np.array([1])
noise = arma_generate_sample(ar_params, ma_params, n)
y = y_pure + noise

# Fit ARIMA with xreg (SARIMAX in Python)
# order=(p, d, q)
m1 = SARIMAX(y, exog=x, order=(2, 0, 0)).fit(disp=False)
print(m1.summary())

# Predict
# For one-step ahead with original xreg
pred1 = m1.get_prediction(exog=x).predicted_mean

# ----------------------------------------------------------------
# 2. Harmonic Oscillation + Noise
# ----------------------------------------------------------------
n_harm = 300
t = np.arange(1, n_harm + 1)
noise_harm = arma_generate_sample([1, -0.9], [1], n_harm)

# Signal: Amplitude 5 * sin(...) + 2
amplitude = 5
det = amplitude * np.sin(0.1 * t + 1) + 2
signal = det + noise_harm

# Harmonic Regressors (xreg)
exog_harm = pd.DataFrame({
    'sin': np.sin(0.1 * t),
    'cos': np.cos(0.1 * t)
})

# Fit AR(1) with Harmonic xreg
# include_intercept=True is default via 'c' in trend or just having the mean in SARIMAX
a3 = SARIMAX(signal, exog=exog_harm, order=(1, 0, 0), trend='c').fit(disp=False)

# Forecasting 100 steps ahead
t_future = np.arange(301, 401)
exog_forecast = pd.DataFrame({
    'sin': np.sin(0.1 * t_future),
    'cos': np.cos(0.1 * t_future)
}, index=t_future)

forecast_res = a3.get_forecast(steps=100, exog=exog_forecast)
mean_forecast = forecast_res.predicted_mean
conf_int = forecast_res.conf_int(alpha=0.05) # 95% CI

# Plotting
plt.figure(figsize=(10, 5))
plt.plot(t, signal, label='Observed')
plt.plot(t_future, mean_forecast, color='green', label='Harmonic xreg Forecast')
plt.fill_between(t_future, conf_int.iloc[:, 0], conf_int.iloc[:, 1], color='green', alpha=0.2)
plt.title("Harmonic Oscillation Forecast")
plt.legend()
plt.show()

# ----------------------------------------------------------------
# 3. Linear Trend (Drift) + Noise
# ----------------------------------------------------------------
n_trend = 300
t_trend = np.arange(1, n_trend + 1)
noise_trend = arma_generate_sample([1, -0.9], [1, 0.6], n_trend)
signal_trend = (0.05 * t_trend + 2) + noise_trend

# Python SARIMAX handles drift via the 'trend' parameter
# 'c' = intercept, 't' = time trend, 'ct' = both
a5 = SARIMAX(signal_trend, order=(1, 0, 1), trend='ct').fit(disp=False)
print(a5.summary())

# Predict 100 steps
forecast_trend = a5.get_forecast(steps=100)
mean_t_forecast = forecast_trend.predicted_mean

plt.figure(figsize=(10, 5))
plt.plot(t_trend, signal_trend, label='Data')
plt.plot(np.arange(301, 401), mean_t_forecast, label='Forecast with Trend', color='red')
plt.legend()
plt.show()
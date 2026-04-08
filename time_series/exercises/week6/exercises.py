import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
# The following time series {yt}is supposed to be the Danish krone (DKK) to the
# US dollar (USD) exchange rate (DKK/100$) over a period of 20 weeks. Each
# number in Table 6.3 shows the average exchange rate of the corresponding
# week.
#
#
# Question 1 Sketch the time series. Is the time series stationary?
# DKK/100 USD example

DKK_100_USD = np.array(
    [
        1084,
        1052,
        1028,
        1035,
        1013,
        1029,
        998,
        980,
        976,
        967,
        955,
        934,
        922,
        949,
        956,
        940,
        942,
        919,
        906,
        885,
    ]
)
t = np.arange(1, len(DKK_100_USD) + 1)

plt.plot(t, DKK_100_USD, marker="o")
plt.show()

# Answer 1: The time series is clearly n
# not staionary as the plot does not converge
# towards some average

## Question 2 Find a transformation that gives an acceptable stationary time
# series and sketch the generated time series xt.

# We will model it by looking on the difference from the price
# at time t and the price at time t-1

diff_step = 1
rate_of_change = np.diff(DKK_100_USD, n=diff_step)

plt.plot(t[diff_step:], rate_of_change, marker="o")
plt.show()

# Question 3 Estimate the autocorrelation function (lag ≤5) for {Xt}and sketch
# the result.

acf = sm.tsa.acf(rate_of_change)
print(acf)
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(12, 4))
sm.graphics.tsa.plot_acf(rate_of_change, lags=8, ax=axes[0])
sm.graphics.tsa.plot_pacf(rate_of_change, lags=8, ax=axes[1])
plt.show()

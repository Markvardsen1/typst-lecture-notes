import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
## plotting acf function


def theoretical_acf_AR(phi_1, phi_2, n_lags=30):

    acf = np.zeros(n_lags)
    acf[0] = 1.0
    acf[1] = -(phi_1) / (1 + phi_2)
    acf[2] = ((phi_1**2) / (1 + phi_2)) - phi_2

    for k in range(2, n_lags - 1):
        acf[k + 1] = -phi_1 * acf[k] - phi_2 * acf[k - 1]

    return acf


if __name__ == "__main__":
    phi_1 = -7 / 10
    phi_2 = -1 / 5

    acf = theoretical_acf_AR(phi_1, phi_2)
    plt.plot(acf, marker="o")
    plt.show()
    # 1. Simulate an AR(1) process: x_t = 0.7 * x_{t-1} + e_t
    # Note: statsmodels uses the form (1 - phi_1*L - phi_2*L^2)x_t = e_t
    # So for phi=0.7, we input [1, -0.7]
    ar_coeffs = np.array([1, -0.7, -0.2])
    ma_coeffs = np.array([1])

    process = sm.tsa.ArmaProcess(ar_coeffs, ma_coeffs)
    acf_values = process.acf(lags=31)

    plt.stem(range(31), acf_values)
    plt.xlabel("Lag")
    plt.ylabel("rho(k)")
    plt.show()

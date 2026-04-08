import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.statespace.sarimax import SARIMAX
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf


def run_seasonal_simulations():
    # Model definitions: (p,d,q), (P,D,Q,s), [parameters], title
    # Note: parameters follow order [ar, ma, sar, sma, sigma2]
    models = [
        ((1, 0, 0), (0, 0, 0, 12), [0.6, 1.0], "2.1: AR(1)"),
        ((0, 0, 0), (1, 0, 0, 12), [-0.9, 1.0], "2.2: SAR(1)_12"),
        ((1, 0, 0), (0, 0, 1, 12), [0.9, -0.7, 1.0], "2.3: AR(1) x SMA(1)_12"),
        ((1, 0, 0), (1, 0, 0, 12), [-0.6, -0.8, 1.0], "2.4: AR(1) x SAR(1)_12"),
        ((0, 0, 1), (0, 0, 1, 12), [0.4, -0.8, 1.0], "2.5: MA(1) x SMA(1)_12"),
        ((0, 0, 1), (1, 0, 0, 12), [-0.4, 0.7, 1.0], "2.6: MA(1) x SAR(1)_12"),
    ]

    for order, s_order, params, title in models:
        # Initialize model with dummy data to access simulation
        mod = SARIMAX(
            np.zeros(100),
            order=order,
            seasonal_order=s_order,
            enforce_stationarity=False,
            enforce_invertibility=False,
        )

        # Generate 250 observations (50 burn-in + 200 for plotting)
        y = mod.simulate(
            nsimulations=100,
            params=params,
            repetitions=2,
            initial_state=np.zeros(mod.k_states),
        )
        print(f"y has shape {y.shape}")
        fig = plt.figure(figsize=(12, 6))
        gs = fig.add_gridspec(nrows=2, ncols=2)
        ax_ts = fig.add_subplot(gs[0, :])
        ax_acf = fig.add_subplot(gs[1, 0])
        ax_pacf = fig.add_subplot(gs[1, 1])

        fig.suptitle(title, fontsize=14, fontweight="bold")
        plt.style.use("seaborn-v0_8-poster")
        colors = ["#008080", "#E67E22", "#34495E"]
        # Time Series Plot
        ax_ts.set_prop_cycle(color=colors)
        ax_ts.plot(
            y[:, 0, :2],
            lw=1.5,
            alpha=0.5,
        )
        ax_ts.set_xlabel("Time")
        ax_ts.set_ylabel("Value")
        ax_ts.legend([f"Realization {i + 1}" for i in range(2)], loc="upper right")
        n = len(y[:, 0, 0])

        for x in range(0, n, 12):
            ax_ts.axvline(x, color="gray", linestyle="--", alpha=0.5)

        ax_ts.set_title("Simulated Path for 3 realizations")

        # ACF Plot
        plot_acf(y[:, 0, 0], lags=36, ax=ax_acf, title="ACF (3 seasonal cycles)")

        # PACF Plot
        plot_pacf(
            y[:, 0, 0],
            lags=35,
            ax=ax_pacf,
            title="PACF (3 seasonal cycles)",
            method="ywm",
        )

        plt.tight_layout()
        plt.show()


if __name__ == "__main__":
    run_seasonal_simulations()

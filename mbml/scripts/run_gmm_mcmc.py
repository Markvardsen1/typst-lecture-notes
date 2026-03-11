import torch
import pyro
import pyro.distributions as dist
from pyro import plate
from pyro.infer import MCMC, NUTS
from sklearn.datasets import make_blobs
import numpy as np

def gmm(data=None, K=2):
    # Prior for the mixing proportions
    weights = pyro.sample("weights", dist.Dirichlet(torch.ones(K)))
    # Priors for the mixture components
    with plate('components', K):
        mu = pyro.sample('mu', dist.Normal(torch.zeros(2), 5.*torch.ones(2)).to_event(1))
        sigma = pyro.sample('sigma', dist.HalfCauchy(5.*torch.ones(2)).to_event(1))
    with plate('data', len(data)):
        assignment = pyro.sample('assignment', dist.Categorical(weights), infer={"enumerate": "parallel"})
        points = pyro.sample('obs', dist.Normal(mu[assignment], sigma[assignment]).to_event(1), obs=data)
    return points

if __name__ == "__main__":
    pyro.clear_param_store()
    pyro.set_rng_seed(0)

    # generate the same dataset as in the notebook
    X, y_true = make_blobs(n_samples=100, centers=2, cluster_std=0.60, random_state=0)
    X = X[:, ::-1].astype(np.float32)
    X_torch = torch.from_numpy(X).float()

    # Run with a single chain (works well in notebooks / interactive)
    print("Running MCMC with num_chains=1")
    nuts = NUTS(gmm)
    mcmc_single = MCMC(nuts, num_samples=1000, warmup_steps=500, num_chains=1)
    mcmc_single.run(X_torch)
    print(mcmc_single.summary())

    # Run with multiple chains (requires running this script, not a notebook)
    print("\nRunning MCMC with num_chains=4")
    nuts = NUTS(gmm)
    mcmc_multi = MCMC(nuts, num_samples=1000, warmup_steps=500, num_chains=4)
    mcmc_multi.run(X_torch)
    print(mcmc_multi.summary())
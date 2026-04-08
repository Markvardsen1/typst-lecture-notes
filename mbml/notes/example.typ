#import "../../base/template.typ": *

#let title = "Model Based Machine Learning"
#let author = "Mathias Markvardsen"
#let professor = "Filipe"
#let creater = "Beitian Ma"
#let time = "Spring 2026"
#let abstract = lorem(60)

#show: note_page.with(title, author, professor, creater, time, abstract)

== Week 9 Monte Carlo Methods
Markov Chain Monte Carlo (MCMC) is a powerful method for sampling from complex probability distributions. It is widely used in Bayesian statistics and machine learning for inference and optimization tasks.

*How it works:*

The method is used when you wish to determine the latent variables $bold(z)$ given the observations $bold(x)$. The goal is to sample from the posterior distribution $p(bold(z) | bold(x))$, which is often intractable. MCMC constructs a Markov chain that has the desired distribution as its equilibrium distribution. By simulating the chain for a long time, we can obtain samples that approximate the target distribution.

We use these methods when an analytical approach is not feasible and we need to rely on numerical methods to approximate the posterior distribution. MCMC allows us to generate samples from the posterior, which can then be used for various inference tasks, such as estimating parameters, making predictions, or performing model selection.

==== Reasons for intractability of the posterior distribution
- Dimensionality of the latent space is too high to work with directly.
- Posterior distribution has a highly complex form for which expectations are not analytically tractable.

== Monte Carlo Methods
In most cases, the posterior distribution $p(bold(z) | bold(x))$ is required only for evaluating expectations of the form:

$ op("E")_p(z|x) [f(x)] = integral f(z) p(z|x) dif z $

- (Note: we are using $z$ to denote the variables whose posterior we wish to infer!)
- For example, the mean of $z$ is given by:

$ op("E")_p(z|x) [z] = integral z p(z|x) dif z $

- The idea behind sampling methods is to obtain a set of samples $z^((s))$, for $s in {1, ..., S}$, drawn independently from the distribution $p(z|x)$.
- This allows us to approximate expectations as finite sums:

$ op("E")_p(z|x) [f(x)] approx 1/S sum_(s=1)^S f(z^((s))) $

=== Example: Making Predictions
- Let $z$ denote the parameters of our model (e.g., Bayesian logistic regression).
- Let $D = {x_n, y_n}_(n=1)^N$ denote our dataset of observed variables.
- In this case, the posterior is $p(z | D)$.
- Suppose we wish to make a prediction $y^*$ for a new observation $x^*$:

$
  op("E")_p(z|D) [p(y^* | x^*, z)] = integral p(y^* | x^*, z) p(z | D) dif z approx 1/S sum_(s=1)^S p(y^* | x^*, z^((s)))
$

Where $z^((s)) ~ p(z|D)$. This is model averaging over all parameters.

Notice that:
$ 1/S sum_(s=1)^S p(y^* | x^*, z^((s))) != p(y^* | x^*, z^((s))) $

Even if the posterior $p(bold(z) | bold(D))$ is intractable, we can still make predictions by sampling from the posterior and averaging over the samples.

#let p_z_d = $p(bold(z) | D)$
But if #p_z_d is intractable, how do we sample from it? This is where MCMC comes in.

The Monte Carlo estimator is *unbiased*, meaning the expected value of the estimator equals the true value. However, it can have high variance. Because of the *Law of Large Numbers*, averages of i.i.d. samples converge to the true expectation as $S -> infinity$.

#image("images/2026-04-08_13-29-56.png", width: 60%)

=== Sampling from Distributions
- Draw mass to the left of point: $u ~ op("Uniform")(0,1)$
- Use inverse CDF to find corresponding point: $z = F^(-1)(u)$

#image("images/2026-04-08_13-31-21.png", width: 60%)

Keep in mind that we cannot always compute and invert the CDF $F^(-1)(u)$. In Bayesian inference, we often have:

$ p(z|x) = (p(x|z)p(z)) / (integral p(x|z)p(z) dif z) $

In many cases, the denominator is intractable. However, we have easy access to the *unnormalized posterior* $tilde(p)(z|x) = p(x|z)p(z)$, which is sufficient for MCMC.

== Rejection Sampling
Suppose we wish to sample from the unnormalized distribution $tilde(p)(z) approx p(z)$.

- Construct a *proposal distribution* $k q(z)$ such that $k q(z) >= tilde(p)(z)$ for all $z$.

#image("images/2026-04-08_13-39-40.png", width: 60%)

1. Draw a sample $z^* ~ q(z)$.
2. Draw a uniform height $u ~ op("Uniform")(0, k q(z^*))$.
3. *Reject* if $u > tilde(p)(z^*)$; otherwise *accept* $z^*$ as a sample from $p(z)$.

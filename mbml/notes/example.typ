#import "template.typ": *

#let title = "Model Based Machine Learning"
#let author = "Mathias Markvardsen"
#let professor = "Filipe"
#let creater = "Beitian Ma"
#let time = "Spring 2026"
#let abstract = lorem(60)

#show: note_page.with(title, author, professor, creater, time, abstract)

= MBML
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

== Importance Sampling
importance sampling is very similar to rejection sampling we simply multiply $q(z)$

$
  op("E")_p(z) [f(z)] = integral f(z) p(z) dif z = integral f(z) (p(z)/q(z)) q(z) dif z approx 1/S sum_(s=1)^S f(z^((s))) (p(z^((s)))/q(z^((s))))
$
wehre $z^((s)) ~ q(z)$.

- the ratio $p(z^(s)) / q(z^(s))$ is called the *importance weight* of the sample $z^(s)$.

all in all the 2 monte carlo methods (rejection sampling and importance sampling) performs poorly when dimensionality of the latent space is high, and the posterior distribution has a complex form. This is because the proposal distribution $q(z)$ may not be a good fit for the target distribution $p(z)$, leading to a high rejection rate in rejection sampling and high variance in importance sampling.

Therefore we will now consider Markov Chain Monte Carlo (MCMC) methods, which are designed to address these issues by constructing a Markov chain that has the desired distribution as its equilibrium distribution.

== Markov Chain Monte Carlo (MCMC)

=== Metropolis-Hastings Algorithm

+ Start with some initial state *z* and iterate the following steps:
+ Perturb variables using proposal distribution $q(z' | z)$ to get a new state $z'$. e.g. $q(z' | z) = op("Normal")(bold(z')|bold(z), sigma^2 bold(I))$
+ Accept the new state with probability: $min(1, tilde(p)(bold(z')) / tilde(p)(bold(z)))$
+ in other words always accept

Essentially we do some sort of random walk until we reach a sort of minimum of the unnormalized posterior distribution, and then we will be sampling from the high density region of the posterior distribution.
https://arogozhnikov.github.io/2016/12/19/markov_chain_monte_carlo.html


= Week 11 : Varitional inference


#image("images/2026-04-15_13-07-24.png", width: 60%)

A practical example on Bayesian Gaussian Mixture moddels.

How to choose a tractable family of distributions $Q$? We can use the *mean-field* approximation, which assumes that the latent variables are independent:

for example assume fully factorized distribution:

$ q(bold(z)) = product_(i=1)^M q_i(z_i) $

This is called *mean-field approximation*.

#image("images/2026-04-15_13-25-03.png", width: 60%)

step 2 : What does it mean to be close to the true posterior distribution?

In most cases Kullback-Leibler (KL) divergence is used to measure the distance between the true posterior distribution $p(z|x)$ and the variational distribution $q(z)$:

$
  op("KL")(q(z) || p(z|x)) = integral q(z) log(q(z) / p(z|x)) dif z
  = op("E")_q [log(q(z) / p(z|x))]
$

the "||" is a notation for KL divergence, which is not symmetric. It measures how much information is lost when we approximate $p(z|x)$ with $q(z)$.


#image("images/2026-04-15_13-32-00.png", width: 60%)

If you flip the KL divergence, you get a different optimization problem:
this is called Expectation Propagation (EP), which is another variational inference method. It minimizes $op("KL")(p(z|x) || q(z))$ instead of $op("KL")(q(z) || p(z|x))$. This can lead to different approximations, as it tends to focus on fitting the modes of the distribution rather than the tails.

So in the figure above in a) the EP is moment-matching, which means it tries to match the moments of the distribution, while in b) the VI is mode-seeking, which means it tries to find the mode of the distribution. It finds the local minima.

Our goal is to find the variational parameters $nu^*$, such that:

$
  bold(nu)^* = arg min_bold(nu) op("KL")(q(z|bold(nu)) || p(z|x))
  = arg min_bold(nu^*) integral_z q(z|nu) log(q(z|bold(nu)) / p(z|x)) dif z
$
note : nu is the greek letter even though typst cannot read it.

Unfortunately, the KL divergence is intractable because it involves the true posterior distribution $p(z|x)$, which is intractable. However, we can derive an alternative objective function called the *Evidence Lower Bound* (ELBO), which is tractable and can be optimized instead.

The function we aim to be able is to minimize is equal to KL divergence up to an additive constant:


#image("images/2026-04-15_13-47-58.png", width: 60%)
$
  bb(K L)(q(bold(z)) || p(bold(z) | bold(x)))
  &= bb(E)_q [ log frac(q(bold(z)), p(bold(z) | bold(x))) ] \
  &= bb(E)_q [ log q(bold(z)) ] - bb(E)_q [ log p(bold(z) | bold(x)) ] \
  &= bb(E)_q [ log q(bold(z)) ] - bb(E)_q [ log frac(p(bold(z), bold(x)), p(bold(x))) ] \
  &= -(bb(E)_q [ log p(bold(z), bold(x)) ] - bb(E)_q [ log q(bold(z)) ]) + log p(bold(x)) \
  &= -cal(L)(q) + log p(bold(x))
$
- the log $p(x)$ does not depend on q and thus is can be ignored.
- Minimizig the KL divergence is then equivalent to maximizing the ELBO:
- $cal(L)_q = bb(E)_q [ log p(bold(z), bold(x)) ] - bb(E)_q [ log q(bold(z)) ]$ is called *evidence lower bound* (ELBO) because it is a lower bound on the log evidence $log p(x)$.


#image("images/2026-04-15_13-52-53.png", width: 60%)

- The ELBO $cal(L)_q$ is tight when $q(bold(z)) approx p(bold(z) | bold(x))$, which means that the variational distribution is a good approximation of the true posterior distribution.

This can be derived from $log p(x)$

$
  log p(x) & = log integral p(z, x) dif z \
           & = log integral q(z) frac(p(z, x), q(z)) dif z \
           & = log bb(E)_q [ frac(p(z, x), q(z)) ] \
           & >= bb(E)_q[log p(z, x)] - bb(E)_q[log q(z)] \
$

Where the inequality is due to Jensen's inequality, which states that the log of an expectation is greater than or equal to the expectation of the log.

$
  log bb(E)[p(x)] >= bb(E)[log(p(x))]
$

So now we can optimize the ELBO by an *optimization algorithm* such as gradient ascent or coordinate ascent. The choice of optimization algorithm depends on the specific problem and the structure of the variational distribution.

so at converge we can state

- $q(z) approx p(z|x)$
- $cal(L)_q approx log p(x)$

=== Two different perspective on the ELBO $cal(L)_q$

#image("images/2026-04-15_14-10-48.png", width: 85%)



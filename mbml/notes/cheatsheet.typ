#set page(
  margin: (x: 1cm, y: 1cm),
  columns: 2,
  numbering: "1",
)
#set text(font: "Libertinus Serif", size: 8pt)
#show heading: set text(fill: navy)

= MBML Revision Cheat Sheet

== 1. Probabilistic Foundations
*Sum Rule (Marginalization):*
$p(x) = sum_y p(x, y)$

*Product Rule (Chain Rule):*
$p(x, y) = p(y|x)p(x)$

*Misleading Identities:*
$p(A|B) = sum_c p(A, C | B)$
is true, but:
$p(A|B) = sum_c p(A | B, C)$
is not true, because $p(A|B)$ is not necessarily equal to $p(A|B, C)$ for all $C$.

*Bayes' Theorem:*
$ p(theta | D) = (p(D|theta) p(theta)) / p(D) $
- $p(theta|D)$: Posterior
- $p(D|theta)$: Likelihood
- $p(theta)$: Prior
- $p(D)$: Evidence (Marginal Likelihood)

== 2. PGM Representation
- *Nodes:* Represent Random Variables.
  - *Shaded:* Observed data.
  - *Unshaded:* Latent/Hidden variables.
- *Edges:* Probabilistic dependencies.
- *Plates:* Denote $N$ independent repetitions of the enclosed variables.
- *Joint Factorization:* A PGM defines the joint distribution as the product of all nodes conditioned on their parents:
$ p(x_1, ..., x_n) = product_(i=1)^n p(x_i | "parents"(x_i)) $

== 3. Independence & D-Separation
$x perp perp y | z$ means $x$ is independent of $y$ given $z$.
- *Tail-to-Tail:* $x <- z -> y$. Path blocked if $z$ is observed.
- *Head-to-Tail:* $x -> z -> y$. Path blocked if $z$ is observed.
- *Head-to-Head (Collider):* $x -> z <- y$. Path *open* if $z$ (or its descendants) is observed. This is "explaining away."

== 4. Frequentist vs. Bayesian
- *Frequentist:* Parameters $theta$ are fixed. We find $theta_"MLE"$ by maximizing $p(D|theta)$.
- *Bayesian:* Parameters are Random Variables with distributions. We seek the full posterior $p(theta|D)$.
- *Conjugate Priors:* If the prior and posterior are in the same family (e.g., Beta prior + Bernoulli likelihood = Beta posterior), inference is exact and easy.

== 2.1 D-seperation algorithm
For any expression "is *x* independent of *y* given *z*" (formally, $x perp perp y | z$):
+ Draw the ancestral graph:
  - It is the part of the original graph that has only the variable sets *x*, *y* and  *z*, and all their ancestors among them.
+ Moralize the graph by marrying the parents.
  - For each pair of variables with a common child, draw an undirected edge between them. (if a variables has more than one parent, connect all parents with undirected edges).
+ Disorient the graph by replacing all edges for undirected edges.
+ Delete the variables *z* (and any other observed variables not explicitly included in *z*), and their edges.

// #v(1fr)
#block(fill: luma(240), inset: 8pt, radius: 4pt)[
  Analysis of the result:
  - if *x* and *y* are *disconnected*, then they are unconditionally independent given *z!*.
    - Being disconnected means that there is no path between *x* and *y* in the resulting graph.
  - Otherwise, they are not proven to be independent.
]


== 5. Regression Models
- *Linear-Gaussian:* $y tilde "Normal"(beta^T x, sigma^2)$. Assumes constant noise (homoscedastic).
- *Poisson Regression:* Used for count data (e.g., taxi pickups). $y tilde "Poisson"(lambda)$ where $lambda = exp(beta^T x)$.
- *Heteroscedastic:* Noise $sigma^2$ is not constant but depends on input $x$: $sigma^2(x)$.

#colbreak()
== 6. Classification
- *Logistic Regression:* For binary $y in \{0, 1\}$.
$ p(y=1 | x) = sigma(beta^T x) = 1 / (1 + e^(-beta^T x)) $
- *Categorical:* Extension to $K$ classes using the Softmax function.
- *Hierarchical Models:* Parameters vary by group (e.g., individual habits in travel data).

== 7. Mixture Models (Latent Variables)
Used for clustering or modeling multi-modal data.
- *Generative Story:*
  1. Draw mixing proportions $pi tilde "Dirichlet"(alpha)$.
  2. For each component $k$, draw parameters $theta_k$.
  3. For each data point $n$:
    - Draw assignment $z_n tilde "Categorical"(pi)$.
    - Draw data $x_n tilde p(x | theta_(z_n))$.

== 8. Probabilistic Programming (Pyro)
- `pyro.sample("name", dist, obs=data)`: Defines a random variable. If `obs` is provided, it's an observed node.
- `pyro.plate("name", size)`: Creates a plate for vectorized operations.
- *Inference:* Translates the model into an algorithm (MCMC or Variational Inference) to find the posterior.

#block(fill: luma(240), inset: 8pt, radius: 4pt)[
  *Exam Tip:* When asked for a "Generative Story," always write it as a step-by-step sampling process.
  Furthermore, when asked to draw the corresponding PGM. Even if the "Generative Story" describes specific distributions, the PGM should only include the random variables and their dependencies, without specifying the exact distributions. Thereby, keeping it more abstract and general.
]

== 8. Temporal Models
- *Markov Assumption:* $p(y_t | y_(1:t-1)) = p(y_t | y_(t-1))$. Future independent of past given present.
- *AR(M):* $y_t = sum_(i=1)^M beta_i y_(t-i) + epsilon$. Direct observations; noise accumulates in state.
- *SSM / LDS:* Separates latent "truth" ($h_t$) from noisy observations ($y_t$).
  - *Trans:* $h_t = A h_(t-1) + eta_t, quad eta_t tilde cal(N)(0, R)$
  - *Emiss:* $y_t = C h_t + epsilon_t, quad epsilon_t tilde cal(N)(0, sigma^2)$
- *Inference Types:* *Filtering* $p(h_t | y_(1:t))$ (live), *Smoothing* $p(h_t | y_(1:T))$ (post-hoc), *Prediction* $p(y_(t+k) | y_(1:t))$ (forecast).
- *HMM:* Discrete latent states $h_t$. Uses *Forward-Backward* or *Viterbi* (most likely sequence).
- *Extensions:* *EKF* (Non-linear via Taylor expansion), *SLDS* (Discrete $z_t$ switches between linear regimes).

#table(
  columns: (1.2fr, 1fr, 1.5fr),
  inset: 3pt,
  align: horizon,
  [*Model*], [*Latent $h_t$*], [*Key Tool*],
  [AR(M)], [None], [MLE / OLS],
  [LDS / SSM], [Continuous], [Kalman Filter],
  [HMM], [Discrete], [Forward-Backward],
  [EKF], [Non-linear], [Linearization],
)

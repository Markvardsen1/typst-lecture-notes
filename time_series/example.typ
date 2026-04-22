#import "../base/template.typ": *

#let title = "Time Series Analysis"
#let author = "Mathias Markvardsen"
#let professor = "Henrik M. Pedersen"
#let creater = "M. Markvardsen"
#let time = "Spring 2025"
#let abstract = lorem(60)

#show: note_page.with(title, author, professor, creater, time, abstract)

= Abstract Integration
#lorem(80)

#definition[#lorem(60)]

#lorem(60)

== Set-theoretic notations and terminology

#lorem(40)

#notefig("images//plot1.svg", width: 40%)

#lorem(60)

#definition[
  This is a test to see how defition works. And to be fair it works just fine.
]

#lorem(60)

$ cal(A) := { x in RR | x "is natural" } $

#lorem(10)

#theorem[

  This is the a test to see hwo theorems work. And to be fair it works just fine.

  $ sum_(i=0)^(n) 1 / 2^i <= 2n $
]

#lorem(30)

#corollary[
  #lorem(20)
  $
    sum_(k=0)^n k & = 1 + ... + n \
                  & = (n(n+1)) / 2
  $
  #lorem(20)
]

#lorem(40)

#theorem[#lorem(30)]

== The concept of measurability
#definition[#lorem(10)]

#lorem(80)

#corollary[#lorem(30)]

#lorem(50)

#lemma[#lorem(40)]

#lorem(40)

= Week 1 - Introduction and overview of the course

Motivation: Time series analysis applies to:
+ Prediction
+ Estimation and hypothesis testing
+ Control and decision making

We want a good model!
- Use data to fit a model
- Any modelling technique can be used, there are no rules.
- only performance matters.
- Pros and cons: robustness, complexity, computational time, man hours to set up...
- We ONLY do Linear models in this course, but there are many other models out there.

== Last year example of modelling and predicting


#image("images/2026-02-06_08-43-04.png", width: 60%)

#image("images/discretize_the_ode.png", width: 60%)

$ (d T_i) / (d t) = (1) / (R C) (T_e - T_i) $

It has the solution

#corollary[
  We want to see white noise when analyzing our predictions
]

== Multivariate random variables

- #definition[
    A multivariate random variable is a vector of random variables.

    $
      bold(X) = vec(X_1, X_2, ..., X_n)
    $

    Joint density function - cont
  ]

=== Marginal Density Function
#definition[
  The marginal density function of $ X_i $ is given by

  $
    integral_(R^(n-1)) f_X(x_1, ..., x_n) (d x_1) ... (d x_(i-1)) (d x_(i+1)) ... (d x_n)
  $
]

- Conditional distributions

#definition[
  The conditional density function of $ X_i $ given $ X_j = x_j $ is given by

  $
    f_(X_i | X_j)(x_i | x_j) = (f_X(x_1, ..., x_n)) / (f_(X_j)(x_j))
  $
]

- Independence

#definition[
  The random variables $ X_1, ..., X_n $ are independent if

  $
    f_X(x_1, ..., x_n) = f_(X_1)(x_1) ... f_(X_n)(x_n)
  $
]

- Expectation continous and discrete case
#definition[
  The expectation of a multivariate random variable $ X $ is given by

  $
    E[X] = integral_(R^n) x f_X(x) (d x)
  $
  and for the discrete case
  $
    E[X] = sum_(x in R^n) x P(X = x)
  $
]
#corollary[
  The expectation of a linear combination of random variables is given by

  $
    E[a_1 X_1 + ... + a_n X_n] = a_1 E[X_1] + ... + a_n E[X_n]
  $
]

- Moments and Variance
#definition[
  the n'th moment of a multivariate random variable $X$ is given by:

  $
    E[X^n] = integral_(-infinity)^(infinity) x^n f_X(x) d x
  $
]

= Week 1 exercises:

#image("images/exercise2_1.png", width: 95%)
#image("images/ex2_1continued.png", width: 95%)
#image("images/ex2_2.png", width: 95%)
#image("images/ex2_2continued.png", width: 95%)
#image("images/ex2_3.png", width: 95%)

=== Week 2 exercises:

refer to jupyter notebook for exercises
// #path("time_series/exercises_week2.ipynb")
== Weighted Least Squares (WLS)
A weighted is very similar to ordinary least squares, but we give different weights to the different observations. This is useful when we have heteroscedasticity, i.e. when the variance of the errors is not constant.
Why I mean is that you add the wieghts as an inverse diagonal matrix to the normal equation.

Let us introduce the weighted least squares estimates for the $theta$ in the linear model:
$
  bold(Y) = bold(x) bold(theta) + bold(epsilon)
$
Using $op("E")[epsilon] = 0$ and $op("Var")(epsilon) = sigma^2 bold(op(Sigma))^(-1)$, where $bold(op(Sigma))$ is a diagonal matrix with positive entries, we can derive the weighted least squares estimates for $theta$ as follows by minimizing the weighted sum of squared residuals:

$
  op(S) = bold(Y- x theta)^T bold(op(Sigma)^(-1)) (bold(Y - x theta))
$

#theorem[
  The weighted least squares estimates for $theta$ are given by

  $
    bold(hat(theta)) = (bold(x)^T bold(op(Sigma)^(-1)) bold(x))^(-1) bold(x)^T bold(op(Sigma)^(-1)) bold(Y)
  $

  If $bold(x)^T op(Sigma)^(-1) bold(x)$ has full rank.
]

#definition[
  Full of a rank is defined as the rank of the matrix being equal to the number of columns. In this case, it means that the matrix $bold(x)^T bold(op(Sigma)^(-1)) bold(x)$ has full rank if its rank is equal to the number of columns of $bold(x)$.
]

Since we have defined how to solve for the estimates of a weighted least squares problem, we can now derive the properties of these estimates. We can derive the expectation and variance of the weighted least squares estimates as follows:

#definition[
  Variance of the weighted least squares estimates is given by:
  $
    op("Var")(bold(hat(theta))) = sigma^2 (bold(x)^T bold(op(Sigma)^(-1)) bold(x))^(-1)
  $

  Expectation is defined as:
  $
    op("E")[bold(hat(theta))] = bold(theta)
  $
]

It is also possible to $sigma^2$ from the data using the weighted least squares estimates. We can derive an unbiased estimator for $sigma^2$ as follows:

#theorem[
  An unbiased estimator for $sigma^2$ is given by:
  $
    hat(sigma^2) = ((bold(Y) - bold(x) bold(hat(theta)))^T bold(op(Sigma)^(-1)) (bold(Y) - bold(x) bold(hat(theta)))) / (N - p)
  $
  where N is the number of observations and p is the number of parameters in the model.
]

In general note how similar this model is to ordinary Least squares but we are simply adding the weights to the normal equation. This is a very powerful technique that can be used to handle heteroscedasticity in the data and can lead to more efficient estimates of the parameters in the model.

#definition[
  Heteroscedasticity is a condition in which the variance of the errors in a regression model is not constant across all levels of the independent variable(s). This can lead to inefficient estimates of the parameters in the model and can also affect the validity of hypothesis tests and confidence intervals.
]

Effectively, by adding a weight closer to 1 for the latest observations and adding weights closer to 0 for early obersvations, we can give more importance to the latest observations and less importance to the early observations. This can be useful when we have a time series data where the latest observations are more relevant for predicting the future than the early observations.

== Make sure heteroscedasticity is relevant)

== If weights are unknown
If the weights are unknown then we can make use of the relaxation algorithm (Goodwin and Payne, 1977) to estimate the weights iteratively. The algorithm works as follows:

+ Select a value for $bold(Sigma)$ i.e. $bold(Sigma) = bold(I)$
+ Find the estimates for this values of $Sigma$ by solving the normal equations.
+ Consider the residuals ${hat(epsilon_t)}$ and calculate the correlation and variance structure of the residuals. Then select a new value for $bold(Sigma)$ based on the correlation and variance structure of the residuals.
+ Stop if convergence is achieved, otherwise go back to step 2.

== Prediction for Least Squares and Weighted Least Squares
I gathered both as the approach is very similar to the final equation however slightly different. For ordinary least squares, let the weights in the covariance matrix be the identity matrix.

For future observations the model we have created can in practice not predict 100% what the next result will be, but instead we can with certain % of confidence say that our model will predict future values to be within a certain interval. This type of interval we defined as *prediction interval*

#theorem[
  PREDICTION IN THE GENERAL LINEAR MODEL:
  _Assume that the unknown parameters *$theta$* in the linear model are estimated using a least squared method, then the minimum variance prediction is:_
  $
    hat(bold(Y))_(t+l) = op("E")[Y_(t+l)| bold(X_(t+l)) = bold(x_(t+l))] = bold(x^T_(t+l)) bold(hat(theta))
  $
  The variance of the prediction error $e_(t+l) = Y_(t+l) - hat(Y)_(t+l)$ becomes:
  $
    op("Var")(e_(t+l)) = op("Var")[bold(Y)_(t+l) - hat(bold(Y))_(t+l)] =sigma^2 (1 + bold(x^T_(t+l)) (bold(X)^T bold(X))^(-1) bold(x_(t+l)))
  $

]
The theorem may seem subtle but notice the different terms in the parenthesis. the sigma was already calculated on the training set and therefore is will be constant, 1 is of course also constant. The inverse matrix $(X^T X)^{-1}$ is also constant as it is calculated on the training set. The only term that changes is the $x^T_{t+l}$ and $x_{t+l}$ which are the new observation we want to predict. This means that the variance of the prediction error will depend on the new observation we want to predict. If i.e. $x_{t+l}$ is a time step the variance will increase as time moves further and further away from the training set.


#image("images/example_of_uncertainty.png", width: 95%)

== Stochastic Processes
Common for the Autoregressive AR(p), MA(q), ARMA(p, q), and ARIMA(p, d, q) models is that they are all examples of stochastic processes. We will go further in depth with each but for now the most important aspect is that to efficiently estimate parameters and characterize what type of model it is then this can be estimated by the shape of the AutoCorrelation function (ACF) and the Partial AutoCorrelation Function (PACF). The ACF and PACF are defined as follows:

#definition[
  AutoCorrelation Function (ACF) is defined as the correlation between the time series and a lagged version of itself. The ACF at lag k is given by:
  $
    gamma(k) = op("COV")(Y_t, Y_(t-k))
  $

  and for the partial autocorrelation function (PACF) is defined as the correlation between the time series and a lagged version of itself, after controlling for the effects of the intermediate lags. The PACF at lag k is given by:
  $
    gamma_p(k) = op("COV")(Y_t, Y_(t-k) | Y_(t-1), ..., Y_(t-k+1))
  $
]
Below is an attached table that demonstrates how to characterize the model based on a plot of the ACF and PACF.


#image("images/Golden_table.png", width: 100%)

Notice an important skill for analysis of ARIMA processes. First of all, almost all the processes can be restated by the backwards operator $bold(B)$.

$ bold(op("VAR")) $

== Week 9 : State Space Models and Kalman Filter

#image("images/2026-04-10_08-34-23.png", width: 60%)
in directed graph at least a simple kalman filter can be shown as a Hidden Markow Model (HMM) where the state variable is the hidden variable and the observed variable is the observed variable. The state space model is a generalization of the HMM where the state variable can be continuous and the observed variable can also be continuous. The state space model is given by:

The whole point is that a latent variable $X_t$ depends on the previous latent variable $X_(t-1)$ and some noise $w_t$ and the observed variable $Y_t$ depends on the latent variable $X_t$ and some noise $v_t$.

Goal is to reconstruct and predict the state (latent variables) of the systems based on the observed varables.

#image("images/2026-04-10_08-39-27.png", width: 60%)

=== Determining the model structure

- The system model  is often based on physical considerations; start by formulating the model using differential equations.
- Rewrite m'th order differential equations as a system of first order equations.
- Find the discrete time model for a particular time step by formulatign the 1-step predictions.
- if the resulting model is linear,
  - Add noise to appropiate states
  - Formulate observation equations.


==== Example:
$
  dif x / dif t = a x
  implies
  X_t = X_0 e^(a t)
  X(t+ delta t) = X_0 * e^(a (t + delta t)) = X_0 e^(a t) e^(a delta t) = X(t) e^(a delta t)
$

In discrete time

$
  X_(t+1) = A X_t
$

where,

$
  A = e^(a delta t)
$

==== Example - a falling body

$
  x'' = a x' + b x + c
  y = x'
$
so,

$
  cases(
    x' = y,
    y' = a y + b x + c
  )
$

In matrix form:

$
  vec(x', y') = mat(0, 1; -b, a) vec(x, y) + vec(0, -c)
$

What we just did was to rewrtite the second order differential equation as a system of first order equations. We can then discretize the system by using the 1-step prediction to get the discrete time model. Finally, we can add noise to the system and formulate the observation equations to get the state space model.

$
  X_t = -1/2 * g * (t - delta t)^2 + v_0 * (t - delta t) + x_0
  y_t = -g * (t - delta t) + v_0
  t = k T
  delta t = (k - 1) T
$
$
  implies
  cases(
    X_(k T) = -1/2 * g * ((k - 1) T)^2 + v_0 * ((k - 1) T) + x_0,
    y_(k T) = -g * ((k - 1) T) + v_0
  )
$

in vector form:

$
  vec(x y)_k = mat(1, 1; 0, 1) vec(x y)_(k-1) + vec(-11/2, -1) g
$
$
  y_k = vec(0, 1)^T vec(x y)_k + epsilon_k
$


#image("images/2026-04-10_08-57-07.png", width: 95%)

Given measurements of the position at time points 1, 2, . . . , k we could:
▶ Predict the future position and velocity x k +n|k (n > 0).
▶ Reconstruct the current position and velocity from noisy measurements x k |k .
▶ Smooth to find the best estimate of the position and velocity at a previous time point x k +n|k
(n < 0) (estimate the path in the state space).

We do this with the Kalman filter.
Before that remember what *linear projection* is.

Consider 2 random vectors *Y* and *X*, then:

$ op("E")[vec(Y, X)] = vec(mu_y, mu_x) $

and

$
  op("Var")[vec(Y, X)] = mat(
    Sigma_(YY), Sigma_(YX);
    Sigma_(XY), Sigma_(XX)
  )
$

Define the linear projection:

$
  rho_X(Y) = mu_y + Sigma_(YX) Sigma_(XX)^(-1) (X - mu_x)
$
Then,

- $rho_X(Y)$ is of the form $a + BX$
- $op("Var")[Y - rho_X(Y)] = Sigma_(YY) - Sigma_(YX) Sigma_(XX)^(-1) Sigma_(XY)$
- $op("Cov")(Y - rho_X(Y), X) = 0$








The Systems Eqations for a state space model are given by:
#definition[
  State equation:
  $
    bold(x)_(t+1) = bold(A) bold(x)_t + bold(B) bold(u)_t + bold(w)_t
  $

  Measurement equation:
  $
    bold(y)_t = bold(C) bold(x)_t + bold(D) bold(u)_t + bold(v)_t
  $
]

or in matrix expanded matrix form:

$
  bold(X)_t = mat(
    -phi_1, 1, 0, dots, 0;
    -phi_2, 0, 1, dots, 0;
    dots.v, , dots.v, , dots.v;
    -phi_(n-1), 0, 0, dots, 1;
    -phi_n, 0, 0, dots, 0
  ) bold(X)_(t-1) + vec(1, theta_1, theta_2, dots, theta_(n-1)) epsilon_t
$

=== Random walk with measurement noise
consider the state space model given by:

$
  X_(t+1) = X_t + eta_t
  Y_t = X_t + epsilon_t
$

where $eta_t$ and $epsilon_t$ are independent white noise processes with variances $sigma^2_eta$ and $sigma^2_epsilon$ respectively. This model is known as a random walk with measurement noise. The state equation describes the evolution of the state variable $X_t$ over time, while the measurement equation describes how the observed variable $Y_t$ is related to the state variable.

$X_t$ is a random walk, that is not observed directly, but instead we observe $Y_t$ which is the state variable plus some measurement noise. The Kalman filter can be used to estimate the state variable $X_t$ based on the observed variable $Y_t$ and the parameters of the model. The Kalman filter provides a recursive algorithm for estimating the state variable at each time step, taking into account the uncertainty in the measurements and the evolution of the state variable over time.

$diff Y_t = Y_t - Y_(t-1) = (X_t + epsilon_t) - (X_(t-1) + epsilon_(t-1)) = (X_t - X_(t-1)) + (epsilon_t - epsilon_(t-1)) = eta_(t-1) + (epsilon_t - epsilon_(t-1))$

So what exactly defines the last equation? It can be considered as an ARIMA(0, 1, 1) this means we can use tools similar to previous weeks to analyze the model.

a

#import "template.typ": *

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
The therom may seem subtle but notice the different terms in the parenthesis. the sigma was already calculated on the training set and therefore is will be constant, 1 is of course also constant. The inverse matrix $(X^T X)^{-1}$ is also constant as it is calculated on the training set. The only term that changes is the $x^T_{t+l}$ and $x_{t+l}$ which are the new observation we want to predict. This means that the variance of the prediction error will depend on the new observation we want to predict. If i.e. $x_{t+l}$ is a time step the variance will increase as time moves further and further away from the training set.


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

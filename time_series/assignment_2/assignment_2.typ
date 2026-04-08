#import "../../base/template.typ": *

#let title = "Assignment 2: ARMA Processes and Seasonal Processes."
#let author = "Mathias Markvardsen"
#let professor = "Henrik M. Pedersen"
#let creater = "M. Markvardsen"
#let time = "Spring 2025"
#let abstract = lorem(60)

#show: note_page.with(title, author, professor, creater, time, abstract)


= Stability
#definition[
  Let the process ${bold(X_t)}$ be an $op("AR")(2)$ given by
  $
    X_t - phi_1 X_(t-1) - phi_2 X_(t-2) = epsilon_t
  $
  where ${epsilon_t}$ is white noise process with mean zero and variance $sigma_(epsilon) = 1$
]

== Characteristic equation
We can rewrite the AR(2) to its chracteristic equations by defining it based on the backshift operator $B$. The backshift operator work as follows:

#lemma[
  The backshift operator $B$ is defined as $B X_t = X_(t-1)$, and for k backshift we would write it by taking the operator to the exponent of k.
  $B^k X_t = X_(t-k)$
]

== Stationarity of AR(2)

We can now proceed onto the AR(2) process.
$
  X_t - phi_1 X_(t-1) - phi_2 X_(t-2) = epsilon_t <=> \ (1 - phi_1 B - phi_2 B^2) X_t = epsilon_t
$

Now let $ phi_1 & = -7/10 \
phi_2 & = -1/5 $

Let us now find the root of the characteristic equation. We can find the roots by setting the characteristic polynomial to zero.
$
  1 + 7/10B +1/5B^2 = 0 => \
  x = (7/10 plus.minus sqrt((7/10)^2 - 4/5))/2 = (7/10 plus.minus sqrt(49/100 - 4/5))/2 = (7/10 plus.minus sqrt(49/100 - 80/100))/2 = (7/10 plus.minus sqrt(-31/100))/2 \
  = 7/20 plus.minus i sqrt(31)/20
$

We have found the roots of the function $phi(B)$, but in reality we are interested in the transfer function $phi(z^-1)$
Firstly the norm of the 2 roots are given by:
$
  ||op("roots")|| = sqrt((7/20)^2 plus.minus (sqrt(31)/20)^2)
  = {sqrt(5)/5 , (3 sqrt(2))/20}
$

Taking the inverse of the roots we get:
$(sqrt(5)/5)^(-1) = sqrt(5) approx 2.24$ and $((3 sqrt(2))/20)^(-1) = (10 sqrt(2))/3 approx 4.71$

In both cases the roots $phi_1(z^(-1))$ are greater than 1,  which means that the AR(2) is not stationary. From the same theorem, namely, theorem 5.9 in the book we know autoregressive processes are always invertible, so to conclude, the AR(2) process is not stationary but it is invertible.

#theorem[
  AR(p) process: stationarity and invertibility
  An AR(p) proces is:
  + Always invertible
  + Stationary if the roots of $phi(z^(-1)) = 0$, with respect to z, all lie within the unit circle.
]

== Autoregressive correlation functions $rho(k)$
For an AR(2) process, we can determine the values of $rho(1)$ and $rho(2)$ by the Yule-Walker equations. The Yule-Walker equations for an AR(2) process are given by:
$
  vec(rho(1), rho(2)) = mat(1, rho(1); rho(1), 1) vec(-phi_1, -phi_2)
$

Expanding to a system of equations and isolation $rho(1)$ and $rho(2)$ gives us:
$
  rho(1) & = -phi_1 / (1 + phi_2) = (7/10) / (1 - 1/5) = 7 / 8 \
  rho(2) & = phi_1^2 / (1 + phi_2) - phi_2 = (-7/10)^2 / (1 - 1/5) + 1/5 = 49/80 + 1/5 = 49/80 + 16/80 = 65/80 = 13/16
$
Thereby, we have found that $rho(1) = 7/8$ and $rho(2) = 13/16$ for the AR(2) process.

=== Autocorrelation $rho(k)$
let us write the general fourmula for the autocorrelation function of an AR(2) process. The autocorrelation function can be found by the following recursive formula:

$
  rho(k) + phi_1 rho(k-1) + phi_2 rho(k-2) = 0
$
*QUESTION SHOULD WE DERIVE IT BY HAND OR SIMPLY MAKE USE OF THE RESULTS FROM THE BOOK??*
Now since we have found $rho_1$ and $rho_2$ we could then recursively find $rho(k)$ using the formula above. For example, to find $rho(3)$ we would do the following:

$
  rho(3) = -phi_1 rho(2) - phi_2 rho(1) = 7/10 * 13/16 + 1/5 * 7/8 = 91/160 + 7/40 = 91/160 + 28/160 = 119/160
$
etc.

== Plotting
we will now plot the autocorrelation function for the given AR(2) process.

#image("images/2026-03-12_13-38-41.png", width: 85%)
on the figure have the lags on the x-axis and on the y-axis we have autocorrelation values for different lags derived through the yule-walker equations.

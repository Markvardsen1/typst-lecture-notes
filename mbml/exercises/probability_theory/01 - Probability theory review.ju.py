# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.19.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% [markdown] id="ep8dvskmwQdM"
# # Week 1 - Probability theory and Statistics review
#
# Hello! Welcome to our course on Model-Based Machine Learning! We hope you will enjoy and learn a lot of new powerful techniques for your future.
#
# As usual in Python, the first thing to do is to import the necessary packages. Let's start with some usual ones for now...
#

# %% id="CHQOv8powQdN"
import numpy as np
import matplotlib.pyplot as plt
import math
import pandas as pd
import scipy
# %matplotlib inline

# %% [markdown] id="nnnwSxoHaNa0"
# ## Part 1 - Random variables, independence, conditionality, Bayes theorem
#

# %% [markdown] id="A5sky1nLaUKj"
# We are going to work on a 2D world for now, and a uniform distribution.
#

# %% [markdown] id="gUVwFhaLaUKm"
# So, let's create N 2D points:
#

# %% id="nSGPCmDqaUKo"
N = 500
pts = np.random.uniform(size=(N, 2))

# %% [markdown] id="9GBkR6Y3aUKq"
# Take a look at these points. You'll notice they all fall inside a [0,1]x[0,1] square...
#

# %% id="MpMNMd3RaUKs" outputId="df56e0b9-78f0-4737-a447-83b7203b30a0"
pts[:10]


# %% [markdown] id="JtsWmwq8aUKx"
# Can you count how many such points fall inside a circle centered at (0,0) and radius 1?
#


# %% id="LBWRF7zGaUKz"
def in_circ(x, y):
    return x**2 + y**2 < 1


# %% id="Zm2T1OKaaUK1" outputId="c7d8578b-5ba9-47c7-9d6c-fbf945925024"
inc = sum([in_circ(x, y) for x, y in pts])
print(inc)

# number printed is the number of randlonly generated points between (0,500) that has a radius less than 1.


# %% [markdown] id="k4stFiF8aUK3"
# Consider a={a given point (x,y) falls inside the circle centered at (0,0) with radius 1}
#

# %% [markdown] id="TyYzZUHbaUK4"
# Calculate the probability of a, p(a)

<img src="images/2026-02-10_15-09-50.png" width="60%">
# %% id="ob89Gr34aUK5"
p_a = inc / N
p_a

# %% id="rjMoNOpoaUK6"

# %% [markdown] id="QKqFy6L_aUK7"
# Visualizations are often quite useful. Can you visualize both the points as well as the circle line? Focus only on the first quadrant.
#

# %% id="6rUQY7KnaUK9"

# %% id="hylmYlYXaUK-"

# %% [markdown] id="4v6BCA2raUK_"
# Just to link with your trigonometrics knowledge: what is the area of this circle (radius=1)? And what is the area of a quarter of that circle (the part that you just drew)?
#

# %% id="nwR0BknSaULA"

# %% [markdown]
# What is the relationship with that value and the probability that you just calculated (you can vary the number of points, N, to check your theory)?
#

# %% [markdown] id="aR1hH8h0aULB"
# Now, let's add a new event b={a point (x,y) falls on the right hand side of the [0,1]x[0,1] square}. Note that this has nothing to do with the circle. A point on the right hand side of the [0,1]x[0,1] square implies x >= 0.5.
#

# %% [markdown] id="a-SJLGRuaULC"
# Calculate p(b)
#

# %% id="ZyjSkFMiaULE"

def rhs_square(x,y):
    return x >= 0.5

inc_b = sum([rhs_square(x,y) for x, y in pts])
p_b = inc_b / N
p_b

# %% id="bMYDgrvdaULF"

# %% [markdown] id="eBmwknDOaULG"
# So, now you have p(a) and p(b). Do you want to try calculating p(a,b)?
#
# Are they independent? Is there any reason to believe that they aren't?
#
# To check their independence, try two approaches:
#
# -- p(a,b)=p(a)\*p(b)
#
# -- Just count the points that fulfill both a and b constraints (and divide by the total number of points... ;-) ).
#

# %% id="ZFeQ4F52aULH"

naive = p_a * p_b 
proper = sum([rhs_square(x,y) and in_circ(x,y) for x, y in pts]) / N

print(naive, proper)

# %% id="H6VHlO4QaULI"

# %% [markdown] id="_XI_iHlUaULJ"
# They are different! Why?... If you are in doubt, take a look at the picture...
#

# %% id="0tWssswXaULK"

# %% [markdown] id="dclt7p7QaULL"
# Maybe they are not independent, after all... if so, their joint probability is instead
#

# %% [markdown] id="Hel4soaWaULM"
# p(a,b)=p(a|b)\*p(b)
#

# %% [markdown] id="OQN4O6a6aULN"
# Please calculate p(a|b), in order to get the right value...
#

# %% id="gdmg2rO-aULO"

inc_given_b = sum([in_circ(x,y) for x, y in pts if rhs_square(x,y)])
p_a_given_b = inc_given_b / sum([1 for x, y in pts if rhs_square(x,y)])
print(p_a_given_b)

# %% id="fnZfszCEaULP"

# %% [markdown] id="YnIT2F5OaULQ"
# Now you calculate p(a,b)=p(a|b)\*p(b)
#

# %% id="a0ACIyAPaULR"
p_a_b = p_a_given_b * p_b
p_a_b

# %% [markdown] id="ga2E8uZtaULS"
# Compare with the values above. Does it make more sense now?
#
# Another well known property is the Bayes theorem:
#
# $p(b|a)=\frac{p(a|b)p(b)}{p(a)}$
#
# Calculate the p(b|a) using the Bayes theorem, and calculate it directly from data. Are they converging to the same value?
#

# %% id="Zl7MSgj2aULU"

p_b_given_a = p_a_given_b * p_b / p_a
p_b_given_a

# %% id="4ARNhCDaaULV"

in_right_given_in_circ = sum([rhs_square(x,y) for x, y in pts if in_circ(x,y)])
in_circ_total = sum([1 for x,y in pts if in_circ(x,y)])
in_right_given_in_circ / in_circ_total

# %% [markdown] id="MoDgtveYaULW"
# Look at the following table:
#

# %% id="LomOhIj2aULX" outputId="43cf8734-8cbd-4267-d21c-2455fcd2a44a"
f = pd.DataFrame(
    [[0.068966, 0.137931, 0.068966], [0.344828, 0.241379, 0.137931]],
    columns=["T=Hot", "T=Mild", "T=Cold"],
    index=["W=Sunny", "W=Cloudy"],
)

print(f)

# %% [markdown] id="mXkl5yqqaULZ"
# Marginalization allows us to compute distributions over a selection of variables that we want. For example, for the table above, that represents p(W, T) in a non-normalized way, we could "marginalize out weather", i.e. calculate p(T), by doing
#
# $p(T)=\sum_W p(W, T)$
#
# Marginalize out weather (Hint: the pandas package has a nice "sum()" function associated with the the DataFrame object f that you can use...)
#

# %% id="1uUdfcoLaULa" outputId="48168e7e-a19f-48ac-cedf-6a8c4b58b359"
f.sum(axis=0)

# %% [markdown] id="yYNrz5WdaULc"
# Marginalize out temperature
#

# %% id="6lg2AP8JaULc"

f.sum(f.sum(axis=1)

# %% [markdown] id="aSPwNp5EaULd"
# ---
#

# %% [markdown] id="Uw3uwv3JaULe"
# ## Part 2 - Independence
#

# %% [markdown] id="UmnlkzreaULf"
# Let's get further into the concept of **independence**
#

# %% [markdown] id="GuZ5d5G9aULf"
# To begin with, let's create a small dataset of size N. We will start with two random variables, z and t, both uniformly distributed.
#
# Each random variable will be an integer value in {0, 1, 2} (you can change this later, of course).
#

# %% id="TOUEUvH7aULg"

N 1000
D = 3

z = np.random.randint(D, size=N)
t = np.random.randint(D, size=N)

# %% [markdown] id="XfeRAKmiaULh"
# Let's calculate the probability of each different value of z. Take a look at this code. It may be useful later
#

# %% id="3BjIXRZmaULi" outputId="6dd4f736-b1ac-427d-dace-1d7559c54966"
z_items, z_counts = np.unique(
    z, return_counts=True, axis=0
)  # returns a list of different items in Z; it also counts how
# many times each one appears

# calculates the p(Z=z), for each possible value of z
for item, ct in zip(z_items, z_counts):
    print("p(z=%d)=%f" % (item, ct / N))


# %% [markdown] id="02fdM_OyaULk"
# Actually, we're going to reuse the above code quite a lot. Let's make a new function, then...
#


# %% id="FQJkOHvEaULl"
# Function p. It receives a list of values, K, and simply prints the probability of each of its values
# nam and given - Two strings just for printing. Just run this once and you'll see... ;-)
def p(nam, K, given=""):
    k_items, k_counts = np.unique(K, return_counts=True, axis=0)
    for item, ct in zip(k_items, k_counts):
        print("p(%s=%s%s)=%f" % (nam, item, given, ct / sum(k_counts)))


# %% [markdown] id="COyauhoHaULn"
# Let's try it with our variables Z and T
#

# %% id="-p4x35GVaULo" outputId="fe3378ec-63cc-4db5-cff0-42568713957b"
p("z", z)
p("t", t)

# %% [markdown] id="2PKAy0ibaULq"
# ok. So, we have the probability of each value, according to this dataset.
#
# Assuming that both z and t are uniformly distributed, the calculation for the probability of each event (without having to count frequencies) should be trivial, right? What is it?
#

# %% id="vanH1_OvaULr"

# %% [markdown] id="WvJfBtt2aULs"
# Does it match the above? If you're in doubt, you can increase the value of N, the dataset size. As N grows, it should approximate your latest calculation...
#

# %% [markdown] id="v50-GX60aULt"
# Let's now think of the joint distribution of z and t. In other words, how these two variables seem to co-vary, together. The first thing to do is to "align" them, i.e., re-create a new random variable (z_t), that is a pair of observations, z and t.
#

# %% id="um__Sv_RaULu"
z_t = np.stack(
    (z, t), axis=-1
)  # Check the result of this operation, to understand what it does...

# %% id="Qf0h-5ViaULv"

# %% [markdown] id="Qki1InzYaULw"
# So, let's use the function above, to calculate the join distribution
#

# %% id="jIL6ZMNCaULx" outputId="ea96c573-b15d-4ba0-e69d-305fb75528f4"
p("z,t", z_t)

# %% [markdown] id="ar5_YPh7aULz"
# Are Z and T independent? If yes, the formula for their join distribution is trivial. Please calculate it (and check if it verifies).
#

# %% id="y6nXPIxnaUL1"

# %% id="QH3dK71GaUL2"

# %% [markdown] id="YSBEpY05aUL3"
# Let's create two more variables, both based on Z.
#

# %% id="Vwglg58daUL4"
betay = -2
betax = 1
y = betay * z
x = betax * z

# %% [markdown] id="k3OeeQ2WaUL5"
# Are they independent? What do you think? A good way to see is by plotting... do you want to do it?
#

# %% id="5fKysh8SaUL6"

# %% [markdown] id="5iPb70AdaUL7"
# What should it look like when variables are independent? And when they are correlated?
#

# %% [markdown] id="arLnk1oyaUL9"
# Let's check their joint distribution, then...
#

# %% id="-43QDzX_aUL-" outputId="128a2377-3525-4864-bad8-8e564074cbb8"
x_y = np.stack((x, y), axis=-1)
p("x,y", x_y)

# %% [markdown] id="ahqwg6TzaUMA"
# Notice that, for all other value combinations (e.g. x,y=[0,-2]), the probability is zero.
#
# If x and y are independent, then the product of their marginal probabilities should be equal to the values above, right? Do you want to calculate?
#

# %% id="8DcuAxCXaUMC"

# %% [markdown] id="F1HtA3O5aUMC"
# Should the values match at all? Let's try instead to calculate the conditional probabilities, of and x and y, given z.
#

# %% [markdown] id="DnUY3J7oaUME"
# To do it, directly on the data, we need to calculate, for EACH value of z, the distributions for both x and y.
#
# This means that we need to organize the data accordingly. How about using a dictionary?
#

# %% id="a4emppUEaUMF"
from collections import defaultdict

z_dict = defaultdict(list)

for X, Y, Z in zip(x, y, z):
    z_dict[Z].append([X, Y])

# %% [markdown] id="y8KR8c0caUMG"
# To make sure you understand the code above, don't forget to check z_dict carefully...
#

# %% id="oDAmLqjhaUMI"

# %% [markdown] id="NMABXasjaUMJ"
# The code below uses the dictionary to calculate the conditional marginal and joint distributions. Check it carefully.
#

# %% id="YcGaJvAuaUMK" outputId="7fcf71b6-2414-4aee-ab4e-f6668658eb9f"
for Z in z_dict:
    x_y = z_dict[Z]
    x = np.array(x_y)[:, 0]
    y = np.array(x_y)[:, 1]
    p("x", x, "|z=%d" % Z)
    p("y", y, "|z=%d" % Z)
    p("x,y", x_y, "|z=%d" % Z)


# %% [markdown] id="qnzdSeKIaUML"
# So, what do you conclude? Is it true that x is independent of y given z?
#

# %% [markdown] id="5t-gacFfaUMM"
#

# %% [markdown] id="jE8yAj_8aUMN"
# The example above was particularly odd, because there is NO randomness involved (i.e. x is **exactly** betax times z). As a consequence, the probabilities are quite extreme.
#
# Try to redo the whole exercise, by adding a little randomness to x and y (don't forget to keep them as integers). Notice how the conditional independence property varies of "intensity", as you add more or less randomness...
#

# %% id="nqIHEy-iaUMO"

# %% id="sdEzvP27aUMR"

# %% id="_v5oJqAAaUMS"

# %% id="zJ1iI_ojaUMS"

# %% [markdown] id="3caHInJvaUMT"
# Finally, let's try a different perspective on conditional independence: why does it actually matter??
#
# Particularly, we want to understand the meaning of the following sentence:
#
# **"If we know z, then knowing about y tells us nothing about x"**
#

# %% [markdown] id="7UYTpKV3aUMU"
# Using your small dataset (x, y, z), you will try to make linear regression prediction models. Our goal is to "know about x", i.e. x will be the target (or dependent) variable in our linear regression.
#
# Compare the following models (e.g. using sklearn's LinearRegression model):
#
# - $x=\beta_1*z$
# - $x=\beta_1*y+\beta_2*z$
# - $x=\beta_1*y$
#

# %% id="4GDsrqHkaUMV"

# %% id="X2FbG9ijaUMW"

# %% [markdown] id="ntBI7Q7gaUMW"
# Notice the coefficients, what do they mean?
#

# %% [markdown] id="EftXkJ6taUMX"
# ---
#

# %% [markdown] id="3jUaO8V4aUMX"
# ## Part 3 - Expectation of discrete variables
#

# %% [markdown] id="6fnfyqr-aUMY"
# Calculate the expected value of x, using
#
# $E(x)=\sum_x xp(x)$
#

# %% id="DwjUNrTYaUMZ"

# %% [markdown] id="JaVALn0QaUMa"
# Compare it with the mean of x (x.mean() )
#

# %% id="RmsKV0kuaUMb"

# %% [markdown] id="cuWWcdKSaUMc"
# ---
#

# %% id="X5EIxYxztEjp"

# %% [markdown] id="2D41Mqsws3EQ"
# ## Part 4 - Well-known probability distributions
#

# %% [markdown] id="aciduDFMs3ER"
# In this lecture, we talk about a few probability density functions. Let's define them. Take a careful look at the expressions, and the parameters.
#


# %% id="Cxl6mB7xs3ES"
def normpdf(x, mu, sigma):
    return (
        1
        / (math.sqrt(2 * math.pi) * sigma)
        * math.exp(-1.0 / 2 * (mu - x) ** 2 / (sigma**2))
    )


def poispdf(x, lamb):
    return lamb**x * math.exp(-lamb) / math.factorial(x)


def exppdf(x, lamb):
    return lamb * math.exp(-lamb * x)


def betapdf(x, Alpha, Beta):
    Bx = scipy.special.beta(Alpha, Beta)
    return x ** (Alpha - 1) * (1 - x) ** (Beta - 1) / Bx


# %% [markdown] id="3gzN629Os3ET"
# Notice that these function exists in many other Python packages, you don't need to redefine them all the time...
#

# %% [markdown] id="bnZzb-ics3EU"
# It's very useful to plot them, as we do below (this is the code used to generate the pictures in the slides)
#

# %% [markdown] id="Z5Zyr2-Xs3EV"
# First, the **Gaussian**
#

# %% id="LsA46Ubys3EV" outputId="03e0a159-5e86-4b0b-e32a-f722b2c38825"
X = np.arange(-4, 4, 0.01)
L = np.random.normal(size=5000)
mu = 0
sigma = 1
Y = np.array([normpdf(x, mu, sigma) for x in X])
plt.hist(L, bins=100, density=True)
plt.plot(X, Y)
plt.plot([mu, mu], [0, 0.5], c="black")
plt.annotate(text="$\mu$", xy=(mu + 0.1, 0.47), size=20)

# %% [markdown] id="9DMVw4a0s3EX"
# Now, the **Poisson** . Remember that it is a discrete probability distribution (the x axis has to be discrete numbers - any ).
#
# Try to use the parameters "bins=..." in the plt.hist call, to see this influence of different bin sizes in the shape of the histogram.
#

# %% id="fI2jEOdps3EY" outputId="e6312c35-493a-4e01-b05e-d40f6500eea0"
X = range(0, 20)
lamb = 5
L = np.random.poisson(lamb, size=5000)
Y = np.array([poispdf(x, lamb) for x in X])
weights = np.ones_like(L) / float(len(L))
plt.hist(L, weights=weights)
plt.plot(X, Y)
plt.plot([lamb, lamb], [0, 0.37], c="black")
plt.xticks(X)
plt.annotate(text="$\lambda$", xy=(lamb + 0.1, 0.34), size=20)

# %% [markdown] id="T4K85UsNs3Ea"
# Let's try the **exponential**
#

# %% id="5604JheKs3Eb" outputId="7d0c8be2-913e-4679-eac1-2d5a150c74a7"
X = np.arange(0, 20, 0.01)
lamb = 0.5
L = np.random.exponential(1 / lamb, size=5000)
Y = np.array([exppdf(x, lamb) for x in X])
plt.hist(L, bins=100, density=True)
plt.plot(X, Y)
plt.plot([1 / lamb, 1 / lamb], [0, 0.37], c="black")
plt.annotate(text="$1/\lambda$", xy=(1 / lamb + 0.1, 0.34), size=20)

# %% [markdown] id="x0meQrk_s3Eb"
# And finally, the **Beta**
#

# %% id="IbnMNZqjs3Ec" outputId="e0cb88a3-e774-48c6-e445-0e1ebd083c1d"
X = np.arange(0, 1, 0.01)
Alpha = 2
Beta = 5
L = np.random.beta(Alpha, Beta, size=5000)
Y = np.array([betapdf(x, Alpha, Beta) for x in X])
plt.hist(L, bins=100, density=True)
plt.plot(X, Y)
#
m = Alpha / (Alpha + Beta)
plt.plot([m, m], [0, 2.7], c="black")
plt.annotate(text="$\\alpha/(\\alpha+\\beta)$", xy=(m + 0.01, 2.6), size=20)

# %% [markdown] id="UC9xUwtRs3Ed"
# **The Central limit theorem**
#
# A very important theorem in all statistics is called the Central Limit Theorem, which says that
#
# > The distribution of the sampling means approaches a normal distribution as the sample size gets larger — no matter what the shape of the population distribution.
#
# Try to test yourself the Central Limit Theorem. Essentially, generate multiple random datasets, each time following the same parameters, and a probability density function (pdf) of your choice. Test with each of the pdfs created above.
#

# %% id="amhdZmHTs3Ee"

# %% [markdown] id="nMjXDMces3Ef"
# We will now work with bivariate distributions, i.e. instead of having one value at a time, we have two.
#
# Let's use the Bivariate normal distribution for it
#

# %% id="djp18VoSs3Eg"
X = np.random.multivariate_normal([0, 0], [[1, 0.6], [0.6, 1]], size=5000)

# %% [markdown] id="6vK53Z8Hs3Eh"
# Let's check the second parameter (in this case, the list [[1,.6],[.6, 1]]). It corresponds to the covariance matrix of the normal distribution.
#

# %% id="OZVOF4L2s3Ei" outputId="eb1f7607-8bae-4f61-e200-9173ee55d010"
plt.scatter(X[:, 0], X[:, 1], alpha=0.1)

# %% [markdown] id="4jGODM5cs3Ej"
# Try changing the values of that matrix, and see the results...
#

# %% [markdown] id="JpVyZFPMs3Ej"
# Just to make sure you don't make mistakes in the future, notice that the code below is ONLY for a covariance matrix of independent normal variables.
#

# %% id="pY1N1Ejus3Ek"
X = np.random.normal(loc=0, scale=1, size=[5000, 2])

# %% id="oM7RP2DIs3El" outputId="7bf3f336-5fc7-4900-d4ca-78e17dd2c5ce"
plt.scatter(X[:, 0], X[:, 1], alpha=0.1)

# %% [markdown] id="VVbsYBoDs3Em"
# Just to make sure you got it, sample from an equivalent (independent) gaussian, now with the np.random.multivariate_normal function mentioned above.
#

# %% id="JnmmdN9os3En"

# %% id="0bhGR-7ds3Eo"

# %% [markdown] id="hgir2a5Ws3Eo"
# ---
#

# %% [markdown] id="hu8kYnncs3Ep"
# ## Part 5 - Maximum likelihood estimation
#

# %% [markdown] id="vqxQp1A-s3Eq"
# Time now to work on the concept of maximum loglikelihood, a fundamental one in statistical modeling.
#

# %% [markdown] id="URKU0lzVs3Eq"
# Let's create a dataset...
#

# %% id="-x-1iLeIs3Er"
P = np.random.normal(loc=4.5, scale=3, size=1000)


# %% [markdown] id="lDSxkm3Ls3Es"
# Now, let's follow the slides, and create the function that returns the Gaussian loglikelihood of a dataset, given a pair of parameters:
#

# %% [markdown] id="qCcCpha9s3Es"
# $-\frac{n}{2} (log(2\pi)+log(\sigma^2) -\frac{1}{2\sigma^2}\sum_i (x_i-\mu)^2$
#
# Confirm that the function has no mistake...
#


# %% id="aUU7SEsys3Et"
def loglikelihood(P, mu, sigma):
    n = len(P)
    s = sum([(xi - mu) ** 2 for xi in P])
    return (
        -n / 2 * (math.log(2 * math.pi) + math.log(sigma**2)) - 1 / (2 * sigma**2) * s
    )


# %% [markdown] id="ZO7Lo4TCs3Eu"
# So, we want to find the values of $\mu$ and $\sigma$ that maximize that function in our dataset... Do you want to try to find them?
#
# A simple way is to try MANY such values (e.g. a range of possible values). Go ahead!
#

# %% id="puWbYo8bs3Eu"

# %% id="mSZaM8E7s3Eu"

# %% [markdown] id="bnkqYodEs3Ev"
# Compare the values you obtained with the sample mean and sample variance.
#

# %% [markdown] id="9UmbsqVKs3Ev"
# As mentioned in the lecture, this task falls in the realm of Optimization. Python also has tools for optimizing a function, which is much more clever than blindly trying many values for $\mu$ and $\sigma$. We will not explore them here, but in case you're curious, just try the methods in:
#
# > scipy.optimize
#

# %% [markdown] id="ePHXt9Pcs3Ev"
# Now, just for illustration, let's try a case where the data comes from a combination (a _mixture_) of two different distributions.
#

# %% id="OvwdTDXjs3Ew"
L1 = np.random.normal(loc=4.5, scale=3, size=1000)
L2 = np.random.normal(loc=-5, scale=2, size=1000)
L = np.concatenate((L1, L2))

# %% [markdown] id="njm7bQVFs3Ew"
# Plot the respective histogram...
#

# %% id="EssIc5Vfs3Ex" outputId="5d4f11f8-2176-412d-f022-305c18c306bf"
plt.hist(L, bins=100)

# %% [markdown] id="lRnBruRhs3Ex"
# Just getting the mean and standard deviation, assuming a single Gaussian would be mistake... check it yourself!
#

# %% id="ilJb5CCOs3Ey"

# %% [markdown] id="fwBpZcues3Ey"
# Plot the distribution you estimated on top of the histogram, just to see the difference
#

# %% id="urLJbE55s3Ez"

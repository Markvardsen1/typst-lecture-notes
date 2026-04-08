# ----------------------------------------------------------------
# Example, investigate if arima() does fit a transfer function

# Generate a step input
n <- 500
x <- c(rep(0,100), rep(1,n-100))
# Add a step
plot(x, type="s")

# Make an output vector "filtered" by the system: y_t = 0.98 * y_t + x_t
y <- filter(x,0.98,"recursive")
# Add AR noise
y <- y + c(arima.sim(list(ar=c(0.7,0,0)), n))
# Plot the output
plot(y)

# Try to model with arima
m1 <- arima(y, xreg=x, order=c(2,0,0))
m1
tsdiag(m1)

# Predict to see the predicted one-step output
pred1 <- predict(m1, newxreg=x, n.ahead = 1)
# plot(pred1<span>$pred)
# There is no exponential response, so xreg is not included as a transfer function!

# Try to recreate the arima() with xreg is hard!
# Just LS directly, get parameters very different
lm(y ~ x)

# Conclusion:
# arima() does IN ONE GO: a linear model with xreg together with ARMA on residuals, 
# like e.g. ML estimation of ARMA(1,1) with one xreg: 
#   
#     (Y_t - beta_0 + x_t beta_1) = phi1 * (Y_{t-1} - beta_0 + x_{t-1} beta_1) + theta_0 eps_t + theta_1 eps_{t-1}
# 
# The parameters are estimated to minimize the squared residuals using an optimizer (so very close to maximum likelihood with normal distributed error)
# ----------------------------------------------------------------


# ----------------------------------------------------------------
# (1) ARX model model for a transfer function
# Make AR lags
y.l1 <- c(0,y[-n])
y.l2 <- c(0,y.l1[-n])

# Fit and one-step predictions with ARX(1)
arx1 <- lm(y ~ y.l1 + x)
summary(arx1)
plot(x, type="s")
plot(predict(arx1), type="l")
# ----------------------------------------------------------------


# ----------------------------------------------------------------
# Simulating some AR noise
set.seed(2)
noise <- arima.sim(model=list(ar=0.9), n = 300)
plot(noise)
# ----------------------------------------------------------------


# ----------------------------------------------------------------
# Harmonic oscillation + noise

# (2-3) Deterministic part with an amplitude:
amplitude <- 5
det <- amplitude * sin(0.1*(1:300)+1) + 2 
signal <- det + noise
plot(signal)
acf(signal) # Not stationary
acf(diff(signal)) # Looks like something odd creating a little correlation but no clear structure
(a1 <- arima(signal, order=c(0,1,0)))
# Validates?
tsdiag(a1) 
pacf(residuals(a1))
plot(residuals(a1))

# (4) Other model for amplitude 10
(a2 <- arima(signal, order=c(?,?,?)))
tsdiag(a2) # Looks good 

# (5) Let us try to predict with this model
plot(signal, xlim=c(0,400))
a2.pred <- predict(a2, n.ahead = 100)
matlines(301:400, a2.pred$</span>pred + 1.96*cbind(0, -a2.pred<span>$se, a2.pred$</span>se), col=2, lty=c(1,2,2))

# (6) Let us try a model using xreg with sin and cos with the true period
x <- cbind(sin = sin(0.1*(1:300)), cos = cos(0.1*(1:300)))
# We can fit a simple LM model:
lm1 <- lm(signal~x)
qqnorm(residuals(lm1)) # Looks fine
qqline(residuals(lm1))
summary(lm1) # All significant
acf(residuals(lm1)) # Ups - we should not trust the LM as residuals are correlated
pacf(residuals(lm1))
# Looks like AR(1)

# Using the same predictors and AR(1) structure for residuals
(a3 <- arima(signal, order=c(1,0,0), xreg = x, include.mean = TRUE))
tsdiag(a3) # Looks good

# Predict with harmonics model
plot(signal, xlim=c(0,400))
# We have to provide the xreg for the future
xpred <- cbind(sin = sin(0.1*(301:400)), cos = cos(0.1*(301:400)))
a3.pred <- predict(a3, n.ahead = 100, newxreg = xpred)
matlines(301:400, a2.pred<span>$pred + 1.96*cbind(0, -a2.pred$</span>se, a2.pred<span>$se), col=2, lty=c(1,2,2))
matlines(301:400, a3.pred$</span>pred + 1.96*cbind(0, -a3.pred<span>$se, a3.pred$</span>se), col=3, lty=c(1,2,2))
legend("bottomleft", legend = c("Using diff", "Using harmonic xreg"), lty=1, col=2:3, bg="white")
# ----------------------------------------------------------------


# ----------------------------------------------------------------
# Example: Linear trend + noise, using Arima from forecast package which automatically includes a slope
set.seed(2)
noise <- arima.sim(model=list(ar=0.9, ma=0.6), n = 300)
plot(noise)

det <- 0.05*(1:300+1) + 2
signal <- det + noise
plot(signal)
acf(signal) # Non stationary
acf(diff(signal)) 
pacf(diff(signal)) # More in PACF than ACF so maybe ARIMA(0,1,1)

a1 <- arima(signal, order=c(0,1,1))
tsdiag(a1) # Looks good
pacf(residuals(a1)) # Looks good
a1 # Note that you only estimate the ma1 parameter. There is no mean nor slope

# Predicting
plot(signal, xlim=c(0,400), ylim=c(-5,40))
# We have to provide the xreg for the future
a1.pred <- predict(a1, n.ahead = 100)
matlines(301:400, a1.pred<span>$pred + 1.96*cbind(0, -a1.pred$</span>se, a1.pred<span>$se), col=2, lty=c(1,2,2))
legend("bottomleft", legend = c("ARIMA(0,1,1)"), lty=1, col=2)
#Note that the prediction is a constant.
# 'arima' cannot estimate the slope of a trend without specifying it 

# The 'Arima' function from the forecast library can 'include.drift' (a slope)
library(forecast)
?Arima 
Arima # If you dig in you will see that it creates xreg ... see at the end

# Restarting with a simple linear regression (Same as lm(y~time))
a3 <- Arima(signal, order=c(0,0,0), include.drift = TRUE)
tsdiag(a3) # ACF is exponential
pacf(residuals(a3)) # Let us try an AR(1)

a4 <- Arima(signal, order=c(1,0,0), include.drift = TRUE)
tsdiag(a4) # Better but still something in lag 1
pacf(residuals(a4)) # Both lags 1 and 2 so try adding MA(1)

a5 <- Arima(signal, order=c(1,0,1), include.drift = TRUE)
tsdiag(a5) # Looks good
pacf(residuals(a5)) # Also good

# Fitting the same model using 'xreg' in 'arima'
a5b <- arima(signal, order=c(1,0,1), xreg = cbind(inter = 1, trend = 1:length(signal)), include.mean = FALSE)

# But let us try to predict with this model
plot(signal, xlim=c(0,400), ylim=c(-5,40))
# We have to provide the xreg for the future
lm.pred <- cbind(inter = 1, trend = (301:400))
a5b.pred <- predict(a5b, n.ahead = 100, newxreg = lm.pred)
matlines(301:400, a1.pred$</span>pred + 1.96*cbind(0, -a1.pred<span>$se, a1.pred$</span>se), col=2, lty=c(1,2,2))
matlines(301:400, a5b.pred<span>$pred + 1.96*cbind(0, -a5b.pred$</span>se, a5b.pred<span>$se), col=3, lty=c(1,2,2))
legend("topleft", legend = c("Using diff", "Using linear xreg"), lty=1, col=2:3)

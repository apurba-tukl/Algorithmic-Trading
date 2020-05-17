library(xts)
library(tseries)
library(quantmod)
library(PerformanceAnalytics)
library(urca)
library(forecast)

#Creating time-series for SPY 
spyts = (SPY$`Adj Close`)
spyts

#plotting the SPY timeseries
plot(spyts, col='darkred', type = "l", ylab='SPY Price', xlab='Time Periods')

# Stationarity Testing 
stationarity_test = ur.df(spyts, type='none', selectlags='AIC')
summary(stationarity_test)

# conclusion: the time series's not stationary
# Stationarity testing on first differences

spy.diff= diff(spyts, lag=1, differences = 1)
spy.diff = na.omit(spy.diff)

#plotting the SPY timeseries
plot(spy.diff, col='darkgreen', type = "l", ylab='Difference SPY Price', xlab='Time Periods')


# Stationarity Testing with the difference
stationarity_test = ur.df(spy.diff, type='none', selectlags='AIC')
summary(stationarity_test)


#ACF and PACF
ggAcf(spy.diff, lag.max=10) #lags 2 so q=2
ggPacf(spy.diff, lag.max=10) #lags 4 so p=4

#Fit the ARIMA model
ARIMA1 <- Arima(spy.diff, order = c(1,0,1))
ARIMA2 <- Arima(spy.diff, order = c(1,0,2))
ARIMA3 <- Arima(spy.diff, order = c(1,0,3))
ARIMA4 <- Arima(spy.diff, order = c(1,0,4))
ARIMA5 <- Arima(spy.diff, order = c(2,0,1))
ARIMA6 <- Arima(spy.diff, order = c(2,0,2))
ARIMA7 <- Arima(spy.diff, order = c(2,0,3))
ARIMA8 <- Arima(spy.diff, order = c(2,0,4))

#Summary of outputs
summary(ARIMA1)
summary(ARIMA2)
summary(ARIMA3)
summary(ARIMA4)
summary(ARIMA5)
summary(ARIMA6)
summary(ARIMA7)
summary(ARIMA8)

#conclusion: ARIMA4 i.e. ARIMA(1,0, 4) has the lowest AIC AND RMSE

#AUTOARIMA uses AIC and BIC to choose the best ARIMA model
Fitted.ARIMA = auto.arima(spyts)

#plot forecasted ARIMA with last 50 days
q = forecast(Fitted.ARIMA, h=10)
summary(q)
plot(q, include=50)

  


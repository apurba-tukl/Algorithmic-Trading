library(zoo)
library(xts)
library(tseries)
library(urca)
library(quantmod)
library(PerformanceAnalytics)

# Column 6th is the Adjusted Closing price in Yahoo Finance Data
AAPL<-getSymbols("AAPL", source="yahoo", from = "2019-01-01",to = "2019-03-31",
                 auto.assign=FALSE, return.class="xts")[,6]

#Creating time-series for AAPL stock
AAPL <- xts(x=AAPL$AAPL.Adjusted, order.by = index(AAPL))

autoplot(AAPL)

#AR(1) model on APPL stock
arima(AAPL,order = c(1,0,0))

#AR(2) model on APPL stock
arima(AAPL,order = c(2,0,0))


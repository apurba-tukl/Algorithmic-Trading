library(fma)
library(forecast)
library(ggplot2)
library(ggfortify)

autoplot(books, size=1)
#fit a linear regression model
fit <- lm(Paperback  ~ Hardcover, data=books)
#summary of the fit
summary(fit)
#plot the data with the regression line
plot(Paperback  ~ Hardcover, data=books, pch=19)
abline(fit)

#-------------------------
#simple methods of forecasting
#naive method
naive(wineind, 1)
#average
meanf(wineind, 1)
#random walk
rwf(wineind, 1)

#-------------------------
#Moving Average
#structure
str(wineind)
length(wineind)
#moving avearge
sm <- ma(wineind,order=1)
plot(wineind, col="black")
par(new=TRUE)
plot(sm, col="red")

#-------------------------
#simple exponential smoothing with various alphas (smoothing factor)

str(beer)
autoplot(beer)

beer1 <- ses(beer, h=25, level=c(80,95), alpha = 0.1)
summary(beer1)
autoplot(beer1)

beer2 <- ses(beer, h=25, level=c(80,95), alpha = 0.5)
summary(beer2)
autoplot(beer2)

beer3 <- ses(beer, h=25, level=c(80,95), alpha = 0.7)
summary(beer3)
autoplot(beer3)

#-------------------------
#Holt-Winters Forecasting Model

#Holt-Winters Exponential Smoothing Example

#############################
#Simple exponential Smoothing
#############################
airpass

autoplot(airpass)



ses5 <- ses(airpass, h=1)
data.frame(date=index(ses5), coredata(ses5))



accuracy(ses5)
plot(ses5)
fitted(fitted(ses5))


#############################
# Holt's Linear Trend Method
#############################

holt5 <- holt(airpass,h=5)
#autoplot(holt5) + 
#  autolayer(fitted(holt5),series = "Fitted")

plot(holt5)
holt5damped <- holt(airpass, damped=TRUE, phi = 0.9, h=15)

#Evidence suggested that the Holt's Linear Trend method 
#overestimated the predicted values. Gardner and McKenzie (1985) 
#found that dampening the trend helped accuracy

autoplot(airpass) +
  autolayer(holt5[2], series="Holt's method", PI=FALSE) +
  autolayer(holt5damped, series="Damped Holt's method", PI=FALSE) +
  ggtitle("Forecasts from Holt's method") + 
  guides(colour=guide_legend(title="Forecast"))

##############################
# Holt's Seasonal Trend Method
##############################

hw1 <-hw(airpass, seasonal = "additive")
hw2 <-hw(airpass, seasonal = "multiplicative")
plot(airpass, col='black')
par(new=TRUE)
plot(hw1, series="HW additive forecasts", PI=FALSE, col='yellow')
par(new=TRUE)
plot(hw2, series="HW multiplicative forecasts",PI=FALSE, col='red') 
  

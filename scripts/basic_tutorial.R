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
#White Noise

w<- rnorm(5)  # 5 standrd normal distributed number
plot(w, type='l')

plot(rnorm(500), type='l')

mean(w) #close to 0
sd(w) #close to 1

#sample
library(xts)
a <- rnorm(1000)
tsa <- xts(a)
autoplot(tsa)
str(tsa)

library(zoo)
methods(class="zoo")


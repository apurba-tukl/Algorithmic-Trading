
#############################################################
#
# Financial Analytics Assignment 3.
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to create a portfolio.
# You will then be asked to interpret the # results.  
#
# For this assignment, you may use any resources necessary
# to be able to exectute the code.  However, the interpretation 
# should reflect your own thinking.
#
# You are to work on the problem alone, without help 
# from any other person.
#
# In this assignment, you will create a portfolio with only two
# stocks.  Use the sample code for reference.
###############################################################

# INSTRUCTIONS:  Enter your code between the comments line 
# as directed.  Comments begin with a hashtag '#'.

# For example

### Start Code

### End Code

# If you are asked to interpret results, make sure to put your
# answers in a comment line.

################################################################ 

###  required libraries  ###
# Run the following code to load the packages (libraries)
# If the library package does not load properly, make sure 
# that you have installed the package onto  your system.  
# Use the 'Packages' tab in RStudio to install the package.

library(fPortfolio)
library(quantmod)
library(ggplot2)
library(BatchGetSymbols)
library(timeSeries)


#Select two stocks from the S&P 500 and get their ticker symbol from the yahoo finance.
# You may NOT choose Apple, Intel, or any other of the symbols used in the example code.
#####################################################
# QUESTION 1: Write down the stock symbols here.

# Stock 1 is: NFLX

### Start Code

#listing out the companies wthe their respective ticker symbols
#symbols <- stockSymbols()[,c('Name', 'Symbol', 'Exchange')]

#get S&P 500 and get the tickers
df.SP500 <- GetSP500Stocks()
tickers <- df.SP500$Tickers

#Obtaining stock price data for Netflix
Netflix <- getSymbols('NFLX', source="yahoo", auto.assign=FALSE,
                  return.class="xts")[,6]
Netflix

### End Code

# Stock 2 is: AMZN

### Start Code

#Obtaining stock price data for Amazon
Amazon <- getSymbols("AMZN", source="yahoo", auto.assign=FALSE,
                      return.class="xts")[,6]
Amazon
### End Code

#* End Question 1
######################################################

#* In this solution, I use XXXX and YYYY as the two ticker symbols.  The students should
#* update the code appropriately. That is, they should substitute XXXX with the ticker symbol
#* that they selected.

######################################################
# Question 2: Modify the next line of code.
stocks1 <- c("NFLX", "AMZN")

#######################################################
#Run the following code
prices1 <- getSymbols(stocks1[1], source="yahoo", auto.assign=FALSE,
                      return.class="xts")[,6]
prices2 <- getSymbols(stocks1[2], source="yahoo", auto.assign=FALSE,
                      return.class="xts")[,6]

prices <- cbind(prices1, prices2)

colnames(prices) <- stocks1

# End of Code to Run
########################################################
#QUESTION 3: Plot the first stock

plot(prices$NFLX)

#QUESTION 4: Plot the second stock
plot(prices$AMZN)

# End Question 3 and 4
#########################################################

#######################################################
#Run the following code

#Since we will be working with returns, let us convert the price data to returns 

Portfolio1 <- na.omit(diff(log(prices)))

#Trimming the Data to get recent data post 12-31-2014
Portfolio1 <- Portfolio1["2015/"]

head(Portfolio1, 10)
# End of Code to Run
########################################################


########################################################
### QUESTION 5: Update the following code with your stocks to get
#* the means and variances.
mean(Portfolio1$NFLX)
var(Portfolio1$NFLX)
mean(Portfolio1$AMZN)
var(Portfolio1$AMZN)

means <- c(mean(Portfolio1$NFLX),mean(Portfolio1$AMZN))
vars <- c(var(Portfolio1$NFLX),var(Portfolio1$AMZN))

### End code  update
########################################################

#######################################################
#Run the following code
Stockplot <- as.data.frame(t(cbind(vars, means)))
colnames(Stockplot)<- stocks1
Stockplot <- t(Stockplot)

plot(Stockplot, col = heat.colors(3), pch= 15, xlab = "Variance", ylab = "Mean Returns", main = "Risk vs Return")
legend("topleft", legend=stocks1,col=heat.colors(3), lty=1:2, cex=0.8, pch = 15)

#Convert the numeric vectors to timeseries vectors

Portfolio1 <- as.timeSeries(Portfolio1)

#Let us build portfolio using each of the stock combinations to obtain the minimum variance portfolio in each of the cases

#Set Specs
Spec = portfolioSpec()
setNFrontierPoints(Spec)<-100

##Determine the efficient frontier and plot the same
effFrontier1 <- portfolioFrontier(Portfolio1, Spec ,constraints = "LongOnly")
effFrontier1

plot(effFrontier1, c(1))

### End code  to run
########################################################


########################################################
# QUESTION 6: Describe what is an Efficient Frontier plot. 

#* A good answer will desribe the x-axis, y-axis, meaning of the x-axis,
#* meaning of the y-axis, and the points on the frontier.

# Efficient frontier denotes a set of optimal portfolios the offer the highest expected return
# for a lower or defined level of risk or the lowest risk for given level of expected return.
# As we have learnt that the X axis reprents the Risk (in terms of volatality) and the 
# Y axis represents the expected return of the portfolio. Each of the points on the curve is calculated based
# on the combination of weights of each of the assets included in the respective portfolio.
# So, here we can observe that the part of the curve which is of 'grey' color can be ignored as it falls below the minimum
# variance portfolio (right at the point where the black and grey colored part of
# curve coincides). Any part in the black colored portion of the curve is considered legitimate and called as the Efficient Frontier.
# From this portion we need to choose the optimal point by applying strategies like the 'tangency portfolio'.

#######################################################
#Run the following code

##Obtain the weights for each stock for the portfolio with the least variance
mvp1 <- minvariancePortfolio(Portfolio1, spec=portfolioSpec(),constraints="LongOnly")
mvp1

##Obtain the weights for each stock for the tangency portfolio
tanPort1 <- tangencyPortfolio(Portfolio1, spec=portfolioSpec(), constraints="LongOnly")
tanPort1

#Let us tabulate the weights for the two portfolios for comparison
minvarweights1 <- getWeights(mvp1) 
tanportweights1 <- getWeights(tanPort1)
weights1 <- (cbind(minvarweights1, tanportweights1))
colnames(weights1) <- c("Min. Variance Portfolio", "Tangency Portfolio")
weights1

### End code  to run
########################################################
#Questions 7 and 8 use the results from above.

#QUESTION 7.A:What is the Minimum Variance Portfolio?

# The Minimum Variance Portfolio is the combination of securities that's consolidated in a way to 
# reduce the amount of volatality (in terms of variance or standard deviation) of the
# complete portfolio. It's a condition that represents the minimum risk w.r.to the expected
# return. So, any part of the curve below the  Minimum Variance Portfolio is considered to 
# be non-significant because of the higeher risks and less return where the
# same amount of risks provide better returns if we consider the part of the curve with
# black color.
# In this case the Minimum Variance Portfolio has the mean of 0.0015 (Target Return)
# and Cov as 0.0186 (Mean-Var Target Risk), the cordinate is (0.0186, 0.0015)

# Q7.B: What is the expected return of the Minimum Variance Portfolio?

# The expected return at Minimum Variance Portfolio is 0.0015

# Q7.C: What are the weights of the Minimum Variance portfolio.

# The weights at Minimum Variance portfolio is as follows:
# Netflix : 0.1830887 and Amazon : 0.8169113

#QUESTION 8.A:What is the Tangency Portfolio?

# The tangency portfolio is teh optimal point of the risk-return tradeoff. It has the
# highest sharpe ratio i.e the risk adjusted returns. It's location is derived as the point
# where the capital allocation line (taking slope as sharpe ratio) is tangent to the
# Efficient Frontier.
# In this case the Tangency Portfolio has the mean of 0.0015 (Target Return)
# and Cov as 0.0186 (Mean-Var Target Risk), the cordinate is (0.0186, 0.0015)

# Q8.B: What is the expected return of the Tangency Portfolio?

# The expected return of the Tangency Portfolio is 0.0015

# Q8.C: What are the weights of the Tangency portfolio

# The weights at Tangency portfolio is as follows:
# Netflix : 0.239048 and Amazon : 0.760952

#* 
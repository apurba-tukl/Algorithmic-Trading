#############################################################
#
# Financial Analytics Assignment
#
# In this assignment, you are asked to use some of the
# commands demonstrated in the video examples to analyze
# the problem.  You will then be asked to interpret the
# results.
#
# For this assignment, you may use any resources necessary
# to be able to exectute the code.  However, the interpretation
# should reflect your thinking.
#
  # You are to work on the problem alone, without help
# from any other person.
#
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

library(fma)
library(ggplot2)


### end required libraries

### Run the following code

data(housing)                   # This load the housing dataset into R

hstarts <- housing[,'hstarts']  # This line moves one column of housing
# to a variable called hstarts.

# The data housing is a time series dataset with three columns.
# We will only use one column to simplify the code.
# This data is the monthly housing starts from Jan. 1983 - Oct. 1989.

######################################################################
######################################################################
#

#*** START CODING:  Question 1

# Q1.A Inspect the first 10 elements of hstarts using the head() command.

### Start Code

head(hstarts, 10)

### End Code

# Q1.B Plot the hstarts data using autoplot().
### Start Code

autoplot(hstarts)

### End Code

# Q1.C Describe the plot in your own words.
# (answer here - remember to use hash tags for comments)
# We can clearly observe that the time-series doesn't have a strong upward or
# downward trend (A minor downward trend). As far as the seasonality is concerned,
# we can see that the hstarts have gone up in the first half of the year and dies
# off as in the later half. As there's any strong trend, the mean and variance seems to be mostly stable.


# Q1.D Plot the hstarts data using the seasonplot() command.

seasonplot(hstarts)

# Q1.E Describe and interpret theseason plot in your own words.
# (answer here - remember to use hash tags for comments)

#** A good description will note what is on the y-axis, x-axis,
#** describe the trend, and describe any seasonal or cyclical patterns

# We can get a much specific picture of seasonality. Mostly for February to June,
# the hstart is on the higher side and gradually decreases mostly from July onwards.


#*** END CODING: Question 1




### QUESTION 2

# The next set of questions analyze the kkong dataset.
# using linear regression.

data(kkong)   # This data set has height and weight of 21 gorillas.
attach(kkong) # This command allows you to reference just the column names.
# The column names are 'weight' and 'height'.



#*** START CODING:  Question 2


# Q2.A Use the summary() command on the column 'height' and 'weight'.

### Start Code

summary(kkong)

### End Code

# Q2.B Describe the results in your own words. Include

# a description of the range, min, max, and central tendencies will suffice.

#The mean of the weight distribution is 50 with a median on 47. the 1st quartile
#value and the 3rd quartile values is 41 and 53 respectively which means that
# 25% and the 75% percentage of the values values are below 41 and 53 respectively.
# That means there are some outliers in the data which is skewing the dataset.
# For height the mean is 35.14 and the 25% and 75% of the values are below 25 and
# 35 respectively but the max is 150. So, there are some outliers as well.
# overall the data is dense.

boxplot(kkong)
# Q2.C Plot the data using the command plot().

### Start Code

plot(kkong)

### End Code

# Q2.D Describe the results in your own words.

#* The desciption should include a description of the graph and a description
#* of the data clustered around the bottom left corner
#* as well as a discussion of the one outlier at the top left.

# As we conclude before the data is mostly dense but there is an outlier which
# has weight of more than 120 and height of more that 140. The relationship between
# weight and height seems to be approximately liner with a positive correlation.


# Q2.E Run a regression using height as the dependent variable
#      and store the results in 'fit'.  Use the summary() command to see
#      the results.

### Start Code
fit <- lm(height  ~ weight, data=kkong)
summary(fit)
### End Code

# Q2.F From the results answer the following (short answer):
#   - What is the coefficient for weight?
#   - Is the coefficient significant?
#   - What does the coefficient mean? In other words, interpret the coefficient.
#   - What is the Adjusted R-squared and what does it mean?

# coefficient = 1.3078

# As we observe that P value is way less than the t statistics. So, we can reject
# the null hypothesis and conclude that the coefficient is significant.

# coefficient means the wight of the parameter 'weight' in determining the 'height'.
#It also refers the slope of the fitted regression line.

# Adjusted R-squared:  0.8782 which means the weight attributes improves the model by more
#then the expected value and it's able to capture almost 87% meaning of the data.


#*** END CODING:  Question 2


#*** START CODING:  Question 3

# In this question, we will using the hstarts time series used in Question 1.

# Q3.A  Create a moving average of hstarts using 5 lags and store it in hstartsMA5.

### Start Code

hstartsMA5 <- ma(hstarts, 5)

### End Code


# Q3.B  Create a moving average of hstarts using 15 lags and store it in hstartsMA15.

### Start Code

hstartsMA15 <- ma(hstarts, 15)

### End Code

# RUN the following lines to make a graph.
plot(hstartsMA5, col = 'red')
lines(hstartsMA15, col = 'green')


# Q3.C  Describe the two moving average plots in your own words.

# from hstartsMA5 there's is clear seasonality in the data for each year, mostly there's is a spike
#at the middle of the year. But with hstartsMA15 that seasonality is somewhat
#suppressed. In this scenario, it's better to go ahead with hstartsMA15 as it
#captures the meaning of the data and at the same time reduces the impact of
#seasonality.

#*** END CODING:  Question 3


#*** START CODING:  Question 4
#

# Q4.A Create a simple exponential smoothing series using ses()
#     with h=5 lags and store it in hstartsSES5

### Start Code

hstartsSES5 <- ses(hstarts, 5)
summary(hstartsSES5)

### End Code


# Q4.B What is the RMSE?  (Use the accuracy() command.)

### Start Code

accuracy(hstartsSES5)
#RMSE : 19.46083

### End Code


# Q4.C Create a Holt-Winters model using the hw() command and store it in hstartsHWa
#      using the option : seasonal = "additive".

### Start Code

hstartsHWa <- hw(hstarts, seasonal = "additive")
summary(hstartsHWa)

### End Code

# Q4.D Create a Holt-Winters model using the hw() command and store it in hstartsHWm
#      using the option : seasonal = "multiplicative".

### Start Code
hstartsHWm <- hw(hstarts, seasonal = "multiplicative")
summary(hstartsHWm)

### End Code

# run the following to create the plot

autoplot(hstarts) +
  autolayer(hstartsHWa, series="HW additive forecasts",
            PI=FALSE) +
  autolayer(hstartsHWm, series="HW multiplicative forecasts",
            PI=FALSE) +
  ggtitle("Housing Starts") +
  guides(colour=guide_legend(title="Forecast"))

# Q4.E Which model (additive or multiplicative) looks better and why?

# A good answer will describe the two forecast graphs and also describe how the the multiplicative
# forecast will use a percentage of past changes.

# It seems like additive model is a better option to go for. But still on an
# overall perspective I would says both models are able to capture the downward trend
# and also the monthly seasonalities in the data. They both show a nice extrapolation from
# the historical data. As we can observe that the variation in the
# seasonality is quite similar over time and that's why, though by a small margin,
# additive model outperforms the multiplicative model. The dampening of the multiplicative
# happened because of division factor from the previous timestamp. As we can see that
# percentage changes in the seasonality becomes lower especially in the last few years,
# and that factor caused the multiplicative model's results to get dampened a bit.

#* Sample answer
#* Both models are good possibilities for forecasts as they both exibit the cyclical cycles as well
#* the downward trend from 1987 onward.  However, the multiplicative mode also seems to dampen the cycles.
#* A visual inspection of the previous 3-4 cycles seem to confirm the dampening of the cycles.

#*** END CODING:  Question 4

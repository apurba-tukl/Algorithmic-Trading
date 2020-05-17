
#############################################################
#
# Financial Analytics Assignment 2
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


data(pigs) # This load the  dataset into R from fma library

# see https://cran.r-project.org/web/packages/fma/fma.pdf for details.


# The data a time series of monthly total number of pigs
# slaughtered in Victoria, Australia (Jan 1980 - Aug 1995)
# 

#*** START CODING: Question 1

# Q.1  Display the first 24 data points using the head() function.  Familiarize
# yourself with the structure of the data.

  ### Start Code
  
  head(pigs, 24) # first 24 elements in the dataset
  str(pigs) # structure of teh data
  
  ### End Code

# Q.2 Use the autoplot()  command to graph the pigs data.

  ### Start Code
  
  autoplot(pigs)
  
  ### End Code

# Q.3 Describe the plot.

  # We can observe the below points from the time series plot:
    # 1. There is no specific trend in the numbers of pigs slaughtered. There's
    # is some sort of an upward trend till 1985 and then it's kind of decaying till 1990 and
    # the again trend picks up from there.
    # 2. There is no prominent seasonlity in the distribution.
    # A suden slump in pig slaughtered happend from Feb, 1980 to March 1980 
    # while it shoot up in April 1980. Seems like some external or internal shocks
    # in the demand/ supply for pigs in the month of March in 1980 (some kind of anomaly)
    # 3. The timeseries doesn't seem to be stationary from naked eye assessment.
  

#* A good answer will describe the x-axis, y-axis, and any trends.



# Q.4 Use the seasonplot()  command to graph the pigs data.

  ### Start Code
  
  seasonplot(pigs)
  
  ### End Code


# Q.5 Describe the plot.

  # Findings from the plot:
    # 1. There's no prominent seasonlity in the distribution.
    # 2. 1980 March is clearly to be perceived as anomaly here as we see sudden drop
    # in number of pigs slaughtered.
  


# Q.6 Create an ARIMA model using the auto.arima() command and the pigs data. 

  ### Start Code
  
  auto.arima(pigs)
  
  ### End Code


# Q.7 What are the paremeters for the ARIMA model using the data 'pigs'? 
# In other words what is the model (ARIMA (p,d,q)(P,D,Q)) and what do the parameters mean?

  # The best fitted ARIMA model is ARIMA(2,1,0)(2,0,0)[12]
  # the number of significant lags for Auto Regressive part is 2
  # the number of significant lags from Moving Average is 0 (error terms)
  # the order of differentiation is 1 
  # The seasonaliy component is having the significant lags as 2 for Auto Regressive part (backshift by 12*2 = 24 periods in the past)
  # The seasonaliy component is having the significant lags as 0 for Moving Average part (error terms)(backshift by 12*0 = 0 periods in the past)
  # The order of differentiation for seasonaliy component is 0 (number of backshifts in time periods)
  # here m = 12 which mieans a 12 months horizon is considered as a seasonality cycle. 
  # That means, it takes 12 months for a seasonality to get repeated.


#Q.8 What is the AIC value?

  # AIC=3954.06 

#Q.9 What is the AIC used for?

  # AIC is used for comparing the efficiency of the models with several combinations
  # of p, q, d, P, Q, D and m. The model having lowest AIC is considered to be
  # the most accurate/ efficient model.

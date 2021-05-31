#Basic Neural Network Implementation
#We will be using the APTelectricity dataset
#The dataset covers power transfers every 5 minutes for a range of time
#The data comes from a smart meter in a one bedroom house
#The third column has the amount of appliances in use at the time of measurement
#Here we will convert the dataset into a time series
watt_series <- ts(APTelectricity$watt, frequency = 288)

#Here we are plotting the time series
plot(watt_series)

#Now we are going to fit the time series into a neural network
set.seed(34)
library(forecast)
fit = nnetar(watt_series)

#Now let's forecast future watt usage with our neural network
wattforecast <- forecast(fit, h = 400, PI = F)

#Here is a plot of the forecast
library(ggplot2)
autoplot(wattforecast)

#It looks essentially identical to the previous data

#Here we will add an external regressor to our model
#It will be amount of appliances in use
#Should make sense since more appliances = more wattage in use
fit2 = nnetar(watt_series, xreg = APTelectricity$appliances)

#Here we are defining the vector which we want to forecast
#We are going to forecast the next ten hours of usage
y = rep(2, times = 12*10)

newforecast <- forecast(fit2, xreg = y, PI = F)

#Here is the plot of the new forecast
autoplot(newforecast)
#The forecast looks pretty accurate for the early morning usage

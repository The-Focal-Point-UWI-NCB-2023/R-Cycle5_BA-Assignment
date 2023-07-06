library(lubridate)
## Checking date format
str(data$date)

# Comparing Time Series of Two Months January Will be the first Month
str(MonthOne)
temp.date <- as.Date(MonthOne$date, format = "%Y/%m/%d")
MonthOne <- filter(data, (as.Date(data$date) > as.Date('2019-12-01')) & (as.Date(data$date) <= as.Date('2019-12-31'))) #January

#Sorting the days of the Month in Order
MonthOne <- MonthOne[order(MonthOne$date), ]

#Assigning start and end date to the time series
MonthOneTs <- ts(MonthOne$deposit, start = decimal_date(ymd("2019-12-01")), end = decimal_date(ymd("2019-12-31")), frequency = 365 )


#decimal <- 2009.11
date_decimal(time(MonthOneTs)[1])

MonthOne_df <- data.frame(date =date_decimal(time(MonthOneTs)), deposit = as.numeric(MonthOneTs))

#data1 <- as.data.frame(MonthOneTs)
#data1
# Plotting the time series graph
plot(MonthOneTs, type = "l", xlab = "Date", ylab = "Deposit")




#plot_ly(MonthOne_df, x = ~date, y = ~deposit, type = 'scatter', mode = 'lines',
        #xlab = "Date", ylab = "Deposit") %>%
  #layout(title = list(text = "Time Series Plot for January"))




# December Will be the second Month
MonthTwo <- filter(data, (as.Date(data$date) > as.Date('2019-12-01')) & (as.Date(data$date) <= as.Date('2019-12-31')))

#Ordering the Days within the Month
MonthTwo <- MonthTwo[order(MonthTwo$date),]

#Assigning start and end date to the time series
MonthTwoTs <- ts(MonthTwo$deposit, start = decimal_date(ymd("2019-12-01")), end = decimal_date(ymd("2019-12-31")), frequency = 365) #December

# Plotting the time series graph
plot(MonthTwoTs, type = "l", xlab = "Date", ylab = "Deposit") 

MonthOne_df <- data.frame(date =date_decimal(time(MonthOneTs)), deposit = as.numeric(MonthOneTs))




print(formatted_dates)
# Created A second Plot to test Something
ggplot(data = MonthOne_df, aes(x = date, y = deposit)) +
  geom_line() +
  labs(x = "Date", y = "Deposit") +
  ggtitle("January Series")

ggplot(data = MonthTwo, aes(x = date, y = deposit)) +
  geom_line() +
  labs(x = "Date", y = "Deposit") +
  ggtitle("December Series")




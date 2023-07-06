#view the structure of the duration column
str(data$duration)

#view the summary of the data
summary(data$duration)

#find the sum of missing values 
dur_na_sum <- sum(is.na(data$duration))

#find the sum of missing values 
dur_null_sum <- sum(is.null(data$duration))

#shows the distribution
##chose histogram because of numeric values 
duration.hist <- hist(data$duration, main = 'Histogram of Duration (before cleaning)')

#density plot for alternate visualization
d <- density(data$duration,na.rm = T)
plot(d,frame=FALSE, col = "Blue",main = 'Density plot of Duration (before cleaning)')

#convert from seconds to minutes
data$duration <- round(as.duration(data$duration) / dminutes(1))

data$duration <- ifelse(data$duration>12, mean(data$duration), data$duration)
duration.hist <- hist(data$duration,main = 'Density plot of Duration (after cleaning and conversion)')
#density plot for alternate visualization
d <- density(data$duration,na.rm = T)
plot(d,frame=FALSE, col = "Blue",main = 'Histogram of Duration (after cleaning and conversion)')

avg_duration <- mean(data$duration)





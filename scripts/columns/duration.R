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
duration.hist <- hist(data$duration)

#density plot for alternate visualization
d <- density(data$duration,na.rm = T)
plot(d,frame=FALSE, col = "Blue",main="Duration")

avg_duartion <- mean(data$duration)

#convert from seconds to minutes
data$duration_temp <- round(as.duration(data$duration) / dminutes(1))

data$duration <- round(as.duration(data$duration) / dminutes(1))
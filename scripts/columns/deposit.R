#Take an initial look at data
str(data)
summary(data)

# Detecting Outliers
depositPreClean <- data$deposit
d <- density(depositPreClean,na.rm = T)
hist(depositPreClean)
plot(d,frame=FALSE, col = "Blue",main="Deposit")
boxplot(depositPreClean)


#Using average deposit based on job
avg.job.deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE)
data$avg.deposit <- avg.job.deposit$deposit[match(data$job, avg.job.deposit$job)]
data$deposit <- ifelse(is.na(data$deposit), round(data$avg.deposit,1), round(data$deposit,1))
data$balance <- ifelse(data$balance<=-112000, -112000, data$balance)

#After Cleaning
data$avg.deposit <- NULL
avg.job.deposit <- NULL
avg.job.balance <- NULL
plot(density(data$deposit))
plot(hist(data$deposit))
str(data)
summary(data)
d <- NULL

str(data)
summary(data)

d <- density(data$deposit,na.rm = T)
hist(data$deposit)

plot(d,frame=FALSE, col = "Blue",main="Deposit")
boxplot(data$deposit)

#sch2 = data.frame(data$job,sch.data$deposit)
#View (sch2)

#Using average deposit based on job
#avg.job.deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE)
#data$avg_deposit <- avg.job.deposit$deposit[match(data$job, avg.job.deposit$job)]
#data$deposit <- ifelse(is.na(data$deposit), data$avg_deposit, data$deposit)
#data$deposit <- NULL

#Using average balance based on job
avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg_balance <- avg.job.balance$balance[match(data$job, avg.job.deposit$job)]
data$deposit <- ifelse(is.na(data$deposit), data$avg_balance, data$deposit)
data$avg_balance <- NULL

#After Cleaning
View(data)
boxplot(data)
str(data)
summary(data)

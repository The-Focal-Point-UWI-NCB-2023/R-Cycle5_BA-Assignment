str(data)
summary(data)

d <- density(data$deposit,na.rm = T)
hist(data$deposit)

plot(d,frame=FALSE, col = "Blue",main="Deposit")
boxplot(data$deposit)

#sch2 = data.frame(data$job,sch.data$deposit)
#View (sch2)

#Using average deposit based on job
avg.job.deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE)
data$avg_deposit <- avg.job.deposit$deposit[match(data$job, avg.job.deposit$job)]
data$deposit <- ifelse(is.na(data$deposit), round(data$avg_deposit,1), round(data$deposit,1))
data$avg_deposit <- NULL

#Using average balance based on job
#avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
#data$avg_balance <- avg.job.balance$balance[match(data$job, avg.job.deposit$job)]
#data$deposit <- ifelse(is.na(data$deposit), data$avg_balance, data$deposit)
#data$avg_balance <- NULL

data$balance <- ifelse(data$balance<=-112000, -112000, data$balance)

#After Cleaning
#View(data)
avg.job.deposit <- NULL
avg.job.balance <- NULL
boxplot(data)
str(data)
summary(data)
d <- NULL

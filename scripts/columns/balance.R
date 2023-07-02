str(data)
summary(data)
View(data)

boxplot(data)

avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg_balance <- avg.job.balance$balance[match(data$job, avg.job.balance$job)]
#Replace balance with average balance based on job if the balance is over the 75% quater, because we don't want to affect more than 10% of the value
#and we would not be affecting up to 10% when we change outliers using this method
data$balance <- ifelse(data$balance > 278505, as.integer(data$avg_balance), data$balance)
data$avg_balance <- NULL


View(data)

summary(data)

boxplot(data)
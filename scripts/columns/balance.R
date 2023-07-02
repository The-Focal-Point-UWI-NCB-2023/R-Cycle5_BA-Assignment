str(data)
summary(data)
View(data)
options("scipen"=100, digits = 22)

boxplot(data)

avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg_balance <- avg.job.balance$balance[match(data$job, avg.job.balance$job)]
#Replace balance with average balance based on job if the balance is over the 75% quater, because we don't want to affect more than 10% of the value
#and we would not be affecting up to 10% when we change outliers using this method
data$balance <- ifelse(data$balance > 668520, as.integer(data$avg_balance), data$balance)
data$avg_balance <- NULL
count <- sum(data$balance > 668520)
print(paste("Number of rows where balance is higher than 668520:", count))

#View(data)

#summary(data)

#boxplot(data)

#boxplotStats <- boxplot.stats(data$balance)
#sum_outliers <- length(boxplotStats$out)
#print(sum_outliers)
#print(boxplotStats)

#d <- density(data$balance,na.rm = T)

#plot(d,frame=FALSE, col = "Blue",main="Balance")



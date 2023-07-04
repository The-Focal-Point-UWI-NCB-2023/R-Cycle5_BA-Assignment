str(data)
summary(data)
#View(data)
options("scipen"=100, digits = 22)

boxplot(data)


data$old.balance <- data$balance
avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg_balance <- avg.job.balance$balance[match(data$job, avg.job.balance$job)]
#Replace balance with average balance based on job if the balance is over the 75% quater, because we don't want to affect more than 10% of the value
#and we would not be affecting up to 10% when we change outliers using this method
data$balance <- ifelse(data$balance > 668520, as.integer(data$avg_balance), data$balance)
data$new.balance <- data$balance
data$ratio <- percent((data$new.balance- data$old.balance)/data$old.balance)
data <- data %>% mutate(ratio = (old.balance- new.balance) / old.balance,
                        percentage = percent(ratio),
                        new.deposit = ifelse(ratio == 0, deposit, deposit * (1-ratio)))

data$new.balance <- NULL
data$old.balance <- NULL
data$ratio <- NULL
data$percentage <- NULL
data[is.na(data)] <- 0
data$avg_balance <- NULL
data$deposit <- data$new.deposit
data$new.deposit <- NULL

count <- sum(data$balance > 668520)
print(paste("Number of rows where balance is higher than 668520:", count))

avg.job.balance <- NULL

data$deposit <- ifelse(data$deposit>190000, 190000, data$deposit)
#View(data)

#summary(data)

#boxplot(data)

#boxplotStats <- boxplot.stats(data$balance)
#sum_outliers <- length(boxplotStats$out)
#print(sum_outliers)
#print(boxplotStats)

#d <- density(data$balance,na.rm = T)

#plot(d,frame=FALSE, col = "Blue",main="Balance")



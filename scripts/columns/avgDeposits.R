library(ggplot2)

avg.job.deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE)
print(avg.job.deposit)

# Plotting the average deposits
ggplot(avg.job.deposit, aes(x = job, y = deposit)) +
  geom_bar(stat = "identity", fill = "blue") +
  xlab("Job") +
  ylab("Average Deposit") +
  ggtitle("Average Deposits by Job Category")

#getting the minimum deposit value
min_deposit <- min(avg.job.deposit$deposit)
print(min_deposit)

#find the job associated with minimum deposit 
job_min_deposit <- avg.job.deposit$job[avg.job.deposit$deposit == min_deposit]  
print(job_min_deposit)

#getting the maximum deposit value
max_deposit <- max(avg.job.deposit$deposit)
print(max_deposit)

#find the job associated with minimum deposit 
job_max_deposit <- avg.job.deposit$job[avg.job.deposit$deposit == max_deposit]
print(job_max_deposit)

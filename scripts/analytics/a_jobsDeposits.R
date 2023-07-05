library(ggplot2)

avg_job_deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE) 


# Plotting the average deposits
avg_job_deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE) 

# Plotting the average deposits
ggplot(avg_job_deposit, aes(x = job, y = deposit,label=deposit)) +
  geom_bar(stat = "identity", fill = "blue") +
  geom_bar(data = subset(avg_job_deposit, deposit == max(deposit)), fill = "red", stat = "identity")+
  geom_bar(data = subset(avg_job_deposit, deposit == min(deposit)), fill = "black", stat = "identity")+
  geom_text(size = 3, position = position_stack(vjust=1.09)) +
  xlab("Job") +
  ylab("Average Deposit") +
  ggtitle("Average Deposits by Job Category")

#getting the minimum deposit value
min_deposit <- min(avg_job_deposit$deposit)

#find the job associated with minimum deposit 
job_min_deposit <- avg_job_deposit$job[avg_job_deposit$deposit == min_deposit]  

#getting the maximum deposit value
max_deposit <- max(avg_job_deposit$deposit)

#find the job associated with minimum deposit 
job_max_deposit <- avg_job_deposit$job[avg_job_deposit$deposit == max_deposit]

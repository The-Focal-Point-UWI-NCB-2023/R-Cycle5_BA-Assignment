#unique(data$age)
#unique(data$job)

# Creating The weights for Job feature
Job.Weights <- c("admin." = 1, "blue-collar" = 1, "entrepeneur" = 2, "housemaid" = 1,
                 "management" = 0, "retired" = 3,   "self-employed" = 2, "services" = 1, 
                 "student" = 3,"technician" = 1, "unemployed" = 3)
#levels(data$job)
# Creating The weights for Marital feature
Marital.Weights <- c("single" = 1, "married" = 0, "divorced" = 1)
#levels(data$marital)

# Creating The weights for Age feature
age.Weigths <- c("20-29" = 0, "30-39"= 0,  "40-49" = 1,  "50-60" = 2)

# Creating The weights for Housing feature
housing.weights <- c("no" = 0, "yes" = 1)
#levels(data$housing)

# Creating The weights for loan feature
loan.weights <- c("no" = 0, "yes" = 1)
#levels(data$loan)

#Calculating mean for each job and creating a Matrix 
mean.balance <- aggregate(balance ~ job, data = data, FUN = mean)
job.mean.matrix<- matrix(mean.balance$balance, nrow = nlevels(data$job), ncol = 1)
row.names(job.mean.matrix) <- levels(data$job)
colnames(job.mean.matrix) <- "Mean Balance"
#student <- mean.balance$balance[mean_balance$job=="student"]


# Applying Credit Rating Risk based on weights and criteria
data$creditRisk <- Job.Weights[data$job] +
  Marital.Weights[data$marital] +
  housing.weights[data$housing] + 
  age.Weigths[data$age] +
  loan.weights[data$loan] + 
  ifelse(data$balance < job.mean.matrix[data$job], 1, 0 ) + # Checking if an individuals balance is below the mean balance for their associated job
  ifelse(data$balance <= 100000/1000, 2, 0) + # Checking if an individual has a balance of below 100,000 . Divided by 1000 because data was normalized by 1000
  ifelse(data$balance < 0, 1, 0) # Checking if Individuals are in overdraft or not

summary(data$creditRisk)

score.range <- c(-Inf, 2, 4, 6, 8, 12) #creating ranges for different levels of binning 0-2 - Very low, 2-4 Low etc
risk.labels <- c("very low", "low", "medium", "high", "very high") # Creating binning labels of "very low", "low", "medium", "high", "very high"
data$creditRiskBin <- cut(data$creditRisk, breaks = score.range, labels = risk.labels, ) # Binning the data based on the range and labels


#Creating a new data frame with reference number and credit risk filtering customers with only low and very low risks
target.customers <- data %>% select(RefNum, creditRiskBin) %>% 
  filter(creditRiskBin == "very low" | creditRiskBin == "low")

#View(target.customers)
summary(data$creditRiskBin)


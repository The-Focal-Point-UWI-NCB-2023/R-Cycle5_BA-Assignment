#("admin", "unemployed", "management", "housemaid", 
#"entrepreneur", "student", "blue-collar", "self-employed", 
#"retired", "technician", "services")

summary(data$job)

jobPreClean <- data$job

#plot(density(as.numeric(jobPreClean)))
#plot(hist(as.numeric(jobPreClean)))

levels(jobPreClean)
View(data)

# Replace blank values with average per job
# For each blank job get the balance
# Insert the job where the balance matches the closest balance average
avgBalancePerJob <- aggregate(data$balance, list(data$job), FUN=mean, na.rm = TRUE)


# Remove empty factor levels
data$job <- droplevels(data$job)
levels(data$job)

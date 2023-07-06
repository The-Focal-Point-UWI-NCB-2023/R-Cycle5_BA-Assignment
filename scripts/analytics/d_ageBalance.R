age.groups <- c("20-29", "30-39", "40-49", "50-60")
avg.bal <- c()

#average the balance
for (i in 1:length(age.groups)){
  rows <- data[data$age == age.groups[i],]
  avg.bal[i] <- round(mean(rows$balance),2)
}

c("Age Group:",age.groups[which(avg.bal == max(avg.bal))] )
c("Max Average Balance: ",max(avg.bal))

# Plot the bar chart 
barplot(avg.bal, names.arg = age.groups, xlab ="Age Group", 
        ylim = c(0, max(avg.bal) + 20),
        ylab ="Average Balance", col ="lightblue", 
        main ="Average Balance Between Age Groups")
max(avg.bal)

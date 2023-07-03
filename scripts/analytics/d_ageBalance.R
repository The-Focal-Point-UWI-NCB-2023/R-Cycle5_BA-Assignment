all.ages <- unique(data$age)
all.ages
length(all.ages)
groups <- as.character(all.ages)
avg.bal <- c()
#average.balance c

for (i in 1:length(all.ages)){
  rows <- data[data$age == all.ages[i],]
  print(all.ages[i])
  print(groups[i])
  avg.bal[i] <- round(mean(rows$balance),2)
}

#plot(groups, avg.bal, type = "l", xlab = "Age Groups", ylab = "Average Balance", main = "Average Balance Between Groups")


# Create data for chart
val <-data.frame(groups,
                 avg.bal)

# Basic Line
ggplot(data=val, aes(x=groups, y=avg.bal, group=1)) +
  geom_line()+
  geom_point()

# Plot the bar chart 
barplot(avg.bal, names.arg = groups, xlab ="Age Group", 
        ylab ="Average Balance", col ="lightblue", 
        main ="Average Balance Between Age Groups")
max(avg.bal)

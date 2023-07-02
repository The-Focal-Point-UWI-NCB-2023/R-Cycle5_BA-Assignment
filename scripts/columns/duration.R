str(data)
hist(data$duration)
sum(is.na(data$duration))

#convert from seconds to minutes
## right now a new column is created but the durations column can easily be replaced doing same
###just in case there is conflict i just created a new column
data$duration <- round(as.duration(data$duration) / dminutes(1))

data$deposit <- ifelse(data$deposit>190000, 190000, data$deposit)
data$duration <- ifelse(data$duration>12, 12, data$duration)
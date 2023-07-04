data$deposit <- ifelse(data$deposit>190000, 190000, data$deposit)
data$balance <- ifelse(data$balance<=-112000, -112000, data$balance)
# data$duration <- ifelse(data$duration>12, 12, data$duration)
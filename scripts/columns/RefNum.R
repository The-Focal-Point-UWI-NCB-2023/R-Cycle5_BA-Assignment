# Convert to factor check for uniqueness
data$RefNum = as.factor(data$RefNum)

# All unique values, can remove
data$RefNum <- NULL
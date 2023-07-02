# Convert to factor check for uniqueness
data$RefNum = as.factor(data$RefNum)

# All unique values, can remove (1142 factors = 1142 rows)
data$RefNum <- NULL
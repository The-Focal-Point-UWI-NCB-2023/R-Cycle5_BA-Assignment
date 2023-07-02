# Age - Ordinal?
# Converting to factor, gives 42 unique values
summary(data)
data$temp = as.factor(data$age)
data$temp <- NULL

# Data seems clean

# ageSum <- as.vector(summary(data$age))
# ageMin <- ageSum[1]
# age1Q <- ageSum[2]
# ageMedian <- ageSum[3]
# ageMean <- ageSum[4]
# age3Q <- ageSum[5]
# ageMax <- ageSum[6]

# Outlier Detection
agePreClean <- data$age
plot(density(agePreClean))
plot(hist(agePreClean))

# Values > 60 Cap at 60
data$age[data$age > 60] <- 60

# Post Clean Visualization
plot(density(data$age))
plot(hist(data$age))

# Discretize Age
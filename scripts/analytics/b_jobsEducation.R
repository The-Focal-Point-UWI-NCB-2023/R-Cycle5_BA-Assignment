# Checking sum of each category
sum(data$education == "primary")
sum(data$education == "secondary")
sum(data$education == "tertiary")

# Calculate the dominant educational level for each job category
dominant_edu <- aggregate(education ~ job, data, function(x) {
  levels <- table(x)
  levels <- levels[levels == max(levels)]
  paste(names(levels), collapse = ", ")
})

# Print the dominant educational level for each job category
print(dominant_edu)

# Plotting the dominant educational levels
ggplot(dominant_edu, aes(x = job, y = education, fill = education)) +
  geom_bar(stat = "identity") +
  xlab("Job") +
  ylab("Dominant Educational Level") +
  ggtitle("Dominant Educational Levels by Job Category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


library(ggplot2)
library(dplyr)

# Calculate the count of each education level for each job category
edu_count <- data %>%
  group_by(job, education) %>%
  summarize(count = n())

# Plotting the count of each education level for each job category
ggplot(edu_count, aes(x = job, y = count, fill = education)) +
  geom_bar(stat = "identity", position = "stack") +
  xlab("Job") +
  ylab("Count") +
  ggtitle("Count of Education Levels by Job Category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


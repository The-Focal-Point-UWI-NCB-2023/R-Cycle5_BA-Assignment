library(ggplot2)
library(dplyr)
attach(data)


#sum(marital == "married")

married.Cx <- data %>% select(everything()) %>%
  filter(marital == "married")

total.Married = sum(married.Cx$marital == "married")
married.Overdraft <- sum(married.Cx$balance < 0)
percetage.Over <- (married.Overdraft/total.Married) * 100

graphical.df <- data.frame(
  Category = c("Overdraft", "Not in Overdraft"),
  Total = c(married.Overdraft, (total.Married-married.Overdraft))
)
graphical.df$Percentage <- paste0(round(graphical.df$Total / sum(graphical.df$Total) * 100, 1), "%")

overdraft.chart <- ggplot(graphical.df, aes(x = "", y = Total, fill = Category)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  labs(title = "Percentage of Married Customers in Overdraft") +
  theme_void() +
  geom_text(aes(label = Percentage), position = position_stack(vjust = 0.5))

# Display the pie chart 
overdraft.chart

length(boxplot.stats(deposit)$out)

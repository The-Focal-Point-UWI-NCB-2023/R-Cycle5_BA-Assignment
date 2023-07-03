install.packages(corrplot)
library(corrplot)

depBal_matrix <- cor(data[, c('deposit','balance')])
corrplot(depBal_matrix,method = 'ellipse')

#scatter plot for correlation
plot(data$deposit, data$balance, 
     xlab = "Deposit", ylab = "Balance",
     main = "Scatter Plot of Deposit and Balance")
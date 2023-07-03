mortgage.personal <- nrow(data[data$housing == 'yes' & data$loan == 'yes',])
mortgage.personal

one.loan <- nrow(data[xor(data$housing == 'yes', data$loan == 'yes'),])
one.loan

no.loan <- nrow(data[data$housing == 'no' & data$loan == 'no',])
no.loan

chart.data <- c(mortgage.personal,one.loan,no.loan )

piepercent<- round(100*chart.data/sum(chart.data), 1)

labels <- c("Both_Loans", "OneLoan", "NoLoan")

pie(chart.data, labels = piepercent,
    main = "Loan Pie Chart", col = rainbow(length(chart.data)))
legend("topright", c("Both Loans", "One Loan", "No Loan"),
       cex = 0.5, fill = rainbow(length(chart.data)))
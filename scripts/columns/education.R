df <- read.csv(file = file.choose(),stringsAsFactors = TRUE)
library(dplyr)

#Viewing the number of unique values within the column (Should be 3 (Primary, Secondary, Tertiary))
length(unique(df$education)) #= 4

#Counting Empty Spaces 
sum(df$education == "") # 47 missing values

#Counting Na values
sum(is.na(df$education)) # No missing values

attach(df)

avg_balance <- df %>%
  filter(education != "") %>%
  group_by(education) %>%
  summarize(avg_balance = mean(balance, na.rm = TRUE))


#Still working on this
#df <- df %>%
  #mutate(education = if_else(education == "", 
                             #avg_balance[which.min(abs(avg.balance$avg.balance - balance))], 
                            # education))








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


vectorDiff <- (avg_balance - balance)


cleanDf <- mutate(education = )
#df <- df %>%
  #mutate(education = if_else(education == "", 
                             #avg_balance[which.min(abs(avg.balance$avg.balance - balance))], 
                            # education))

attach(avg_balance)

df <- df %>%
  mutate(
    tertiary_diff = balance - avg_balance$avg_balance[3],
    secondary_diff = balance - avg_balance$avg_balance[2],
    primary_diff = balance - avg_balance$avg_balance[1]
  )

#df <- df %>%
  #rowwise() %>%
  #mutate(
    #lowest_diff = if_else(
      #tertiary_diff <= secondary_diff & tertiary_diff <= primary_diff,
      #3,
      #if_else(
        #secondary_diff <= primary_diff,
        #2,
        #1
      #)
    #)
  #)

#df$lowest_diff <- NULL

#df <- df %>%
  #mutate(closest_avg = max.col(-abs(avg_balance - balance)))






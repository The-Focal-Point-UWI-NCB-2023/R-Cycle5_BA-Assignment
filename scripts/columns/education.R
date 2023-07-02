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

#attach(avg_balance)

tempdf <- df %>%
  mutate(
    tertiary_diff = abs(balance - avg_balance$avg_balance[3]),
    secondary_diff = abs(balance - avg_balance$avg_balance[2]),
    primary_diff = abs(balance - avg_balance$avg_balance[1])
  )

tempdf <- tempdf %>%
  rowwise() %>%
  mutate(
    education = if_else(
      education == "",
      if_else(
        tertiary_diff <= secondary_diff & tertiary_diff <= primary_diff,
        "tertiary",
        if_else(
          secondary_diff <= primary_diff,
          "secondary",
          "primary"
        )
      ),
      education
    )
    )

# Removing temporary fields
tempdf$tertiary_diff <- NULL
tempdf$secondary_diff <- NULL
tempdf$primary_diff <- NULL

#Assigning temp back to main df
df <-tempdf

# Checking sum of each category
sum(df$education == "primary")
sum(df$education == "secondary")
sum(df$education == "tertiary")
  







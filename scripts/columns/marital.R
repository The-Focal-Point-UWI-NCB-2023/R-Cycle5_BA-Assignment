df <- read.csv(file = file.choose(),stringsAsFactors = TRUE)

#Viewing the number of unique values within the column (Should be 2 (Yes and NO))
length(unique(df$marital)) #= 3

#Counting Empty Spaces 
sum(df$marital == "")

#Counting Na values
sum(is.na(df$marital))

#No cleaning Required
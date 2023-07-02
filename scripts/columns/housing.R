df <- read.csv(file = file.choose(),stringsAsFactors = TRUE)

#Viewing the number of unique values within the column (Should be 2 (Yes and NO))
length(unique(df$housing)) #= 3

#Counting Empty Spaces 
sum(df$housing == "")

#Counting Na values
sum(is.na(df$housing))

#Cleaning Empty Spaces by deletion as there is no other option to infer the values
df <- df[df$housing != "",]


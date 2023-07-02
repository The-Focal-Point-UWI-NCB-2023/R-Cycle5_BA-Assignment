loan.col <- read.csv(file=file.choose())
View(loan.col)

#Checking For Empty Rows
empty_rows <- is.na(loan.col$loan)
sum(empty_rows)

#Checking For Spaces
space_in_row <- grepl("\\s", loan.col$loan)
sum(space_in_row)

#Check if all rows have the correct category
all(loan.col$loan == "yes" | loan.col$loan == "no")


library(stringr)
# i realized after that we have a main file for this after 
data <- read.csv(file=file.choose())
View(data)

#Checking For Empty Rows
empty_rows <- is.na(data$day)
sum(empty_rows)

#Checking For Spaces
space_in_row <- grepl("\\s", data$day)
sum(space_in_row)


months = 1:12
names(months) = month.name
monthz = str_to_title(data$month)
data[1,day] <- 45
data$date <- as.Date(paste(months[str_to_title(data$month)], data$day, sep = "-"), format = "%m-%d")
x <- c("45jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z
#data$date <- paste(data$month,data$day)
#x <- as.Date(, data$day, sep = "-"), format = "%m-%d")



missing_dates <- sum(is.na(data$date))

if (missing_dates > 0) {
  cat("There are", missing_dates, "missing or invalid dates.")
} else {
  cat("All months have valid dates.")
}






library(stringr)

#Checking For Empty Rows
empty_rows <- is.na(data$day)
sum(empty_rows)

#Checking For Spaces
space_in_row <- grepl("\\s", data$day)
sum(space_in_row)

# Check for non-numeric values 
non.numeric <- any(!is.numeric(data$day))

# Print the result
if (has_non_numeric) {
  cat("The column contains non-numeric values.")
} else {
  cat("The column does not contain any non-numeric values.")
}


#check if a month is invalid using is Date
months = 1:12
names(months) = month.name

data$date <- as.Date(paste(months[str_to_title(data$month)], data$day, sep = "-"), format = "%m-%d")

if(any(is.na(data$date))){
  cat("There are missing or invalid dates.")
}else{
  cat("There are no missing or invalid dates.")
  data$date <- NULL
}

# Check for non-numeric values 
non.numeric <- any(!is.numeric(data$day))

# Print the result
if (has_non_numeric) {
  cat("The column contains non-numeric values.")
} else {
  cat("The column does not contain any non-numeric values.")
}








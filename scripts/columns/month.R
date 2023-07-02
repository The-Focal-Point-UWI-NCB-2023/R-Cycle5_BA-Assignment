#check for na and null values 
sum(is.na(data$month))
sum(is.null(data$month))

#create a vector of valid months
valid_months <- tolower(month.name)
valid_months

#check if any months are invalid
invalid_months <- !(tolower(data$month) %in% valid_months)
sum(invalid_months)
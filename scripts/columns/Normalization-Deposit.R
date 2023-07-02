attach(df) ## Attach function Makes it so each column of a dataframe can be reference by name without $
print(names(df))

df<-tempdf

min.deposit <- min(deposit, na.rm = T) # Setting Min Value
max.deposit <- max(deposit, na.rm = T) # Setting Max value

new.min <- 1 # Setting new min value for normalized Data to 1
new.max <- 100 # Setting new max value for normalized Data to 100

df$deposit <- as.integer(df$deposit)

df<- df %>% 
  # Mutate function essentially  alters the content of a column.
  # In this case we Altering the deposit column to updated with min max normalized values 
  mutate(deposit = as.integer(
    (deposit - min.deposit)/(max.deposit - min.deposit ) * (100 - 1) + 1
    #Formula for Min Max = normalized_value = (value - minimum_value) / (maximum_value - minimum_value) * (new_max - new_min) + new_min
    )
  )

boxplot(df$deposit)


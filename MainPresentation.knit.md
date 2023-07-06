---
title: "Data Science"
author: "The Focal Point"
date: "2023-07-06"
output:
    revealjs::revealjs_presentation:
      navigationMode: linear
      theme: league
      highlight: zenburn
      footer: "The Focal Point (2023)"
      transition: "slide"
      center: true
      css: style.css
---





# Background


-   Bank CB seeks to improve its customer targeting and develop new business lines

-   They want to use the data they have collected so that they can make informed (data-driven) business decisions

------------------------------------------------------------------------

## Problem Definition

-   They want assistance in the form of preliminary insights and answers to their question using the data they have

-   The task involves working in a team to analyze and prepare the data for more complex analysis, uncover preliminary insights, and answer key questions.

------------------------------------------------------------------------

## Assumptions

-   No joint accounts

-   Monetary values should be preserved

-   Longer call duration means more customer interest

------------------------------------------------------------------------

## Constraints

-   No more than 10% of the values should be adjusted

-   Some outliers necessary for analysis

------------------------------------------------------------------------

## Technology Used

-   R - data analytics, preparation

-   R Markdown - slides

    -   revealjs

------------------------------------------------------------------------

## Our Approach

-   Perform column by column data preparation

-   Perform data analysis

-   Configure slides to recreate data preparation and analysis report

------------------------------------------------------------------------

## Terms

-   Factors

-   Central Tendency

-   Outliers

-   Sequicity

-   Cyclical

-   Noise

# Data Collection




```
## 'data.frame':	1142 obs. of  13 variables:
##  $ RefNum   : int  10026141 10026142 10026143 10026144 10026145 10026146 10026147 10026148 10026149 10026150 ...
##  $ age      : int  59 33 60 42 44 50 54 29 59 37 ...
##  $ job      : Factor w/ 12 levels "","admin.","blue-collar",..: 7 6 7 9 6 6 7 2 8 11 ...
##  $ marital  : Factor w/ 3 levels "divorced","married",..: 1 2 2 2 3 3 2 3 2 2 ...
##  $ education: Factor w/ 4 levels "","primary","secondary",..: 4 3 3 3 4 4 3 3 4 3 ...
##  $ housing  : Factor w/ 3 levels "","no","yes": 3 3 3 3 3 3 2 3 2 1 ...
##  $ loan     : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 1 1 1 ...
##  $ contact  : Factor w/ 3 levels "","??","123": 1 3 1 1 2 1 1 1 1 1 ...
##  $ day      : int  5 7 18 26 24 25 1 7 26 5 ...
##  $ month    : Factor w/ 12 levels "april","august",..: 3 5 4 8 1 9 7 6 2 12 ...
##  $ duration : int  168 247 291 187 194 379 151 166 64 232 ...
##  $ deposit  : num  NA NA 41625 136487 186937 ...
##  $ balance  : int  100620 -2700 166680 124740 1792080 234000 472680 -7920 106740 91980 ...
```

# Data Preparation & Cleaning

## What is Data Preparation & Cleaning?

-   Ensuring data integrity, accurate reports

-   Fixing missing values, outliers, noise


## RefNum {.unlisted .unnumbered}


-   Data Type: Qualitative

-   Measurement: Nominal

-   Unique ID number

-   **CAN'T** remove, needed by bank


```r
str(data$RefNum)
```

```
##  int [1:1142] 10026141 10026142 10026143 10026144 10026145 10026146 10026147 10026148 10026149 10026150 ...
```

------------------------------------------------------------------------

### RefNum Preparation


```r
# Convert to factor check for uniqueness 
data$RefNum = as.factor(data$RefNum)  
str(data$RefNum)
```

```
##  Factor w/ 1142 levels "10026141","10026142",..: 1 2 3 4 5 6 7 8 9 10 ...
```

```r
levels <- nlevels(data$RefNum)  
rows <- length(data$RefNum)  

# If the factor count matches the rows 
if(levels == rows) {   
  print("All RefNums Unique") 
}
```

```
## [1] "All RefNums Unique"
```

## Job {.unlisted .unnumbered}


-   Data Type: Qualitative

-   Measurement: Categorical

-   11 Unique Values

-   Large amount of blue-collar jobs

------------------------------------------------------------------------

### Overview

#### Job Categories

| Score | Job Titles                                          |
|-------|-----------------------------------------------------|
| 0     | Management                                          |
| 1     | Admin, Blue-Collar, Housemaid, Services, Technician |
| 2     | Entrepeneur, Self-Employed                          |
| 3     | Student, Retired, Unemployed                        |

------------------------------------------------------------------------

### Job Preparation

-   Noise "" value


```r
str(data$job)
```

```
##  Factor w/ 12 levels "","admin.","blue-collar",..: 7 6 7 9 6 6 7 2 8 11 ...
```

```r
sum(is.na(data$job)) # No NAs
```

```
## [1] 0
```

------------------------------------------------------------------------

-   Converting admin**.** to admin


```r
# Removing . from admin
data$job <- as.character(data$job)
data$job[data$job=='admin.'] <- "admin"
data$job <- as.factor(data$job)
```

------------------------------------------------------------------------

-   Get the average balance per job

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-28-1.png" width="768" />

------------------------------------------------------------------------

-   Replace "" values with the closest match balance


```r
empty_rows <- which(data$job == "") # Empty Rows
for (row in empty_rows) {
  # Find closest job based on balance
  closestMatch <- avgBalancePerJob$Job[
      which.min(
          abs(data$balance[row] - avgBalancePerJob$Balance)
      )
    ]
  #Replace
  data$job[row] <- closestMatch
}

# Check for correct factors
data$job <- droplevels(data$job)
levels(data$job)
```

```
##  [1] "admin"         "blue-collar"   "entrepreneur"  "housemaid"    
##  [5] "management"    "retired"       "self-employed" "services"     
##  [9] "student"       "technician"    "unemployed"
```



------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-31-1.png" width="768" />

------------------------------------------------------------------------

## Deposit {.unlisted .unnumbered}


- This feature represents the average yearly balance of the customer

- Data Type: Quantitative

- Measurement: Ratio


```
##  num [1:1142] NA NA 41625 136487 186937 ...
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##       0    7421   28460   48550   66299  611885     116
```

------------------------------------------------------------------------


```r
avg.job.deposit <- aggregate(deposit ~ job, data, mean, na.rm = TRUE)

data$avg.deposit <- avg.job.deposit$deposit[match(data$job, 
                                                  avg.job.deposit$job)]

data$deposit <- ifelse(is.na(data$deposit), 
                       round(data$avg.deposit,1), 
                       round(data$deposit,1))

data$deposit <- ifelse(data$deposit>190000, 190000, data$deposit)
```

------------------------------------------------------------------------

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-34-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-35-1.png" width="768" />

</div>
:::

------------------------------------------------------------------------

## Deposit Normalization


## Why Normalize?

In order to have smaller values to work with and to preserve the mean of the data-set we decided to perform min-max normalization on the balance and deposit features of our data-set.

------------------------------------------------------------------------


```r
min.deposit <- min(data$deposit, na.rm = T) # Setting Min Value
max.deposit <- max(data$deposit, na.rm = T) # Setting Max value

new.min <- as.integer(min.deposit/1000) # Setting new min value for normalized Data to 0

new.max <- as.integer(max.deposit/1000) # Setting new max value for normalized Data to 199

data<- data %>% 
  # Mutate function essentially  alters the content of a column.
  # In this case we Altering the deposit column to updated with min max normalized values 
  mutate(deposit = as.integer(
    (deposit - min.deposit)/(max.deposit - min.deposit ) 
    * (new.max - new.min) + new.min
  )
  )
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-37-1.png" width="45%" /><img src="MainPresentation_files/figure-revealjs/unnamed-chunk-37-2.png" width="45%" />

------------------------------------------------------------------------

## Balance {.unlisted .unnumbered}


- This feature represents the amount deposited by the customer in the last transaction.

- Data Type: Quantitative

- Measurement: Ratio


```
##  int [1:1142] 100620 -2700 166680 124740 1792080 234000 472680 -7920 106740 91980 ...
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##  -252000    19845   106470   252639   278505 10229580
```

------------------------------------------------------------------------


```r
avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg.balance <- avg.job.balance$balance[match(data$job,
                                                  avg.job.balance$job)]
#Replace balance with average balance based on job
data$balance <- ifelse(data$balance > 668520,as.integer
                       (data$avg.balance), data$balance)
data$new.balance <- data$balance
data$ratio <- percent((data$new.balance- data$old.balance)
                      /data$old.balance)
data <- data %>% mutate(ratio = (old.balance- new.balance)/ old.balance,
                        percentage = percent(ratio),
                        new.deposit = ifelse(ratio == 0, deposit,
                                      deposit * (1-ratio)))
data[is.na(data)] <- 0
data$balance <- ifelse(data$balance<=-112000, -112000, data$balance)
data$deposit <- data$new.deposit
```

------------------------------------------------------------------------

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-40-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-41-1.png" width="768" />

</div>
:::

------------------------------------------------------------------------

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-42-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-43-1.png" width="768" />

</div>
:::

-------------------------------------------------------------

## Balance Normalization


------------------------------------------------------------------------

### Normalizing Balance


```r
min.balance <- min(data$balance, na.rm = T) # Setting Min Value
max.balance <- max(data$balance, na.rm = T) # Setting Max value

# Original 252
new.min <- as.integer(min.balance/1000) # Setting new min value for normalized Data to -112
new.max <- as.integer(max.balance/1000) # Setting new max value for normalized Data to 669


#Normalization Based on Formula
data<- data %>% 
  mutate(balance = as.integer(
    ((balance - min.balance)/(max.balance - min.balance ) 
     * (new.max - new.min) + new.min)
    )
  )
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/figures-side-1.png" width="45%" /><img src="MainPresentation_files/figure-revealjs/figures-side-2.png" width="45%" />

\



------------------------------------------------------------------------

## Age {.unlisted .unnumbered}


-   Data Type: Qualitative

-   Measurement: Ordinal


```
##  int [1:1142] 59 33 60 42 44 50 54 29 59 37 ...
```

------------------------------------------------------------------------

### Preparation


-   Capping values at 60


```r
data$age[data$age > 60] <- 60
```

------------------------------------------------------------------------

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-49-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-50-1.png" width="768" />

</div>
:::

------------------------------------------------------------------------

## Age Discritization

-   Using Equal-Frequency Binning
-   All bins have equal width
-   Preserving original distribution

------------------------------------------------------------------------


```r
# Discretize Age (Using Equal Frequency Binning)
L <- min(data$age) # 20
H <- max(data$age) # 60
N <- 4 # 4 Groups from Histogram
IW <- ((H-L)/N) # 10

data$temp <- data$age

# Convert to groups as factor
age.groups <- c("20-29", "30-39", "40-49", "50-60") 
data$age <- as.factor(ifelse(
  data$temp < 60,
  age.groups[floor(((data$temp/10) - 1))], age.groups[4]
))
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-52-1.png" width="768" />



## Marital {.unlisted .unnumbered}


<h5>Checking For At-most Three Unique Values In Column</h5>


```r
length(unique(data$marital)) #= 3
```

```
## [1] 3
```

<h5>Checking For Spaces</h5>


```r
sum(data$marital == "")
```

```
## [1] 0
```

------------------------------------------------------------------------

<h5>Checking For Null Values</h5>

```r
sum(is.na(data$marital))
```

```
## [1] 0
```


## Education {.unlisted .unnumbered}


## Education Preparation

-   This feature represents the highest level of education attained by each entity.

-   It has 3 factors, namely: Primary, Secondary and Tertiary.


```r
    unique(data$education)
```

```
## [1] tertiary  secondary primary            
## Levels:  primary secondary tertiary
```

## Summary

Measurement : Categorical

Data Type: Factor

The first step in Preparing this feature was to observe the data.


```r
summary(data$education)
```

```
##             primary secondary  tertiary 
##        47       256       648       191
```

------------------------------------------------------------------------

### Education Cleaning - Handling Missing Data

```{=html}
<small> The decision was made to derive the missing data based on information deduced from our data-set. </small>
```
<small> Calculate the average balance associated with each level of education </small>


```{=html}
<div class="plotly html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-24ef2f55bb2077029c56" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-24ef2f55bb2077029c56">{"x":{"visdat":{"4a9443d75e24":["function () ","plotlyVisDat"]},"cur_data":"4a9443d75e24","attrs":{"4a9443d75e24":{"x":{},"y":{},"marker":{"color":["blue","green","red"]},"hovertemplate":"Education: %{x}<br> Average Balance: %{y}","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"education","type":"category","categoryorder":"array","categoryarray":["","primary","secondary","tertiary"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"avg_balance"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["primary","secondary","tertiary"],"y":[159.859375,148.97222222222223,155.79057591623035],"marker":{"color":["blue","green","red"],"line":{"color":"rgba(31,119,180,1)"}},"hovertemplate":["Education: %{x}<br> Average Balance: %{y}","Education: %{x}<br> Average Balance: %{y}","Education: %{x}<br> Average Balance: %{y}"],"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

------------------------------------------------------------------------

### Updating Missing Values




```r
tempdf <- tempdf %>%
  rowwise() %>%
  mutate(
    education = if_else( education == "",
      if_else(
        tertiary_diff <= secondary_diff & tertiary_diff <= primary_diff,
        "tertiary",
        if_else(
          secondary_diff <= primary_diff, "secondary", "primary")
      ),education
    )
    )
data$education <- as.factor(tempdf$education)

summary(data$education)
```

```
##   primary secondary  tertiary 
##       274       676       192
```

------------------------------------------------------------------------


## Housing {.unlisted .unnumbered}


------------------------------------------------------------------------

## Summary - Housing

<small> This feature indicates whether or not a person has a mortgage.</small>

<small> Measurement: Quantitative (Categorical) </small>

<small> Data type: Factor </small>


```r
unique(data$housing)
```

```
## [1] yes no     
## Levels:  no yes
```

------------------------------------------------------------------------

## Summary - Housing


```r
str(data$housing)
```

```
##  Factor w/ 3 levels "","no","yes": 3 3 3 3 3 3 2 3 2 1 ...
```

```r
summary(data$housing)
```

```
##        no  yes 
##    4  106 1032
```

------------------------------------------------------------------------

## Cleaning 

<small> We made the decision to clean these missing values through deletion </small>


```r
data <- data[data$housing != "",]
data$housing <- droplevels(data$housing)
summary(data$housing)
```

```
##   no  yes 
##  106 1032
```

## Loan {.unlisted .unnumbered}


------------------------------------------------------------------------

-   Data Type: Qualitative

-   Measurement: Categorical

------------------------------------------------------------------------

<h5>Checking For Empty Rows</h5>


```r
empty_rows <- is.na(data$loan)
sum(empty_rows)
```

```
## [1] 0
```

<h5>Checking For Spaces</h5>


```r
space_in_row <- grepl("\\s", data$loan)
sum(space_in_row)
```

```
## [1] 0
```

------------------------------------------------------------------------

<h5>Check if all rows have the correct category</h5>


```r
all(data$loan == "yes" | data$loan == "no")
```

```
## [1] TRUE
```

## Contact {.unlisted .unnumbered}


-   No information on what this is

-   Removed


```r
data$contact <- NULL
```

## Day {.unlisted .unnumbered}


------------------------------------------------------------------------

-   Data Type: Quantitative

-   Measurement: Interval

------------------------------------------------------------------------

Checking For Null Elements

```r
empty_rows <- sum(is.na(data$day))
```

Checking For Spaces

```r
space_in_row <- grepl("\\s", data$day)
```

Checking For Non-Numeric Values

```r
non.numeric <- any(!is.numeric(data$day))
```

------------------------------------------------------------------------

## Checking if A Day is Invalid  

```r
months = 1:12
names(months) = month.name

data$date <- as.Date(paste(
  months[str_to_title(data$month)], 
  data$day, sep = "-"), 
  format = "%m-%d")

# Check and print rows with NA values in a specific column FIRST CHECK
na_rows <- is.na(data$date)

# Print the rows with NA values
for (i in which(na_rows)) {
  cat("Row", i, "contains an NA value in column", "column_name", "\n")
}
```

```
## Row 71 contains an NA value in column column_name 
## Row 251 contains an NA value in column column_name 
## Row 731 contains an NA value in column column_name 
## Row 755 contains an NA value in column column_name
```
------------------------------------------------------------------------

```r
# If the date is invalid then change the day to the last 
#real day of the month
for (i in 1:nrow(data)) {
  if(is.na(data$date[i])){
    fixed.date <- as.Date(paste(months
    [str_to_title(data$month[i])], 1, sep = "-"), format = "%m-%d")
    end.of.month <- lubridate::ceiling_date(fixed.date, "month") - 1
    last.day <- format(end.of.month,format ='%d')
    data$day[i] <- as.integer(last.day)
    data$date[i] <- end.of.month
  }
  
  
}
```

------------------------------------------------------------------------

```r
# Check and print rows with NA values in a specific column FINAL CHECK
na_rows <- is.na(data$date)

# Print the rows with NA values
for (i in which(na_rows)) {
  cat("Row", i, "contains an NA value in column", "column_name", "\n")
}

#Remove Date Column
if (sum(na_rows) == 0 ){
  print('There are no invalid days')
  data$date <- NULL}
```

```
## [1] "There are no invalid days"
```
------------------------------------------------------------------------





## Month {.unlisted .unnumbered}


## Month Preparation

This feature indicates the last deposit month of the year for the customer

Measurement: Quantitative (Categorical)

Data type: Factor


```r
#view the structure of the duration column  
str(data$month)
```

```
##  Factor w/ 12 levels "april","august",..: 3 5 4 8 1 9 7 6 2 10 ...
```

------------------------------------------------------------------------

### Summary of Month Data

-   Pre-clean Checks


```r
#find the sum of NA values  
month_na_sum <- sum(is.na(data$month))
print(month_na_sum)
```

```
## [1] 0
```


```r
#find the sum of null values  
month_null_sum <- sum(is.null(data$month))
print(month_null_sum)
```

```
## [1] 0
```

------------------------------------------------------------------------

### Summary of Month Data


```r
#create a list of valid months
valid_months <- tolower(month.name)
print(valid_months)
```

```
##  [1] "january"   "february"  "march"     "april"     "may"       "june"     
##  [7] "july"      "august"    "september" "october"   "november"  "december"
```

```r
#check if any months are invalid
invalid_months <- !(tolower(data$month) %in% valid_months)
num_of_invalid <- sum(invalid_months)
print(num_of_invalid)
```

```
## [1] 0
```

------------------------------------------------------------------------

## Duration {.unlisted .unnumbered}


## Duration Preparation

This feature shows the time spent (seconds) on the last call.

Measurement: Quantitative (Interval)

Data type: Numeric


```r
#view the structure of the duration column 
str(data$duration)
```

```
##  int [1:1138] 168 247 291 187 194 379 151 166 64 322 ...
```


```r
#view the structure of the duration column 
summary(data$duration)
```

```
##                  Min.               1st Qu.                Median 
##    5.0000000000000000  123.2500000000000000  210.5000000000000000 
##                  Mean               3rd Qu.                  Max. 
##  279.8321616871704691  342.5000000000000000 2241.0000000000000000
```

------------------------------------------------------------------------

### Summary of Duration

-   Pre-clean Checks

    
    ```r
    #find the sum of NA values 
    dur_na_sum <- sum(is.na(data$duration))
    print(dur_na_sum)
    ```
    
    ```
    ## [1] 0
    ```
    
    ```r
    #find the sum of null values 
    dur_null_sum <- sum(is.null(data$duration))
    print(dur_null_sum)
    ```
    
    ```
    ## [1] 0
    ```

------------------------------------------------------------------------

## Summary of Duration

-   conversion from SECONDS to MINUTES

    
    ```r
    #install.packages("lubridate")
       
    #convert from seconds to minutes
    data$duration_temp <- round(as.duration(data$duration) / dminutes(1))
    data$duration <- round(as.duration(data$duration) / dminutes(1))
    ```



------------------------------------------------------------------------

## Visualization of Duration

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-84-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-85-1.png" width="768" />

</div>
:::

------------------------------------------------------------------------

## Visualization of Duration

::: {style="display: flex;"}
<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-86-1.png" width="768" />

</div>

<div>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-87-1.png" width="768" />

</div>
:::

------------------------------------------------------------------------

## Summary of Duration


```r
avg_duration <- round(mean(data$duration),2)
print(avg_duration)
```

```
## [1] 3.890000000000000124345
```

------------------------------------------------------------------------

## Last Deposit


-   This feature represents the number of days since the last deposit.

-   Data Type: Quantitative

-   Measurement: Interval


```r
#Convert to characters so that we can convert it to date
data$temp <- as.character(data$month)
data$temp2 <- as.character(data$day)
data$date <- as.Date(paste("2019", data$temp, data$temp2, sep = "-"), format = "%Y-%B-%d")
#Subtracting current date from last deposit to get the days from last deposit
data$last_deposit <- as.integer(Sys.Date() - data$date)
#Clean up temp columns used for calculation
data$temp <- NULL
data$temp2 <- NULL
```

------------------------------------------------------------------------


```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1284    1376    1467    1466    1558    1647
```

# Data Analysis

-   Observation

-   Insights


## Jobs & Deposits {.unlisted .unnumbered}

-   Which categories of jobs have the highest and lowest average deposits?

------------------------------------------------------------------------


### Jobs & Deposits


Table: Table showing the average deposit per job category

|job           | deposit|
|:-------------|-------:|
|admin         |      42|
|blue-collar   |      40|
|entrepreneur  |      35|
|housemaid     |      21|
|management    |      39|
|retired       |      49|
|self-employed |      59|
|services      |      36|
|student       |      24|
|technician    |      38|
|unemployed    |      39|

------------------------------------------------------------------------

### Jobs & Deposits

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-99-1.png" width="768" />

------------------------------------------------------------------------

## Summary of Findings

-   Job with **minimum** deposit: **Student**

-   Job with **maximum** deposit: **Self-employed**

## Jobs & Education Level {.unlisted .unnumbered}

-   What is the dominant educational level of each category of job?

------------------------------------------------------------------------


## Jobs & Education Level {.unlisted .unnumbered}


Table: dominant educational level of each category of job

|job           |education           |
|:-------------|:-------------------|
|admin         |secondary           |
|blue-collar   |secondary           |
|entrepreneur  |secondary, tertiary |
|housemaid     |primary             |
|management    |tertiary            |
|retired       |secondary           |
|self-employed |tertiary            |
|services      |secondary           |
|student       |secondary           |
|technician    |secondary           |
|unemployed    |secondary           |

------------------------------------------------------------------------

## Jobs & Education Level {.unlisted .unnumbered}

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-101-1.png" width="768" />

------------------------------------------------------------------------

## Jobs & Education Level {.unlisted .unnumbered}

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-102-1.png" width="768" />

## Mortgage & Personal Loans {.unlisted .unnumbered}

-   What percentage of persons have both mortgage and personal loan?

------------------------------------------------------------------------


<h3>Gathering Information on Individuals Loans</h3>


```r
mortgage.personal <- nrow(data
[data$housing == 'yes' & data$loan == 'yes',])

one.loan <- nrow(data[xor(data$housing == 'yes', 
data$loan == 'yes'),])

no.loan <- nrow(data[data$housing == 'no' & data$loan == 'no',])
```
### Loan Distribution Table

|Category   | Count|
|:----------|-----:|
|Both Loans |   134|
|One Loan   |   907|
|No Loan    |    97|
------------------------------------------------------------------------

<h3>Presenting Loan Information</h3>

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-105-1.png" width="768" />

## Age & Highest Balance {.unlisted .unnumbered}

-   Which age-group has the highest average balance?

------------------------------------------------------------------------


### Highest Average Age Balance Data Retrieval


```r
age.groups.temp <- c("20-29", "30-39", "40-49", "50-60")
avg.bal <- c()

#average the balance
for (i in 1:length(age.groups)){
  rows <- data[data$age == age.groups[i],]
  avg.bal[i] <- round(mean(rows$balance),2)
}
```

### Average Age Balance Data Results

```
## [1] "Age Group:" "50-60"
```

```
## [1] "Max Average Balance: " "188.22"
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-108-1.png" width="768" />

## Married & Overdraft {.unlisted .unnumbered}

-   What percentage of customers who are married also are in overdraft?

------------------------------------------------------------------------





<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-110-1.png" width="768" />

------------------------------------------------------------------------

- Most Married Customers are good with money management.
- Most Married Customers are not in overdraft.

------------------------------------------------------------------------


## Deposit & Balance {.unlisted .unnumbered}

-   Is there a correlation between deposit and balance? Discuss the findings. Explain the implications.

------------------------------------------------------------------------


<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-111-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-112-1.png" width="768" />

------------------------------------------------------------------------

- Positive Correlation    

- As the deposit increases the balance increases.
- As the balance decreases the deposit decreases.

## Deposit {.unlisted .unnumbered}

-   Plot time-series graph(s) to show comparison between deposits made over 2 comparative periods within the data (month/quarter). Interpret and discuss the result.

------------------------------------------------------------------------


### Time Series December


```
## [1] "2019-12-01 00:00:00 UTC"
```

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-113-1.png" width="768" />

------------------------------------------------------------------------

### Time Series January


<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-114-1.png" width="768" />

# Credit Risk Score

-   If the Bank wanted to launch a new loan product to target persons who may be considered to have the least credit risk, propose a metric to determine these persons. Use at least 3 features to justify/select your target profile. Example: RefNum \< X AND Married=T AND education=="Tertiary" Risk=Low.
-   Be prepared to explain why you made the decision on the variables used for determining the best person to target. This may be helped by investigating what banks generally use.

------------------------------------------------------------------------



```r
# Creating The weights for Job feature
Job.Weights <- c("admin." = 1, "blue-collar" = 1, "entrepeneur" = 2, "housemaid" = 1,
                 "management" = 0, "retired" = 3,   "self-employed" = 2, "services" = 1, 
                 "student" = 3,"technician" = 1, "unemployed" = 3)
#levels(data$job)
# Creating The weights for Marital feature
Marital.Weights <- c("single" = 1, "married" = 0, "divorced" = 1)
#levels(data$marital)
```

------------------------------------------------------------------------


```r
# Creating The weights for Age feature
age.Weigths <- c("20-29" = 0, "30-39"= 0,  "40-49" = 1,  "50-60" = 2)

# Creating The weights for Housing feature
housing.weights <- c("no" = 0, "yes" = 1)
#levels(data$housing)

# Creating The weights for loan feature
loan.weights <- c("no" = 0, "yes" = 1)
#levels(data$loan)
```

------------------------------------------------------------------------



```r
#Calculating mean for each job and creating a Matrix 
mean.balance <- aggregate(balance ~ job, data = data, FUN = mean)
job.mean.matrix<- matrix(mean.balance$balance, nrow = nlevels(data$job), ncol = 1)
row.names(job.mean.matrix) <- levels(data$job)
colnames(job.mean.matrix) <- "Mean Balance"
#student <- mean.balance$balance[mean_balance$job=="student"]
```

------------------------------------------------------------------------

```r
# Applying Credit Rating Risk based on weights and criteria
data$creditRisk <- Job.Weights[data$job] +
  Marital.Weights[data$marital] +
  housing.weights[data$housing] + 
  age.Weigths[data$age] +
  loan.weights[data$loan] + 
  ifelse(data$balance < job.mean.matrix[data$job], 1, 0 ) + # Checking if an individuals balance is below the mean balance for their associated job
  ifelse(data$balance <= 100000/1000, 2, 0) + # Checking if an individual has a balance of below 100,000 . Divided by 1000 because data was normalized by 1000
  ifelse(data$balance < 0, 1, 0) # Checking if Individuals are in overdraft or not

summary(data$creditRisk)
```

```
##                  Min.               1st Qu.                Median 
##  0.000000000000000000  4.000000000000000000  5.000000000000000000 
##                  Mean               3rd Qu.                  Max. 
##  5.084358523725835077  6.000000000000000000 11.000000000000000000
```


------------------------------------------------------------------------

```r
score.range <- c(-Inf, 2, 4, 6, 8, 12) #creating ranges for different levels of binning 0-2 - Very low, 2-4 Low etc
risk.labels <- c("very low", "low", "medium", "high", "very high") # Creating binning labels of "very low", "low", "medium", "high", "very high"
data$creditRiskBin <- cut(data$creditRisk, breaks = score.range, labels = risk.labels, ) # Binning the data based on the range and labels


#Creating a new data frame with reference number and credit risk filtering customers with only low and very low risks
#target.customers <- data %>% select(RefNum, creditRiskBin) %>% 
#  filter(creditRiskBin == "very low" | creditRiskBin == "low")

#View(target.customers)
summary(data$creditRiskBin)
```

```
##  very low       low    medium      high very high 
##        58       411       408       224        37
```

Weights Of Features
------------------------------------------------------------------------

| Feature | Categories     | Weights |
|---------|----------------|---------|
| Job     | admin.         | 1       |
|         | blue-collar    | 1       |
|         | entrepreneur   | 2       |
|         | housemaid      | 1       |
|         | management     | 0       |
|         | retired        | 3       |
|         | self-employed  | 2       |
|         | services       | 1       |
|         | student        | 3       |
|         | technician     | 1       |
|         | unemployed     | 3       |
------------------------------------------------------------------------


| Feature | Categories     | Weights |
|---------|----------------|---------|
| Marital | single         | 1       |
|         | married        | 0       |
|         | divorced       | 1       |
| Age     | 20-29          | 0       |
|         | 30-39          | 0       |
|         | 40-49          | 1       |
|         | 50-60          | 2       |
------------------------------------------------------------------------

| Feature | Categories     | Weights |
|---------|----------------|---------|
| Housing | no             | 0       |
|         | yes            | 1       |
| Loan    | no             | 0       |
|         | yes            | 1       |
------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-120-1.png" width="768" />

------------------------------------------------------------------------









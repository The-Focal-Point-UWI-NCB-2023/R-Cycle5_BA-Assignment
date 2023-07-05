---
title: "Data Science"
author: "The Focal Point"
date: "2023-07-05"
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




```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## corrplot 0.92 loaded
```

# Background





# Data Collection



<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-4-1.png" width="768" />

# Data Preparation & Cleaning


## RefNum {.unlisted .unnumbered}


-   Unique ID number

-   Nominal Measurement (No order)

-   **CAN'T** remove, needed by bank


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


-   Categorical Measurement

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


```
##  Factor w/ 12 levels "","admin.","blue-collar",..: 7 6 7 9 6 6 7 2 8 11 ...
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-26-1.png" width="768" />

------------------------------------------------------------------------


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
##  [1] "admin."        "blue-collar"   "entrepreneur"  "housemaid"    
##  [5] "management"    "retired"       "self-employed" "services"     
##  [9] "student"       "technician"    "unemployed"
```



------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-29-1.png" width="768" />

------------------------------------------------------------------------

## Deposit {.unlisted .unnumbered}


### Deposit Preparation

Data Type: Quantitative

Measurement: Ratio


```
##  num [1:1142] NA NA 41625 136487 186937 ...
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##       0    7421   28460   48550   66299  611885     116
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-31-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-32-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-33-1.png" width="768" />

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


```r
#After Cleaning
data$avg.deposit <- NULL
avg.job.deposit <- NULL
avg.job.balance <- NULL
d <- NULL
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-36-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-37-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-38-1.png" width="768" />

## Deposit Normalization


------------------------------------------------------------------------


```r
min.deposit <- min(data$deposit, na.rm = T) # Setting Min Value
max.deposit <- max(data$deposit, na.rm = T) # Setting Max value

new.min <- 0 # Setting new min value for normalized Data to 0
# Orginal Max - 479
new.max <- 199 # Setting new max value for normalized Data to 199

data<- data %>% 
  # Mutate function essentially  alters the content of a column.
  # In this case we Altering the deposit column to updated with min max normalized values 
  mutate(deposit = as.integer(
    (deposit - min.deposit)/(max.deposit - min.deposit ) * (new.max - new.min) + new.min
    #Formula for Min Max = normalized_value = (value - minimum_value) / (maximum_value - minimum_value) * (new_max - new_min) + new_min
  )
  )
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-40-1.png" width="768" />


------------------------------------------------------------------------



## Balance {.unlisted .unnumbered}


### Balance Preparation

Data Type: Quantitative

Measurement: Ratio


```
##  int [1:1142] 100620 -2700 166680 124740 1792080 234000 472680 -7920 106740 91980 ...
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##  -252000    19845   106470   252639   278505 10229580
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-42-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-43-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-44-1.png" width="768" />

------------------------------------------------------------------------


```r
data$old.balance <- data$balance
avg.job.balance <- aggregate(balance ~ job, data, mean, na.rm = TRUE)
data$avg.balance <- avg.job.balance$balance[match(data$job, avg.job.balance$job)]
#Replace balance with average balance based on job if the balance is over the 75% quartile, because we don't want to affect more than 10% of the value
#and we would not be affecting up to 10% when we change outliers using this method
data$balance <- ifelse(data$balance > 668520, as.integer(data$avg.balance), data$balance)
data$new.balance <- data$balance
data$ratio <- percent((data$new.balance- data$old.balance)/data$old.balance)
data <- data %>% mutate(ratio = (old.balance- new.balance) / old.balance,
                        percentage = percent(ratio),
                        new.deposit = ifelse(ratio == 0, deposit, deposit * (1-ratio)))

data[is.na(data)] <- 0
data$balance <- ifelse(data$balance<=-112000, -112000, data$balance)
```

------------------------------------------------------------------------


```r
#After Cleaning
data$new.balance <- NULL
data$old.balance <- NULL
data$ratio <- NULL
data$percentage <- NULL
data$avg.balance <- NULL
data$deposit <- data$new.deposit
data$new.deposit <- NULL
avg.job.balance <- NULL
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-47-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-48-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-49-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-50-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-51-1.png" width="768" />

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-52-1.png" width="768" />


## Balance Normalization


------------------------------------------------------------------------


```r
min.balance <- min(data$balance, na.rm = T) # Setting Min Value
max.balance <- max(data$balance, na.rm = T) # Setting Max value

# Original 252
new.min <- -112 # Setting new min value for normalized Data to 1
new.max <- 669 # Setting new max value for normalized Data to 100


#Normalization Based on Formula
data<- data %>% 
  # Mutate function essentially  alters the content of a column.
  # In this case we Altering the deposit column to updated with min max normalized values 
  mutate(balance = as.integer(
    ((balance - min.balance)/(max.balance - min.balance ) * (new.max - new.min) + new.min)
    #Formula for Min Max = normalized_value = (value - minimum_value) / (maximum_value - minimum_value) * (new_max - new_min) + new_min
    )
  )
```

------------------------------------------------------------------------

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-54-1.png" width="768" />

------------------------------------------------------------------------


## Age {.unlisted .unnumbered}


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Marital {.unlisted .unnumbered}


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Education {.unlisted .unnumbered}


# Education Preparation

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
<div class="plotly html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-b623934637994e559a28" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-b623934637994e559a28">{"x":{"visdat":{"f00f8f2d66":["function () ","plotlyVisDat"]},"cur_data":"f00f8f2d66","attrs":{"f00f8f2d66":{"x":{},"y":{},"marker":{"color":["blue","green","red"]},"hovertemplate":"Education: %{x}<br> Average Balance: %{y}","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"education","type":"category","categoryorder":"array","categoryarray":["","primary","secondary","tertiary"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"avg_balance"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["primary","secondary","tertiary"],"y":[160.23046875,149.29938271604939,156.16753926701571],"marker":{"color":["blue","green","red"],"line":{"color":"rgba(31,119,180,1)"}},"hovertemplate":["Education: %{x}<br> Average Balance: %{y}","Education: %{x}<br> Average Balance: %{y}","Education: %{x}<br> Average Balance: %{y}"],"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
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
##       273       676       193
```

------------------------------------------------------------------------


## Housing {.unlisted .unnumbered}


------------------------------------------------------------------------

# Summary - Housing

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


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Contact {.unlisted .unnumbered}


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Day {.unlisted .unnumbered}


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

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


```r
#view the structure of the duration column  
summary(data$month)
```

```
##     april    august  december  february   january      july      june     march 
##        95        95        95        95        95        95        95        95 
##       may  november   october september 
##        95        95        94        94
```

-   

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
    
    #check if any months are invalid
    invalid_months <- !(tolower(data$month) %in% valid_months)
    num_of_invalid <- sum(invalid_months)
    ```

------------------------------------------------------------------------

## Visualization of Months

-   Bar graph

    -    used to show distribution blah blah


```r
library(ggplot2)
sum_deposits_per_month <- aggregate(deposit ~ month, data, sum)

ggplot(sum_deposits_per_month, aes(x = month, y = deposit)) +
  geom_bar(stat = "identity", fill = "blue") +
  xlab("Months") +
  ylab("Amount of Deposits") +
  ggtitle("Amount of Deposits per month")
```

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-73-1.png" width="768" />

------------------------------------------------------------------------

## Visualization of Months


```r
library(ggplot2)
sum_deposits_per_month <- aggregate(deposit ~ month, data, sum)

ggplot(sum_deposits_per_month, aes(x = month, y = deposit, label=deposit)) +
  geom_bar(stat = "identity", fill = "blue") +
  geom_bar(data = subset(sum_deposits_per_month, deposit == max(deposit)), fill = "red", stat = "identity")+
  geom_text(size = 3, position = position_stack(vjust=1.02)) +
  xlab("Months") +
  ylab("Amount of Deposits") +
  ggtitle("Amount of Deposits per month") +
  theme(plot.title = element_text(hjust = 0.5))
```

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-74-1.png" width="768" />

## Duration {.unlisted .unnumbered}


## Duration Preparation

This feature measures the time spent on the call during the last contact with the customer, expressed in seconds.

Measurement: Quantitative (Interval)

Data type: Numeric


```r
#view the structure of the duration column 
str(data$duration)
```

```
##  int [1:1138] 168 247 291 187 194 379 151 166 64 322 ...
```

------------------------------------------------------------------------

### Summary of Duration


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

-   Pre clean Checks

    
    ```r
    #find the sum of NA values 
    dur_na_sum <- sum(is.na(data$duration))
    ```

    
    ```r
    #find the sum of null values 
    dur_null_sum <- sum(is.null(data$duration))
    ```

------------------------------------------------------------------------

## Summary of Duration

-   conversion from SECONDS to MINUTES

    
    ```r
    install.packages("lubridate")
    ```
    
    ```
    ## Warning: package 'lubridate' is in use and will not be installed
    ```
    
    ```r
    library('lubridate')
    #convert from seconds to minutes
    data$duration_temp <- round(as.duration(data$duration) / dminutes(1))
    
    data$duration <- round(as.duration(data$duration) / dminutes(1))
    ```

------------------------------------------------------------------------

## Visualization of Duration

-   Histogram

    -   used to show distribution blah blah


```r
hist(data$duration)
```

<img src="MainPresentation_files/figure-revealjs/unnamed-chunk-80-1.png" width="768" />

------------------------------------------------------------------------

## Visualization of Duration

-   Density Plot

    -   used to

    -   alternative visualization

        
        ```r
        d <- density(data$duration,na.rm = T)
        plot(d,frame=FALSE, col = "Blue",main="Duration")
        ```
        
        <img src="MainPresentation_files/figure-revealjs/unnamed-chunk-81-1.png" width="768" />

## Last Deposit


### Last Deposit

Data Type: Quantitative

Measurement: Interval


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
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1283    1374    1465    1465    1556    1646       4
```




# Data Analysis


## Jobs & Deposits {.unlisted .unnumbered}

-   Which categories of jobs have the highest and lowest average deposits?

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Jobs & Education Level {.unlisted .unnumbered}

-   What is the dominant educational level of each category of job?

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Mortgage & Personal Loans {.unlisted .unnumbered}

-   What percentage of persons have both mortgage and personal loan?

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Age & Highest Balance {.unlisted .unnumbered}

-   Which age-group has the highest average balance?

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Married & Overdraft {.unlisted .unnumbered}

-   What percentage of customers who are married also are in overdraft?

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Deposit & Balance {.unlisted .unnumbered}

-   Is there a correlation between deposit and balance? Discuss the findings. Explain the implications.

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Deposit {.unlisted .unnumbered}

-   Plot time-series graph(s) to show comparison between deposits made over 2 comparative periods within the data (month/quarter). Interpret and discuss the result.

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

## Least Credit Risk {.unlisted .unnumbered}

-   If the Bank wanted to launch a new loan product to target persons who may be considered to have the least credit risk, propose a metric to determine these persons. Use at least 3 features to justify/select your target profile. Example: RefNum \< X AND Married=T AND education=="Tertiary" Risk=Low.
-   Be prepared to explain why you made the decision on the variables used for determining the best person to target. This may be helped by investigating what banks generally use.

------------------------------------------------------------------------


### Slide Header 1


```r
# Code Here
print("Test Output")
```

```
## [1] "Test Output"
```

------------------------------------------------------------------------

### Slide Header 2

-   Horizontal Rules Separate Slides

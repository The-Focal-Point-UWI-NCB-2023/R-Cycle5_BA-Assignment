rm(list=ls())

library(ggplot2)
library(lubridate)
library(dplyr)
library(scales)
library(corrplot)

# Project Path 
path <- "./scripts/columns/"

# Read Data (Normalize one feature in the dataset. Justify your decision.)
data <- read.csv(file='./dataset.csv', stringsAsFactors = TRUE)

# Prep job
source(paste(path,"job.R", sep=""))

# Prep deposit, Fix 100+ blank values first, balance fix affect deposit
source(paste(path,"deposit.R", sep=""))

# Prep balance
source(paste(path,"balance.R", sep=""))

# Prep RefNum
source(paste(path,"RefNum.R", sep=""))

# Prep age (The bank has indicated the need to target different age groups. Apply one of the binning methods discussed to discretize age. Justify your selection and apply the changes to make age a categorical variable (factor in R).)
source(paste(path,"age.R", sep=""))

# Prep marital
source(paste(path,"marital.R", sep=""))

# Prep education
source(paste(path,"education.R", sep=""))

# Prep housing
source(paste(path,"housing.R", sep=""))

# Prep loan
source(paste(path,"loan.R", sep=""))

# Prep contact
data$contact <- NULL

# Prep day
source(paste(path,"day.R", sep=""))

# Prep month
source(paste(path,"month.R", sep=""))

# Prep duration (Convert the duration from the current value in seconds to minutes.)
source(paste(path,"duration.R", sep=""))

# Construct last_deposit column
source(paste(path,"last_deposit.R", sep=""))

# Remove other outliers
source(paste(path,"remove_outliers.R", sep=""))

# Normalize Balance
source(paste(path,"Normalization-Balance.R", sep=""))

# Normalize Deposit
source(paste(path,"Normalization-Deposit.R", sep=""))

# boxplot(data$balance)
# boxplotStats <- boxplot.stats(data$balance)
# sum_outliers <- length(boxplotStats$out)
# sum_outliers


source('./scripts/prepData.R')
path <- './scripts/analytics/'

# 2) Data Analysis

# a) Jobs & Deposits
source(paste(path,"a_jobsDeposits.R", sep=""))
  
# b) Jobs & Education Level 
source(paste(path,"b_jobsEducation.R", sep=""))

# c) Mortgage & Personal Loans 
source(paste(path,"c_mortgageLoans.R", sep=""))

# d) Age & Highest Balance 
source(paste(path,"d_ageBalance.R", sep=""))

# e) Married & Overdraft
source(paste(path,"e_marriedOverdraft.R", sep=""))

# f) Deposit & Balance 
source(paste(path,"f_depositBalance.R", sep=""))

# g) Deposit 
source(paste(path,"g_depositTime.R", sep=""))

# h) Least Credit Risk
source(paste(path,"h_creditRisk.R", sep=""))

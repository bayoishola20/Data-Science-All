getwd() # this gets current working directory
setwd("/var/www/example.com/public_html/Data-Science-All") # sets working directory

# library(xlsx)

# The above does have memory issues even for a file as small as 2.5MB. Use below

library("openxlsx")

start.time <- Sys.time()

tradeData <- read.xlsx("Q3_2017_FOREIGN_TRADE_STATISTICS_full_TABLES.xlsx", 1)

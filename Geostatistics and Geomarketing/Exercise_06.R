
#=========================================Q1====================================
# 1a)	Load	the	Dataset	“Groundwater_Temperature.xls”	from	the	data	folder	in	your	Dropbox	share.

install.packages("rio") # install rio package to help with data conversion
# rio allows you to import files in almost any format using one, typically single-argument, function.
library("rio") # activate package
require(rio) # alternative activate package

install.packages("spatstat")
library("spatstat") # activate package
require(spatstat) # alternative activate package

require(sp) # activate package


setwd("/var/www/example.com/public_html/Data-Science-All/Geostatistics and Geomarketing") # set working directory

gw <- import("Groundwater_Temperature.xls") #import data

View(gw) #view data
str(gw) # examine structure of data

convert("Groundwater_Temperature.xls", "Groundwater_Temperature_1.csv") #conversion from xls to csv

gw <- import("Groundwater_Temperature.csv")

gw <- read.csv("Groundwater_Temperature.csv")

View(gw) #view data



gwt <- read.csv("Groundwater_Temperature.csv", header = TRUE, col.names = c("Name", "X_Coordinate", "Y_Coordinate", "Surface", "Date", "Temperature"), colClasses = c("Name" = "character", "X_Coordinate" = "double", "Date" = "character"), numerals = c("no.loss"))

# colClasses are assigned as "character" for "Name" and "Date" to preserve data
# col.names to reassign names of columns to English


class(gwt) # get class of gw_test
str(gwt)

# gwt$Surface <- as.numeric(gwt$Surface) # first convert to numeric to perform value subsetting

gwt_sub <- subset(gwt,subset=(Surface > 0)) # subsetting values of Surface variables > 0. Data now has 489 unlike the original of 492

gwt_sub <- gwt[gwt$Surface > 0,] # alternative subsetting values of Surface variables > 0


# 1b)	Creating a	Point	Pattern


#=========================================Q2====================================

#=========================================Q3====================================

#=========================================Q4====================================

#=========================================Q5====================================

#=========================================Q6====================================

#=========================================Q7====================================

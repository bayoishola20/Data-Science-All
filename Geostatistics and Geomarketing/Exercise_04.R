
#=========================================Q1====================================
# 1a)	Load	the	Dataset	“Groundwater_Temperature.xls”	from	the	data	folder	in	your	Dropbox	share.

install.packages("rio") # install rio package to help with data conversion
# rio allows you to import files in almost any format using one, typically single-argument, function.
library("rio") # activate package
require(rio) # alternative activate package


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

gwt_sub <- subset(gwt,subset=(Surface > 0)) # subsetting values of Surface variables > 0

gwt_sub <- gwt[gwt$Surface > 0,] # alternative subsetting values of Surface variables > 0


# 1b)	Get	a	summary	for	the	imported	data	frame	and	print	the	results	to	your	report.

summary(gwt_sub)

# 1c)	Calculate	the	mean,	the	standard	deviation,	the	median,	the	sum,	the	minimum	and	the	maximum	for	the	 groundwater	temperature	and	the	groundwater	surface	values	and	print	the	results	to	your	report.	
mean(gwt_sub$Temperature) #mean of groundwater temperature
sd(gwt_sub$Temperature) #standard deviation of groundwater temperature
median(gwt_sub$Temperature) #median of groundwater temperature
min(gwt_sub$Temperature) #minimum of groundwater temperature
max(gwt_sub$Temperature) #maximum of groundwater temperature

mean(gwt_sub$Surface) #mean of groundwater surface
sd(gwt_sub$Surface) #standard deviation of groundwater surface
median(gwt_sub$Surface) #median of groundwater surface
min(gwt_sub$Surface) #minimum of groundwater surface
max(gwt_sub$Surface) #maximum of groundwater surface


# 1d) Histogram	plot for	the	groundwater	temperature	and	the	groundwater surface	values

hist(gwt_sub$Temperature, col = "blue", border = "white", main = "Groundwater Temperature", xlab = "Groundwater Temperature", labels = TRUE, plot = TRUE) # Histogram	plot	for	groundwater	temperature

hist(gwt_sub$Surface, col = "brown", border = "white", main = "Groundwater Surface", xlab = "Groundwater Surface", labels = TRUE, plot = TRUE) # Histogram	plot	for	groundwater	temperature

# 1e) site	plan	for	the	sample	locations
plot(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, pch=3, main = "Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", col = "blue", lwd = 1) # site plan of points


# 1f) Buuble plot of coordinates

#========== For Surface
znorm <- gwt_sub$Surface - mean(gwt_sub$Surface) # quasi-normalization of spatial points with "Surface" values

gwt_sub01 <- data.frame(x=gwt_sub$X_Coordinate, y=gwt_sub$Y_Coordinate, z=gwt_sub$Surface, znorm) # defining new data.frame

gwt_sub01_sp <- gwt_sub01 # storing in another variable

coordinates(gwt_sub01_sp) = ~x+y

bubble(gwt_sub01_sp, "znorm", fill=F, main = "Bubble-Plot of Groundwater Surface values", scales = list(draw = TRUE), xlab = "X-Coordinates", ylab = "Y-Coordinates")

#========== For Temperature
znorm <- gwt_sub$Temperature - mean(gwt_sub$Temperature) # quasi-normalization of spatial points with "Surface" values

gwt_sub01 <- data.frame(x=gwt_sub$X_Coordinate, y=gwt_sub$Y_Coordinate, z=gwt_sub$Temperature, znorm) # defining new data.frame

gwt_sub01_sp <- gwt_sub01 # storing in another variable

coordinates(gwt_sub01_sp) = ~x+y

bubble(gwt_sub01_sp, "znorm", fill=F, main = "Bubble-Plot of Groundwater Temperature values", scales = list(draw = TRUE), xlab = "X-Coordinates", ylab = "Y-Coordinates")

# 1g) Decide	if	a	correlation	exists	between	the	groundwater	temperature	and	the	groundwater	surface	values.	Calculate	the	correlation	coefficient	after	Pearson	to	answer	this	question.

cor(gwt_sub$Temperature, gwt_sub$Surface, use = "everything", method = c("pearson"))


# 1h) Plot	the	groundwater	temperature	values	vs.	the	groundwater	surface	values.	Calculate	the	regression	line	and	plot the	regression	line	in	green	above	the	xy-plot.

plot(gwt_sub$Temperature, gwt_sub$Surface, pch=3, main = "Temp. vs Surface", xlab = "Temperature", ylab = "Surface", col = "brown", lwd = 1) # groundwater	temperature	values	vs.	surface	values

abline(lm(gwt_sub$Temperature~gwt_sub$Surface))



#=========================================Q2====================================
# 2)	Calculate	the	Kurtosis	and	Skewness	of	the	groundwater	temperature	values	and	interpret	the	results.

# Kurtosis function
mykurtosis <- function(x) {
  m4 <- mean((x-mean(x))^4)
  kurt <- m4/(sd(x)^4)
  kurt
}

mykurtosis(gwt_sub$Temperature)


# Skewness function
myskewness <- function(x) {
  m3 <- mean((x-mean(x))^3)
  skew <- m3/(sd(x)^3)
  skew
}

myskewness(gwt_sub$Temperature)

#=========================================Q3====================================
# 3 Check if	the	groundwater	temperatures	are	normally	distributed

# histogram
hist(gwt_sub$Temperature, probability = T, col = "gray", border = "white", main = "Groundwater Temperature", xlab = "Temperature(C)", labels = TRUE, plot = TRUE) # probability parameter is important

lines(density(gwt_sub$Temperature), lwd=3, col="red")

# QQ Plot

qqnorm(gwt_sub$Temperature, main = "Groundwater Temperature",xlab = "Quantiles of the Standard Normal Distribution", ylab = "Temperature(C)", col="black")

qqline(gwt_sub$Temperature, lwd=2, col="red")

shapiro.test(gwt_sub$Temperature)

#Interpretation: the p-value of 3.391e-12 is less than 0.05, therefore the null hypothesis (normal distribution) is rejected.
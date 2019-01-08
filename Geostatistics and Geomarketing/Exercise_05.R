
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

marks = gwt_sub$Temperature # get temperature values

Xppp <- ppp(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, marks=gwt_sub$Temperature, window=owin(c(min(gwt_sub$X_Coordinate),max(gwt_sub$X_Coordinate)), c(min(gwt_sub$Y_Coordinate),max(gwt_sub$Y_Coordinate)))) # marks needs to be defined explicitly here

idw.out <- idw(Xppp, power=2) # create IDW with input as ppp-object

plot(idw.out, main="Inverse Distance Weight") #plot

points(Xppp$x,Xppp$y, main = "Point Pattern Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", cex=0.5,pch=19,col="blue", lwd = 1) # plotting of points on IDW

# 1c)Create	a	bubble	plot	for	the	groundwater	temperature	values.	Use	the	regular	plot	command.	Scale	the	symbols	 properly.	Try	another	bubble	plot where	you	use	the	absolute temperatures	for	the	symbol	size.	Discuss	the	difference to the	first	plot.


bubble(gwt_sub, "Temperature", fill=F, main = "Bubble-Plot of Groundwater Temp. values", scales = list(draw = TRUE), xlab = "X-Coordinates", ylab = "Y-Coordinates") # absolute values plot

bubble(Xppp$marks, "znorm", fill=F, main = "Bubble-Plot of Groundwater Temp. values", scales = list(draw = TRUE), xlab = "X-Coordinates", ylab = "Y-Coordinates", cex=gwt_sub$Temperature/5) # cex=gwt_sub$Temperature,	cex=gwt_sub$Temperature/5,	cex=(gwt_sub$Temperature-8)/5



# Discuss difference

#=========================================Q2====================================
# 2)		Calculate	the	Nearest	Neighbour	Index	R	for	the	point	distribution	of	the	groundwater	temperatures.

n = length(nndist(Xppp)) # n = number of points

n

D = mean(nndist(Xppp)) # D = mean nearest neighbour distance

D # View value

# A = area.owin(convexhull.xy(coords(Xppp))) # A = area of region
A = area.owin(bounding.box.xy(coords(Xppp))) # A = area of region

A # view area

R = 2*D*sqrt(n/A) # R = nearest neighbour index

R # view outcome

#Plotting the point pattern
plot(Xppp)
#Plotting the convex hull
plot(bounding.box.xy(coords(Xmeuse)),add=T, border="red")

# The index is between 0 and 2.15. If R = 0, then clustered; R = 1, then random; R = 2.15, then regularly dispersed/distributed. See pic in folder

# Decide:	if	the	points	are	clustered,	randomly	or	regularly	distributed.

#     The Nearest Neighbour Index R value is very sensitive due to changes of the area !!!
# The following points must be considered:
  #Note that the area (or length) affects the index as well as the mean nearest neighbour distance. Accordingly, defining the area correctly is extremely important. There are two possible conventions for this:
  # An area with a well-defined boundary (eg county/administrative district). In some cases you may need to carry out an exercise to define the boundary first - eg mapping the CBD (= City Business District).
  # The smallest possible rectangle that includes all the points you wish to conside .
  # If you are intending to compare nearest neighbour indices for two regions, you should use the same convention for defining the area for each (i.e. both rectangles or both defined boundaries).

#=========================================Q3====================================
# 3 Calculate	the	Centroid	and	the	Weighted Mean	for	the	groundwater	temperature	and	the	groundwater	surface	values.	Discuss	the	results	for	the	temperature	and	surface	values.	What is the	same,	what is different	and	why.

# centroid
ct=sum(gwt_sub$Temperature)/length(gwt_sub$Temperature) # centroid of temperature
cs =sum(gwt_sub$Surface)/length(gwt_sub$Surface) # centroid of surface
#Plotting the Dataset
plot(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate, pch=19, col='black', cex=0.5, asp=1)
#Plotting the Centroid
points(ct,col='red', pch=1, cex=2)

# weighted mean
wmt=sum(meuse$x*meuse$zinc)/sum(meuse$zinc)
wms=sum(meuse$y*meuse$zinc)/sum(meuse$zinc)
#Plotting the Centroid
points(xwm,ywm,col='blue', pch=1, cex=2)

# DISCUSS: 

#Interpretation: 

#=========================================Q4====================================
# 4 Find	the	Nearest	Neighbours	for	every	point	of	the	groundwater	temperature	dataset	using	the	package	spatstat.	Plot the	result.


par(mfrow=c(1,2)) # to help with side-by-side comparison
plot(gwt_sub$Temperature, main='NN of Groundwater Temperature')
m <- nnwhich(gwt_sub$Temperature)
m2 <- nnwhich(gwt_sub$Temperature, k=2)
# plot nearest neighbour links
b <- gwt_sub$Temperature[m]
arrows(cells$x, cells$y, b$x, b$y, angle=15, length=0.15, col="red")
#Find points which are the neighbour of their neighbour
self <- (m[m] == seq(m))
# plot them
A <- gwt_sub$Temperature[self]
B <- gwt_sub$Temperature[m[self]]
plot(gwt_sub$Temperature, main='Neighbour of their Neighbour')
segments(A$x, A$y, B$x, B$y)
par(op)


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

points(Xppp$x,Xppp$y, main = "Point Pattern Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", cex=0.5, pch=19, col="blue", lwd = 1) # plotting of points on IDW

# 1c)Create	a	bubble	plot	for	the	groundwater	temperature	values.	Use	the	regular	plot	command.	Scale	the	symbols	 properly.	Try	another	bubble	plot where	you	use	the	absolute temperatures	for	the	symbol	size.	Discuss	the	difference to the	first	plot.

plot(x <- gwt_sub$Temperature, type = "p", main = "Bubble plot of Temp.", ylab = "y-coordinates")
points(x, col = "dark red", ylab = "Temp.") # no symbol scaling

plot(x <- gwt_sub$Temperature, type = "p", main = "Bubble plot of Temp. scaled at absolute Temp. values", ylab = "y-coordinates")
points(x, cex=gwt_sub$Temperature, col = "dark green") # symbol scaled at temperature absolute values cex=gwt_sub$Temperature


plot(x <- gwt_sub$Temperature, type = "p", main = "Bubble plot of Temp. scaled at one-fifth Temp. values", ylab = "y-coordinates")
points(x, cex=gwt_sub$Temperature/5, col = "dark blue") # symbol scaled at cex=gwt_sub$Temperature/5

plot(x <- gwt_sub$Temperature, type = "p", main = "Bubble plot of Temp.", ylab = "y-coordinates")
points(x, cex=(gwt_sub$Temperature-8)/5, col = "dark orange") # symbol scaled at cex=(gwt_sub$Temperature-8)/5



# Discuss difference between scaled symbols and absolute temperature values symbols

#=========================================Q2====================================
# 2)		Calculate	the	Nearest	Neighbour	Index	R	for	the	point	distribution	of	the	groundwater	temperatures.

n = length(nndist(Xppp)) # n = number of points

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
plot(bounding.box.xy(coords(Xppp)),add=T, border="red")

# Interpretation: 0.9684622 is closer to 1 meaning that groundwater temperature observations are randomly distributed 
# The index is between 0 and 2.15. If R = 0, then clustered; R = 1, then random; R = 2.15, then regularly dispersed/distributed. See pic in folder. Decide:	if	the	points	are	clustered,	randomly	or	regularly	distributed.

#     The Nearest Neighbour Index R value is very sensitive due to changes of the area !!!
# The following points must be considered:
  #Note that the area (or length) affects the index as well as the mean nearest neighbour distance. Accordingly, defining the area correctly is extremely important. There are two possible conventions for this:
  # An area with a well-defined boundary (eg county/administrative district). In some cases you may need to carry out an exercise to define the boundary first - eg mapping the CBD (= City Business District).
  # The smallest possible rectangle that includes all the points you wish to conside .
  # If you are intending to compare nearest neighbour indices for two regions, you should use the same convention for defining the area for each (i.e. both rectangles or both defined boundaries).

#=========================================Q3====================================
# 3 Calculate	the	Centroid	and	the	Weighted Mean	for	the	groundwater	temperature	and	the	groundwater	surface	values.	Discuss	the	results	for	the	temperature	and	surface	values.	What is the	same,	what is different	and	why.

# centroid
xc=sum(gwt_sub$X_Coordinate)/length(gwt_sub$X_Coordinate) # centroid of x
yc =sum(gwt_sub$Y_Coordinate)/length(gwt_sub$Y_Coordinate) # centroid of y
#Plotting the Dataset
plot(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate, xlab='X-Coordinates', ylab='Y-Coordinates', main = "Centroid of Groundwater Temperature.", pch=19, col='dark red', cex=0.6, asp=1)
#Plotting the Centroid
points(xc, yc, col='red', pch=1, cex=2)

c(xc,yc) # print data centroid coordinates

# weighted mean of temperature
x_wmt=sum(gwt_sub$X_Coordinate*gwt_sub$Temperature)/sum(gwt_sub$Temperature)
y_wmt=sum(gwt_sub$Y_Coordinate*gwt_sub$Temperature)/sum(gwt_sub$Temperature)
#Plotting the Centroid
points(x_wmt,y_wmt,col='dark blue', pch=1, cex=2)

c(x_wmt,y_wmt) #print temperature centroid coordinates

# weighted mean of surface
x_wms=sum(gwt_sub$X_Coordinate*gwt_sub$Surface)/sum(gwt_sub$Surface)
y_wms=sum(gwt_sub$Y_Coordinate*gwt_sub$Surface)/sum(gwt_sub$Surface)
#Plotting the Centroid
points(x_wms,y_wms,col='dark green', pch=1, cex=2)

c(x_wms,y_wms) # print surface centroid coordinates

# DISCUSS: 

#Interpretation: 

#=========================================Q4====================================
# 4 Find	the	Nearest	Neighbours	for	every	point	of	the	groundwater	temperature	dataset	using	the	package	spatstat.	Plot the	result.


par(mfrow=c(1,2)) # to help with side-by-side comparison
plot(Xppp, main='NN of Groundwater Temperature') # using point pattern variable Xppp created earlier
m <- nnwhich(Xppp)
m2 <- nnwhich(Xppp, k=2)
# plotting nearest neighbour links
b <- Xppp[m]
arrows(Xppp$x, Xppp$y, b$x, b$y, angle=15, length=0.15, col="red")
#Find points which are the neighbour of their neighbour
self <- (m[m] == seq(m))
# plot them
A <- Xppp[self]
B <- Xppp[m[self]]
plot(Xppp, main='Neighbour of their Neighbour')
segments(A$x, A$y, B$x, B$y, col="blue")
par(op)

# 1a)	Load	the	Dataset	“Groundwater_Temperature.xls”

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


# 1b) Create SPatialPoints object

gwt_sub_xy <- cbind(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate) # X and Y coordinate coercion along column

gwt_sub.sp <- SpatialPoints(gwt_sub_xy)

summary(gwt_sub.sp)

bbox(gwt_sub.sp)

proj4string(gwt_sub.sp)

class(gwt_sub.sp)

str(gwt_sub.sp)

par(mfrow=c(1,2)) # to help with side-by-side comparison

plot(gwt_sub.sp, pch=1, main = "Using SpatialPoints [gwt_sub.sp]", xlab = "X-coordinates", ylab = "Y-coordinates", col = "blue", lwd = 1) # plot of Groundwater dataset using SpatialPoints

plot(gwt_sub, pch=1, main = "Without SpatialPoints [gwt_sub]", xlab = "X-coordinates", ylab = "Y-coordinates", col = "red", lwd = 1) # plot of Groundwater dataset without SpatialPoints

# Difference between SpatialPoints object	(gwt_sub.sp)	and	the	Data	Frame	object	(gwt_sub)	is,	that	the	 SpatialPoints	object	is	lacking	attribute	data.


# 1c) Assign CRS to gwt_sub.sp
proj4string(gwt_sub.sp) # check CRS projection

proj4string(gwt_sub.sp) <- CRS("+init=epsg:31468") # http://spatialreference.org/ref/epsg/31468/

proj4string(gwt_sub.sp) # check CRS projection


# 1d) SpatialPointsDataFrame creation

z <- gwt_sub$Surface

z <- data.frame(z) #set z as dataFrame

gwt_sub.spdf <- SpatialPointsDataFrame(gwt_sub.sp, z) # defining SpatialPointsDataFrame

gwt_sub.spdf # view SpatialPointsDataFrame

# Accessing Properties

gwt_sub.spdf@data  # read z properties

gwt_sub.spdf@coords  # read XY-coordinates

gwt_sub.spdf@proj4string # read CRS which was inherited epsg:31468

gwt_sub.spdf@bbox # access the boundary box



# 2 Load "meuse.grid"



## Additional resources
## https://cran.r-project.org/web/packages/rio/vignettes/rio.html#data_import

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
require(rgeos) #activate rgeos


setwd("/var/www/example.com/public_html/Data-Science-All/Geostatistics and Geomarketing") # set working directory

gw <- import("Groundwater_Temperature.xls") #import data

View(gw) #view data
str(gw) # examine structure of data

convert("Groundwater_Temperature.xls", "Groundwater_Temperature_1.csv") #conversion from xls to csv

gw <- import("Groundwater_Temperature.csv")

gw <- read.csv("Groundwater_Temperature.csv")

View(gw) #view data

install.packages(c("tripack", "akima", "gstat", "dismo", "spatstat", "fields")) # install packages needed for this exercise.

#load all required packages
library("dismo")
library("fields")
library("akimo")
library("spatstat")
library("tripack")
library("spatstat")
library("sp")
library("rgeos")
library("wesanderson")

gwt <- read.csv("Groundwater_Temperature.csv", header = TRUE, col.names = c("Name", "X_Coordinate", "Y_Coordinate", "Surface", "Date", "Temperature"), colClasses = c("Name" = "character", "X_Coordinate" = "double", "Date" = "character"), numerals = c("no.loss"))

# colClasses are assigned as "character" for "Name" and "Date" to preserve data
# col.names to reassign names of columns to English


class(gwt) # get class of gw_test
str(gwt)

# gwt$Surface <- as.numeric(gwt$Surface) # first convert to numeric to perform value subsetting

gwt_sub <- subset(gwt,subset=(Surface > 0)) # subsetting values of Surface variables > 0. Data now has 489 unlike the original of 492

gwt_sub <- gwt[gwt$Surface > 0,] # alternative subsetting values of Surface variables > 0


# 1b)	Create a SpatialPointsDataFrame object (e.g. gwt_sub.spdf) from this imported data.frame (e.g. gwt_sub). The crs of the groundwater temperature dataset is DHDN / 3-degree Gauss-Kruger zone 4. Use the EPSG code of this system (Google!) to define the crs for gwt_sub.sp.

gwt_sub_xy <- cbind(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate) # X and Y coordinate coercion along column

gwt_sub.sp <- SpatialPoints(gwt_sub_xy) # create spatial points

summary(gwt_sub.sp)

bbox(gwt_sub.sp) #get bouding box

proj4string(gwt_sub.sp)

class(gwt_sub.sp) # confirm object class

str(gwt_sub.sp)

proj4string(gwt_sub.sp) <- CRS("+init=epsg:31468") # http://spatialreference.org/ref/epsg/31468/

proj4string(gwt_sub.sp) # check CRS projection

# SPDF for Surface

z <- gwt_sub$Surface #surface as third attribute, z

z <- data.frame(z) # assign z as dataFrame

gwt_sub.spdf <- SpatialPointsDataFrame(gwt_sub.sp, z) # defining SpatialPointsDataFrame

gwt_sub.spdf # print SpatialPointsDataFrame

# SPDF for temperature
w <- gwt_sub$Temperature #temperature as third attribute, w

w <- data.frame(w) # assign w as dataFrame

gwt_sub.spdf2 <- SpatialPointsDataFrame(gwt_sub.sp, w) # defining SpatialPointsDataFrame for temperature

gwt_sub.spdf2 # print SpatialPointsDataFrame

#=========================================Q2====================================

# The package "tripack" includes functions for the Triangulation of irregularly spaced data. 

# 2a) Use the package ”tripack” for creating a triangulation mesh with the Delaunay method for the dataset gwt_sub. Examine the result with summary and plot the mesh.

summary(tri.mesh(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate))

plot(tri.mesh(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate), col="green", main="Delaunay Triangulation")
points(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, col="red")

# 2b) Use the package ”tripack” for creating Voronoi polygons with the Delaunay method for the dataset gwt_sub. Examine the result with summary and plot the Voronoi polygons.

summary(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate))

plot(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"), col="blue", main="Voronoi Polygons")
points(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, col="orange")

# 2c) Plot the triangulation mesh, the Voronoi polygons und the Spatial Points in one map. Discuss the relationship of the triangulation mesh and the Voronoi polygons.

plot(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"), col="blue", main="Triangulation Mesh and Voronoi Polygons")

plot(tri.mesh(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"),col="green", add=TRUE)

points(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate, col="gray")

# DISCUSS

#=========================================Q3====================================
# Use the package “dismo” for creating the Voronoi Polygons with the original data values from the gwt_sub points

voronoi.spoly <- voronoi(gwt_sub.spdf)

plot(voronoi.spoly)
summary(voronoi.spoly)

# 3a) Plot the Voronoi polygons showing the temperature and surface values for each polygon with a specific color scale

#for surface
voronoi.spoly <- voronoi(gwt_sub.spdf)
plot(voronoi.spoly)
spplot(voronoi.spoly, "z", col=heat.colors(5))

#for temperature
voronoi.spoly2 <- voronoi(gwt_sub.spdf2)
plot(voronoi.spoly2)
spplot(voronoi.spoly2, "w", col= rainbow(5))



#3b) Calculate the convex hull for the gwt_sub points use the convex hull for clipping the Voronoi polygons from 3a)



#=========================================Q4====================================

# Use the package “akima” to create a linear interpolation surface for the gwt_sub dataset. Add the triangulation mesh from exercise 2a) and the spatial points from gwt_sub to this plot. Discuss what you see.

#=========================================Q5====================================

#Use the package “spatstat” or the package “gstat” for applying the Inverse Distance Weighting (IDW) for the gwt_sub data. What do you observe, if you are increasing successively the power value. Do you think, that the IDW method is useful for creating spatial surfaces of natural phenomena like precipitation over Europe or gold content of sandstones in the Australian desert.

#=========================================Q6====================================

# Use the package “surf.ls” or the package “gstat” for creating trend surfaces of 1st, 2nd, 3rd and 4th order for the gwt_sub dataset. Compare these 4 different surfaces by calculating the Root Mean Square Error for each of them.

#=========================================Q7====================================

# Use the package “fields” for fitting a thin plate spline surface to the irregularly spaced data of the temperature and surface values of the gwt_sub dataset.
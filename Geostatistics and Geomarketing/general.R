# Numerous spatial data
# https://cran.r-project.org/web/views/Spatial.html

# Spatial Data Types  


# VECTOR vs. RASTER DATA
# For vector data, you are storing only vertices and edges. In Raster, you are storing pixels and this takes up more space.

library("sp") # activate spatial first
getClass("Spatial") # get "Spatial" classes

x <- rnorm(10)

y <- rnorm(10)

class(x)

class(y)

xy <- cbind(x,y) # bind the xy data along the column

class(xy)

xy.sp <- SpatialPoints(xy)

class(xy.sp)

plot(xy)
plot(xy.sp, pch = 3) # default or 3 is cross; 0 is square; 1 is circle; 2 is triangle;


summary(xy.sp)

bbox(xy.sp) #bounding box

proj4string(xy.sp) # Projection not defined

proj4string(xy.sp) <- CRS("+init=epsg:4326")

proj4string(xy.sp) # Projection defined

class(xy.sp) # class of the object xy.sp

str(xy.sp) # internal structure of the object "xy.sp"

xy.sp@coords # get all the coordinates

xy.sp$y # to get the y-coordinates

xy.sp$x # to get the x-coordinates


# SpatialPointDataFrame I
#=========================

z <- rnorm(10)

z <- data.frame(z)

xy.spdf <- SpatialPointsDataFrame(xy.sp, z)

xy.spdf

summary(xy.spdf) # a summary

str(xy.spdf) # find the structure

bbox(xy.spdf) # find bounding box coordinates

proj4string(xy.spdf) # check projection system

coordinates(xy.spdf)

xy.spdf@data

xy.spdf@coords

xy.spdf@bbox

xy.spdf@proj4string


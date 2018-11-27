# 1a)

library("sp") # activate spatial first
getClass("Spatial") # get "Spatial" classes

x <- runif(100, min = 4000000, max = 4010000) # intgers

# x <- sample(4000000:4010000, 100) alternatively

y <- runif(100, min = 5205000,	max = 5205500) # integers

# y <- sample(5205000:5205500, 100) alternatively

z <- runif(100, min = 500,	max = 600) # float

elevations <- data.frame(x,y,z) # DataFrame elevations

# 1b)

plot(elevations$x, elevations$y, pch=1, main = "Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", col = "blue", lwd = 1) # plots x and y of elevations as circles

plot(elevations$x, elevations$y, pch=0, main = "Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", col = "blue", lwd = 1) # plots x and y of elevations as squares

plot(elevations$x, elevations$y, pch=2, main = "Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", col = "blue", lwd = 1) # plots x and y of elevations as triangles

plot(elevations$x, elevations$y, pch=3, main = "Plot of XY coordinates", xlab = "x-coordinates", ylab = "y-coordinates", col = "blue", lwd = 1) # plots x and y of elevations as a crosses


# 1c)

hist(elevations$z, col = "gray", border = "white", main = "Histogram of z coordinates", xlab = "z-coordinates", labels = TRUE)

# 2)

data("meuse") # load the meuse data from "sp" package

# 2a)

meuse$zinc # get column zinc

mean(meuse$zinc) # get mean of zinc column

# 2b)

meuse[,5] # get the fifth column. [row,column]

median(meuse[,5]) # median of fifth column

# 2c)

meuse[30,] # get 30th row

c(meuse[30,]$x, meuse[30,]$y) # coordinates of 30th row

# 2d)

meuse[50,]$lead # lead value of the 50th row

# 3

class(meuse)
str(meuse)

# 3a)

summary(meuse) # main	statistical	parametersfor	every	column

# 3b)

length(meuse) # this means that there are 14 variables

# 3c)

length(meuse$zinc) # this means that there are 155 observations

# 3d)

class(meuse$cadmium) # class type of cadmium: numeric data of float type

# 3e)

class(meuse$soil) # class type of cadmium: factor data with three levels (1, 2 and 3)

# 3f)

names(meuse) # column	names	of the	meuse	dataset

# 4)

meuse.spdf <- meuse # conversion of meuse to SpatialPointsDataFrame

coordinates(meuse.spdf) <- c("x", "y") # x,y coordinates concatenation & becomes a class

proj4string(meuse.spdf) <- CRS("+init=epsg:28992")

meuse.spdf@proj4string # check

plot(meuse.spdf, main = "SpatialPointsDataFrame")

summary(meuse.spdf) # a statistical summary

bbox(meuse.spdf) # find bounding box coordinates

proj4string(meuse.spdf) # check projection system

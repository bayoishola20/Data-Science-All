
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
library("akima")
require(spatstat)
library("tripack")
library("sp")
library("rgeos")
library("spatial")
library("fields")
library("gstat")
library("RColorBrewer")

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

plot(tri.mesh(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate), main="Triangulation mesh based on Delaunay Method", col="blue")
points(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, col="red")

# 2b) Use the package ”tripack” for creating Voronoi polygons with the Delaunay method for the dataset gwt_sub. Examine the result with summary and plot the Voronoi polygons.

summary(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate))

plot(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"), col="blue", main="Voronoi Polygons")
points(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, col="orange")

# 2c) Plot the triangulation mesh, the Voronoi polygons and the Spatial Points in one map. Discuss the relationship of the triangulation mesh and the Voronoi polygons.

plot(voronoi.mosaic(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"), col="blue", main="Triangulation Mesh and Voronoi Polygons")

plot(tri.mesh(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate,duplicate="remove"),col="green", add=TRUE)

points(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate, col="gray")

# DISCUSS: The nodes of the mesh (gray) are equidistant to each other with the voronoi edges (blue) acting as the boundary. To further validate this, the mesh has 489 nodes while the Voronoi polygon has just about twice the number of nodes (961 and 15 dummy nodes.)

#=========================================Q3====================================
# Use the package “dismo” for creating the Voronoi Polygons with the original data values from the gwt_sub points

voronoi.spoly <- voronoi(gwt_sub.spdf)

plot(voronoi.spoly, main="Groundwater Voronoi Polygons")
summary(voronoi.spoly)

# 3a) Plot the Voronoi polygons showing the temperature and surface values for each polygon with a specific color scale

#for surface
voronoi.spoly <- voronoi(gwt_sub.spdf)
spplot(voronoi.spoly, "z", col.regions= brewer.pal(n = 7, name = "Accent"))

#for temperature
voronoi.spoly2 <- voronoi(gwt_sub.spdf2)
spplot(voronoi.spoly2, "w", col.regions= brewer.pal(n = 7, name = "OrRd"))



#3b) Calculate the convex hull for the gwt_sub points use the convex hull for clipping the Voronoi polygons from 3a)

Xgwt <- ppp(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, marks=gwt_sub$Temperature, window=owin(c(min(gwt_sub$X_Coordinate),max(gwt_sub$X_Coordinate)), c(min(gwt_sub$Y_Coordinate),max(gwt_sub$Y_Coordinate))))

A=area.owin(bounding.box.xy(coords(Xgwt)))

gwtCH <- convexhull.xy(coords(Xgwt))

plot(gwtCH, col="gray", projection="UTM")

#for surface
voronoi.spoly <- voronoi(gwt_sub.spdf)
plot(voronoi(gwt_sub.spdf))
spplot(voronoi(gwt_sub.spdf), "z", col.regions= brewer.pal(n = 7, name = "Accent"))
plot(gwtCH,add=T, border="red")


#for temperature
voronoi.spoly2 <- voronoi(gwt_sub.spdf2)
plot(voronoi(gwt_sub.spdf2))
spplot(voronoi(gwt_sub.spdf2), "w", col.regions= brewer.pal(n = 7, name = "OrRd"))
plot(gwtCH,add=T, border="red")


# clip surface
require(PBSmapping)

gwt_subXY<-data.frame(gwt_sub$X_Coordinate,gwt_sub$Y_Coordinate)
names(gwt_subXY)<- c("X","Y")
summary(gwt_subXY)

convexHull <- calcConvexHull(gwt_subXY)
class(convexHull)
plotMap(convexHull, col="gray", border = "red")
p1 = cbind(convexHull$X, convexHull$Y)
sp1 = Polygons(list(Polygon(p1)),"p1")
sp = SpatialPolygons(list(sp1))
proj4string(sp) <-CRS("+init=epsg:31468")
summary(sp)


voronoi.spolyClip <- crop(voronoi.spoly, sp)
spplot(voronoi.spolyClip, "z", col.regions= brewer.pal(n = 7, name = "Accent"))


# clip Temperature
voronoi.spolyClip2 <- crop(voronoi.spoly2, sp)
spplot(voronoi.spolyClip2, "w", col.regions= brewer.pal(n = 7, name = "OrRd"))

#=========================================Q4====================================

# Use the package “akima” to create a linear interpolation surface for the gwt_sub dataset. Add the triangulation mesh from exercise 2a) and the spatial points from gwt_sub to this plot. Discuss what you see.

gwt_sub.li <- interp(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, gwt_sub$Surface)
#Plotting the results
image (gwt_sub.li, main="Linear Interpolation Surface, Mesh and Points", asp=1)
contour(gwt_sub.li, col='blue', add=TRUE)
points(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, pch = 1, xlab = "x-coordinates", ylab = "y-coordinates")
plot(tri.mesh(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate), col="blue", add =TRUE, lty="dotted")

# DISCUSSION: 

#=========================================Q5====================================

#Use the package “spatstat” or the package “gstat” for applying the Inverse Distance Weighting (IDW) for the gwt_sub data. What do you observe, if you are increasing successively the power value. Do you think, that the IDW method is useful for creating spatial surfaces of natural phenomena like precipitation over Europe or gold content of sandstones in the Australian desert.

# PS: Ensure you don't have both gstat and spatstat package loaded

par(mfrow=c(2,2)) # for comparison

Xgwt <- ppp(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, marks = gwt_sub$Surface, window=owin(c(min(gwt_sub$X_Coordinate),max(gwt_sub$X_Coordinate)), c(min(gwt_sub$Y_Coordinate),max(gwt_sub$Y_Coordinate))))

idw.out <- idw(Xgwt, power=2) # create IDW with input as ppp-object @ pow = 2

plot(idw.out, main="Inverse Distance Weight (pow=2)") #plot


idw.out <- idw(Xgwt, power=3) # create IDW with input as ppp-object @ pow = 3

plot(idw.out, main="Inverse Distance Weight (pow=3)") #plot


idw.out <- idw(Xgwt, power=4) # create IDW with input as ppp-object @ pow = 4

plot(idw.out, main="Inverse Distance Weight (pow=4)") #plot


idw.out <- idw(Xgwt, power=5) # create IDW with input as ppp-object @ pow = 5

plot(idw.out, main="Inverse Distance Weight (pow=5)") #plot

# DISCUSSION:

#=========================================Q6====================================

# Use the package “surf.ls” or the package “gstat” for creating trend surfaces of 1st, 2nd, 3rd and 4th order for the gwt_sub dataset. Compare these 4 different surfaces by calculating the Root Mean Square Error for each of them.

#Least Square Method from 1 to 4th power

gwt_sub1 <- surf.ls(1, x = gwt_sub$X_Coordinate, y = gwt_sub$Y_Coordinate, z = gwt_sub$Surface)
gwt_sub2 <- surf.ls(2, x = gwt_sub$X_Coordinate, y = gwt_sub$Y_Coordinate, z = gwt_sub$Surface)
gwt_sub3 <- surf.ls(3, x = gwt_sub$X_Coordinate, y = gwt_sub$Y_Coordinate, z = gwt_sub$Surface)
gwt_sub4 <- surf.ls(4, x = gwt_sub$X_Coordinate, y = gwt_sub$Y_Coordinate, z = gwt_sub$Surface)

# Difference between the Predictions and the Observed Values
z1<-predict(gwt_sub1, gwt_sub1$x, gwt_sub1$y)
delta1=gwt_sub$Surface-z1

z2<-predict(gwt_sub2, gwt_sub2$x, gwt_sub2$y)
delta2=gwt_sub$Surface-z2

z3<-predict(gwt_sub3, gwt_sub3$x, gwt_sub3$y)
delta3=gwt_sub$Surface-z3

z4 <- predict(gwt_sub4, gwt_sub4$x, gwt_sub4$y)
delta4=gwt_sub$Surface-z4


# RMSE  comparison

sqrt(sum(delta1**2/length(delta1)))
sqrt(sum(delta2**2/length(delta2)))
sqrt(sum(delta3**2/length(delta3)))
sqrt(sum(delta4**2/length(delta4)))

par(mfrow = c(2, 2))
hist(delta1, main="Hist. of Delta at Pow=1", col=topo.colors(6), border = "white")
hist(delta2, main="Hist. of Delta at Pow=2", col=topo.colors(6), border = "white")
hist(delta3, main="Hist. of Delta at Pow=3", col=topo.colors(6), border = "white")
hist(delta4, main="Hist. of Delta at Pow=4", col=topo.colors(6), border = "white")

#=========================================Q7====================================

# Use the package “fields” for fitting a thin plate spline surface to the irregularly spaced data of the temperature and surface values of the gwt_sub dataset.


#=== For Temperature
gwt_spline<-Tps(coordinates(gwt_sub.sp), gwt_sub$Temperature)

par(mfrow = c(1, 2)) # for side-by-side comparison

#Plot the surface object
surface(gwt_spline)
class(gwt_spline)
points(gwt_sub.sp)

#Plot the predict.surface object
gwt_spline_img<-predictSurface(gwt_spline)
class(gwt_spline_img)
image(gwt_spline_img)
contour(gwt_spline_img,add=T)
points(gwt_sub.sp,col='white', xlab="x-coordinates", ylab="y-coordinates")


#=== For Surface
gwt_spline<-Tps(coordinates(gwt_sub.sp), gwt_sub$Surface)

par(mfrow = c(1, 2)) # for side-by-side comparison

#Plot the surface object
surface(gwt_spline)
class(gwt_spline)
points(gwt_sub.sp)

#Plot the predict.surface object
gwt_spline_img<-predictSurface(gwt_spline)
class(gwt_spline_img)
image(gwt_spline_img)
contour(gwt_spline_img,add=T)
points(gwt_sub.sp,col='white')

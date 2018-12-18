
#=========================================Q1====================================
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

plot(gwt_sub$X_Coordinate, gwt_sub$Y_Coordinate, pch=1, main = "Without SpatialPoints [gwt_sub]", xlab = "X-coordinates", ylab = "Y-coordinates", col = "blue", lwd = 1) # plot of Groundwater dataset without SpatialPoints

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


#=========================================Q2====================================
# 2 Load "meuse.grid"

data("meuse.grid") # load "meuse.grid" data from package "sp"
class(meuse.grid)

# 2a) SpatialGridDataFrame of attribute soil

# creation of "SpatialPointsDataFrame"
meuse.grid_SPointDF <- meuse.grid # assigning as variable to keep main data untouched

coordinates(meuse.grid_SPointDF) <- c("x", "y") # setting coordinates and promotion to SpatialPointsDataFrame

meuse.grid_SPointDF@coords # to acccess the coordinates slot @

class(meuse.grid_SPointDF) # calidate object class is "SpatialPointsDataFrame"

# creation of "SpatialPixelsDataFrame"
meuse.grid_SPixelDF <- SpatialPixelsDataFrame(coordinates(meuse.grid_SPointDF), data = meuse.grid) # promotion of SpatialPointsDataFrame to SpatialPixelsDataFrame
class(meuse.grid_SPixelDF) # confirm object class as "SpatialPixelsDataFrame"


# creation of "SpatialGridDataFrame"
meuse.grid_SGridDF <- as(meuse.grid_SPixelDF, "SpatialGridDataFrame") # promotion to SpatialGridDataFrame
class(meuse.grid_SGridDF) # confirm object class as "SpatialGridDataFrame"

# plots with plot,image	and	spplot
plot(meuse.grid_SGridDF["soil"], main = "meuse.grid SpatialGridDataFrame soil attribute (plot)", col = rainbow(3)) # plot
image(meuse.grid_SGridDF["soil"], main = "meuse.grid SpatialGridDataFrame soil attribute (image)", col = topo.colors(3)) # image
spplot(meuse.grid_SGridDF["soil"], main = "meuse.grid SpatialGridDataFrame soil attribute (ssplot)") # spplot

# par(mfrow=c(1,3)) # to help with side-by-side comparison


# 2b) SpatialPixelsDataFrame of attribute soil

# creation of "SpatialPointsDataFrame"
meuse.grid_SPointDF <- meuse.grid # assigning as variable to keep main data untouched

coordinates(meuse.grid_SPointDF) <- c("x", "y") # setting coordinates and promotion to SpatialPointsDataFrame

meuse.grid_SPointDF@coords # to acccess the coordinates slot @

class(meuse.grid_SPointDF) # calidate object class is "SpatialPointsDataFrame"

# creation of "SpatialPixelsDataFrame"
meuse.grid_SPixelDF <- SpatialPixelsDataFrame(coordinates(meuse.grid_SPointDF), data = meuse.grid) # promotion of SpatialPointsDataFrame to SpatialPixelsDataFrame
class(meuse.grid_SPixelDF) # confirm object class as "SpatialPixelsDataFrame"

par(mfrow=c(1,3)) # to help with side-by-side comparison
# plots with plot,image	and	spplot
plot(meuse.grid_SPixelDF["soil"], main = "meuse.grid SpatialPixelDataFrame soil attribute (plot)", col = rainbow(3)) # plot: n val of rainbow must equal factor levels of soil which is 3. (1,2,3)
image(meuse.grid_SPixelDF["soil"], main = "meuse.grid SpatialPixelDataFrame soil attribute (image)", col = topo.colors(3)) # image
spplot(meuse.grid_SPixelDF["soil"], main = "meuse.grid SpatialPixelDataFrame soil attribute (ssplot)") # spplot

# par(mfrow=c(1,3)) # to help with side-by-side comparison


# 2c) Difference between the SpatialGridDataFrame and	the	SpatialPixelsDataFrame

# SpatialPixelsDataFrame is directly from SpatialPoints or SpatialPointsDataFrame whereas SpatialGridDataFrame is always created from GridTopology or SpatialPixels.

# SpatialPixelsDataFrame is composed of Irregular Grid whereas SpatialGridDataFrame is composed of Regular Grid

# SpatialPixelsDataFrame Grid Points have always Data Values whereas SpatialGridDataFrame Grid Points are without Data Values (NaN)

# 3) Load dataset	“wrld_simpl” from	“maptools” package

require(maptools) # load "maptools" package. rgeos is a core dependency
library("maptools") # alternative: load "maptools" package

data("wrld_simpl")


#=========================================Q3====================================
#3 a) Examine	the	dataset	“wrld_simpl”	with	the	generic	methods	str(),	summary(),	coordinates(),	bbox()	and	proj4string()	and	print	the	results.

str(wrld_simpl) # structure of "wrld_simpl"
summary(wrld_simpl) # statistical summary of "wrld_simpl"
coordinates(wrld_simpl) # coordinates of "wrld_simpl"
bbox(wrld_simpl) # boundary box of "wrld_simpl"
proj4string(wrld_simpl) # projection of "wrld_simpl"

# 3b) Access	the	dataset	“wrld_simpl”	with	the	slot	operator	to	get	informations	about	the	attribute	data
# @ - slot operator

str(wrld_simpl@data) # gets structure of the attribute "data".

str(wrld_simpl@polygons) # gets structure of the attribute "polygons".

str(wrld_simpl@proj4string) # gets structure of the attribute "proj4string"

str(wrld_simpl@bbox) # gets structure of the attribute "bbox".


# 3c) Subset the “wrld_simpl”	dataset	for	your home	country	and	plot it	with the color “red”.

nigeria <- wrld_simpl[wrld_simpl$NAME=="Nigeria",]
class(nigeria)
str(nigeria,max.level=3)
plot(nigeria, col="red", main = "Boundary Map of Nigeria.", border="white", bg="gray")


# 3d) Plot	the	whole	“wrld_simpl”	dataset	with	spplot	using	the	attributes	“NAME”,	“REGION”	and	“POP2005”.	Try	different	color	palettes,	e.g.	rainbow,	topo,	bpy,	...	

spplot(wrld_simpl, "NAME", colorkey=FALSE, col.regions = rainbow(length(wrld_simpl$NAME)), main="Map of the World by country name", border="white") # map of the world by country name using rainbow color scheme

spplot(wrld_simpl, "REGION", colorkey=FALSE, col.regions = bpy.colors(length(wrld_simpl$REGION+1)), main="Map of the World by region") # map of the world by countries using bpy color scheme

spplot(wrld_simpl, "POP2005", colorkey=FALSE, col.regions = rainbow(length(wrld_simpl$POP2005)), main="Map of the World by 2002 Census Data") # map of the world by 2002 census data using rainbow color scheme

## Additional resources
## https://cran.r-project.org/web/packages/rio/vignettes/rio.html#data_import
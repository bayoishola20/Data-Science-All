# General Rule
  # & - only TRUE when both sides of the operator are TRUE; otherwise, FALSE.
  # | - only FALSE when both sides of the operator are FALSE; otherwise, TRUE.
(1<10) & (10<100)
(1<10) | (10<100)
(1<10) | (10>100)
(1<10) & (10>100)

"*" (3,3)
?sqrt # search result on the sqrt function. help(sqrt) is similar
??sqrt # searches available help pages. help.search('sqrt') is similar

# An object is an instance of a certain class
# data structures - classes that are used to store data

# class function returns the class name of the object that it receives

class(TRUE)
class(1)
class(sqrt)
class(array)
class(matrix)

# a raster object in R may include two numeric vectors (holding the raster values and its dimensions) and a character vector (holding the Coordinate Reference System (CRS) information)

library(raster) # this requires package sp and so loads it also
r <- raster("/var/www/example.com/public_html/Data-Science-All/Data/seattle_hillshade_102348.tif")
r # alternative to print(r)
r[100, 120] = 200
writeRaster(r, "/var/www/example.com/public_html/Data-Science-All/Data/seattle2.tif")
u <- raster("/var/www/example.com/public_html/Data-Science-All/Data/seattle2.tif")
u
c("cat","dog","mouse","apple")
3:30
30:20

as.character(30.5:20.5)
as.numeric(30.5:20.5)
as.integer(30.5:20.5)

factor(c("carto", "maps", "maps", "maps"))

ls() # function returns a character vector with the names of all the user-defined objects

rm("u") # remove a stored variable from environment

v = c(5,2,1,3,9,7,2,5,7)
length(v)
which.max(v) # returns position of maximum element
which.min(v) # returns position of minimum element
unique(v) # returns vector without repitition

l = c(TRUE, FALSE, FALSE, TRUE, FALSE)
any(l) # for logical vectors to know if TRUE is available
all(l) # for logical vectors to know if all is TRUE
sum(l) # number of TRUE

length(l) - sum(l) # number of FALSE
which(l) # returns the positions of all the TRUE elements
which(!l) # returns the positions of all the FALSE elements

1:7 * 2

12 %in% 1:13 # checks if 12 is in the range
any(1:13 == 12) # checks if 12 is in the range

paste("There are", "2", "public holidays.") # concantenates; converts numeric to character
paste("There are", 2:5, "books.")

c(2,3,4) * c(20,30,40)

c(1,2,3,4) * c(3,5) # Recycling - the first vector is the reference. c(1,2,3,4) multiplied by c(3,5,3,5)

1:5 * c(1,10,100) #this works but with an error message

seq(from = 100, to = 150, by = 10) # function with 3 parameters

vector(mode = "numeric", length = 5L)  # creating vectors
x <- rep(x = c(8,0,2), times = 3) # repititive

y <- "Adebayo Ishola"
substr(y, start = 4, stop = 7) # gives bayo. It includes start and stop positions; they are inclusive

x <- c(2,3,5,7,8,9,0,1)
x[1] # Subsetting
x[length(x)]
x[2] <- 2 * x[2]

x <- 33:20
x[length(x):1] # reverses x

x <- c(43,85,10)
x[rep(3,4)] # replicate the third index of x 4 times.

x <- 1:10
x[3:8] <- c(4,2)

x <- seq(85, 100, 3)
x > 10

x[x > 10]

x[x>85 & x< 95]

x[x>85 | x < 95]

x = c(2:10)

mean(x)

x[2] = NA

mean(x) #mean of a vector with at least one NA will produce NA

is.na(x)

!is.na(x)

x[!is.na(x)]

mean(x[!is.na(x)]) # calculate mean of vectors while removing NA

mean(x, na.rm = T) # remove NA and calculate mean

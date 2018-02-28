x <- c(1,2,3,4)
y <- c("green", "white", "green", NA)
z <- c(TRUE,FALSE,TRUE,FALSE)
dataFrame <- data.frame(x,y,z)
names(dataFrame) <- c("Primary key","Color","Status") # variable/column names

length(dataFrame)
str(dataFrame)    # structure of an object
class(dataFrame)  # class or type of an object
names(dataFrame)  # names
c(x,y,z)       # combine objects into a vector
cbind(x, y, z) # combine objects as columns
rbind(x, y, z) # combine objects as rows 

ls()       # list current objects
rm(x) # delete x object

newDataFrame <- edit(dataFrame) # edit copy and save as newobject
fix(dataFrame)               # edit in place 

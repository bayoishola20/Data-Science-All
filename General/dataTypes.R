# Variables
a <- 2

# VECTORS
b <- c(1,2,3,4,5)

# numeric vectors
d <- c(1.1,2.2,5.3,6,-2,-4, -7)

# character or string vector
e <- c("one","two","three")

# logical or boolean vector
f <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)

# vector subsetting
g <- d[c(2,4)]

# MATRIX <- All columns must have the same mode/data-type (string/character, numeric, boolean/logical)
h <-matrix(1:5, nrow=5,ncol=4)

cells <- c(1,26,24,68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
matrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE, dimnames=list(rnames, cnames))

# matrix subsetting

h[,3] # 3rd column of matrix
h[3,] # 3rd row of matrix
h[2:4,1:3] # rows 2,3 and 4 of columns 1,2 and 3 

# ARRAYS <- Arrays are similar to matrices but can have more than two dimensions

# DATA FRAMES

i <- c(1,2,3,4)
j <- c("green", "white", "green", NA)
k <- c(TRUE,FALSE,TRUE,FALSE)
dataFrame <- data.frame(i,j,k)
names(dataFrame) <- c("Primary key","Color","Status") # variable/column names

# dataframes subsetting
dataFrame[1:3] # columns 3,4,5 of data frame
dataFrame[c("Primary key","Status")] # columns Primary key and Status from data frame
dataFrame$X1 # variable x1 in the data frame

# LIST

list1 <- list(name="Bob Freeman", mynumbers=b, mymatrix=h, height=5.3)
list2 <- list(name="Leon", mynumbers=d, mymatrix=h, height=6.1)
# example of a list containing two lists
m <- c(list1,list2)

# list subsetting

list1[[2]]
list2[["mynumbers"]]

# FACTORS

# variable cars with 30 "volvo" entries and 30 "golf" entries
# golf and volvo are the levels
cars <- c(rep("volvo",30), rep("golf", 30))
cars <- factor(cars)

summary(cars)

# ordered factor

# variable rating coded as "large", "medium", "small'
rating <- c("volvo"=1, "bmw"=7, "toyota"=4,
            "honda"=2, "golf"=3)
rating <- ordered(rating)

# Arithmetic Operations
z <- sqrt(a*a+3)
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

# MATRIX
h <-matrix(1:5, nrow=5,ncol=4)

cells <- c(1,26,24,68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
matrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE, dimnames=list(rnames, cnames))

# matrix subsetting

h[,3] # 3rd column of matrix
h[3,] # 3rd row of matrix
h[2:4,1:3] # rows 2,3 and 4 of columns 1,2 and 3 

# Arithmetic Operations
z <- sqrt(a*a+3)
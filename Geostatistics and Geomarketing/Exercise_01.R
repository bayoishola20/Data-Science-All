## 1a) Start search
help.start()

## 1b) Search for "hist" help.
help.search("hist")

## 1c) Vignettes for GSTAT (Spatial and Spatio-Temporal Geostatistical Modelling, Prediction and Simulation)

install.packages("gstat") # install gstat package
library("gstat") # Activate gstat

vignette(package = "gstat") # get vignette for gstat

# ===================================Vignettes in package ‘gstat’:====================
  
#st                        Introduction to Spatio-Temporal Variography(source, pdf)
# spatio-temporal-kriging  Spatio-Temporal Geostatistics using gstat (source, pdf)
# gstat                    The meuse data set: a tutorial for the gstat R package (source, pdf)
# prs                      The pairwise relative semivariogram (source,pdf)
  
# ===================================Vignettes in package ‘gstat’:=====================

vignette('gstat', package = NULL, lib.loc = NULL, all = TRUE) # This calls the print function which generates a PDF

## 1d) vignette  "intro_sp"  Content  of  this  vignette;  Its  different  spatial  data  types.
# could't find "intro_sp" on CRAN Archive and went for sp which has one of its vignettes as intro_sp
# https://win-builder.r-project.org/incoming_pretest/soiltexture_1.4.6_20180501_150209/Windows/examples_and_tests/tests_x64/soiltextureInfo.Rout

install.packages("sp") # Classes and Methods for Spatial Data
library("sp") # Activate package

# ===================================Vignettes in package ‘sp’:====================
  
# csdacm                         Customising spatial data classes and methods (source, pdf)
# intro_sp                       sp: classes and methods for spatial data (source, pdf)
# over                           sp: overlay and aggregation (source, pdf)

# ===================================Vignettes in package ‘sp’:====================

vignette("intro_sp", package = "sp", lib.loc = NULL, all = TRUE) # prints a PDF

# =================================== Spatial Data Class of vignette ‘intro_sp’:===========
# The spatial data classes implemented are points, grids, lines, rings and polygons
# =================================== Spatial Data Class of vignettes ‘intro_sp’:===========


## 2)

#========================================== R Data Structures =============================
# ATOMIC VECTOR
    # By atomic, we mean the vector only holds data of a single type.
    # 
    # character: "a", "swc"
    # numeric: 2, 15.5
    # integer: 2L (the L tells R to store this as an integer)
    # logical: TRUE, FALSE
    # complex: 1+4i (complex numbers with real and imaginary parts)
    # * Useful functions: class(), typeof(), length(), attributes()

# LIST: In R lists act as containers. Unlike atomic vectors, the contents of a list are not restricted to a single mode and can encompass any mixture of data types. A list is a special type of vector
    # a <- list(3, "a", FALSE, 4+4i)

# MATRIX: In R matrices are an extension of the numeric or character vectors. They are not a separate type of object but simply an atomic vector with dimensions; the number of rows and columns.
    # a <- matrix(nrow = 2, ncol = 2)

# DATA FRAME: A data frame is a special type of list where every element of the list has same length
    # test <- data.frame(id = letters[5:10], x = 5:10, y = 15:20)

# FACTORS: Factors are special vectors for categorical data. They can be ordered or unordered and are important for modelling functions like lm() and glm() and also in plot methods.
    # a <- factor(c("no", "no", "yes", "yes", "no"))

#========== Key Points ================
# R’s basic data types are character, numeric, integer, complex, and logical.
# 
# R’s basic data structures include the vector, list, matrix, data frame, and factors.
# 
# Objects may have attributes, such as name, dimension, and class.
#========== Key Points ================

#*** Ref: https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/ && https://ramnathv.github.io/pycon2014-r/learn/structures.html ****
#========================================== R Data Structures =============================



## 3)

help("runif")

a <- runif(100) # 100 random numbers
min(a) # minumum value
max(a) # maximum value
range(a) # range

b <- runif(1000, min=0, max=100) #1000 uniformly distributed random integers between 0 & 100

par(mfrow=c(1,2)) # to help with side-by-side comparison

p1 <- hist(a, col = "red", border = "white")
p2 <- hist(b, col = "blue", border = "white")

# COMMENTS: 

## 4)

  # 4a)
  c <- seq(from = -100, to = 100)
  
  plot(c**2, main = "Plot of c^2") #plot(c^2) is also an alternative
  
  # 4b)
  d <- seq(from = 0, to = 6, length.out = 100)
  plot(d, sin(d), main = "Sinus plot of d") #sinus plot
  
  # 4c)
  e <- LETTERS #OR
  e <- c(LETTERS)
  
  # 4d)
  f <- rep.int(1, 100)
  
  
  ## 5
  ?matrix # matrix help documentation
  # 5a)
  x <- matrix(data = -99, nrow = 10, ncol = 10)
  
  # 5b) 100 by 100 matrix consisting of uniformly distributed values
  y <- matrix(data = runif(10000), nrow = 100, ncol = 100)
  
  # 5c)
  z <- y > 0.5
  
  # 5d)
  image(x)
  image(y)



## ************** Key Resource **************
  # http://www.cookbook-r.com/Numbers/Generating_random_numbers/
## ************** Key Resource **************


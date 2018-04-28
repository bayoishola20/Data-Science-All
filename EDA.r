# ggplot2 comes default
library(ggplot2)

# install RColorBrewer
library(RColorBrewer)

# load midwest data
data("midwest")

# Scatter plot of total population versus known poverty population
ggplot(midwest, aes(x = poptotal, y = poppovertyknown, color = state)) + geom_point(size=5) + scale_color_brewer(palette = 'Accent')


# ?mean - this opens help file
# getwd()
# View(diamonds)

diamondsSubset <- diamonds[diamonds$color=="E", ]
head(diamondsSubset, 2)
dim(diamondsSubset)

data(mtcars)
str(mtcars)
subset(mtcars, mpg >= 30 | hp < 60)
mtcars[mtcars$mpg >= 30 | mtcars$hp < 60, ]

setwd("/var/www/example.com/public_html/Data-Science-All")
reddit <- read.csv('reddit.csv')
table(reddit$employment.status)
str(reddit)
levels(reddit$age.range)


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


reddit <- read.csv('reddit.csv')
table(reddit$employment.status)
str(reddit)
levels(reddit$age.range)


qplot(data = reddit, x = age.range)
qplot(data = reddit, x = income.range)

# QUIZ

levels(reddit$age.range)
reddit$age.range <- ordered(reddit$age.range, levels = c("Under 18", "18-24", "35-44", "45-54", "55-64", "65 or Above"))
qplot(data = reddit, x = age.range)

read.delim('pseudo_facebook.tsv')
list.files()
pf <- read.csv('pseudo_facebook.tsv', sep = "\t") # tsv - tab seperated values file

pf <- read.delim('pseudo_facebook.tsv') # read.delim() function defaults to the tab character as the separator between values and the period as the decimal character.

names(pf)
qplot(x = dob_day, data = pf)

install.packages('ggthemes', dependencies = TRUE)
library(ggthemes)

ggplot(aes(x = dob_day), data = pf) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = 1:31) +
  facet_wrap(~dob_month, ncol = 3)

ggplot(aes(x = friend_count), data = subset(pf, !is.na(gender))) +
  geom_histogram(binwidth = 25) +
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50))+
  facet_wrap(~gender)

qplot(x = friend_count, data = pf, xlim = c(0, 1000))

table(pf$gender)
by(pf$friend_count, pf$gender, summary)

qplot(x = tenure, data = pf, color = I('black'), fill = I('#FF9429'))

qplot(x = tenure/365, data = pf, binwidth = .25, color = I('white'), fill = I('#FF9429')) +
  scale_x_continuous(breaks = seq(1, 7, 1), limits = c(0, 7)) +
  xlab('Number of years using Facebook') +
  ylab('Number of users in sample')

ggplot(aes(x = tenure), data = pf) +
  geom_histogram(binwidth = 30, color = 'black', fill = 'skyblue')

ggplot(aes(x = tenure/365), data = pf) +
  geom_histogram(binwidth = .25, color = 'white', fill = 'lightblue')

summary(pf$age)

ggplot(aes(x = age), data = pf) +
  geom_histogram(binwidth = 1, color = 'white', fill = '#7760AB') +
  scale_x_continuous(breaks = seq(0, 113, 5)) +
  xlab('Facebook users age') +
  ylab('Number of users in sample')


# TRANSFORMING DATA
# ===============================
install.packages('gridExtra')

summary(pf$friend_count)
summary(log10(pf$friend_count + 1))
summary(sqrt(pf$friend_count))

library(gridExtra)

# scale_x_log10() to adjust the x-axis
plot1 <- qplot(x = friend_count, data = pf)
plot2 <- qplot(x = log10(friend_count + 1), data = pf)
plot3 <- qplot(x = sqrt(friend_count), data = pf)

grid.arrange(plot1, plot2, plot3, ncol = 1)

plot4 <- ggplot(aes(x = friend_count), data = pf) +
  geom_histogram()
plot5 <- plot1 <- ggplot(aes(x = friend_count), data = pf) +
  geom_histogram() + scale_x_log10()
plot6 <- plot1 <- ggplot(aes(x = friend_count), data = pf) +
  geom_histogram() + scale_x_sqrt()

grid.arrange(plot4, plot5, plot6, ncol = 1)


## ADDING A SCALE LAYER

logScale <- qplot(x = log10(friend_count), data = pf)

countScale <- ggplot(aes(x = friend_count), data = pf) +
  geom_histogram() +
  scale_x_log10()

grid.arrange(logScale, countScale, ncol = 2)

## FREQUENCY POLYGONS

qplot(x = friend_count, data = subset(pf, !is.na(gender)),
      binwidth = 10) +
  scale_x_continuous(lim = c(0, 1000), breaks = seq(0, 1000, 50)) +
  facet_wrap(~gender)

qplot(x = friend_count, y = ..count../sum(..count..),
      data = subset(pf, !is.na(gender)),
      xlab = 'Friend Count',
      ylab = 'Proportion of Users with that of friend count',
      binwidth = 10, geom = 'freqpoly', color = gender) +
  scale_x_continuous(lim = c(0, 1000), breaks = seq(0, 1000, 50))

ggplot(aes(x = friend_count, y = ..count../sum(..count..)),
       data = subset(pf, !is.na(gender))) +
  geom_freqpoly(aes(color = gender), binwidth=10) +
  scale_x_continuous(limits = c(0, 1000),
                     breaks = seq(0, 1000, 50)) +
  xlab('Friend Count') +
  ylab('Proportion of users with that friend count')

qplot(x = www_likes, data = subset(pf, !is.na(gender)),
      geom = 'freqpoly', color = gender) +
  scale_x_log10()

ggplot(aes(x = www_likes), data = subset(pf, !is.na(gender))) +
  geom_freqpoly(aes(color = gender)) +
  scale_x_log10()

## LIKES ON THE WEB

by(pf$www_likes, pf$gender, sum)


## BOX PLOTS

qplot(x = gender, y = friend_count,
      data = subset(pf, !is.na(gender)),
      geom = 'boxplot',ylim = c(0, 1000))

qplot(x = gender, y = friend_count,
      data = subset(pf, !is.na(gender)),
      geom = 'boxplot',
      xlab = 'Gender',
      ylab = 'Friend Count') +
  scale_y_continuous(limits = c(0, 1000))

qplot(x = gender, y = friend_count,
      data = subset(pf, !is.na(gender)),
      geom = 'boxplot',
      xlab = 'Gender',
      ylab = 'Friend Count') +
  coord_cartesian(ylim = c(0, 1000))

## BOX PLOTS, QUARTILES, AND FRIEND REQUESTS

qplot(x = gender, y = friend_count,
      data = subset(pf, !is.na(gender)),
      geom = 'boxplot',
      xlab = 'Gender',
      ylab = 'Friend Count') +
  coord_cartesian(ylim = c(0, 250))

by(pf$friend_count, pf$gender, summary)

qplot(x = gender, y = friendships_initiated,
      data = subset(pf, !is.na(gender)),
      geom = 'boxplot',
      xlab = 'Gender',
      ylab = 'Friendship Initiated') +
  coord_cartesian(ylim = c(0, 250))

by(pf$friendships_initiated, pf$gender, summary)

# GETTING LOGICAL

summary(pf$mobile_likes > 0)

mobile_check_in <- NA

pf$mobile_check_in <- ifelse(pf$mobile_likes > 0, 1, 0)
pf$mobile_check_in <- factor(pf$mobile_check_in)
summary(pf$mobile_check_in)
sum(pf$mobile_check_in == 1)/length(pf$mobile_check_in) * 100


# =========== LESSON 4 ================ #
# QUIZ 1
dim(diamonds) # Number of observations and variables
str(diamonds) # ordered factors
str(diamonds$color) # best diamond color

# QUIZ 2
ggplot(diamonds) + 
  geom_histogram(aes(x=price), binwidth = 100,
                 color = "coral", fill = "red") +
  xlab("Price")+
  ylab("Diamonds Count") +
  ggtitle("Diamonds Price Plot")

# QUIZ 3

summary(diamonds$price)

# The shape of the graph depicts a right-skewed distribution of diamonds price with a median price of 2401 and a mean price of 3933.

# QUIZ 4
nrow(subset(diamonds, price < 500)) # numberof diamonds < $500
nrow(subset(diamonds, price < 250))
nrow(subset(diamonds, price > 15000 | price == 15000))

# QUIZ 5
ggplot(diamonds) + 
  geom_histogram(aes(x=price), binwidth = 15, color = "coral",
                 fill = "red") +
  xlab("Price")+
  ylab("Diamonds Count") +
  ggtitle("Diamonds Price Histogram between $0 and $1000.") +
  coord_cartesian(xlim=c(0,1000)) +
  ggsave("/plots/priceHistogram.png")


# QUIZ 6
ggplot(diamonds) + 
  geom_histogram(aes(x=price), binwidth = 100, color = "coral",
                 fill = "red") +
  xlab("Price")+
  ylab("Diamonds Count") +
  ggtitle("Price ~ Cut Histogram") +
  facet_grid(~cut) +
  ggsave("/plots/priceCutHistogram.png")

# QUIZ 7

# Price by cut
diamonds[which.max(diamonds$price),] # highest diamond price
tapply(diamonds$price, diamonds$cut, min) # lowest diamond price
by(diamonds$price,diamonds$cut,summary) # least median

# QUIZ 8

# Scales and Multiple Histograms

qplot(x = price, data = diamonds) + facet_wrap(~cut)

by(diamonds$price, diamonds$cut, summary)

ggplot(aes(x=price), data=diamonds) +
  geom_histogram(binwidth=100, color='coral', fill='red') +
  facet_wrap(~cut, scales="free")

# QUIZ 9

# Price per Carat by Cut

ggplot(aes(x=price/carat), data=diamonds) +
  geom_histogram(binwidth=0.03, color='coral', fill='red') +
  ggtitle("Price per Carat by Cut") +
  xlab("Price per Carat") +
  scale_x_log10() +
  facet_wrap(~cut)

# QUIZ 10

# Price Box Plots

ggplot(aes(x = cut, y = price), data=diamonds) +
  geom_boxplot() +
  ggtitle("Price by box plots") +
  ggsave("/plots/priceBoxPlots.png")

by(diamonds$price, diamonds$cut, summary)



#==============
# CORE
#==============

setwd("/var/www/example.com/public_html/Data-Science-All")
load("//var/www/example.com/public_html/Data-Science-All/workspace.RData")
save.image("/var/www/example.com/public_html/Data-Science-All/workspace.RData")

# ggplot2 comes default
library(ggplot2)

# install RColorBrewer
library(RColorBrewer)

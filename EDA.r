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

install.packages('gridExtra')

summary(pf$friend_count)
summary(log10(pf$friend_count + 1))
summary(sqrt(pf$friend_count))

library(gridExtra)

save.image("/var/www/example.com/public_html/Data-Science-All/workspace.RData")

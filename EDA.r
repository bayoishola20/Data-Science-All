# ggplot2 comes default
library(ggplot2)

# install RColorBrewer
library(RColorBrewer)

# load economics data
data(diamonds)

# Scatter plot of population versus unemploy
ggplot(data = diamonds, x = carat, y = price, color = cut) + scale_color_brewer(palette = 'Accent')

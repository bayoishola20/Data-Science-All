# ggplot2 comes default
library(ggplot2)

# install RColorBrewer
library(RColorBrewer)

# load midwest data
data("midwest")

# Scatter plot of total population versus known poverty population
ggplot(midwest, aes(x = poptotal, y = poppovertyknown, color = state)) + geom_point(size=4) + scale_color_brewer(palette = 'Accent')

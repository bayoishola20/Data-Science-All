# DESCRIPTION: Animate MSc Cartography Intakes 
setwd("/var/www/example.com/public_html/Data-Science-All") # set working directory


require(ggplot2) # graphics plotting
require(maps) # maps
require(mapproj) # for map projections
require(ggthemes)  # plot themes
require(gganimate) # graphic animation
require(gifski) # gif renderer: it might require additional installation. In my case, "sudo apt-get install cargo" on a linux

data <- read.csv("Data/CartoGISDay.csv");

head(data)

str(data$Country) # meaning that there are about 60 countries - 59 actually because UK/Great Britain

str(data$EntryDate) # since factor of 8, this means that there are 8-intakes.

entryDate <- as.Date(data$EntryDate) # convert entryDate date data-type

str(entryDate)

formatData <- data %>%
  mutate(startDate = as.Date(data$EntryDate)) %>%
  arrange(startDate) # alternatively is to convert data and attach to original data table

# world <- ggplot() +
#   borders("world", colour = "gray80", fill = "gray") +
#   theme_map()

cartoMap <- ggplot() +
  geom_polygon(data = map_data("world"), aes(x = long, y = lat, group=group), color = "gray85", fill = "gray80") +
  geom_point(data = data, aes(x = data$Longitude, y = data$Latitude, size = data$Count), colour = 'brown', alpha = .5) +
  scale_size_continuous(range = c(4, 10), breaks = c(250, 500, 750, 1000)) + # range controls size
  transition_states(data$Year) + # could be changed to entryDate
  theme_map() +
  coord_map("azequidistant") +
  theme(plot.title = element_text(size=14, hjust = 0.5,  family="Abadi MT Condensed Light", face="bold"),
        plot.subtitle = element_text(size=13, hjust = 0.5,  family="Abadi MT Condensed Light"),
        plot.caption = element_text(family="Abadi MT Condensed Light"),
        legend.position = "bottom") +
  labs(size = data$Count,
       title = "Program Intakes from different parts of the world",
       subtitle = 'PERIOD OF STUDY: {closest_state}',
       caption = 'Points are scaled by number of persons')

# cartoMap

# ggsave("cartomap.png", device = "png", plot = cartoMap, dpi = 900)

anim <- animate(cartoMap, duration = 0.005, nframes = 8*length(unique(entryDate)), height = 400, width = 700) # animate

anim_save("plots/cartoAnime.gif", anim) #save animation

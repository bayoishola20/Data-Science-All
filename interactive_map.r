library(leaflet)
library(stringr)

# leaflet() %>%
#   # addTiles()
#   addProviderTiles("OpenStreetMap.BlackAndWhite")

# Print the providers list included in the leaflet library
providers

# Print only the names of the map tiles in the providers list 
names(providers)

# Use str_detect() to determine if the name of each provider tile contains the string "CartoDB"
str_detect(names(providers), "CartoDB")

# Use str_detect() to print only the provider tile names that include the string "CartoDB"
names(providers)[str_detect(names(providers), "CartoDB")]
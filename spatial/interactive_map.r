library(leaflet)
library(stringr)

leaflet() %>%
  # addTiles()
  addProviderTiles("OpenStreetMap.BlackAndWhite")

# Print the providers list included in the leaflet library
providers

# Print only the names of the map tiles in the providers list 
names(providers)

# Use str_detect() to determine if the name of each provider tile contains the string "CartoDB"
str_detect(names(providers), "CartoDB")

# Use str_detect() to print only the provider tile names that include the string "CartoDB"
names(providers)[str_detect(names(providers), "CartoDB")]

#================================================================

leaflet() %>%
  addProviderTiles(provider = "CartoDB")

leaflet() %>%
  addProviderTiles(provider = "CartoDB.PositronNoLabels")

#================================================================
# Addresses are converted to coordinates using the geocode() function in the ggmaps package
library(ggmap)
dc_hq <- geocode(c("350 5th Ave, Floor 77, New York, NY 10118", "Martelarenlaan 38, 3010 Kessel-Lo, Belgium"))
leaflet() %>% 
  addProviderTiles("CartoDB.PositronNoLabels") %>% 
  setView(lng = dc_hq$lon[2], lat = dc_hq$lat[2], zoom = 4)

#=================================================================
leaflet(options = leafletOptions(
  # Set minZoom and dragging 
  minZoom = 12, dragging = TRUE))  %>% 
  addProviderTiles("CartoDB")  %>% 
  
  # Set default zoom level 
  setView(lng = dc_hq$lon[2], lat = dc_hq$lat[2], zoom = 14) %>% 
  
  # Set max bounds of map 
  setMaxBounds(lng1 = dc_hq$lon[2] + .05, 
               lat1 = dc_hq$lat[2] + .05, 
               lng2 = dc_hq$lon[2] - .05, 
               lat2 = dc_hq$lat[2] - .05)

#================================================================
library(tibble)
dc_hq <- 
  tibble(
    hq = c("DataCamp - NYC", "DataCamp - Belgium"),
    lon = geocode(c("350 5th Ave, Floor 77, New York, NY 10118")),
    lat = geocode(c("Martelarenlaan 38, 3010 Kessel-Lo, Belgium"))
  )

leaflet() %>%
  addTiles() %>%
  addMarkers(lng = dc_hq$lon, lat = dc_hq$lat, popup = dc_hq$hq)

#=================================================================
capital = geocode(c("Lagos, Nigeria", "Abuja, Nigeria"))
leaflet() %>%
  addProviderTiles("CartoDB") %>%
  addMarkers(lng = capital$lon, lat = capital$lat)
library(shiny)
library(leaflet)
library(rgdal)
library(sp)

vars <- c(
  "Population density" = "Pop_Densit",
  "Inhabitants" = "Inhabitant",
  "Foreigners" = "Foreigners",
  "Households" = "Households"
)

ui <- fluidPage(
  # Assign a title to your application
  titlePanel("Munich in Figures"),
  sidebarLayout(
    sidebarPanel(
      selectInput("color", "Color", vars),
      selectInput("plot", "Distribution", vars),
      plotOutput("Histplot", height = 300)
      
    ),
    mainPanel(
      leafletOutput("map", width = "100%", height = 600)
    )
  )
)

districts <- readOGR("shp/Munich_Districts.shp",layer = "Munich_Districts")
pal <- colorNumeric("YlOrRd", domain = districts$colorData, n = 6)

# plotBy <- input$plot
# plotData <- districts[[plotBy]]

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(districts) %>%
      # Base groups.
      # The tiles and provider tiles might be added to a group. Humanfriendly group names are permitted-
      # they need not be short, identifier-style names.
      addTiles(group = "OpenStreetMap") %>%
      addProviderTiles("CartoDB.Positron", group = "CartoDB") %>%
      addProviderTiles("Esri.WorldImagery", group = "ESRI") %>%
      # Point of map view. Here we can set the coordinates and zoom level
      setView(lng = 11.557137, lat = 48.157831, zoom = 12)%>%
      # Overview map
      # toggleDisplay sets whether the minimap should have a button to
      #minimise it. Defaults to false.
      addMiniMap(tiles = providers$CartoDB.Positron,
               toggleDisplay = TRUE)%>%
      # Layers
      addLayersControl(
        baseGroups = c("OpenStreetMap", "CartoDB", "ESRI")
      )%>%
      addPolygons(color = "white", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5,
                  dashArray = "3",
                  fillColor = ~pal(Pop_Densit),
                  label = districts$DISTRICT,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px
                                 8px"),
                    textsize = "15px",
                    direction = "auto"),
                  highlightOptions = highlightOptions(color = "grey", weight
                                                      = 2,
                                                      bringToFront = TRUE)
      )%>%
      addLegend(pal = pal, values = ~Pop_Densit, opacity = 0.7, title =
                  "Population density",
                position = "bottomleft")
    
  })
  
  output$Histplot <- renderPlot({
    plotBy <- input$plot
    plotData <- districts[[plotBy]]
    hist(plotData, col = "gray", border = "white", xlab = "No. of people per sqkm", main = "Histogram of data")
  })
  
  observe({
    colorBy <- input$color
    colorData <- districts[[colorBy]]
    pal2 <- colorNumeric("YlOrRd", districts$colorData, n = 6)

    leafletProxy("map", data = districts) %>%
      clearShapes() %>%
      addPolygons(color = "white", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5,
                  fillColor = ~pal2(colorData),
                  dashArray = "3",
                  highlightOptions = highlightOptions(color = "grey", weight
                                                      = 2,
                                                      bringToFront = TRUE),
                  label = districts$DISTRICT,
                  #label = c(districts$DISTRICT, districts$Inhabitant),
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px
                                 8px"),
                    textsize = "15px",
                    direction = "auto")
                  )

  })
  
}



# Run the application 
shinyApp(ui = ui, server = server)


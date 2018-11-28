# 1a)	Load	the	Dataset	“Groundwater_Temperature.xls”

install.packages("rio") # install rio package to help with data conversion
# rio allows you to import files in almost any format using one, typically single-argument, function.
library("rio") # activate package
require(rio) # alternative activate package

list.files("/var/www/example.com/public_html/Data-Science-All/Geostatistics and Geomarketing") # list files in current directory

gw <- import("/var/www/example.com/public_html/Data-Science-All/Geostatistics and Geomarketing/Groundwater_Temperature.xls") #import data

View(gw) #view data
str(gw) # examine structure of data
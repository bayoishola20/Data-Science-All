library(sbtools)
library(dataRetrieval)
library(sf) # Requires GEOS, GDAL, proj4

is_logged_in() # check if logged in

item_file_download(sb_id = "5a83025ce4b00f54eb32956b", 
                   names = "huc8_05010007_example.zip", 
                   destinations = "Data/huc8_05010007_example.zip", 
                   overwrite_file = TRUE)

huc_poly <- st_read('Data/huc8_05010007_example')

class(huc_poly) # check type

str(huc_poly) # get data structure

head(huc_poly) # top

st_geometry(huc_poly)

st_bbox(huc_poly) # get boundary box coords

st_crs(huc_poly) # get CRS

huc_gages <- whatNWISdata(huc = "05010007", parameterCd = "00060", service="uv")

head(huc_gages)

# Downloaded packages are found ‘/tmp/RtmpZBp8m6/downloaded_packages’
# Resource: https://www.r-bloggers.com/beyond-basic-r-mapping/

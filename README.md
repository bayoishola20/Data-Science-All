# Data Science

Tips, Tricks and Thoughts

## To use

* Clone the repo: `git clone https://github.com/bayoishola20/Data-Science-All.git`

## Additional Libraries Used

&rightarrow; install.packages("xlsx") [To install this, run `sudo apt-get install r-cran-rjava`]

&rightarrow; install.packages("openxlsx") [# The above does have memory issues even for a file of few MBs. Use this instead]

&rightarrow; install.packages('RColorBrewer') [For viz color]

&rightarrow; install.packages('ggthemes', dependencies = TRUE) [Theme for ggplot2]

&rightarrow; install.packages('gridExtra') [For creating multiple histograms on a plot]

&rightarrow; install.packages('leaflet') [For leaflet maps]

&rightarrow; install.packages('tidyverse') [All tidyverse packages]

&rightarrow; install.packages('stringr') [Checks for a pattern]

&rightarrow; install.packages("sbtools") [USGS package (https://owi.usgs.gov/R/training-curriculum/usgs-packages/) for USGS web platform for data storage]

&rightarrow; install.packages("dataRetrieval") [USGS package (https://owi.usgs.gov/R/training-curriculum/usgs-packages/) for retrieving gages (hydrologic time series data) with discharge from watershed]

&rarr; to get above two working, run `sudo apt-get install libudunits2-dev libxml2-dev`

&rightarrow; install.packages("sf") [For "simple features" like shapefiles]

&rightarrow; to get above working on terminal run `sudo apt install libgdal-dev`, then install.packages(c("proj4", "rgdal", "sf")). Check gdal using `gdalinfo --version`


## Tips

&rarr; Get all files in a particular folder `list.files("/home/bayo/Documents/Geostatistics & Geomarketing/")`

## Topics of Interest

* matplotlib
* D3.js
* Spatial Analysis (leaflet, GDAL, OGR)
* Inferential statistics & Probability distributions
* Parameter estimation
* Hypothesis testing
* Statistical significance
* Correlation and regression
* A/B Testings
* Maximum likelihood
* Generalized linear model

### Machine Learning

* Scikit-learn
* Supervised and unsupervised learning
* Naive Bayes
* SVM
* Decision trees
* Regression
* clustering
* Dimensionality reduction
* Validation & evaluation of ML methods

[bayoishola20](https://github.com/bayoishola20/)

Inspired by several online resources and personal encounters. :smiles:

&rightarrow; https://www.statmethods.net/input/datatypes.html

&rightarrow; https://rstudio.github.io/leaflet/morefeatures.html

&rightarrow; https://www.datacamp.com/community/data-science-cheatsheets

PS. Ubuntu is the OS used.
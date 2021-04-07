# time series analysis
# greenland increase of temperature
# data e codice di Emanuela Cosma

# install.packages("raster")
library(raster)
setwd("/Users/mariaelenacavallini/lab/greenland") 
lst_2000 <- raster("lst_2000.tif")
#plot(lst_2000) per visualizzare la prima mappa caricata
lst_2005 <- raster("lst_2005.tif")
#plot(lst_2005)

#codice in R per telerilevamento

setwd("/Users/mariaelenacavallini/lab/") #con le virgolette perche' fuori da R

#installo e importo raster
#install.packages("raster") #gia installato
library(raster)

#funzione brick crea un oggetto raster brick
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011) #plot delle 7 bande del file p22...
dev.off()

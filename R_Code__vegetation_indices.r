# R_code_vegetation_indices.r

library(raster)
library(RStoolbox) #per gli indici della vegetazione

#set della working directory
setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#caricamento delle 2 immagini
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg") 
# band1: NIR
# band2: red
# band3: green
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#si vede bene la differenza anche delle acque +- solidi disciolti +- riflettanza

# defor1
# band1: NIR, defor1.1
# band2: red, defor1.2
dvi1 <- defor1$defor1.1 - defor1$defor1.2 #sottrazione delle due bande della defor1 tra banda NIR e rosso

# defor2
# band1: NIR, defor2.1
# band2: red, defor2.2
dvi2 <- defor2$defor2.1 - defor2$defor2.2 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(2,1))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

#NDVI range (-1;+1) (NIR-RED)/ (NIR+RED)
par(mfrow=c(2,1))
NDVI1= (defor1$defor1.1 - defor1$defor1.2)/(defor1$defor1.1 + defor1$defor1.2)
plot(NDVI1, col=cl, main="NDVI1")
NDVI2= (defor2$defor2.1 - defor2$defor2.2)/(defor2$defor2.1 + defor2$defor2.2)
plot(NDVI2, col=cl, main="NDVI2")

Si1<- spectralIndices(defor1, green=3, red=2, nir=1)
plot(Si1, col=cl)
Si2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(Si2, col=cl)

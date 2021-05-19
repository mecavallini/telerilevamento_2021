#R_Code_variability.r

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")

setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

sent <- brick("sentinel.png")
plotRGB(sent, stretch="lin")
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

# 1: sentinel.1 NIR
nir <- sent$sentinel.1
# 2: sentinel.2 RED
red <- sent$sentinel.2

ndvi <- (nir - red) / (nir + red)
plot(ndvi)
#bianco --> no vegetazione, roccia nuda 
#verdino --> boschi e praterie

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3,ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)

ndvimn <- focal(ndvi, w=matrix(1/9, nrow=3,ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvimn, col=clsd)

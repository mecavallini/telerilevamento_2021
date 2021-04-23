setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

library(raster)
library(RStoolbox)
#caricamento immagine p224r63_2011_masked.grd
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)

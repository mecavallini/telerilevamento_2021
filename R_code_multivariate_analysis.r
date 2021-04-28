setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

library(raster)
library(RStoolbox)
#caricamento immagine p224r63_2011_masked.grd
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)

pairs(p224r63_2011) # si vede la correlazione tra le diverse bande

#utilizzo raster aggregate per ricampionare il file raster p224r63_2011
p224r63_2011res <- aggregate(p224r63_2011, fact=10, fun=mean)
plot(p224r63_2011res)
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")           #r=infrarosso, g=blu, b=verde
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#PCA: principal component analysis for raster
#pacchetto di riferimento RStoolbox
PCA <- rasterPCA(p224r63_2011res)
summary(PCA$model)
plot(PCA$map)
plotRGB(PCA$map, r=1, g=2, b=3, stretch="lin")  
str(PCA)

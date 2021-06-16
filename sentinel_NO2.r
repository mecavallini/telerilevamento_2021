#https://sentinels.copernicus.eu/web/sentinel/data-products/-/asset_publisher/fp37fc19FN8F/content/sentinel-5-precursor-level-2-nitrogen-dioxide

#pacchetti utilizzati
library(raster)


#1. set wd 
# setwd("~/lab/EN") # Linux
# setwd("C:/lab/EN") # Windows
setwd("/Users/mariaelenacavallini/lab/EN") # Mac 

# 2. Import the first image (single band)
# we will select band 1, but the raster function enables to select other single-bands
# [suggerimento studenti]
# https://www.rdocumentation.org/packages/raster/versions/3.4-10/topics/raster
EN01 <- raster("EN_0001.png")

#plot della prima immagine con un palette
#il giallo evidenza i valori con NO2 più alto
cls <- colorRampPalette(c("red","pink","orange","yellow")) (200)
plot(EN01, col=cls)
 
#import e plot dell'ultima immagine
EN13 <- raster("EN_0013.png")
plot(EN13, col=cls)

#faccio la differenza tra le 2 immagini e la plotto
ENdif <- EN13 - EN01

par(mfrow=c(3,1)) #anche gridarrange
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January - March)")

# list of files:
rlist <- list.files(pattern="EN")
rlist
import <- lapply(rlist,raster)
import
EN <- stack(import)
plot(EN, col=cls)


# 8. Replicate the plot of images 1 and 13 using the stack
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)
 










#setwd("C:/") # Windows
setwd("/Users/mariaelenacavallini/")

library(raster)
#rasterVis: metodi di visualizzazione per i dati raster
#install.packages("rasterVis")
library(rasterVis)
#install.packages("rgdal")
library(rgdal)
#install.packages("RStoolbox")
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)  
#install.packages("gridExtra")
library(gridExtra)

#carico l'immagine 1
imm1 <- raster("weuropeflooding_oli_2021167_lrg.jpg")

imm2 <- raster("weuropeflooding_oli_2021199_lrg.jpg")

par(mfrow=c(2,1))
plot(imm1)
plot(imm2)

imm1b <- brick("weuropeflooding_oli_2021167_lrg.jpg")
imm2b <- brick("weuropeflooding_oli_2021199_lrg.jpg")
par(mfrow=c(1,2))
plotRGB(imm1b, 1,2,3)
plotRGB(imm2b, 1,2,3)

immd <- imm1b - imm2b
plot(immd) #da le singole bande
plotRGB(immd, 1,2,3) #Error in grDevices::rgb(RGB[, 1], RGB[, 2], RGB[, 3], alpha = alpha, max = scale) :   color intensity -18, not in 0:255

#differenza delle singole bande
primabanda <- imm1b$weuropeflooding_oli_2021167_lrg.1 - imm2b$weuropeflooding_oli_2021199_lrg.1
secondabanda <- imm1b$weuropeflooding_oli_2021167_lrg.2 - imm2b$weuropeflooding_oli_2021199_lrg.2
terzabanda <- imm1b$weuropeflooding_oli_2021167_lrg.3 - imm2b$weuropeflooding_oli_2021199_lrg.3
plot(primabanda)

setwd("/Users/mariaelenacavallini/LC08_L1TP_198024_20210718_20210718_02_RT")
rlist <- list.files(pattern="tif") #vado solo a trovare i file con nome "lst" all'interno della mia cartella di wd
import <- lapply(rlist,raster) #così li importo tutti insieme lapply, con funzione raster che importa singoli file 
imma <- stack(import) #fa un blocco unico di file raster in un vettore
plot(imma)


imm1b <- brick("")

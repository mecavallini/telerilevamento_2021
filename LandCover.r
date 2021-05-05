#LandCover.r

#library
library(ggplot2)        #https://ggplot2-book.org
library(raster)
library(RStoolbox) #classification
# install.packages("gridExtra")
library(gridExtra)


setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#caricamento delle 2 immagini
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg") 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow =2) #un grafico sull'altro #need gridExtra


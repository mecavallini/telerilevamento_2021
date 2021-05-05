#LandCover.r

#library
library(ggplot2)
library(raster)
library(RStoolbox) #classification



setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#caricamento delle 2 immagini
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg") 


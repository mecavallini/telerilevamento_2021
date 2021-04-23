setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#immagine con 3 lielli RGB Solar_Orbiter_s_first_views_of_the_Sun_pillars
library(raster) #per rasterbrick
library(RStoolbox)
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#visualizzare RGB raster
plotRGB(so, 1, 2, 3, stretch="lin") 
plotRGB(so, 1, 2, 3, stretch="hist") #diventa con i colori bianco e nero

#unsupervised classification
set.seed(42) #per il numero random
soe <- unsuperClass(so, nClasses=3)
cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(soe$map,col=cl)

#unsupervised classification with 20 classes
set.seed(42) #per il numero random
soe20 <- unsuperClass(so, nClasses=20)
cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(soe20$map,col=cl)

sn <- brick("sun.png")
#unsupervised classification
set.seed(42) #per il numero random
sne <- unsuperClass(sn, nClasses=40)
#cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(sne$map,col=cl)

mu <- brick("mu.jpg")
#unsupervised classification
set.seed(42) #per il numero random
mue <- unsuperClass(mu, nClasses=100)
#cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(mue$map)

#usano tutti sensori passivi, mentre la scansione laser/radar è attiva (le nuvole vengono eliminate).

#grand canyon data 
library(raster) #per rasterbrick
library(RStoolbox)

setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") #per caricare un immagine con più livelli

#visualizzare RGB raster
plotRGB(gc, 1, 2, 3, stretch="lin") 
plotRGB(gc, 1, 2, 3, stretch="hist") 

gce <- unsuperClass(gc, nClasses=2)
plot(gce$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)





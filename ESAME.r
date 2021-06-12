#codice utilizzato per l'esame 
#Maria Elena Cavallini

#analisi di immagini tra 201 nel bacino del Gadria (Bz) 
#classifico detrito vegetato e non vegetato e sua variazione nel tempo - frequenza delle classi (tipo landcover) e relativi grafici
#variazione ndvi nel tempo
#ggplot 



#imposto la working directory
setwd("/Users/mariaelenacavallini/lab/ESAME")

#importo o installo le librerie necessarie
#install.packages("raster")
library(raster)
#rasterVis: metodi di visualizzazione per i dati raster
#install.packages("rasterVis")
library(rasterVis)
library(rgdal)
library(RStoolbox)
#importo i file .tif tramite la funzione raster
#inserisco le foto degli anni 2011 - 2018 ------- da inserire anche gli anni 2020
g_18 <- brick("gadria18.tif")
g_11 <- brick("gadria11.tif")
g_20 <- brick("gadria20.tif")


par(mfrow=c(2,1)) #(3,1)
plotRGB(g_11, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin") 
#plotRGB(g_20, r=1, g=2, b=3, stretch="lin") 

#unsupervised classification
set.seed(42) #per il numero random
CLg11 <- unsuperClass(g_11, nClasses=6)
cl <- colorRampPalette(c('white','light green','dark green','forestgreen','brown','black'))(100) #creazione di una palette di colori 
plot(CLg11$map,col=cl)
CLg18 <- unsuperClass(g_18, nClasses=6)
plot(CLg18$map,col=cl)

pdf("CL11-18.pdf")
par(mfrow=c(1,2))
plot(CLg11$map,col=cl)
plot(CLg18$map,col=cl)
dev.off()

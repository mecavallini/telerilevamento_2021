#R_code di telerilevamento geo-ecologico

#----------------------------------------------------
#summary
# 1- remote sensing - first code
# 2- time series analysis: greenland increase of temperature
# 3- dati da copernicus
# 4- knitr
# 5- multivariate analisis PCA
# 6- classification
# 7- rcode ggplot
# 8- vegetation indices
# 9- land cover
# 10- variability
# 11- spectral signature
#----------------------------------------------------
#1
#il primo codice in R per telerilevamento

#installo e importo raster
#install.packages("raster") #con le virgolette perchè fuori da R
library(raster)

#imposto la working directory
setwd("/Users/mariaelenacavallini/lab/") 

#funzione brick crea un oggetto raster brick
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011) #plot delle 7 bande del file p224r63_2011
#dev.off() si utilizza pe ripulire la finestra di plot

#creazione di una palette di colori 
cl <- colorRampPalette (c("orange","green","pink","purple","gold")) (100)
plot(p224r63_2011, col=cl)

#simboli e sensori per ogni banda 
# B1: blue
# B2: green
# B3: red
# B4: NIR infrarosso vicino
# B5 infrarosso medio
# B6 infrarosso termico
# B7 infrarosso medio

#plot solo della banda del blu (B1) tramite l'utilizzo del simbolo $
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)
dev.off()

#funzione par: mf(multiframe) di n°righe e colonne determinate
#se si indica prima il numero di colonne par(mfcol=c(","))
# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot delle prime 4 bande in un unico plot in 1 colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plot delle prime 4 bande in 2x2
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#plot delle prime 4 bande in 2x2 con palette ben definite
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)
clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c('dark red','red','light red'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

#visualizzare dati in plot rgb
# B1: blue
# B2: green
# B3: red
# B4: NIR infrarosso vicino
# B5 infrarosso medio
# B6 infrarosso termico
# B7 infrarosso medio

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")

pdf("ilmioprimopdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")
dev.off()
#chiusura pdf

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin") #colori naturali
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin") #falsi colori lineari
#stretch histogram
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #falsi colori histograms

#multitemporal set per visualizzare i cambiamenti 
# 2011 image p224r63_2011_masked
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# 1988 image p224r63_1988_masked
p224r63_1988 <- brick("p224r63_1988_masked.grd")
pdf("4imm2011-1988.pdf")
par(mfrow=c(2,2)) #per visualizzare insieme
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin") #colori
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin") #colori
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#----------------------------------------------------
#2
# time series analysis
# greenland increase of temperature
# data e codice di Emanuela Cosma

#importo o installo le librerie necessarie
#install.packages("raster")
library(raster)
#rasterVis: metodi di visualizzazione per i dati raster
#install.packages("rasterVis")
library(rasterVis)
library(rgdal)

#imposto la working directory
#setwd("C:/lab/greenland") # Windows
setwd("/Users/mariaelenacavallini/lab/greenland") 

#importo i file .tif tramite la funzione raster
lst_2000 <- raster("lst_2000.tif")
#plot(lst_2000) per visualizzare la prima mappa caricata
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

par(mfrow=c(2,2)) #unico grafico con i 4 dati temporali
    plot(lst_2000)
    plot(lst_2005)
    plot(lst_2010)
    plot(lst_2015)
#dev.off()

#list f file:
rlist <- list.files(pattern="lst") #vado solo a trovare i file con nome "lst"
import <- lapply(rlist,raster) #così li importo tutti insieme lapply, con funzione raster che importa singoli file 
TGr <- stack(import) #fa un blocco unico di file raster in un vettore
plot(TGr)
plotRGB(TGr,1,2,3,stretch="Lin") #primo livello 2000, 2° 2005, 3° 2010 RGB 
#plotRGB(TGr,2,3,4,stretch="Lin")

levelplot(TGr)
levelplot(TGr$lst_2000)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#melt variation in time
meltlist <- list.files(pattern="melt") #vado solo a trovare i file con nome "lst"
mimport <- lapply(meltlist,raster) #così li importo tutti insieme lapply, con funzione raster che importa singoli file 
MLT <- stack(mimport) 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(MLT,col.regions=cl, main="melt variation in time")
          #names.attr=c("July 2000","July 2005", "July 2010", "July 2015", ...))
#differenze di scioglimento
diff <- MLT$X2007annual_melt - MLT$X1979annual_melt #melt$ per dire che appartiene a MLT
cld <- colorRampPalette(c("blue","white","red"))(100)
levelplot(diff,col.regions=cld, main="melt variation 2007-1979")

#----------------------------------------------------
#3
library(raster)
install.packages("ncdf4")
library(ncdf4) #per leggere i file ncdf

setwd("/Users/mariaelenacavallini/lab/")
SWI <- raster("c_gls_SWI10_202006011200_GLOBE_ASCAT_V3.1.1.nc") #soil water index
cl <- colorRampPalette(c("blue","light blue", "red", "pink")) (100)
plot(SWI, col=cl)

#modify the size of dataset
SWIres <- aggregate(SWI, fact=100) #fact=factor, number of pixel aggregated
plot(SWIres, col=cl)


#----------------------------------------------------
#4
# starting from the code folder where framed.sty is put
#utilizzare solo Rstudio!!!
setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows
#require(knitr)

library(knitr)

stitch("R_time_series.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#----------------------------------------------------
#5
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

#----------------------------------------------------
#6
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

#----------------------------------------------------
#7
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#----------------------------------------------------
#8
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

#differenza tra NDVI1 e 2
difndvi <- NDVI1 - NDVI2
plot(difndvi, col=cld, main="differenza di ndvi")

## for the worldwide NDVI
# install.packages("rasterdiv")
library(rasterdiv)
# install.packages("rasterVis")
library(rasterVis)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) #per eliminare l'acqua
plot(copNDVI)
levelplot(copNDVI)

#------------------------------------------------
#9
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
# https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg") 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow =2) #un grafico sull'altro #need gridExtra

#unsuperclass
d1c <- unsuperClass(defor1, nClasses = 2)
d2c <- unsuperClass(defor2, nClasses = 2)
d2c3 <- unsuperClass(defor2, nClasses = 3)
set.seed(10)
plot(d1c$map)
plot(d2c$map)
plot(d2c3$map)

#frequenza
f1 <- freq(d1c$map)
#      value  count
# [1,]     1  35562 agricolo   
# [2,]     2 305730 foresta
s1 <- sum(35562,305730)
prop1 <- f1/s1
percent_92 <- prop1 * 100
#             value     count
# [1,] 2.930042e-06 0.1041982 agricolo -> 10%
# [2,] 5.860085e-06 0.8958018 foresta -> 89%
f2 <- freq(d2c$map)
#      value  count
# [1,]     1 163187 agricolo
# [2,]     2 179539 foresta
s2 <- sum(163187,179539)
prop2 <- f2/s2
percent_06 <- prop2 * 100
#            value     count
# [1,] 2.917783e-06 0.4761442 agricolo -> 47%
# [2,] 5.835565e-06 0.5238558 foresta -> 52%

#generazione di un dataset (dataframe)
cover <- c("Forest", "Agricolture")
percent_1992 <- c(89.58, 10.41)
percent_2006 <- c(52.38, 47.61)
percentages <- data.frame(cover, percent_1992, percent_2006) #column names
percentages
pl92 <- ggplot(percentages, aes(x= cover, y=percent_1992 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
pl06 <- ggplot(percentages, aes(x= cover, y=percent_2006, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(pl92,pl06, nrow =1) #need gridExtra


#---------------------------------------------------------------------------------
#10
#R_Code_variability.r

library(raster)
library(RStoolbox)
# install.packages("RStoolbox")
library(ggplot2)
library(gridExtra)
library(viridis)

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

ndvisd13 <- focal(ndvi, w=matrix(1/25, nrow=5,ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd13, col=clsd)

#PCA analisi
sentinel_pca <- rasterPCA(sent)
sentinel_pca
plot(sentinel_pca$map) #dalla prima alla 4°immagine diminuisce la quantità di informazioni
summary(sentinel_pca$model)
#il primo pc contiene  67,36804%   di informazione

pc1 <- sentinel_pca$map$PC1
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5,ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(pc1sd5, col=clsd)

#uso della funzione source
pc1 <- sentinel_pca$map$PC1
pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7,ncol=7), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(pc1sd7, col=clsd)
#salvataggio di questo pezzo di codice code.r
source("code.r")

source("source_ggplot.r")
#il file contiene la parte di grafici tramite l'uso di ggplot
pc1 <- sentinel_pca$map$PC1
plot(pc1)
# focal analysis
pc1_devst <- focal(pc1, w=matrix(1/9,nrow=3,ncol=3), fun=sd)

# cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
# plot(pc1_devst, col=cl)

# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
# ggplot() + geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis()

# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
p0 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis() +  ggtitle("viridis palette")
p1 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="magma") +  ggtitle("magma palette")
p2 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="plasma") +  ggtitle("plasma palette")
p3 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="inferno") +  ggtitle("inferno palette")
p4 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="cividis") +  ggtitle("cividis palette")
p5 <- ggplot() +
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="mako") +  ggtitle("mako palette")
p6 <- ggplot() + 
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="rocket") + ggtitle("rocket palette")
p7 <- ggplot() + 
      geom_raster(pc1_devst, mapping = aes(x = x, y = y, fill = layer)) + 
      scale_fill_viridis(option="turbo") + 
      ggtitle("turbo palette")

grid.arrange(p0, p1, p2, p3, p4, p5, p6, p7, nrow = 2) # this needs griExtra
#-----------------------------------------------------------------------------------------
#11 #elaborazione per la creazione di firme spettrali

library(raster)
library(rgdal)
library(ggplot2)
#set della wd
setwd("/Users/mariaelenacavallini/lab")

#carico il dataset da utilizzare
#defor1_2: Rio Peixoto de azevedo

defor2 <- brick("defor2.jpg")
#defor2.1 , defor2.2, defor2.3
#NIR,       red,      green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#https://gdal.org/
#click è la funzione per la generazione di firme spettrali
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#results
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 88.5 131.5 248171      213       12       30       #vegetazione
        #      x     y   cell defor2.1 defor2.2 defor2.3
        #1 125.5 224.5 181527       45       43       65      
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 638.5 219.5 185625       47      101      139      #acqua(fiume)

#creo le colonne del dataframe
band <- c(1,2,3)
forest <- c(213, 12, 30)
water <- c(47, 101, 139)

spectrals <- data.frame(band, forest, water)

ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") +
 labs(x="wavelength", y="reflectance")

##################################################################

#analisi multitemporale
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#output di 5 valori random
          #DEFOR1
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 331.5 262.5 153842      227       20       36
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 163.5 114.5 259346      191       15       28
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 335.5 146.5 236670      199       15       27
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 587.5 228.5 178374      197       12       26
#      x     y   cell defor1.1 defor1.2 defor1.3
#1 632.5 275.5 144861      199       16       44

          #DEFOR2
#  x     y   cell defor2.1 defor2.2 defor2.3
#1 151.5 298.5 128495      199        9       21
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 241.5 288.5 135755      172      148      136
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 577.5 251.5 162620      100       42       64
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 526.5 325.5 109511      189        5       13
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 603.5 362.5 83059      185       24       32

# define the columns of the dataset and generate dataframe:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)

spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

# plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="green") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="blue") +
 labs(x="band",y="reflectance")

######################
#image from Earth Observatory
imm4 <- brick("imm4.jpg")
plotRGB(imm4, r=1, g=2, b=3, stretch="hist")
click(imm4, id=T, xy=T, cell=T, type="p", pch=16, col="magenta")
#      x   y  cell imm4.1 imm4.2 imm4.3
#1 206.5 9.5 47679    229     29      0
#      x     y cell imm4.1 imm4.2 imm4.3
#1 170.5 177.5 1275      0     93    127
#     x    y  cell imm4.1 imm4.2 imm4.3
#1 11.5 36.5 40032    207    163     58
bnd <- c(1,2,3)
strato1 <-  c(229,0,207)
strato2 <-  c(29,93,163)
strato3 <-  c(0,127,58)
set <- data.frame(bnd, strato1, strato2, strato3)

# plot the spectral signatures
ggplot(set, aes(x=bnd)) +
 geom_line(aes(y=strato1), color="red") +
 geom_line(aes(y=strato2), color="blue") +
 geom_line(aes(y=strato3), color="yellow") +
 labs(x="band",y="reflectance")

##################################################################

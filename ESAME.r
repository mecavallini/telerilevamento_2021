#codice utilizzato per l'esame                              Maria Elena Cavallini

#analisi di immagini tra 2011 -2020 nel bacino del Gadria (Bz) 
#classifico detrito vegetato e non vegetato e sua variazione nel tempo - frequenza delle classi (tipo landcover) e relativi grafici
#variazione ndvi nel tempo
#ggplot 
# fonte del dato “volo LiDAR unibz - progetto EARFLOW”


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
library(ggplot2)  
library(gridExtra)

#importo i file .tif tramite la funzione raster
#inserisco le foto degli anni 2011 - 2018 ------- da inserire anche gli anni 2020
g_18 <- brick("gadria18.tif")
g_11 <- brick("gadria11.tif")
g_20 <- brick("gadria20.tif")


par(mfrow=c(1,3)) 
plotRGB(g_11, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_20, r=1, g=2, b=3, stretch="lin") 

##################################              Unsupervised classification                        #################################
set.seed(42) #per il numero random
cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"

CLg11 <- unsuperClass(g_11, nClasses=3)
plot(CLg11$map,col=cl2)

CLg18 <- unsuperClass(g_18, nClasses=3)
plot(CLg18$map,col=cl2)

CLg20 <- unsuperClass(g_20, nClasses=3)
plot(CLg20$map,col=cl2)

par(mfrow=c(1,3))
plot(CLg11$map,col=cl2)
plot(CLg18$map,col=cl2)       #i colori sono invertiti
plot(CLg20$map,col=cl2)

par(mfrow=c(3,2))
plot(CLg11$map,col=cl)
plot(CLg18$map,col=cl)
plot(CLg20$map,col=cl2)
plotRGB(g_11, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_20, r=1, g=2, b=3, stretch="lin")

###################################              Analisi di frequenza delle 3 classi                ################################
#frequenza 2011
f11 <- freq(CLg11$map)
#     value    count
#[1,]     1 46623578
#[2,]     2 41706884
#[3,]     3 75595846
s11 <- sum(46623578,41706884,75595846)
prop11 <- f11/s11
percent_11 <- prop11 * 100
#            value    count
#[1,] 6.100302e-07 28.44179 -->28%
#[2,] 1.220060e-06 25.44246 -->26%
#[3,] 1.830091e-06 46.11575 -->46%

#frequenza 2018
f18 <- freq(CLg18$map)
#     value     count
#[1,]     1 111364055
#[2,]     2 114230292
#[3,]     3  30544438
s18 <- sum(111364055,114230292,30544438)
prop18 <- f18/s18
percent_18 <- prop18 * 100
#            value    count
#[1,] 3.904133e-07 43.47801 -->43%
#[2,] 7.808267e-07 44.59703 -->45%
#[3,] 1.171240e-06 11.92496 -->12%

#frequenza 2020
f20 <- freq(CLg20$map)
#     value    count
#[1,]     1 85424235
#[2,]     2 92495860
#[3,]     3 78218690
s20 <- sum(85424235,92495860,78218690)
prop20 <- f20/s20
percent_20 <- prop20 * 100
#            value    count
#[1,] 3.904133e-07 33.35076 -->33%
#[2,] 7.808267e-07 36.11162 -->36%
#[3,] 1.171240e-06 30.53762 -->31%

#generazione di un dataset (dataframe)
#cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
cover <- c('bosco e prato','roccia affiorante e detrito neoformato', 'detrito più "vecchio"')
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"
percent_11 <- c(28.44,25.44,46.12)
percent_18 <- c(43.48,44.60,11.92)
percent_20 <- c(33.35,36.11,30.54)
percentages <- data.frame(cover, percent_11, percent_18, percent_20) #column names
percentages

###################################              Generazione dei grafici con l'utilizzo di GGPLOT2              ################################

pl11 <- ggplot(percentages, aes(x= cover, y=percent_11 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
pl18 <- ggplot(percentages, aes(x= cover, y=percent_18, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
pl20 <- ggplot(percentages, aes(x= cover, y=percent_20, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(pl11,pl18,pl20, nrow =1) #need gridExtra

###################################                      Calcolo della variazione di NDVI               ######################################
#g_11 --> RGB --> gadria11.1, gadria11.2, gadria11.3 
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

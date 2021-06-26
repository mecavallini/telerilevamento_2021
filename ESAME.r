#codice utilizzato per l'esame                              Maria Elena Cavallini

#analisi di immagini tra 2011 - 2018 - 2020 nel bacino del Gadria (Bz) 
#classifico detrito vegetato e non vegetato e sua variazione nel tempo - frequenza delle 3 classi definite e relativi grafici (ggplot2) 
#variazione ndvi nel tempo 2020 - 2011

# fonte del dato “volo LiDAR unibz - progetto EARFLOW”


#imposto la working directory
setwd("/Users/mariaelenacavallini/lab/ESAME")

#importo o installo le librerie necessarie
#install.packages("raster")
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

#importo i file .tif tramite la funzione raster
#inserisco le foto degli anni 2011 - 2018 ------- da inserire anche gli anni 2020
g_18 <- brick("gadria18.tif")
g_11 <- brick("gadria11.tif")
g_20 <- brick("gadria20.tif")

#jpeg("/Users/mariaelenacavallini/lab/ESAME/parRGB.jpg", 800, 800)
par(mfrow=c(1,3))
plotRGB(g_11, r=1, g=2, b=3, stretch="lin", main = "Plot 2011") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin", main = "Plot 2018") 
plotRGB(g_20, r=1, g=2, b=3, stretch="lin", main = "Plot 2020") 
dev.off()
##################################              Unsupervised classification                        #################################
set.seed(42) #per il numero random
cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"

CLg11 <- unsuperClass(g_11, nClasses=3)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg11.jpg", 800, 800)
plot(CLg11$map,col=cl2)

CLg18 <- unsuperClass(g_18, nClasses=3)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg18.jpg", 800, 800)
plot(CLg18$map,col=cl2)

CLg20 <- unsuperClass(g_20, nClasses=3)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg20.jpg", 800, 800)
plot(CLg20$map,col=cl2)

#jpeg("/Users/mariaelenacavallini/lab/ESAME/parCL.jpg", 800, 800)
par(mfrow=c(1,3))
plot(CLg11$map,col=cl2)
plot(CLg18$map,col=cl2)       #i colori sono invertiti
plot(CLg20$map,col=cl2)

#jpeg("/Users/mariaelenacavallini/lab/ESAME/parCL_rgb.jpg", 800, 800)
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
#jpeg("/Users/mariaelenacavallini/lab/ESAME/grafico_percentuali.jpg", 1600, 800)


anno <- c("2011","2011","2011", "2018","2018","2018", "2020","2020","2020") 
percentuali <- c(percent_11,percent_18,percent_20) 
copertura <- cover 
data <- data.frame(anno,percentuali,copertura)
data
ggplot(data, aes(fill=anno, y=percentuali, x=copertura)) + 
    geom_bar(position="dodge", stat="identity")
jpeg("/Users/mariaelenacavallini/lab/ESAME/grafico_percentualiG.png", 1600, 800) #per il salvataggio


####################################          Analisi della variazione di NDVI tra gli anni 2011 e 2020             ################################
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

g_11R <- brick("gadria11R.png")
#g_11R
g_20R <- brick("gadria20R.png")
#g_20R

plotRGB(g_11R, r=1, g=2, b=3, stretch="lin", main = "Plot in false color 2011") 
plotRGB(g_18R, r=1, g=2, b=3, stretch="lin", main = "Plot in false color 2020") 

#NDVI range (-1;+1) (NIR-RED)/ (NIR+RED)
NDVI1= (g_11R$gadria11R.1 - g_11R$gadria11R.2)/(g_11R$gadria11R.1 + g_11R$gadria11R.2)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVI11.jpg", 800, 800)
plot(NDVI1, col=cl, main="NDVI11")
dev.off()
NDVI2= (g_20R$gadria20R.1 - g_20R$gadria20R.2)/(g_20R$gadria20R.1 + g_20R$gadria20R.2)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVI20.jpg", 800, 800)
plot(NDVI2, col=cl, main="NDVI20")
dev.off()
NDVIdiff <- NDVI2 - NDVI1
#jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVIdiff.jpg", 800, 800)
plot(NDVIdiff, col=cl, main="NDVI20 - NDVI11")

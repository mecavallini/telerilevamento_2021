#codice utilizzato per l'esame 
#Maria Elena Cavallini

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
#g_20 <- brick("gadria20.tif")


par(mfrow=c(2,1)) #(3,1)
plotRGB(g_11, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin") 
#plotRGB(g_20, r=1, g=2, b=3, stretch="lin") 

#unsupervised classification
set.seed(42) #per il numero random
CLg11 <- unsuperClass(g_11, nClasses=3)
cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"
plot(CLg11$map,col=cl2)
cl <- colorRampPalette(c('white','light green','dark green','goldenrod1','brown','black'))(100) #creazione di una palette di colori 
#'white' = roccia affiorante parte alta
#'light green' = aree e canali in erosione 
#'dark green' = prati e bosco
#'goldenrod1' = prati e bosco
#'brown' = roccia affiorante parte alta
#'black' = zone in ombra
plot(CLg11$map,col=cl)
CLg18 <- unsuperClass(g_18, nClasses=6)
plot(CLg18$map,col=cl)

#frequenza 2011
f1 <- freq(CLg11$map)
#     value    count 
#[1,]     1 24570489
#[2,]     2 16072264
#[3,]     3 35777575
#[4,]     4 20499057
#[5,]     5 35080696
#[6,]     6 31926227
s1 <- sum(24570489,16072264,35777575,20499057,35080696,31926227)
prop1 <- f1/s1
percent_11 <- prop1 * 100
#            value     count
#[1,] 6.100302e-07 14.988741 --> 15%
#[2,] 1.220060e-06  9.804567 --> 10%
#[3,] 1.830091e-06 21.825402 --> 22%
#[4,] 2.440121e-06 12.505044 --> 13%
#[5,] 3.050151e-06 21.400284 --> 21%
#[6,] 3.660181e-06 19.475963 --> 19%

#frequenza 2018
f2 <- freq(CLg18$map)
#     value    count 
#[1,]     1 60640839
#[2,]     2 40114712
#[3,]     3 59628325
#[4,]     4 36695458
#[5,]     5 41086493
#[6,]     6 17972958
s2 <- sum(60640839,40114712,59628325,36695458,41086493,17972958)
prop2 <- f2/s2
percent_18 <- prop2 * 100
#            value     count
#[1,] 3.904133e-07 23.674993 --> 24%
#[2,] 7.808267e-07 15.661319 --> 16%
#[3,] 1.171240e-06 23.279694 --> 23%
#[4,] 1.561653e-06 14.326397 --> 14%
#[5,] 1.952067e-06 16.040715 --> 16%
#[6,] 2.342480e-06  7.016883 --> 7%

par(mfrow=c(1,2))
plot(CLg11$map,col=cl)
plot(CLg18$map,col=cl)
#plot(CLg20$map,col=cl)

par(mfrow=c(2,2))
plot(CLg11$map,col=cl)
plot(CLg18$map,col=cl)
plotRGB(g_11, r=1, g=2, b=3, stretch="lin") 
plotRGB(g_18, r=1, g=2, b=3, stretch="lin") 





#generazione di un dataset (dataframe)
cover <- c('white','light green', 'dark green','forestgreen','brown','black')
percent_11 <- c(14.99,9.80,21.83,12.51,21.40,19.48)
percent_18 <- c(23.67,15.66,23.28,14.33,16.04,7.02)
percentages <- data.frame(cover, percent_11, percent_18) #column names
percentages
pl11 <- ggplot(percentages, aes(x= cover, y=percent_11 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
pl18 <- ggplot(percentages, aes(x= cover, y=percent_18, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(pl11,pl18, nrow =1) #need gridExtra


#frequenza 2011 con 3 classi
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

#generazione di un dataset (dataframe)
#cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
cover <- c('bosco e prato','roccia affiorante e detrito neoformato', 'detrito più "vecchio"')
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"
percent_11 <- c(28.44,25.44,46.12)
#percent_18 <- c(23.67,15.66,23.28,14.33,16.04,7.02)
percentages <- data.frame(cover, percent_11, percent_18) #column names
percentages
pl11 <- ggplot(percentages, aes(x= cover, y=percent_11 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="black")
pl18 <- ggplot(percentages, aes(x= cover, y=percent_18, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(pl11,pl18, nrow =1) #need gridExtra

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
#[1,] 6.100302e-07 28.44179 -->28% verde bosco e prato
#[2,] 1.220060e-06 25.44246 -->26% giallo roccia affiorante e detrito neoformato
#[3,] 1.830091e-06 46.11575 -->46% marrone detrito più "vecchio"

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
#[1,] 3.904133e-07 43.47801 -->43% verde zone in ombra e bosco
#[2,] 7.808267e-07 44.59703 -->45% giallo detrito più "vecchio"
#[3,] 1.171240e-06 11.92496 -->12% marrone roccia affiorante e detrito neoformato

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
#[1,] 3.904133e-07 33.35076 -->33% verde bosco e prato
#[2,] 7.808267e-07 36.11162 -->36% giallo roccia affiorante e detrito neoformato
#[3,] 1.171240e-06 30.53762 -->31% marrone detrito più "vecchio"

#generazione di un dataset (dataframe)
#cl2 <- colorRampPalette(c('light green','goldenrod1','brown'))(100)
cover <- c('bosco e prato','roccia affiorante e detrito neoformato', 'detrito più "vecchio"')
#light green bosco e prato
#goldenrod1 roccia affiorante e detrito neoformato
#brown detrito più "vecchio"
percent_11 <- c(28.44,25.44,46.12)
percent_18 <- c(43.48,11.92,44.60)
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

My_Theme = theme(
  axis.title.x = element_text(size = 18),
  axis.text.x = element_text(size = 18),
  axis.title.y = element_text(size = 18),
  legend.position="right", legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="black"), #“left”,“top”, “right”, “bottom”, “none”.
  legend.key.size = unit(2, 'cm'),
  legend.title=element_text(size=20), 
  legend.text=element_text(size=20))

g <- ggplot(data, aes(fill=anno, y=percentuali, x=copertura)) + geom_bar(position="dodge", stat="identity") +
          geom_text(aes(label = percentuali),position=position_dodge(width=0.9), vjust=-0.25, size = 10) +
          My_Theme 

jpeg("/Users/mariaelenacavallini/lab/ESAME/grafico_percentualiGg_ultimo.png", 1100, 800) #per il salvataggio
g
dev.off()

####################################          Analisi della variazione di NDVI tra gli anni 2011 e 2020             ################################
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
g_11R <- brick("gadria11R.png")
g_20R <- brick("gadria20R.png")
plotRGB(g_11R, r=1, g=2, b=3, stretch="lin", main = "Plot in false color 2011") 
plotRGB(g_20R, r=1, g=2, b=3, stretch="lin", main = "Plot in false color 2020") 

#NDVI range (-1;+1) (NIR-RED)/ (NIR+RED)
NDVI1= (g_11R$gadria11R.1 - g_11R$gadria11R.2)/(g_11R$gadria11R.1 + g_11R$gadria11R.2)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVI11.jpg", 800, 800)
plot(NDVI1, col=cl, main="NDVI11")

NDVI2= (g_20R$gadria20R.1 - g_20R$gadria20R.2)/(g_20R$gadria20R.1 + g_20R$gadria20R.2)
jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVI20.png", 800, 800)
plot(NDVI2, col=cl, main="NDVI20")
dev.off()

NDVIdiff <- NDVI2 - NDVI1
jpeg("/Users/mariaelenacavallini/lab/ESAME/NDVIdiff.png", 800, 800)
plot(NDVIdiff, col=cl, main="NDVI20 - NDVI11")
dev.off()
################################

#importo i file .tif tramite la funzione raster
#inserisco le foto degli anni 2011 - 2020 
ZI_11 <- brick("ZI11.tif")
ZI_20 <- brick("ZI20.tif")

#classificazione a 3
set.seed(42) #per il numero random
cl2 <- colorRampPalette(c('navyblue','chartreuse4','goldenrod1'))(100)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg11.jpg", 800, 800)
CLZI11 <- unsuperClass(ZI_11, nClasses=3)
par(mfrow=c(2,1))
plotRGB(ZI_11, r=1, g=2, b=3, stretch="lin", main = "Plot zona innesco 2011") 
plot(CLZI11$map,col=cl2)
#1navyblue zona in erosione
#2chartreuse4 (verde) zona in ombra + bosco
#3goldenrod1 zona più stabile

CLZI20 <- unsuperClass(ZI_20, nClasses=3)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg20.jpg", 800, 800)
par(mfrow=c(2,1))
plotRGB(ZI_20, r=1, g=2, b=3, stretch="lin", main = "Plot zona innesco 2011") 
plot(CLZI20$map,col=cl2)
#1navyblue zona in ombra
#3goldenrod1 zona più stabile
#2chartreuse4 (verde) zona di erosione

par(mfrow=c(2,1)) #le due scale di colori non sono concordi
plot(CLZI11$map,col=cl2)
plot(CLZI20$map,col=cl2)

###################################              Analisi di frequenza delle 3 classi                ################################
#frequenza 2011
f11zi <- freq(CLZI11$map)
#     value    count
#[1,]     1 1129363.  zona in erosione
#[2,]     2 982999 zona in ombra + bosco
#[3,]     3 1645631 zona più stabile

#1navyblue zona in erosione
#2chartreuse4 (verde) zona in ombra + bosco
#3goldenrod1 zona più stabile

s11zi <- sum(1129363,982999,1645631)
prop11zi <- f11zi/s11zi
zi_11 <- prop11zi * 100
#            value    count
#[1,] 2.660995e-05 30.05229
#[2,] 5.321990e-05 26.15755
#[3,] 7.982985e-05 43.79016

#frequenza 2020
f20zi <- freq(CLZI20$map)
#     value    count
#[1,]     1 1265031
#[2,]     2 1954399
#[3,]     3 2650552
s20zi <- sum(1265031,1954399,2650552)
prop20zi <- f20zi/s20zi
zi_20 <- prop20zi * 100
#            value    count
#[1,] 1.703583e-05 21.55085  zona in ombra
#[2,] 3.407165e-05 33.29480 zona di erosione
#[3,] 5.110748e-05 45.15435 zona più stabile

#zi_20 corretta
#            value    count
#[1,] 3.407165e-05 33.29480
#[2,] 1.703583e-05 21.55085
#[3,] 5.110748e-05 45.15435

#1navyblue zona in ombra
#3goldenrod1 zona più stabile
#2chartreuse4 (verde) zona di erosione

#generazione di un dataset (dataframe)
#cl2 <- colorRampPalette(c('navyblue','chartreuse4','goldenrod1'))(100)
cover <- c('zona in ombra','zona di erosione', 'zona più stabile')
#navyblue zona in erosione
#goldenrod1 zona più stabile
#chartreuse4 (verde) zona di bosco
Zpercent_11 <- c(30.05,26.16,43.79)
Zpercent_20 <- c(33.30,21.55,45.15)
Zpercentages <- data.frame(cover, Zpercent_11, Zpercent_20) #column names
Zpercentages
anno <- c("2011","2011","2011", "2020","2020","2020") 
Zpercentuali <- c(Zpercent_11,Zpercent_20) 
copertura <- cover 
Zdata <- data.frame(anno,Zpercentuali,copertura)
Zdata

My_Theme = theme(
  axis.title.x = element_text(size = 18),
  axis.text.x = element_text(size = 18),
  axis.title.y = element_text(size = 18),
  legend.position="right", legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="black"), #“left”,“top”, “right”, “bottom”, “none”.
  legend.key.size = unit(2, 'cm'),
  legend.title=element_text(size=20), 
  legend.text=element_text(size=20))

ziipl11 <- ggplot(Zpercentages, aes(x= cover, y=Zpercent_11 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
ziipl20 <- ggplot(Zpercentages, aes(x= cover, y=Zpercent_20, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(ziipl11,ziipl20, nrow =1) #need gridExtra


zipl <- ggplot(Zdata, aes(fill=anno, y=Zpercentuali, x=copertura)) + geom_bar(position="dodge", stat="identity") +
          geom_text(aes(label = Zpercentuali),position=position_dodge(width=0.9), vjust=-0.25, size = 10) +
          My_Theme
jpeg("/Users/mariaelenacavallini/lab/ESAME/grafico_percentuali_zona_innesco.png", 1100, 800) #per il salvataggio
zipl
dev.off()

############################## inserisco zone di innesco #################

library(rgdal)
library(raster)
library(ggplot2)
library(gridExtra)

# import raster
innesco11 <- brick("/Users/mariaelenacavallini/lab/ESAME/ZI11.tif")
innesco20 <- brick("/Users/mariaelenacavallini/lab/ESAME/ZI20.tif")

# convert to a df for plotting in two steps, --> 2011
# First, to a SpatialPointsDataFrame
inn11_pts <- rasterToPoints(innesco11, spatial = TRUE)
# Then to a 'conventional' dataframe
inn11_df  <- data.frame(inn11_pts)

#dataframe del 2020
inn20_pts <- rasterToPoints(innesco20, spatial = TRUE)
# Then to a 'conventional' dataframe
inn20_df  <- data.frame(inn20_pts)

innesco2011pl <-     ggplot() +
          geom_raster(data = inn11_df , aes(x = x, y = y, fill = ZI11)) + 
          scale_fill_gradientn(name = "Elevation", colors = terrain.colors(100)) +
          ggtitle("Mappa della zona di innesco nel 2011")
innesco2020pl <-     ggplot() +
          geom_raster(data = inn20_df , aes(x = x, y = y, fill = ZI20)) + 
          scale_fill_gradientn(name = "Elevation", colors = terrain.colors(100)) +
          ggtitle("Mappa della zona di innesco nel 2020")    

grid.arrange(innesco2011,innesco2020, nrow =1) #need gridExtra

jpeg("/Users/mariaelenacavallini/lab/ESAME/zona_innesco1.png", 1100, 800) #per il salvataggio
plotRGB(innesco11, r=1, g=2, b=3, stretch="lin",  axes=TRUE, main = "Mappa della zona di innesco nel 2011")
dev.off()
jpeg("/Users/mariaelenacavallini/lab/ESAME/zona_innesco2.png", 1100, 800) #per il salvataggio
plotRGB(innesco20, r=1, g=2, b=3, stretch="lin",  axes=TRUE, main = "Mappa della zona di innesco nel 2011")
dev.off()

#aggiungo la parte del 2021, riferito solo al bacino di monitoraggio (2)
############################## inserisco zone di innesco e canale sottobacino 2 #################
#fa schifo perche non si vede niente
library(rgdal)
library(raster)
library(ggplot2)
library(gridExtra)
setwd("/Users/mariaelenacavallini/lab/ESAME")
# import raster
upGadria21 <- brick("Ortophoto_Up_Gadria_2021_06.tif")
downGadria2021 <- brick("Orto_Down_Gadria_2021_06.tif")

par(mfrow=c(1,2))
plotRGB(upGadria21, r=1, g=2, b=3, stretch="lin", main = "Plot UP") 
plotRGB(downGadria2021, r=1, g=2, b=3, stretch="lin", main = "Plot DOWN") 


#classificazione delle 2 immagini con 3 classi
#classificazione a 3
set.seed(42) #per il numero random
cl2 <- colorRampPalette(c('navyblue','chartreuse4','goldenrod1'))(100)
#jpeg("/Users/mariaelenacavallini/lab/ESAME/CLg11.jpg", 800, 800)
CLZI21up <- unsuperClass(upGadria21, nClasses=3)

par(mfrow=c(2,1))
plotRGB(upGadria21, r=1, g=2, b=3, stretch="lin", main = "Plot zona innesco 2021") 
#jpeg("/Users/mariaelenacavallini/lab/ESAME/Cl2021M.jpg", 800, 800)
plot(CLZI21up$map,col=cl2)
#     ??????   1navyblue zona in erosione
#     ??????   2chartreuse4 (verde) zona in ombra + bosco
#     ??????   3goldenrod1 zona più stabile
CLZI21down <- unsuperClass(downGadria2021, nClasses=4)
par(mfrow=c(2,1))
plotRGB(downGadria21, r=1, g=2, b=3, stretch="lin", main = "Plot zona canale 2021") 
jpeg("/Users/mariaelenacavallini/lab/ESAME/Cl2021V.jpg", 800, 800)
cl4 <- colorRampPalette(c('navyblue','chartreuse4','goldenrod1', ' red'))(100)
plot(CLZI21down$map,col=cl4)

#frequenza 2021up
f21up <- freq(CLZI21up$map)
#1navyblue zona in erosione
#2chartreuse4 (verde) zona in ombra + bosco
#3goldenrod1 zona più stabile
s21up <- sum(1129363,982999,1645631)
prop21up <- f21up/s21up
up_21 <- prop21up* 100

#frequenza 2021down
f21down <- freq(CLZI21down$map)
#1navyblue zona in erosione
#2chartreuse4 (verde) zona in ombra + bosco
#3goldenrod1 zona più stabile
s21down <- sum(1129363,982999,1645631)
prop21down <- f21down/s21down
down_21 <- prop21down* 100


#generazione di un dataset (dataframe)
#cl2 <- colorRampPalette(c('navyblue','chartreuse4','goldenrod1'))(100)
cover <- c('zona in ombra','zona di erosione', 'zona più stabile')
#navyblue zona in erosione
#goldenrod1 zona più stabile
#chartreuse4 (verde) zona di bosco
percent_21up <- c(30.05,26.16,43.79)
percent_21down <- c(33.30,21.55,45.15)
percentages <- data.frame(cover, percent_21up, percent_21down) #column names
percentages
anno <- c("2021-06") 
percentuali <- c(Zpercent_11,Zpercent_20) 
copertura <- cover 
Zdata <- data.frame(anno,Zpercentuali,copertura)
Zdata

My_Theme = theme(
  axis.title.x = element_text(size = 18),
  axis.text.x = element_text(size = 18),
  axis.title.y = element_text(size = 18),
  legend.position="right", legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="black"), #“left”,“top”, “right”, “bottom”, “none”.
  legend.key.size = unit(2, 'cm'),
  legend.title=element_text(size=20), 
  legend.text=element_text(size=20))

ziipl11 <- ggplot(Zpercentages, aes(x= cover, y=Zpercent_11 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
ziipl20 <- ggplot(Zpercentages, aes(x= cover, y=Zpercent_20, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(ziipl11,ziipl20, nrow =1) #need gridExtra


zipl <- ggplot(Zdata, aes(fill=anno, y=Zpercentuali, x=copertura)) + geom_bar(position="dodge", stat="identity") +
          geom_text(aes(label = Zpercentuali),position=position_dodge(width=0.9), vjust=-0.25, size = 10) +
          My_Theme
jpeg("/Users/mariaelenacavallini/lab/ESAME/grafico_percentuali_zona_innesco.png", 1100, 800) #per il salvataggio
zipl
dev.off()







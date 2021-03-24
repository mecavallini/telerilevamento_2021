#codice in R per telerilevamento

setwd("/Users/mariaelenacavallini/lab/") #con le virgolette perche' fuori da R

#installo e importo raster
#install.packages("raster") #gia installato
library(raster)

#funzione brick crea un oggetto raster brick
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011) #plot delle 7 bande del file p22...
#dev.off() per sistemare il plot nel caso non vada

cl <- colorRampPalette (c("orange","green","pink","purple","gold")) (100)
plot(p224r63_2011, col=cl)

# B1: blue
# B2: green
# B3: red
# B4: NIR infrarosso vicino
# B5 infrarosso medio
# B6 infrarosso termico
# B7 infrarosso medio

#dev off pulisce il grafico attuale
dev.off()
#plot solo della banda del blu
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)

dev.off()
#funzione par:  mf(multiframe) 1 riga e 2 colonne
par(mfrow=c(1,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

# 2 row, 1 columns
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

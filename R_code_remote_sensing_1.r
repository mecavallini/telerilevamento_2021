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

# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

      #se si indica prima il numero di colonne par(mfcol...)

#plot delle prime 4 bande
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

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

#elaborazione per la creazione di firma spettrali

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


# define the columns of the dataset and GENERATE DATAFRAME:
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

# plot the sepctral signatures
ggplot(set, aes(x=bnd)) +
 geom_line(aes(y=strato1), color="red") +
 geom_line(aes(y=strato2), color="blue") +
 geom_line(aes(y=strato3), color="yellow") +
 labs(x="band",y="reflectance")


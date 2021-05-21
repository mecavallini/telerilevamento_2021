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









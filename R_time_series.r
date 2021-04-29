# time series analysis
# greenland increase of temperature
# data e codice di Emanuela Cosma

#install.packages("raster")
library(raster)
#rasterVis: metodi di visualizzazione per i dati raster
#install.packages("rasterVis")
library(rasterVis)
library(rgdal)

#setwd("C:/lab/greenland") # Windows
setwd("/Users/mariaelenacavallini/lab/greenland") 
lst_2000 <- raster("lst_2000.tif")
#plot(lst_2000) per visualizzare la prima mappa caricata
lst_2005 <- raster("lst_2005.tif")
#plot(lst_2005)
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
plotRGB(TGr,1,2,3,stretch="Lin") #primo livello 2000, 2 2005, 3 2010 RGB 
#plotRGB(TGr,2,3,4,stretch="Lin")

levelplot(TGr)
levelplot(TGr$lst_2000)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#melt
meltlist <- list.files(pattern="melt") #vado solo a trovare i file con nome "lst"
mimport <- lapply(meltlist,raster) #così li importo tutti insieme lapply, con funzione raster che importa singoli file 
MLT <- stack(mimport) 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(MLT,col.regions=cl, main="melt variation in time")
          #names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#differenze di scioglimento
diff <- MLT$X2007annual_melt - MLT$X1979annual_melt #melt$ per dire che appartiene a MLT
cld <- colorRampPalette(c("blue","white","red"))(100)
levelplot(diff,col.regions=cld, main="melt variation 2007-1979")

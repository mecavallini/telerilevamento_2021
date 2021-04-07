# time series analysis
# greenland increase of temperature
# data e codice di Emanuela Cosma

# install.packages("raster")
library(raster)
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
dev.off()

#list f file:
rlist <- list.files(pattern="lst") #vado solo a trovare i file con nome "lst"
import <- lapply(rlist,raster) #così li importo tutti insieme lapply
TGr <- stack(import) #fa un blocco unico di file raster in un vettore
plot(TGr)
plotRGB(TGr,1,2,3,stretch="Lin") #primo livello 00, 2 05, 3 10 RGB 
#plotRGB(TGr,2,3,4,stretch="Lin")

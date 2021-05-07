#LandCover.r

#library
library(ggplot2)        #https://ggplot2-book.org
library(raster)
library(RStoolbox) #classification
# install.packages("gridExtra")
library(gridExtra)


setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#caricamento delle 2 immagini 
# https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg") 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow =2) #un grafico sull'altro #need gridExtra

#unsuperclass
d1c <- unsuperClass(defor1, nClasses = 2)
d2c <- unsuperClass(defor2, nClasses = 2)
d2c3 <- unsuperClass(defor2, nClasses = 3)
set.seed(10)
plot(d1c$map)
plot(d2c$map)
plot(d2c3$map)

#frequenza
f1 <- freq(d1c$map)
#      value  count
# [1,]     1  35562 agricolo   
# [2,]     2 305730 foresta
s1 <- sum(35562,305730)
prop1 <- f1/s1
percent_92 <- prop1 * 100
#             value     count
# [1,] 2.930042e-06 0.1041982 agricolo -> 10%
# [2,] 5.860085e-06 0.8958018 foresta -> 89%
f2 <- freq(d2c$map)
#      value  count
# [1,]     1 163187 agricolo
# [2,]     2 179539 foresta
s2 <- sum(163187,179539)
prop2 <- f2/s2
percent_06 <- prop2 * 100
#            value     count
# [1,] 2.917783e-06 0.4761442 agricolo -> 47%
# [2,] 5.835565e-06 0.5238558 foresta -> 52%

#generazione di un dataset (dataframe)
cover <- c("Forest", "Agricolture")
percent_1992 <- c(89.58, 10.41)
percent_2006 <- c(52.38, 47.61)
percentages <- data.frame(cover, percent_1992, percent_2006) #column names
percentages
pl92 <- ggplot(percentages, aes(x= cover, y=percent_1992 , color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
pl06 <- ggplot(percentages, aes(x= cover, y=percent_2006, color=cover)) + #color=cover -> è la legenda
          geom_bar(stat="identity", fill="white")
grid.arrange(pl92,pl06, nrow =1) #need gridExtra

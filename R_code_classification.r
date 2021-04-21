setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows

#immagine con 3 lielli RGB Solar_Orbiter_s_first_views_of_the_Sun_pillars
library(raster) #per rasterbrick

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

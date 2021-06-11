#codice utilizzato per l'esame 
#Maria Elena Cavallini

#analisi di immagini tra 201 nel bacino del Gadria (Bz) 
#classifico detrito vegetato e non vegetato e sua variazione nel tempo - frequenza delle classi (tipo landcover) e relativi grafici
#variazione ndvi nel tempo
#ggplot 



#imposto la working directory
setwd("/Users/mariaelenacavallini/lab/")

#creazione di una palette di colori 
cl <- colorRampPalette (c("orange","green","pink","purple","gold")) (100)
plot(p224r63_2011, col=cl)

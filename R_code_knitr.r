# starting from the code folder where framed.sty is put

#setwd("/Users/mariaelenacavallini/lab/") # Mac
setwd("C:/lab") # Windows
#require(knitr)
library(knitr)

stitch("gr.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

# starting from the code folder where framed.sty is put
#utilizzare solo Rstudio!!!
setwd("/Users/mariaelenacavallini/lab/") # Mac
#setwd("C:/lab") # Windows
#require(knitr)

library(knitr)

stitch("R_time_series.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

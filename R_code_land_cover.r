Per generare mappe Land Cover a partire da immagini satellitari
library(raster)
library(RStoolbox) #per la classificazione

# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# NIR 1, RED 2, GREEN 3

l92 <- brick("defor1_.jpg") #per importare l'immagine di Landsat del 1992
plotRGB(l92, r=1, g=2, b=3, stretch="lin") #plottare l'immagine

l06 <- brick("defor2_.jpg") #per importare l'immagine di Landsat del 2006
plotRGB(l06, r=1, g=2, b=3, stretch="lin") #plottare l'immagine

par(mfrow=c(2,1))
plotRGB(l92, r=1, g=2, b=3, stretch="lin") #plottare l'immagine
plotRGB(l06, r=1, g=2, b=3, stretch="lin") #plottare l'immagine










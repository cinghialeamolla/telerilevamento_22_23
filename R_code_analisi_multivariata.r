# R code for multivariate analysis

library(raster)
library(RStoolbox) #libreria per il telerilevamento, che contiene le funzioni per fare la PCA
library(ggplot2)
library(patchwork)

#  setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #importa un blocco di immagini insieme
plot(p224r63_2011) #plot delle singole immagini, delle singole bande
# 7 bande Landsat

# ricampionamento: 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)  # fact = di quanto aggreghiamo i pixel (10 pixel x 10, ecc)

g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g1+g2

# ricampionamento + invasivo
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

g1 <- ggRGB(p224r63_2011, 4, 3, 2)      #PCA molto lenta
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)     #PCA un po' più veloce
g3 <- ggRGB(p224r63_2011res100, 4, 3, 2)    #PCA molto + veloce, perchè l'immagine è molto più semplificata
g1+g2+g3




#R code variability

library(raster)
library(RStoolbox) #per calcolare la variabilità e visualizzare le immagini
library(ggplot2) #per i plot
library(patchwork)
library(viridis)

# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#Esercizio: importare l'immagine sul Similaun e darle un nome
sim <- brick("sentinel.png")

#Esercizio: plottare l'immagine usando la funzione "ggRGB"
simil <- ggRGB(sim, r=1, g=2, b=3, stretch="lin") #qui lo stretch non è fondamentale da inserire

#Esercizio: plottare i due grafici vicini con ggplot2
g1 <- ggRGB(sim, 1, 2, 3)
g2 <- ggRGB(sim, 2, 1, 3)
g1+g2

#calcolo della variabilità di nir
nir <- sim[[1]]
fun3 <- focal(nir, matrix(1/9, nrow=3, ncol=3), fun=sd)  #
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(fun3, col=clsd)

#plot con ggplot
ggplot() + geom_raster(fun3, mapping=aes(x=x, y=y, fill=layer))  #le zone chiare sono quelle di demarcazione tra bosco e prateria o i crepacci, cioè zone con maggior variabilità

# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html #colori del pacchetto viridis, con leggende ad hoc
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.

#aggiunta di nuova legenda viridis e titolo (serve il pacchetto viridis)
ggplot() + geom_raster(fun3, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis (option="magma") + ggtitle ("Deviazione Standard con Viridis")

#
sd7 <- focal(nir, matrix(1/49, nrow=7, ncol=7), fun=sd)
ggplot() + geom_raster(sd7, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis (option="magma") + ggtitle ("Deviazione Standard con Viridis")




Per generare mappe Land Cover a partire da immagini satellitari
library(raster)
library(RStoolbox) #per la classificazione

# install.packages("ggplot2")  #https://ggplot2-book.org/ (libro su ggplot2)
library(ggplot2)
# install.packages("patchwork") #https://patchwork.data-imaginist.com/ (info sul pacchetto)
library(patchwork)

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

#multiframe con ggplot2
ggRGB(l92, r=1, g=2, b=3, stretch="lin") #plot RGB che usa ggplot2
ggRGB(l06, r=1, g=2, b=3, stretch="lin") #plot RGB che usa ggplot2
p1 + p2 #per visualizzare le immagini in multiframe, con patchwork
#oppure
p1/p2 #per mettere un'immagine sopra e una sotto

# classificazione immagine del 1992
l92c <- unsuperClass(l92, nClasses=2)  #associazione della classificazione dell'immagine del 1992 a un nome
l92c #per visualizzare info sulla classificazione
plot(l92c$map) #per visualizzare la mappa riferita al modello
# classe 1: foresta
# classe 2: area agricola (+ acqua)

# classificazione immagine del 2006
l06c <- unsuperClass(l06, nClasses=2)  #associazione della classificazione dell'immagine del 2006 a un nome
l06c #per visualizzare info sulla classificazione
plot(l06c$map) #per visualizzare la mappa riferita al modello
# classe 1: foresta
# classe 2: area agricola (+ acqua)

# generare tabelle di frequenza dei pixel delle due classi per la mappa del 1992
freq(l92c$map)
# value  count
# Classe 1: 304994 pixel (foresta)
# Classe 2:  36298 pixel (area agricola)

# generare tabelle di frequenza dei pixel delle due classi per la mappa del 2006
freq(l06c$map)
# value  count
# Classe 1: 178477 pixel (foresta)
# Classe 2:  164249 pixel (area agricola)






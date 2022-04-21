# Classificazione automatica (fatta dal softwere) dei pixel

#richiamare le librerie
library(raster)
library(RStoolbox)

#settare la cartella di lavoro
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #importa il file e lo assegna al nome
so

plotRGB(so, r=1, g=2, b=3, stretch="lin") #plot in RGB del file

#classificazione dei dati
soc <- unsuperClass(so, nClasses=3) #suddivisione in 3 classi dei pixel del file (la classificazione è fatta automaticamente dal softwere)
soc  #la funzione sopra crea un modello con unico output una mappa: classificazione e creazione di output che contiene una mappa

cl <- colorRampPalette(c('yellow','black','red'))(100) #palette con 3 classe
plot(soc$map, col=cl) #plot della mappa appena creata con 3 classi

# set.seed può essere usato per ripetere un esperimento

#### DAY 2 Grandcanyon ####

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") #per importare il file su R
plotRGB(gc, r=1, g=2, b=3, stretch="lin")

gcclass2 <- unsuperClass(gc, nClasses=2) #per classificare in 2 classi i pixel dell'immagine
gcclass2
plot(gcclass2$map) #plot delle 2 classi

# Esercizio, classificare la mappa in 4 classi
gcclass4 <- unsuperClass(gc, nClasses=4) 
gcclass4

clc <- colorRampPalette(c('yellow','red','blue','black'))(100)
par(mfrow=c(2,1))
plot(gcclass2$map, col=clc)
plot(gcclass4$map, col=clc)

# comparare la mappa classificata con quella originale
par(mfrow=c(2,1))
plot(gcclass4$map, col=clc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#fare lo "stack" per migliorare la restituzione
st <- stack(gc, gcclass4$map)
plot(st) 






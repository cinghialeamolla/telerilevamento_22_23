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




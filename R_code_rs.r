# Questo è il primo script che useremo a lezione

#install.packages("raster")
library(raster) #per richiamare la libreria raster
#per recuperare i dati bisogna settare la cartella
# setwd("~/lab/") # Linux
 setwd("C:/lab/") # Windows
# setwd("/Userbs/name/Desktop/lab/") # Mac 

l2011 <- brick("p224r63_2011.grd") #per importare un blocco di dati e associarlo a un nome
l2011 #per visualizzare le informazioni

plot(l2011) #per plottare l'immagine

cl <- colorRampPalette(c("black","grey","light grey")) (100)   #https://www.r-graph-gallery.com/42-colors-names.html per scegliere i colori
plot(l2011, col=cl) #plot dell'immagine con i colori scelti da noi

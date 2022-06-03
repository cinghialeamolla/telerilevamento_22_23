# Codice R per i modelli di distribuzione delle specie

# install.packages("sdm")

library(raster) # predittori
library(sdm) #funzioni
library(rgdal) # specie
library(ggplot2)
library(patchwork)
library(viridis)

file <- system.file("external/species.shp", package="sdm") # carica un file che si trova già nel pacchetto di sdm
species <- shapefile(file) #crea uno shapefile
plot(species, pch=19) #plotta lo shapefile

occ <- species$Occurrence  
occ #per verificare la presenza/asssneza della specie

plot(species[occ == 1,],col='blue',pch=16)
# plot per mappare SOLO le presenze (occurrence=1), con un subset, scelta colore e punti (in blu i punti di presenza della specie)

points(species[occ == 0,],col='red',pch=16)
# per aggiungere punti alla funzione (in rosso i punti di assenza della specie)




# permette di prendere tutto il percorso delle quattro mappe (quota, precipitazioni, temperatura e vegetazione)
path <- system.file("external", package="sdm") 
path
# "C:/Users/pamel/Documents/R/win-library/4.1/sdm/external"

# crea una lista con i 4 file sopradetti; path=percorso file; pattern=estensione
lst <- list.files(path=path,pattern='asc$',full.names = T) #full.names è importante per mantenere il nome 
lst
# [1] "C:/Users/pamel/Documents/R/win-library/4.1/sdm/external/elevation.asc"    
# [2] "C:/Users/pamel/Documents/R/win-library/4.1/sdm/external/precipitation.asc"
# [3] "C:/Users/pamel/Documents/R/win-library/4.1/sdm/external/temperature.asc"  
# [4] "C:/Users/pamel/Documents/R/win-library/4.1/sdm/external/vegetation.asc" 

# stack per importare i 4 file
preds <- stack(lst)

# plot "predittori" (nominati così perchè ci aiutano a prevedere la presenza della specie)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predittori e presenza
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

#
plot(elev, col=cl)
points(species[occ == 1,], col="black", pch=19)
#alla specie non piace stare in quota elevata

#
plot(temp, col=cl)
points(species[occ == 1,], col="black", pch=19)
# la specie non ama il freddo

#
plot(prec, col=cl)
points(species[occ == 1,], col="black", pch=19)
# la specie predilige precipitazioni medio-alte

#
plot(vege, col=cl)
points(species[occ == 1,], col="black", pch=19)
# la specie ama essere protetta dalla vegetazione

# funzione del pacchetto sdm, che crea un oggetto con tutti i dati; 
datasdm <- sdmData(train=species, predictors=preds)
datasdm

# funzione che prende i dati e crea un modello lineare logistico (che approssima i dati di presenza nei casi intermedi dei predittori)
# y = a + be + bp + bt + bv 
y = le specie (quindi "Occurrence"); ~ = uguale; bx = nomi dei vari predittori; dati da utilizzare, dichiarati sopra; metodo
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
m1 #modellino

# previsione della mappa finale; newdata = qual'è l'estensione della previsione
#crea un file raster
p1 <- predict(m1, newdata=preds) 
p1 #file raster

# plot dell'output
plot(p1, col=cl)
points(species[occ == 1,], pch=19)
#in base al colore sulla mappa si avrà una probabilità + bassa o + alta di trovare la specie

### 
par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)

#oppure
final <- stack(preds, p1)
plot(final, col=cl)






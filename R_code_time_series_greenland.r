# Time series analysis of Greenland LST data

library(raster)

# setwd("~/lab/greenland") # Linux
setwd("C:/lab/greenland") # Windows #settare la cartella greenland
# setwd("/Users/name/Desktop/lab/greenland") # Mac

#funzione per creare un singolo layer (strato)
lst2000 <- raster("lst_2000.tif")
lst2000

plot(lst2000)

# importare i dati anche per il 2005, 2010 e 2015
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

#multiframe di 4 dati greenland
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)

# questa funzione crea una lista di file
rlist <- list.files(pattern="lst") #il pattern è qualcosa che tutti i file della lista da creare hanno in comune
rlist 
# questa funzione applica una stessa funzione a tutti i file della lista
import <- lapply(rlist, raster) #importare i 4 file
import
#questa funzione crea un blocco comune di tutti i dati
tgr <- stack(import)

plot(tgr, col=cl) #crea il plot multiframe, ma è molto più rapido
plot(tgr[[1]], col=cl) #per plottare un singolo elemento dello stack

plotRGB(tgr, r=1, g=2, b=3, stretch="lin")

########################################################
### Esempio n°2: Decremento NO2 nel periodo di lockdown
########################################################
library(raster)
# setwd("~/lab/en") # Linux
setwd("C:/lab/en") # Windows
# setwd("/Users/name/Desktop/lab/en") # Mac 

en01 <- raster("EN_0001.png") #importa la I banda per il primo set

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)

en13 <- raster("EN_0013.png") #importa la I banda per l'ultimo set
plot(en13, col=cl)

# importare l'intero dataset insieme
# esercizio: list.file, lapply, stack
rlist <- list.files(pattern="EN") #crea una lista di file
rimp <- lapply(rlist, raster) #applica ai file in lista la funzione raster
en <- stack(rimp) #crea un blocco comune dei file in lista importati con raster




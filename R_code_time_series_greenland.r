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


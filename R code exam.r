#Qui sotto il codice oggetto di esame

# dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce file di dati scritti utilizzando la libreria netCDF di Unidata.
# la funzione sottostante si usa per istallare dei pacchetti esterni, dal CRAN with the use of " "
install.packages("ncdf4")

# sp è un pacchetto per i dati spaziali
install.packages("sp")

# Queste funzioni richiamano i pacchetti usati per le analisi
library(ncdf4)
library(raster)

library(raster)

# "setwd" si usa per il settaggio della cartella di lavoro 
setwd("C:/rexam/")  #questa formula si usa per windows


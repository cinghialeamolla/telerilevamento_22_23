# Qui sotto il codice oggetto di esame

# dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce un'interfaccia per i file di dati in formato Unidata netCDF
# la funzione sottostante si usa per istallare dei pacchetti esterni a R, dal CRAN.
# install.packages("ncdf4") # https://cran.r-project.org/web/packages/ncdf4/index.html

# sp è un pacchetto per i dati spaziali
# install.packages("sp") # http://cran.nexr.com/web/packages/sp/index.html

# Queste funzioni richiamano i pacchetti usati per le analisi
library(ncdf4)
library(raster)

# "setwd" si usa per il settaggio della cartella di lavoro 
# setwd("~/lab/") # Linux
setwd("C:/rexam/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

# ho scaricato due file della temperatura della superficie terrestre (Land Surface Temperature), del 24 agosto 2010 e del 24 agosto 2020, allo stesso orario (14:00)
# Fonte dati: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

# questa funzione (rinomina e) carica il dataset
lst_2010 <- raster("LST_08_2010.nc") # LST del 24 agosto 2010
lst_2010 #per visualizzare i dati

# questa funzione serve per visualizzare il dataset ("plottare")
# l'argomento "main" assegna il titolo al plot
plot(lst_2010, main="Temperatura della superficie terrestre 2010") 

# l'argomento "col" assegna una scala di colori pre impostata ("colorRampPalette")
# impostati i colori (cl) si visualizza il dataset con la scala cromatica scelta.
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(lst_2010, col=cl, main="Temperatura della superficie terrestre 2010")

dev.off() # per chiudere il riquadro con l'immagine

# qui vado a importare il secondo dataset
lst_2020 <- raster("LST_08_2010.nc") # LST del 24 agosto 2020
lst_2020 #per visualizzare i dati

# e qui il plot del secondo dataset
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020")

#dev.off

# questa funzione ("par") serve per visualizzare in un unico plot più oggetti
# l'argomento "mfrow" indica il numero di righe del "multiframe", in questo caso formato da 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(lst_2010, col=cl, main="Temperatura della superficie terrestre 2010")
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020")

# a prima vista non si notano molto le differenze, quindi 
diflst <- lst_2010 - lst_2020





# Qui sotto il codice oggetto di esame

# dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce un'interfaccia per i file di dati in formato Unidata netCDF
# la funzione sottostante si usa per istallare dei pacchetti esterni a R, dal CRAN.
# install.packages("ncdf4") # https://cran.r-project.org/web/packages/ncdf4/index.html

# sp è un pacchetto per i dati spaziali
# install.packages("sp") # http://cran.nexr.com/web/packages/sp/index.html

#install.packages("ggplot2")
#install.packages("gridExtra")



# Queste funzioni richiamano i pacchetti usati per le analisi
library(ncdf4)
library(raster)
library(ggplot2)
library(gridExtra) 

# "setwd" si usa per il settaggio della cartella di lavoro 
# setwd("~/lab/") # Linux
setwd("C:/rexam/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

# ho scaricato due file della temperatura della superficie terrestre (Land Surface Temperature), di agosto 2017 e agosto 2020.
# Fonte dati: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

# questa funzione (rinomina e) carica il dataset
lst_2017 <- raster("LST_2017_globe.nc") # LST agosto 2018
lst_2017 #per visualizzare i dati

# questa funzione serve per visualizzare il dataset ("plottare")
# l'argomento "main" assegna il titolo al plot
plot(lst_2017, main="Temperatura della superficie terrestre 2017") 

# l'argomento "col" assegna una scala di colori pre impostata ("colorRampPalette")
# impostati i colori (cl) si visualizza il dataset con la scala cromatica scelta.
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(lst_2017, col=cl, main="Temperatura della superficie terrestre 2017")

dev.off() # per chiudere il riquadro con l'immagine

# qui vado a importare il secondo dataset
lst_2020 <- raster("LST_2020_globe.nc") # LST agosto 2020
lst_2020 #per visualizzare i dati

# e qui il plot del secondo dataset
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020")

#dev.off

# questa funzione ("par") serve per visualizzare in un unico plot più oggetti
# l'argomento "mfrow" indica il numero di righe del "multiframe", in questo caso formato da 1 riga e 2 colonne
par(mfrow=c(1,2))
plot(lst_2017, col=cl, main="Temperatura della superficie terrestre 2017")
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020")

# a prima vista non si notano molto le differenze
#dev.off()

diflst <- lst_2017 - lst_2020  # qui ho calcolato la differenza tra i valori dei due oggetti
cldif <- colorRampPalette(c('dark blue','light blue','yellow'))(100) # per impostare una scala di colori 
plot(diflst, col=cldif, main="Differenza LST tra 2017 e 2020") # plotta la differenza tra i valori di lst del 2017 e quelli del 2020
# si notano delle aree in Nord America e in Nord Eurasia colorate in giallo, dove sembra ci sia stato un aumento di temperatura

#dev.off()

# ho scaricato alcune coppie di immagini inerenti la perdita di ghiaccio e neve in alcune aree della Groenlandia, nelle Isole Svalbard e sull'Himalaya
# Fonte dati: https://earthobservatory.nasa.gov/topic/remote-sensing

# caso 1: regione del fiordo di Hornsund nelle Svalbard

#importare i dataset
sval_1990 <- brick("svalbard_1990.jpg") #immagine catturata da Landsat 5, il 20 agosto 1990
sval_1990 #per visualizzare il dataset
# le bande sono 3: svalbard_1990_1, svalbard_1990_2, svalbard_1990_3

#
sval_2017 <- brick("svalbard_2017.jpg") #immagine catturata da Landsat 8, il 19 agosto 2017
sval_2017 #per visualizzare il dataset
# le bande sono 3: svalbard_2017_1, svalbard_2017_2, svalbard_2017_3 


sval_pca <- rasterPCA(sval_1990)

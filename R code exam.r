# Qui sotto il codice oggetto di esame

# dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce un'interfaccia per i file di dati in formato Unidata netCDF
# la funzione sottostante si usa per istallare dei pacchetti esterni a R, dal CRAN.
# install.packages("ncdf4") # https://cran.r-project.org/web/packages/ncdf4/index.html

# Queste funzioni richiamano i pacchetti usati per le analisi
library(ncdf4)
library(raster)
library(ggplot2) #
library(RStoolbox) #
library(rasterVis) #

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

## caso 1: Nord-Ovest Gronlandia, penisola a nord della Base aerea di Thule (Pituffik)

# importare i dataset
gren_1973 <- brick("greenland_1973_lrg.jpg") # immagine catturata da Landsat 1, il 3 settembre 1973
gren_1973 # per visualizzare il dataset
# greenland_1973_lrg_1, greenland_1973_lrg_2, greenland_1973_lrg_3 

#
# importare i dataset
gren_2022 <- brick("greenland_2022_lrg.jpg") # immagine catturata da Landsat 8, il 20 agosto 2022
gren_2022 #per visualizzare il dataset
# greenland_2022_lrg_1, greenland_2022_lrg_2, greenland_2022_lrg_3 

# Multiframe formato da un'unica colonna e due righe, la prima con l'immagine riferita al 1973 e la seconda al 2022
# l'argomento "stretch" serve
par(mfrow=c(2,1))
plotRGB(gren_1973, r=1, g=2, b=3, stretch="hist")
plotRGB(gren_2022, r=1, g=2, b=3, stretch="hist")

dev.off()

# questa funzione crea una lista di file con punti in comune nel nome (lrg)
grenlist <- list.files(pattern="lrg")
grenlist
# questa funzione applica uno stesso comando a una lista di file
greimp <- lapply(grenlist,raster)
greimp
# questa funzione crea un blocco di file raster uniti insieme in un solo file
grenland_1 <- stack(greimp)
grenland_1

# plotto il gruppo di file uniti
levelplot(grenland_1) #funzione del pacchetto "rasterVis"
# nell'immagine in basso (2022), si nota come l'area rappresentativa delle porzioni ghiacciate sia nettamente inferiore rispetto a quella sopra, di 49 anni prima

# andando ad arricchire il plot, ho aggiunto i seguenti argomenti:
# "col.regions" per cambiare colore alle immagini; "main" per attribuire un titolo al plot; "names.attr" per rinominare le singole immagini
clg<-colorRampPalette(c("blue","light blue","pink","red"))(100)  # per impostare la palette di colori
levelplot(grenland_1,col.regions=clg,main="Perdita di ghiaccio nel nord-ovest della Groenlandia",names.attr=c("Settembre 1973","Agosto 2022"))

#dev.off()

#sottrazione tra il primo dato e il secondo
melting <- grenland_1$greenland_2022_lrg.jpg - grenland_1$greenland_1973_lrg.jpg   # "grenland_1$" lega i singoli file alla loro posizione nello stack

#plotto l'immagine con la differenza
clm <- colorRampPalette(c("blue","white","red"))(100) #assegno una scala di colori ai file

levelplot(melt_amount,col.regions=clb)










# caso x: regione del fiordo di Hornsund nelle Svalbard

#importare i dataset
sval_1990 <- brick("svalbard_1990.jpg") #immagine catturata da Landsat 5, il 20 agosto 1990
sval_1990 #per visualizzare il dataset
# le bande sono 3: svalbard_1990_1, svalbard_1990_2, svalbard_1990_3

#
sval_2017 <- brick("svalbard_2017.jpg") #immagine catturata da Landsat 8, il 19 agosto 2017
sval_2017 #per visualizzare il dataset
# le bande sono 3: svalbard_2017_1, svalbard_2017_2, svalbard_2017_3 

par(mfrow=c(1,2))
plotRGB(sval_1990, r=1, g=2, b=3, stretch="hist")
plotRGB(sval_2017, r=1, g=2, b=3, stretch="hist")

# differenza dei valori tra la prima immagine (gennaio) e l'ultima (marzo)
difsval <- sval_1990 - sval_2017
clsval <- colorRampPalette(c('blue','white','red'))(100) # 
plot(difsval, col=clsval) #plotta la differenza ottenuta con la funzione sopra


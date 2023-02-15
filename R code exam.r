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
library(patchwork)
library(gridExtra) #

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

# ho scaricato una coppia di immagini inerenti la perdita di ghiaccio e neve in un'area nella penisola a nord della Base aerea di Thule (Pituffik), Nord-Ovest della Gronlandia,
# Fonte dati:  https://earthobservatory.nasa.gov/images/150267/a-half-century-of-loss-in-northwest-greenland

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

#multiframe con ggplot2
g1973 <- ggRGB(gren_1973, r=1, g=2, b=3, stretch="lin") #plot RGB che usa ggplot2
g2022 <- ggRGB(gren_2022, r=1, g=2, b=3, stretch="lin") #plot RGB che usa ggplot2
g1973 / g2022 #per visualizzare le immagini in multiframe, con patchwork

dev.off()

# classificazione immagine del 1973
clasl973 <- unsuperClass(gren_1973, nClasses=2)  # associazione della classificazione dell'immagine del 1972 a un nome
clasl973 # per visualizzare info sulla classificazione
plot(clasl973$map) # per visualizzare la mappa riferita al modello
# classe 1: ghiaccio
# classe 2: acqua + superficie terrestre non coperta da ghiaccio

# classificazione immagine del 2022
clas2022 <- unsuperClass(gren_2022, nClasses=2)  #associazione della classificazione dell'immagine del 2022 a un nome
clas2022 #per visualizzare info sulla classificazione
plot(clas2022$map) #per visualizzare la mappa riferita al modello
# classe 1: ghiaccio
# classe 2: acqua + superficie terrestre non coperta da ghiaccio

# generare tabelle di frequenza dei pixel delle due classi per la mappa del 1973
freq(clasl973$map)
# value  count
# Classe 1 2962927 pixel (ghiaccio)
# Classe 2 2092234 pixel (acqua + superficie terrestre non coperta da ghiaccio)

# generare tabelle di frequenza dei pixel delle due classi per la mappa del 2022
freq(clas2022$map)
# value  count
# Classe 1 2734537 pixel (ghiaccio)
# Classe 2 2320624 pixel (acqua + superficie terrestre non coperta da ghiaccio)


#sommo i valori totali delle classi (1993)
s1 <- 2962927 + 2092234
#questa funzione calcola la proporzione delle due classi per l'immagine del 1993
prop1 <- freq(clasl973$map) / s1
prop1
# Prop. ghiaccio: 0.5861192
# Prop. NON ghiaccio: 0.4138808

#proporzioni nella seconda mappa (2022)
s2 <- 2734537 + 2320624 
prop2 <- freq(clas2022$map) / s2
prop2
# Prop. ghiaccio: 0.5409396
# Prop. area NON ghiaccio: 0.4590604


#creare un dataset
#colonne
copertura <- c("Ghiaccio","NON Ghiaccio") #prima colonna
percentuale_1973 <- c(58.61,41.39) # 
percentuale_2022 <- c(54.09,45.91) # 
#tabella
percentuali <- data.frame(copertura, percentuale_1973, percentuale_2022)
percentuali
#plot del grafico  del 1973
p1<-ggplot(percentuali, aes(x=copertura, y=percentuale_1973, color=copertura)) + geom_bar(stat="identity", fill="white")
#plot del grafico  del 2022
p2<-ggplot(percentuali, aes(x=copertura, y=percentuale_2022, color=copertura)) + geom_bar(stat="identity", fill="white")
#arrangiare i due grafici in una pagina
grid.arrange(p1, p2, nrow=2)



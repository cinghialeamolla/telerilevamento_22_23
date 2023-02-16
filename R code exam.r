# Qui sotto il codice oggetto di esame

# dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce un'interfaccia per i file di dati in formato Unidata netCDF
# la funzione sottostante si usa per istallare dei pacchetti esterni a R, dal CRAN.
# install.packages("ncdf4") # https://cran.r-project.org/web/packages/ncdf4/index.html

# queste funzioni richiamano i pacchetti usati per le analisi

# "raster" è usato per l'analisi e la manipolazione di dati geografici e spaziali
library(raster) # https://cran.r-project.org/web/packages/raster/index.html

# richiama "ncdf4"
library(ncdf4) 

# "ggplot2" è usato per la visualizzazione dei dati, è molto curato
library(ggplot2) # https://cran.r-project.org/web/packages/ggplot2/index.html

# "RStoolbox" è usato per l'elaborazione e l'analisi di dati telerilevati (calcolo incici spettrali, pca, classificazione non supervisionata, ecc.
library(RStoolbox) # https://mran.microsoft.com/snapshot/2016-11-02/web/packages/RStoolbox/index.html

# "rasterVis" è usato sempre per la visualizzazone di dati raster (in questo progetto è stato inserito per la funzione "levelplot")
library(rasterVis) # https://cran.r-project.org/web/packages/rasterVis/index.html

# "patchwork" fa parte di ggplot2, ed è usato per combinare tra loro più grafici
library(patchwork) # https://cran.r-project.org/web/packages/patchwork/index.html

# "gridExtra" è usato per impostare dei grafici a griglia o tabelle (io l'ho usato per la funzione "grid.arrange")
library(gridExtra) # https://cran.r-project.org/web/packages/gridExtra/index.html

# "setwd" si usa per il settaggio della cartella di lavoro 
# setwd("~/lab/") # Linux
setwd("C:/rexam/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

#### PRIMA PARTE:
# ho scaricato due file della temperatura della superficie terrestre (Land Surface Temperature), di agosto 2017 e agosto 2020.
# Fonte dati: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

# questa funzione (rinomina e) carica il dataset
lst_2017 <- raster("LST_2017_globe.nc") # LST agosto 2018
lst_2017 #per visualizzare i dati

# questa funzione serve per visualizzare il dataset ("plottare")
# l'argomento "main" assegna il titolo al plot
plot(lst_2017, main="Temperatura della superficie terrestre 2017") 

# l'argomento "col" assegna una scala di colori pre impostata ("colorRampPalette")
# impostati i colori (cl) ho visualizzato il dataset con la scala cromatica scelta.
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(lst_2017, col=cl, main="Temperatura della superficie terrestre 2017")

dev.off() # per chiudere tutte le finestre grafiche

# qui vado a importare il secondo dataset
lst_2020 <- raster("LST_2020_globe.nc") # LST agosto 2020
lst_2020 # per visualizzare i dati

# e qui il plot del secondo dataset, con la stessa scala cromatica impostata sopra
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020")

dev.off()

# questa funzione ("par") serve per visualizzare in un unico plot più oggetti
# l'argomento "mfrow" indica il numero di righe del "multiframe", in questo caso formato da 1 riga e 2 colonne
par(mfrow=c(2,1))
plot(lst_2017, col=cl, main="Temperatura della superficie terrestre 2017") # dataset del 2017
plot(lst_2020, col=cl, main="Temperatura della superficie terrestre 2020") #dataset del 2020
# a prima vista non si notano molto le differenze di temperatura tra le due immagini

dev.off()

diflst <- lst_2017 - lst_2020  # qui ho calcolato la differenza tra i valori dei due oggetti
cldif <- colorRampPalette(c('dark blue','light blue','yellow'))(100) # per impostare una scala di colori 
plot(diflst, col=cldif, main="Differenza LST tra 2017 e 2020") # plotta la differenza tra i valori di lst del 2017 e quelli del 2020
# si notano delle aree in Nord America e in Nord Eurasia colorate in giallo, dove sembra ci sia stato un aumento di temperatura

#dev.off()

#### SECONDA PARTE:
# ho scaricato una coppia di immagini inerenti la perdita di ghiaccio e neve in un'area nella penisola a nord della Base aerea di Thule (Pituffik), Nord-Ovest della Gronlandia,
# Fonte dati:  https://earthobservatory.nasa.gov/images/150267/a-half-century-of-loss-in-northwest-greenland

# qui ho importato il dataset del 1973
gren_1973 <- brick("greenland_1973_lrg.jpg") # immagine catturata da Landsat 1, il 3 settembre 1973
gren_1973 # per visualizzare il dataset

# qui ho importato il dataset del 2022
gren_2022 <- brick("greenland_2022_lrg.jpg") # immagine catturata da Landsat 8, il 20 agosto 2022
gren_2022 #per visualizzare il dataset

# ho impostato un multiframe formato da un'unica colonna e due righe, la prima con l'immagine riferita al 1973 e la seconda al 2022
# l'argomento "stretch" serve per allungare i valori e aumentare il contrasto dell'immagine (si possono usare "lin" o "hist")
par(mfrow=c(2,1))
# questa funzione crea un immagine "a colori veri" (RGB), combinando le 3 bande del dataset
plotRGB(gren_1973, r=1, g=2, b=3, stretch="hist") # immagine di settembre 1973
plotRGB(gren_2022, r=1, g=2, b=3, stretch="hist") # immagine di agosto 2022

dev.off()

# questa funzione crea una lista di file, a partire da punti in comune nel nome (in questo caso "lrg")
grenlist <- list.files(pattern="lrg") # qui ho importato i due dataset come lista di file
grenlist # per visualizzare i file della lista

# questa funzione applica uno stesso comando a una lista di file o a un vettore
greimp <- lapply(grenlist,raster)
greimp

# questa funzione crea un blocco di file raster uniti insieme in un solo file
grenland_1 <- stack(greimp)
grenland_1 # per visualizzare i layer che compongono il "rasterstak"

# plotto il gruppo di file uniti
levelplot(grenland_1) #funzione del pacchetto "rasterVis"
# nell'immagine in basso (2022), si nota come l'area rappresentativa delle porzioni ghiacciate sia nettamente inferiore rispetto a quella sopra, di 49 anni prima

# andando ad arricchire il plot, ho aggiunto i seguenti argomenti:
# "col.regions" per cambiare colore alle immagini; "main" per attribuire un titolo al plot; "names.attr" per rinominare le singole immagini
clg<-colorRampPalette(c("blue","light blue","pink","red"))(100)  # per impostare la palette di colori
levelplot(grenland_1,col.regions=clg,main="Perdita di ghiaccio nel nord-ovest della Groenlandia",names.attr=c("Settembre 1973","Agosto 2022"))

dev.off()

# qui ho creato un multiframe con ggplot2, andando ad utilizzare le due immagini separate (e non lo stack)
# "ggRGB" si usa per creare un immagine singola con le 3 bande (usa ggplot2 e RStoolbox)
g1973 <- ggRGB(gren_1973, r=1, g=2, b=3, stretch="hist") #plot RGB che usa ggplot2, per l'immagine del 1973
g2022 <- ggRGB(gren_2022, r=1, g=2, b=3, stretch="hist") #plot RGB che usa ggplot2, per l'immagine del 2022
g1973 / g2022 #per visualizzare le immagini in multiframe, con il pacchetto "patchwork"

dev.off()

# qui ho fatto la classificazione non supervisionata dell'immagine del 1973
clasl973 <- unsuperClass(gren_1973, nClasses=2)  # associazione della classificazione dell'immagine del 1972 a un nome
clasl973 # per visualizzare info sulla classificazione
plot(clasl973$map) # per visualizzare la mappa riferita al modello
# classe 1: pixel occupati da ghiaccio
# classe 2: pixel occupati da acqua e superficie terrestre non coperta da ghiaccio

# qui ho fatto la classificazione non supervisionata dell'immagine del 2022
clas2022 <- unsuperClass(gren_2022, nClasses=2)  #associazione della classificazione dell'immagine del 2022 a un nome
clas2022 #per visualizzare info sulla classificazione
plot(clas2022$map) #per visualizzare la mappa riferita al modello
# classe 1: pixel occupati da ghiaccio
# classe 2: pixel occupati da acqua e superficie terrestre non coperta da ghiaccio

# qui ho generato una tabella di frequenza con i pixel delle due classi, riferiti alla mappa del 1973
freq(clasl973$map)
# valori delle due classi:
# Classe 1 2962927 pixel (ghiaccio)
# Classe 2 2092234 pixel (acqua + superficie terrestre non coperta da ghiaccio)

# qui ho generato una tabella di frequenza con i pixel delle due classi, riferiti alla mappa del 2022
freq(clas2022$map)
# valori delle due classi:
# Classe 1 2734537 pixel (ghiaccio)
# Classe 2 2320624 pixel (acqua + superficie terrestre non coperta da ghiaccio)


# qui ho sommato i valori totali delle due classi per il 1973
s1 <- 2962927 + 2092234
# questa funzione calcola la proporzione delle due classi per l'immagine del 1993
prop1 <- freq(clasl973$map) / s1
prop1
# Prop. ghiaccio: 0.5861192
# Prop. NON ghiaccio: 0.4138808

# qui ho calcolato le proporzioni nella seconda mappa (2022)
s2 <- 2734537 + 2320624  # somma pixel totali delle due classi
prop2 <- freq(clas2022$map) / s2 # proporzione classi
prop2
# Prop. ghiaccio: 0.5409396
# Prop. area NON ghiaccio: 0.4590604


# qui ho creato un dataset
# ho impostato le colonne del dataset
copertura <- c("Ghiaccio","NON Ghiaccio") # prima colonna: intestazione
percentuale_1973 <- c(58.61,41.39) # seconda colonna: % riferite all'immagine del 1973
percentuale_2022 <- c(54.09,45.91) # terza colonna: % riferite all'immagine del 2022

# qui sotto ho creato la tabella con il dataset soprastante
percentuali <- data.frame(copertura, percentuale_1973, percentuale_2022)
percentuali  # per visualizzare la tabella

# qui ho plottaro il grafico con le diverse % dei pixel di entrambi gli anni
# "aes" serve a impostare la mappatura grafica degli elementi del plot; "geom_bar" imposta il grafico con l'altezza della barra proporzionale al numero di casi in ciascun gruppo
# "stat="identity"" lascia i dati invariati; "fill" imposta il colore di riempimento del  grafico

# plot del grafico  del 1973
p1 < -ggplot(percentuali, aes(x=copertura, y=percentuale_1973, color=copertura)) + geom_bar(stat="identity", fill="white")
# plot del grafico  del 2022
p2 <- ggplot(percentuali, aes(x=copertura, y=percentuale_2022, color=copertura)) + geom_bar(stat="identity", fill="white")
# ho arrangiato i due grafici in una pagina unica (con una funzione del pacchetto "gridExtra")
grid.arrange(p1, p2, nrow=2)



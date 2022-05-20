# Codice R per visualizzare e analizzare dati LiDAR

# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

library(raster)
library(rgdal)
library(viridis)
library(ggplot2)
library(RStoolbox)

dsm_2014 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")

dtm_2014 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

# Calcolare CHM
chm_2014 <- dsm_2014 - dtm_2014 
chm_2014 #da info sul punto più alto e il punto più basso

#plot con ggplot
ggplot() + 
geom_raster(chm_2014, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2014 San Genesio/Jenesien")
#mostra la mappa; il blu scuro sono dei prati attorno al paese; poi ci sono delle case e il bosco attorno (colori + chiari, con alterre sui 38m circa)

## Stesse cose per il 2004

dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")

dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")

# Calcolare CHM
chm_2004 <- dsm_2004 - dtm_2004 

#plot con ggplot
ggplot() + 
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")
#la risoluzione è diminuita (nel 2014 è di 0,5m e qui di 2,5m)

#confrontare i due chm, per vedere cosa è cambiato in 10 anni
difference <- chm_2014 - chm_2004 #ma i due dati hanno una risoluzione dei dati, quindi bisogna ricampionare e accorpare i pixel nel dato del 2014, passando ad una risoluzione più grossolana

#questa funzione ricampiona l'immagine più recente, con risoluzione più alta, sulla base di quella più vecchia, con risoluzione più bassa
chm_2014_r <- resample(chm_2014, chm_2004)
difference <- chm_2014_r - chm_2004 #ora si può fare la differenza

#plot con ggplot
ggplot() + 
geom_raster(difference, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM difference San Genesio/Jenesien")
#nelle aree + scure, blu, (+ basse) le piante sono state tagliate; nelle aree + gialle, chiare (+ alte), le piante sono cresciute dal 2004 al 2014; nel prato non è cambiato nulla; c'è una leggera differenza per il ricampionamento sulle case, ma non è reale

#per visualizzare la nube di punti
# install.packages("lidR")
library(lidR)
point_cloud <- readLAS("point_cloud.laz")
plot(point_cloud) #restituisce il 3D dell'area


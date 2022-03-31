library(raster) #richiamare libreria raster
library(RStoolbox) #richiamare libreria RStoolbox
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

#install.packages("rasterdiv")
library(rasterdiv) #richiamare libreria rasterdiv

#importare defor1 e dargli un nome
l1992 <- brick("defor1_.jpg")
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
# layer 1 = NIR
# layer 2 = Red
# layer 3 = Green

#importare defor2 e dargli un nome
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# plot in multiframe con le 2 immagini
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# calcolo DVI Difference Vegetation Index 
#differenza tra riflettanza in NIR e riflettanza in Red

dvi1992 = l1992[[1]] - l1992[[2]]
#oppure
#dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992, col=cl)

dvi2006 = l2006[[1]] - l2006[[2]]
plot(dvi2006, col=cl)

#differenza dvi 1992 e dvi 2006
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_dif, col=cld)
# i valori rossi hanno la differenza di dvi più alta = fortissima deforestazione

# DAY 2

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

#l'NDVI può essere usato anche per confrontare immagini con diversa risoluzione radiometrica

# 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = (dvi1992) / (l1992[[1]] + l1992[[2]])

# 2006
dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = (dvi2006) / (l2006[[1]] + l2006[[2]])

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#Multiframe con plot RGB dell'immagine sopra e l'NDVI sotto
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

par(mfrow=c(2,1))
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")
plot(ndvi2006, col=cl)

par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# RStoolbox::spectralIndices
si1992 <- spectralIndices(l1992, green = 3, red = 2, nir = 1)
plot(si1992, col=cl)

si2006 <- spectralIndices(l2006, green = 3, red = 2, nir = 1)
plot(si2006, col=cl)

### rasterdiv
plot(copNDVI) #raster a 8 bit che rappresenta la media dell'NDVI globale dal 1999 al 2017 
#maggiore è l'NDVI e maggiore è la copertura vegetale in salute



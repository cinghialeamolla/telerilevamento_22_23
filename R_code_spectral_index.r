library(raster) #richiamare libreria raster
library(RStoolbox) #richiamare libreria RStoolbox
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

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

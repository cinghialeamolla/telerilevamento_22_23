# Questo è il primo script che useremo a lezione

#install.packages("raster")
library(raster) #per richiamare la libreria raster
#per recuperare i dati bisogna settare la cartella
# setwd("~/lab/") # Linux
 setwd("C:/lab/") # Windows
# setwd("/Userbs/name/Desktop/lab/") # Mac 

l2011 <- brick("p224r63_2011.grd") #per importare un blocco di dati (immagine satellitare) e associarlo a un nome
l2011 #per visualizzare le informazioni

plot(l2011) #per plottare l'immagine con le singole bande

cl <- colorRampPalette(c("black","grey","light grey")) (100)   #https://www.r-graph-gallery.com/42-colors-names.html per scegliere i colori
plot(l2011, col=cl) #plot dell'immagine con i colori scelti da noi

dev.off() #per chiudere le finestre con le immagini

#### DAY 2

# Bande Landsat ETM+
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#per plottare una singola banda (in questo caso il blu - B1_sre)
plot(l2011$B1_sre) #nome banda
plot(l2011[[1]])   #elemento

cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(l2011$B1_sre, col=cl) #banda blu con scelta legenda colori

#plot B1 con legenda in gradazione di blu
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(l2011$B1_sre, col=clb)

#esportare le immagini in un pdf nella cartella lab (magia)
pdf("banda1.pdf") #apre il pdf
plot(l2011$B1_sre, col=clb) #contenuto del pdf
dev.off() #chiude la finestra appena aperta

#esportare l'immagine come file png nella cartella lab (magia)
png("banda1.png") #apre il png
plot(l2011$B1_sre, col=clb) #contenuto del png
dev.off() #chiude la finestra appena aperta

#per plottare la singola banda del verde - B2_sre
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(l2011$B2_sre, col=clg) #nome banda

#Per creare un "multi Frame"

# 1 row (riga), 2 columns (colonne)
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# 2 row (righe), 1 columns (colonna)
par(mfrow=c(2,1)) # if you are using columns first: par(mfcol....)
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot con 4 riquadri
par(mfrow=c(4,1))
# blu
plot(l2011$B1_sre, col=clb)
# verde
plot(l2011$B2_sre, col=clg)
# rosso
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(l2011$B3_sre, col=clr)
# vicino infrarosso
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# un quadrato di bande
par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)


clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)



### DAY 3
plot(l2011$B1_sre)
plot(l2011[[4]])

# Plot of l2011 in the NIR channel (NIR band)
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

#plot RGB layers
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

par(mfrow=c(2,1)) #confronto colori naturali e infrarosso
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

#caricare immagine del 1988
l1988<-brick("p224r63_1988.grd")

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

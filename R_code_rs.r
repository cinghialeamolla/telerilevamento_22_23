# Questo è il primo script che useremo a lezione

#install.packages("raster")
library(raster) #per richiamare la libreria raster
#per recuperare i dati bisogna settare la cartella
# setwd("~/lab/") # Linux
 setwd("C:/lab/") # Windows
# setwd("/Userbs/name/Desktop/lab/") # Mac 

l2011 <- brick("p224r63_2011.grd") #per importare un blocco di dati e associarlo a un nome
l2011 #per visualizzare le informazioni

plot(l2011) #per plottare l'immagine

cl <- colorRampPalette(c("black","grey","light grey")) (100)   #https://www.r-graph-gallery.com/42-colors-names.html per scegliere i colori
plot(l2011, col=cl) #plot dell'immagine con i colori scelti da noi

#### DAY 2

# colour change -> new
cl <- colorRampPalette(c("blue","green","grey","red","magenta","yellow")) (100) 
plot(l2011, col=cl)

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(l2011, col=cls)                       

#### DAY 3
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# dev.off will clean the current graph
# dev.off()

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)

# dev.off()

plot(l2011$B1_sre)
plot(l2011_2011$B2_sre)

# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1)) # if you are using columns first: par(mfcol....)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands...:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands...:
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)



#DAY4
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

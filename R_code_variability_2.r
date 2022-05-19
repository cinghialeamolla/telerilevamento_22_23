#R code variability 2 - usando l'analisi delle componenti principali PCA

library(raster)
library(RStoolbox) #per calcolare la variabilità e visualizzare le immagini
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs
library(viridis)

# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

sen <- brick("sentinel.png") #nominare e importare l'immagine del Similaun
ggRGB(sen, 1, 2, 3)

ggRGB(sen, 2, 1, 3) #vegetazione verde (Near infrared) e suolo nudo viola

#prende le varie bande e le da in pasto alla PCA
sen_pca <- rasterPCA(sen)

summary(sen_pca$model) #permette di capire quanto spiega della variabilità ogni singola componente della PCA
pc1 67,37 %
pc2 32,26 %
pc3 0,037 %

plot(sen_pca$map) #plotta le 3 bande

pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

g1 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
 
g2 <- ggplot() +
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))
 
g3 <- ggplot() +
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))

g1 +g2 +g3

#Deviazione Standard di una "moving window" di 3x3 pixel sulla PC1
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)          
             
#mappaggio con GGplot della Deviazione Standard della PC1
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))     

# con i colori del pacchetto viridis
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() 

# con i colori del pacchetto viridis "inferno"
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# Più immagini insieme
im1 <- ggRGB(sen, 2, 1, 3)  #immagine originale
 
im2 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))  # I componente principale
 
im3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")  # Deviazione Standard sulla legenda inferno di viridis

im1 + im2 + im3  #unisce le immagini con patchwork

### Calcolo dell'eterogeneità con una finestra mobile 5x5
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd)

ggplot() +
geom_raster(sd5, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

im3 + im4  #plotta le deviazioni standard calcolate con una finestra 3x3 e una 5x5 (con una variabilità maggiore)

### Calcolo eterogeneità con una finestra 7x7
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
 
im5 <- ggplot() +
geom_raster(sd7, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")
 
im3 + im4 + im5  #3x3, 5x5, e 7x7 

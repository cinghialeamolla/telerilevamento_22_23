# R code per colorist

#The "colorist" (R) package was created to provide additional methodologies and options for studying and communicating information on the distribution of wildlife in space and time.
#To do this "colorist" uses Rasterstack images that describe wildlife distributions, processes and links them to HCL palettes in specific ways.
#Resulting visualizations allow viewers to meaningfully compare values of occurrence, abundance, or density over space and time.


#What is the HCL palette? The Hue-Chroma-Luminance (HCL) color space is an alternative to other color spaces such as RGB, HSV, and so on.
#Each color within the HCL color space is defined by a triplet of values. 
#The dimensions are:

   #Hue: defines the color (hue)
   #Chroma: defines the color (saturation or intensity of the color)
   #Luminance: defines the brightness
   #(https://hclwizard.org/images//hclscheme_pic0.png)

#The basic workflow for colorist is:

   # 1.) Metrics: Users calculate metrics to describe their distributions.
   # 2.) Color palette: Users choose a color palette to enable the display of metrics.
   # 3.) Map: Users combine metrics and palette to map distributions into a single map or more.
   # 4.) Legend: Users generate a legend to accompany their map.
   

install.packages("colorist")

library(colorist)
library(ggplot2) # colorist lavora con ggplot2

# mappare una specie nel ciclo annuale, con dati già presenti nel pacchetto colorist
#EXAMPLE 1: MAPPING A DISTRIBUTION OF SPECIES IN THE ANNUAL CYCLE

#Here, we use eBird status and trend aggregate data for Field Sparrow (Spizella pusilla) to illustrate a different strategy for creating annual cycle maps, which leverages continuous occurrence data to describe where and when viewers might be able to find a species.

#caricare l'esempio con la funzione "data"
data("fiespa_occ")
fiespa_occ # stack di raster

# 1) Creare le metriche
met1<-metrics_pull(fiespa_occ) #This function transforms rasterstack values describing individual distributions or species distributions into standardized intensity values.
print(met1)

# 2) Creare le Palette
pal<- palette_timecycle(fiespa_occ)
head(pal)   #we use head () to return the first values. "Pal" has 1212 objects, with head for example we take the first 6

# 3) Creare la Mappa Multipla
map_multiples(met1, pal, ncol = 3, labels = names (fiespa_occ)) # mappa multipla(metrica, palette, numero colonne, nome del dato)

# per estrarre una mappa singola; layer = numero del layer
map_single(met1, pal, layer = 6)

# per manipolare le mappe, cambiando i colori
p1_custom<- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, ncol = 4, labels = names (fiespa_occ))

# Metrica
met1_distill<-metrics_distill(fiespa_occ)
map_single(met1_distill,pal) #We then display the information in the single image with the "distilled" images and the palette created previously
# le parti più colorate indicano hanno + alta specificità (la specie si trova lì in primavera/estate/inverno/ecc)
# le parti grigie sono meno specifiche: si può trovare la specie in qualsiasi periodo dell'anno

# 4) Creare la legenda
legend_timecycle(pal, origin_label = "jan 1")

### Come mappare un individuo nel tempo circolare
#Here we explore how a Fisher individual (Pekania pennanti), who lives in upstate New York, moved into his local environment over a period of nine sequential nights in 2011.

# caricare i dati
data("fisher_ud")   
fisher_ud

#creare la metrica
m2<-metrics_pull(fisher_ud)
m2

#creare una nuova palette, nel tempo lineare (non annuale)
pal2<-palette_timeline(fisher_ud)
head(pal2)

#creare la mappa multipla
map_multiples(m2, pal2, ncol = 3)

# il fattore lambda_i = -12 aumenta l'opacità, rendendo le mappe + visibili
map_multiples(m2,ncol = 3, pal2, lambda_i = -12)

#
m2_distill<-metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -10)

#creazione legenda
legend_timeline(pal2,time_labels = c("2 aprile", "11 aprile"))

# Per controllare il codice: https://github.com/Ludovico-Chieffallo/Lessons






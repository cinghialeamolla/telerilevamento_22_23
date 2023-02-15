#Qui sotto il codice oggetto di esame

#dati.nc: il formato dei dati copernicus è nc, e per analizzarli occorre istallare alcuni pacchetti su R

# ncdf4 è un pacchetto che fornisce un'interfaccia per i file di dati in formato Unidata netCDF
# la funzione sottostante si usa per istallare dei pacchetti esterni a R, dal CRAN.
#install.packages("ncdf4") #https://cran.r-project.org/web/packages/ncdf4/index.html

#sp è un pacchetto per i dati spaziali
#install.packages("sp") #http://cran.nexr.com/web/packages/sp/index.html

#Queste funzioni richiamano i pacchetti usati per le analisi
library(ncdf4)
library(raster)

#"setwd" si usa per il settaggio della cartella di lavoro 
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

#ho scaricato due file della temperatura della superficie terrestre (Land Surface Temperature), del 24 agosto 2010 e del 24 agosto 2020, allo stesso orario (14:00)
#Fonte dati: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

#questa funzione (rinomina e) carica il dataset
lst_2010 <- raster("LST_08_2010.nc")  

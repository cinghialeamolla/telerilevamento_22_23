#Create new function

#1 
cheer_me <- function(your_name) {

    cheer_string <- paste("Hello", your_name, sep = " ")
    print(cheer_string)
 
}
cheer_me("Pamela")

#2
cheer_me_n_times <- function(your_name, n) {

    cheer_string <- paste("Hello", your_name, sep = " ")

    for(i in seq(1, n)) {
        print(cheer_string)
    }
}

cheer_me_n_times(n=3, your_name="Pamela")
cheer_me_n_times("Pamela", 3)

#settare la cartella di lavoro
# setwd("~/lab/") # Linux
setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac
library(raster)
dato <- raster("sentinel.png")
plot(dato)

plot_raster <- function(r, col=
                        NA) {
    if(!is.na(col)) {
        pal <- colorRampPalette(col)(100)
        plot(r, col=pal)
        } else {
        plot(r)
        }
    }
plot_raster(dato, c("brown", "yellow", "green"))
    


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





#Code to assemble Fig3 sup3 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)

# assemble figure ---------------------------------------------------------
panel_3D <- ggdraw() + draw_image(readPNG("pictures/NITdomain_3D.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig3_sup3 <- panel_3D + 
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig3_sup3

ggsave("figures/Fig3_sup3.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup3, width = 2400, height = 1600, bg='white')  

ggsave("figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700)  

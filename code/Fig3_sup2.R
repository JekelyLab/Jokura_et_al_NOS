#Code to assemble Fig3 sup2 of the Jokura et al Platynereis NOS paper
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
panel_MLD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_AP_NITGC1_MLD_112.55um.png"))
panel_NIT1andNOS <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS-RAT1_acTub_AP_2_Airyscan Processing-Orthogonal Projection-11_c1-3_71.46um.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AB
"

Fig3_sup2 <- panel_MLD + panel_NIT1andNOS +
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig3_sup2

ggsave("figures/Fig3_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup2, width = 2400, height = 1500, bg='white')  

ggsave("figures/Fig3_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup2, width = 2350, height = 1700)  

#Code to assemble Fig3 sup1 of the Jokura et al Platynereis NOS paper
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
panel_A <- ggdraw() + draw_image(readPNG("pictures/FINALSeq_NOS_cdhit080_one_Lopho_3rd.fasta.alngapp.fasta.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig3_sup1 <- panel_A + 
  patchwork::plot_layout(design = layout) #we can change the heights of the rows in our layout (widths also can be defined)


ggsave("figures/Fig3_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700, bg='white')  

ggsave("figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700)  

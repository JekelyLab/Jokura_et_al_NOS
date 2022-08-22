#Code to assemble Fig3 sup4 of the Jokura et al Platynereis NOS paper
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
panel_A <- ggdraw() + draw_image(readPNG("pictures/NITGC_domain_structure.png"))
panel_B <- ggdraw() + draw_image(readPNG("pictures/NITGC&GreencGull_expression.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
ABC
"

Fig3_sup4 <- panel_A + plot_spacer() + panel_B + 
  patchwork::plot_layout(design = layout, widths = c(1, 0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig3_sup4

ggsave("figures/Fig3_sup4.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup4, width = 2400, height = 1000, bg='white')  

ggsave("figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700)  

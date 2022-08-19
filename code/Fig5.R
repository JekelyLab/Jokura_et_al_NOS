rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)


# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_A <- ggdraw() + draw_image(readPNG("pictures/scRNAseq_forR_4.png"))
panel_B <- ggdraw() + draw_image(readPNG("pictures/graph-2_2.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AB
"

Fig5 <- panel_A + panel_B + 
  patchwork::plot_layout(design = layout, widths = c(1, 2.5)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

Fig5

ggsave("figures/Fig5.png", limitsize = FALSE, 
       units = c("px"), Fig5, width = 2400, height = 2400, bg='white')  

ggsave("figures/Fig5.pdf", limitsize = FALSE, 
       units = c("px"), Fig5, width = 2350, height = 1700)  
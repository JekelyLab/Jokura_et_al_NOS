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
panel_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS_acTub_AP_1_58.87um.png"))+
  draw_label("IHC", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT1", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_label("ac-tub", x = 0.3, y = 0.85, color='blue',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_NOS <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS_acTub_AP_2_58.87um.png"))+
  draw_label("IHC", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.7, y = 0.45, color='green',size = 12, fontface='bold') +
  draw_label("ac-tub", x = 0.3, y = 0.85, color='blue',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_NIT1_NOS <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS_acTub_AP_3_58.87um.png"))+
  draw_label("IHC", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT1", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_label("NOS", x = 0.7, y = 0.45, color='green',size = 12, fontface='bold') +
  draw_label("ac-tub", x = 0.3, y = 0.85, color='blue',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
"

Fig3_sup3 <- panel_NIT1 + panel_NOS + panel_NIT1_NOS +
  patchwork::plot_layout(design = layout, widths = c(1,0.01,1,0.01, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold', color='black')) #or 'bold', 'italic'


ggsave("figures/Fig3_sup3.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup3, width = 2400, height = 920, bg='white')  

ggsave("figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700)  

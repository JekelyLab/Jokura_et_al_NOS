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
panel_NIT1 <- ggdraw() + draw_image(readPNG("pictures/HCR_51_DV_NITGC1_MLD_DAPI_1_112.55µm.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT1", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_MLD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_DV_NITGC1_MLD_DAPI_2_112.55µm.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("MLD", x = 0.3, y = 0.85, color='green',size = 12, fontface='bold')  +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_NIT1_MLD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_DV_NITGC1_MLD_DAPI_112.55µm.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT1", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_label("MLD", x = 0.3, y = 0.85, color='green',size = 12, fontface='bold')  +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_NIT2 <- ggdraw() + draw_image(readPNG("pictures/2d_647-NIT-GC2_546-c-opsin1_AP_N_106.62um.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT2", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') + 
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_cop1 <- ggdraw() + draw_image(readPNG("pictures/2d_647-NIT-GC2_546-c-opsin1_AP_c_106.62um.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("c-opsin1", x = 0.3, y = 0.85, color='green',size = 12, fontface='bold')  +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_NIT2_cop1 <- ggdraw() + draw_image(readPNG("pictures/2d_647-NIT-GC2_546-c-opsin1_AP_106.62um.png"))+
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 10) +
  draw_label("NIT2", x = 0.55, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_label("c-opsin1", x = 0.3, y = 0.85, color='green',size = 12, fontface='bold')  +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
#####
D#E#F
"

Fig3_sup2 <- panel_NIT1 + panel_MLD + panel_NIT1_MLD + panel_NIT2 + panel_cop1 + panel_NIT2_cop1 +
  patchwork::plot_layout(design = layout, widths = c(1, 0.01, 1, 0.01, 1), heights = c(1, 0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold', color='black')) #or 'bold', 'italic'


ggsave("figures/Fig3_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup2, width = 2400, height = 1800, bg='white') 

ggsave("figures/Fig3_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup2, width = 2350, height = 1700)  

#Code to assemble Fig1 sup2 of the Jokura et al Platynereis NOS paper
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
arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.75, y2 = 0.85)
panel_NOS3d_ventr_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR_72_DV_NOS_90um.png")) +
  draw_label("in situ HCR", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.9, color="cyan", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.26), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.15, y = 0.11, color = "white", size = 8) +
  draw_label("A", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("P", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_label("eyespots", x = 0.55, y = 0.68, size = 5, color = "white") +
  draw_line(x = c(0.3, 0.45), y = c(0.63, 0.67), color = "white", size = 0.1) +
  draw_line(x = c(0.77, 0.66), y = c(0.65, 0.67), color = "white", size = 0.1) +
  draw_label("adult eyes", x = 0.55, y = 0.34, size = 5, color = "white") +
  draw_line(x = c(0.26, 0.44), y = c(0.43, 0.35), color = "white", size = 0.1) +
  draw_line(x = c(0.77, 0.65), y = c(0.43, 0.35), color = "white", size = 0.1) +
  draw_label("INNOS", x = 0.53, y = 0.45, color="white", size = 5, fontface="bold")


panel_NOS3d_ant_HCR <- ggdraw() + draw_image(readPNG("pictures/HCR_72_AP_NOS_89.25um.png")) +
  draw_label("in situ HCR", x = 0.3, y = 0.99, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.9, color="cyan", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.264), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_image(readPNG("pictures/HCR_48_DV_NOS_15.68um_insert.png"), 
             scale = 0.35, x = 1, hjust = 1, halign = 1, valign = 0.12) +
  draw_label("adult eyes", x = 0.5, y = 0.7, size = 5, color = "white") +
  draw_line(x = c(0.23, 0.41), y = c(0.65, 0.7), color = "white", size = 0.1) +
  draw_line(x = c(0.59, 0.77), y = c(0.7, 0.67), color = "white", size = 0.1) +
  draw_label("eyespot", x = 0.25, y = 0.37, size = 5, color = "white") +
  draw_label("INNOS_dl", x = 0.73, y = 0.36, size = 4, color = "white") +
  draw_label("INNOS_vl", x = 0.92, y = 0.09, size = 4, color = "white") +
  draw_label("INNOS", x = 0.51, y = 0.52, color="white", size = 5, fontface="bold")


panel_NOS3d_ant_HCR_IHC <- ggdraw() + draw_image(readPNG("pictures/HCR_IHC_75_NOS_acTub_AP_3_high_46.18um.png")) +
  draw_label("in situ HCR + IHC", x = 0.1, y = 0.99, size = 10, hjust = 0) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 11, fontface="italic") +
  draw_label("acTub", x = 0.33, y = 0.9, color="green", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.26), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("10 ", mu, "m")), x = 0.15, y = 0.11, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_label("cPRC", x = 0.54, y = 0.88, size = 6, color = "white") +
  draw_line(x = c(0.33, 0.47), y = c(0.81, 0.87), color = "white", size = 0.2) +
  draw_line(x = c(0.6, 0.71), y = c(0.87, 0.84), color = "white", size = 0.2)



#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
"

Fig1_sup2 <- panel_NOS3d_ventr_HCR + panel_NOS3d_ant_HCR + panel_NOS3d_ant_HCR_IHC +
  patchwork::plot_layout(design = layout, widths = c(1, 0.02, 1, 0.02, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


ggsave("Manuscript/figures/Fig1_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig1_sup2, width = 1800, height = 688, bg='white') 

ggsave("Manuscript/figures/Fig1_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig1_sup2, width = 1800, height = 688)  

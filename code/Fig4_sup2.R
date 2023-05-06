#Code to assemble Fig4 sup2 of the Jokura et al Platynereis NOS paper
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

panel_NIT1_MLD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_AP_NITGC1_MLD_DAPI_112.55µm.png"))+
  draw_label("in situ HCR", x = 0.25, y = 0.96, size = 10) +
  draw_label("NIT-GC1", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="italic") +
  draw_label("MLD", x = 0.31, y = 0.87, color="green", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.48, y = 0.87, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.22), y = c(0.11, 0.11), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.13, y = 0.14, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)

panel_72_AP_NIT2 <- ggdraw() + draw_image(readPNG("pictures/HCR_72_AP_NIT_93.98um.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.96, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.87, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.25), y = c(0.11, 0.11), color = "white", size = 0.5)

panel_72_DV_NIT2 <- ggdraw() + draw_image(readPNG("pictures/HCR_72_DV_NIT_180.08um.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.96, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.87, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.31), y = c(0.11, 0.11), color = "white", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.175, y = 0.14, color = "white", size = 8) +
  draw_label("A", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("P", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)


panel_NIT1MO_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_51_AP_NIT1MO_NITGC1_actub_56.82um.png")) +
  draw_label("IHC:", x = 0.15, y = 0.96, size = 10) +
  draw_label(expression(paste(italic("NIT-GC1"))), x = 0.32, y = 0.96, size = 10) +
  draw_label("morpholino", x = 0.57, y = 0.96, size = 10) +
  draw_label("NIT-GC1", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.33, y = 0.87, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.39), y = c(0.11, 0.11), color = "white", size = 0.5)

panel_NIT2MO_NIT2 <- ggdraw() + draw_image(readPNG("pictures/IHC_57_AP_NIT2MO_NITGC2_actub_57um.png")) +
  draw_label("IHC:", x = 0.15, y = 0.96, size = 10) +
  draw_label(expression(paste(italic("NIT-GC2"))), x = 0.32, y = 0.96, size = 10) +
  draw_label("morpholino", x = 0.57, y = 0.96, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.33, y = 0.87, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.39), y = c(0.11, 0.11), color = "white", size = 0.5)

panel_NIT1_NOS <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS_acTub_AP_3_58.87um.png")) +
  draw_label("IHC", x = 0.12, y = 0.96, size = 10) +
  draw_label("NIT-GC1", x = 0.12, y = 0.87, color="magenta", size = 10, fontface="plain") +
  draw_label("NOS", x = 0.33, y = 0.87, color="green", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.52, y = 0.87, color="blue", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.38), y = c(0.11, 0.11), color = "white", size = 0.5)




#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
D#E#F
"

Fig4_sup2 <- panel_NIT1_MLD + panel_72_AP_NIT2 + panel_72_DV_NIT2 +
  panel_NIT1_NOS + panel_NIT1MO_NIT1 + panel_NIT2MO_NIT2 + 
  patchwork::plot_layout(design = layout, widths = c(1, 0.02, 1, 0.02, 1), 
                         heights = c(1, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig4_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 2400, height = 1900, bg='white') 

ggsave("Manuscript/figures/Fig4_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 2350, height = 1700)  

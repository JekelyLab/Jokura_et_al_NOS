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

panelA <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_2d_acTub_XXum.png"))
panelB <- ggdraw() + draw_image(readPNG("pictures/NOS-promotor_3d_acTub_XXum.png"))
panelC <- ggdraw() + draw_image(readPNG("pictures/ssTEM_INNOS_vr_vl.png"))
panelD <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NOS_actub_55.92um.png"))
panelE <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um.png"))
panelF <- ggdraw() + draw_image(readPNG("pictures/CATMAID_graph.png"))

#combine panels into Figure and save final figure as pdf and png
Fig1 <- plot_grid(panelA,panelB,panelC,panelD,panelE,panelF,
                  ncol=3,
                  rel_widths = c(1, 1, 1, 1, 1, 1),
                  labels=c("A","B","C","D","E","F"),
                  label_size = 18, label_y = 1, label_x = 0,
                  label_fontfamily = "sans", label_fontface = "plain") + 
  theme(plot.margin = unit(c(1, 1, 1, 1, 1, 1), units = "pt"))

Fig1

ggsave("figures/Fig1.png", limitsize = FALSE, units = c("px"), Fig1, bg='white')




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

panelA <- ggdraw() + draw_image(readPNG("pictures/220518_phylogeny.png"))
panelB <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NITGC1_actub_52.24um.png"))
panelC <- ggdraw() + draw_image(readPNG("pictures/HCR_RT28_AP_NITGC1_c-opsin1_112.55um.png"))
panelD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_AP_NITGC1_MLD_112.55um.png"))
panelE <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC1_actub_58.47um.png"))
panelF <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC2_actub_60.77um.png"))
panelG <- ggdraw() + draw_image(readPNG("pictures/IHC_51_AP_NOS_actub_61.25um.png"))

#combine panels into Figure and save final figure as pdf and png
Fig3 <- panelA | (panelB/panelD/panelF|panelC/panelE/panelG) 

Fig3 <- Fig3 + plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(size = 5))

Fig3

ggsave("figures/Fig3.png", limitsize = FALSE, units = c("px"), Fig3, bg='white')




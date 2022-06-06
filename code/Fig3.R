#Code to assemble Fig3 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_HCR_NIT1 <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NITGC1_actub_52.24um.png"))
panel_HCR_NIT1_cOps <- ggdraw() + draw_image(readPNG("pictures/HCR_RT28_AP_NITGC1_c-opsin1_112.55um.png"))
panel_HCR_NIT1_RY <- ggdraw() + draw_image(readPNG("pictures/HCR_51_AP_NITGC1_MLD_112.55um.png"))
panel_IHC_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC1_actub_58.47um.png"))
panel_IHC_NIT2 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC2_actub_60.77um.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C#D
E#F####
"

Fig3 <- panel_HCR_NIT1 + panel_HCR_NIT1_cOps + panel_IHC_NIT1 + panel_IHC_NIT2 + 
  panel_HCR_NIT1_cOps + panel_HCR_NIT1_RY +
  patchwork::plot_layout(design = layout, 
                         widths = c(1,0.02,1,0.02,1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

ggsave("figures/Fig3.png", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2400, height = 1600, bg='white')  

ggsave("figures/Fig3.pdf", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2350, height = 1700)  



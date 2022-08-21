#Code to assemble Fig1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")

# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/IHC_54_AP_NOS_actub_71.46um.png"))
panel_B <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AB
"

Fig1_sup2 <- panel_A + panel_B +
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig1_sup2

ggsave("figures/Fig1_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig1_sup2, width = 2350, height = 1700, bg='white')  

ggsave("figures/Fig1_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig1_sup2, width = 2350, height = 1700)  

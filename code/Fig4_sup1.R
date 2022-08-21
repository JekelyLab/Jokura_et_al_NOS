#Code to assemble Fig4 sup1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")

# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))
panel_B <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_GCaMP6s.png"))
panel_C <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_RGWa.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

Fig4_sup1 <- panel_A - (panel_B + panel_C) +
  patchwork::plot_layout(ncol = 1, heights = c(1,2.5)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig4_sup1

ggsave("figures/Fig4_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2350, height = 1700, bg='white')  

ggsave("figures/Fig4_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2350, height = 1700)  

#Code to assemble Fig4 sup2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")

# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))
panel_B <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_GCaMP6s.png"))
panel_C <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_RGWa.png"))
panel_D <- ggdraw() + draw_image(readPNG("pictures/n52hpf_WT_a-2_ROI60_PD1.54_power1_pin216.9_frame_201-241_401-441_co_cPRC.png"))
panel_E <- ggdraw() + draw_image(readPNG("pictures/n52hpf_WT_a-2_ROI60_PD1.54_power1_pin216.9_frame_201-241_401-441_co_NOS.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

Fig4_sup2 <- {((panel_A / (panel_B|panel_C))/(panel_D|panel_E))} +
  patchwork::plot_layout(nrow = 3, heights = c(1,2.25, 2.25)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

ggsave("figures/Fig4_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 2400, height = 3200, bg='white')  

ggsave("figures/Fig4_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 2350, height = 1700)  

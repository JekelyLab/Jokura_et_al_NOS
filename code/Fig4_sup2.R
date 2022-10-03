#Code to assemble Fig4 sup2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")

# assemble figure ---------------------------------------------------------
panel_method <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))

panel_calcium <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_GCaMP6s.png"))+
  draw_label("calcium imaging", x = 0.3, y = 0.99, size = 10) +
  draw_label("GCaMP6s", x = 0.18, y = 0.9, color='white', size = 12, fontface='bold') +
  draw_line(x = c(0.5, 0.95), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.725, y = 0.13, color = "white", size = 10)

panel_immunostain <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_RGWa.png"))+
  draw_label("confocal imaging", x = 0.3, y = 0.99, size = 10) +
  draw_label("nucleus", x = 0.15, y = 0.9, color='cyan', size = 12, fontface='bold') +
  draw_label("postsynaptic cells", x = 0.31, y = 0.83, color='red',size = 12, fontface='bold') +
  draw_label("Ser-h1", x = 0.9, y = 0.75, color='white', size = 9, fontface='plain') +
  draw_label("IN-RGW", x = 0.35, y = 0.35, color='white',size = 9, fontface='plain') +
  draw_line(x = c(0.5, 0.95), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.725, y = 0.13, color = "white", size = 10)

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AAA
B#C
"

Fig4_sup2 <- panel_method + panel_calcium + panel_immunostain +
  patchwork::plot_layout(design = layout, 
                         widths = c(1,0.02,1),
                         heights = c(0.5,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold', color='black')) #or 'bold', 'italic'

ggsave("figures/Fig4_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 1600, height = 1320, bg='white')  

ggsave("figures/Fig4_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 2350, height = 1700)  

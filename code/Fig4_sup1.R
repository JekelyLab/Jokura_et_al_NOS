#Code to assemble Fig4 sup1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_Catmaid_connection.R")

# assemble figure ---------------------------------------------------------
panel_DAF <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_134.95um.png")) +
  draw_label("DAF-FM", x = 0.15, y = 0.9, color='green',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.42), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_DAF_RGECO <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_RGECO_134.95um.png")) +
  draw_label("RGECO1a", x = 0.5, y = 0.9, color='magenta', size = 12, fontface='bold') +
  draw_label("DAF-FM", x = 0.15, y = 0.9, color='green',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.42), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_enlarge <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_RGECO_highmag_56.04um.png")) +
  draw_label("RGECO1a", x = 0.5, y = 0.9, color='magenta', size = 12, fontface='bold') +
  draw_label("cPRC", x = 0.7, y = 0.67, color='magenta', size = 12, fontface='bold') +
  draw_label("DAF-FM", x = 0.15, y = 0.9, color='green',size = 12, fontface='bold') +
  draw_label("IN-NOS", x = 0.7, y = 0.45, color='white',size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
"

Fig4_sup1 <- panel_DAF + panel_DAF_RGECO + panel_enlarge +
  patchwork::plot_layout(design = layout, widths = c(1, 0.02, 1, 0.02, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold', color='black')) #or 'bold', 'italic'

ggsave("figures/Fig4_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2400, height = 900, bg='white')  

ggsave("figures/Fig4_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2350, height = 1700)  

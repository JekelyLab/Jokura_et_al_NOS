#Code to assemble Fig6 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_scRNA_dotplot <- ggdraw() + draw_image(readPNG("pictures/scRNAseq_forR_4.png"))
panel_model <- ggdraw() + draw_image(readPNG("pictures/model.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B
"

Fig6 <- panel_scRNA_dotplot + panel_model +
  patchwork::plot_layout(design = layout, 
                         widths = c(1, 0.05, 2)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold')) #or 'bold', 'italic'

ggsave("figures/Fig6.png", limitsize = FALSE, 
       units = c("px"), Fig6, width = 2400, height = 1000, bg='white')  

ggsave("figures/Fig6.pdf", limitsize = FALSE, 
       units = c("px"), Fig6, width = 2350, height = 1700)  
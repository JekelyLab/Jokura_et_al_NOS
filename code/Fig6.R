#Code to assemble Fig6 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_scRNA_dotplot <- ggdraw() + draw_image(readPNG("pictures/scRNAseq.png"))
panel_model <- ggdraw() + draw_image(readPNG("pictures/model_2.png"))

panel_fitting <- ggdraw() + draw_image(readPNG("pictures/fitting_data.png"))
panel_block_diagram <- ggdraw() + draw_image(readPNG("pictures/fitting_data_block_diagram.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B
###
C#D
"

Fig6 <-panel_block_diagram + panel_fitting + 
  panel_scRNA_dotplot + panel_model + 
  patchwork::plot_layout(design = layout, 
                         heights = c(1, 0.05, 1),
                         widths = c(1,0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig6.png", limitsize = FALSE, 
       units = c("px"), Fig6, width = 1800, height = 2200, bg='white')  

ggsave("Manuscript/figures/Fig6.pdf", limitsize = FALSE, 
       units = c("px"), Fig6, width = 1800, height = 2200)  

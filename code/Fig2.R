#Code to assemble Fig2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_Architecture <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png"))
panel_2dpf <- ggdraw() + draw_image(readPNG("pictures/2dpf_wt_vs_NOS_mutants_for_discussion_1.png"))
panel_3dpf <- ggdraw() + draw_image(readPNG("pictures/3dpf_wt_vs_NOS_mutants_for_discussion.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
ABC
"

Fig2 <- panel_Architecture + panel_2dpf + panel_3dpf +
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

ggsave("figures/Fig2.png", limitsize = FALSE, 
       units = c("px"), Fig2, width = 2400, height = 600, bg='white')  

ggsave("figures/Fig2.pdf", limitsize = FALSE, 
       units = c("px"), Fig2, width = 2350, height = 1700)  




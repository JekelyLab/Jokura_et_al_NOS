#Code to assemble Fig5 sup1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------
panel_method <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig5_sup1 <- panel_method + 
  patchwork::plot_layout(design = layout) #we can change the heights of the rows in our layout (widths also can be defined)


ggsave("Manuscript/figures/Fig5_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig5_sup1, width = 1857, height = 970, bg='white')  

ggsave("Manuscript/figures/Fig5_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig5_sup1, width = 1857, height = 970)  

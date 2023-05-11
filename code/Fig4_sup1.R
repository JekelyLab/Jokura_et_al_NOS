#Code to assemble Fig4 sup1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/FINALSeq_NITGC_allseq_mbGC_sGC_CLAN.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig4_sup1 <- panel_A + 
  patchwork::plot_layout(design = layout) #we can change the heights of the rows in our layout (widths also can be defined)


ggsave("Manuscript/figures/Fig4_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2400, height = 1900, bg='white') 

ggsave("Manuscript/figures/Fig4_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup1, width = 2400, height = 1900)  




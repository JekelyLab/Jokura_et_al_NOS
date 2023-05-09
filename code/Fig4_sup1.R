#Code to assemble Fig4 sup2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/FINALSeq_NITGC_allseq_mbGC_sGC_CD80_plus_Lopho.fasta.alngapp.fasta.treefile.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig4_sup2 <- panel_A + 
  patchwork::plot_layout(design = layout) #we can change the heights of the rows in our layout (widths also can be defined)


ggsave("figures/Fig4_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 1500, height = 2100, bg='white')  

ggsave("figures/Fig4_sup2.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup2, width = 1500, height = 2100)  

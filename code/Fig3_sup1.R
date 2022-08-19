#Code to assemble Fig1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely



# assemble figure ---------------------------------------------------------
panel_A <- ggdraw() + draw_image(readPNG("pictures/NITGC_allseq_mbGC_sGC_CD80_plus_Lopho.fasta.alngapp.fasta.treefile.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A
"

Fig3_sup1 <- panel_A + 
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain', color='black')) #or 'bold', 'italic'

Fig3_sup1

ggsave("figures/Fig3_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700, bg='white')  

ggsave("figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 2350, height = 1700)  

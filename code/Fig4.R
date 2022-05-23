rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)


# assemble figure ---------------------------------------------------------

#read png convert to image panel

panelA <- ggdraw() + draw_image(readPNG("pictures/NITGC1_cGMPassay.png"))
panelB <- ggdraw() + draw_image(readPNG("pictures/cGMP_assay_PNG.png"))
panelC <- ggdraw() + draw_image(readPNG("pictures/NITGC1_analysis.png"))


#combine panels into Figure and save final figure as pdf and png
Fig4 <- plot_grid(panelA,panelB,panelC,
                  ncol=1,
                  rel_widths = c(1, 1, 1),
                  labels=c("A","B","C"),
                  label_size = 18, label_y = 1, label_x = 0,
                  label_fontfamily = "sans", label_fontface = "plain") + 
  theme(plot.margin = unit(c(1, 1, 1), units = "pt"))


Fig4 <- (panelA | panelC) / panelB 

Fig4 <- Fig4 + plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(size = 15))

Fig4

ggsave("figures/Fig4.png", limitsize = FALSE, units = c("px"), Fig4, bg='white')




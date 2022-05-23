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

panelA <- ggdraw() + draw_image(readPNG("pictures/closure period.png"))
panelB <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png"))
panelC <- ggdraw() + draw_image(readPNG("pictures/2dpf_wt_vs_NOS_mutants_for_discussion_1.png"))
panelD <- ggdraw() + draw_image(readPNG("pictures/3dpf_wt_vs_NOS_mutants_for_discussion.png"))


#combine panels into Figure and save final figure as pdf and png
Fig2 <- plot_grid(panelA,panelB,panelC,panelD,
                  ncol=2,
                  rel_widths = c(1, 1, 1, 1),
                  labels=c("A","B","C","D"),
                  label_size = 18, label_y = 1, label_x = 0,
                  label_fontfamily = "sans", label_fontface = "plain") + 
  theme(plot.margin = unit(c(1, 1, 1, 1), units = "pt"))

Fig2

ggsave("figures/Fig2.png", limitsize = FALSE, units = c("px"), Fig2, bg='white')




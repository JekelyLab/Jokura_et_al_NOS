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
panelA <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um.png")) + 
  draw_label("RYa-pNP", x = 0.125, y = 0.95, fontfamily = "sans", fontface = "italic",
             color = "green", size = 25, angle = 0, lineheight = 1, alpha = 1,hjust = 0)
  
  
  
  draw_label("NOS", x = 0.125, y = 0.9, fontfamily = "sans", fontface = "italic",
             color = "magenta", size = 25, angle = 0, lineheight = 1, alpha = 1,hjust = 0)+
  annotate("segment", x=0.7, xend=0.85, y=0.05, yend=0.05, size=2, color= "white")

panelA

Fig1_panelA <- ggdraw() + draw_image(panelA, scale = 1)

panelB <- ggdraw() + draw_image(img2)

+ 
  draw_line(x = c(0.1, 0.3), y = c(0.07, 0.07), color = "black", size = 1)

?ggdraw

ggsave("figures/Figure1_panelA.png", scale = 1, width = 800, height = 800, panelA, 
       limitsize = FALSE, units = c("px"), bg = "white")
Fig1_panelA <- readPNG("figures/Figure1_panelA.png")
Fig1_panelA

?ggsave



panelB <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NOS_actub_55.92um.png"), scale = 1) + 
  draw_label("ac-tub", x = 0.125, y = 0.95, fontfamily = "sans", fontface = "italic",
             color = "green", size = 25, angle = 0, lineheight = 1, alpha = 1,hjust = 0)+
  draw_label("NOS", x = 0.125, y = 0.9, fontfamily = "sans", fontface = "italic",
             color = "magenta", size = 25, angle = 0, lineheight = 1, alpha = 1,hjust = 0)+
  annotate("segment", x=0.7, xend=0.85, y=0.05, yend=0.05, size=2, color= "white")

Fig1 <- panelA + panelB

Fig1

ggsave("figures/Figure1_panelB.png", limitsize = FALSE, panelB, bg = "white")
Fig1_panelB <- draw_image(readPNG("figures/Figure1_panelB.png"), scale = 1)

Fig1_panelA | Fig1_panelB

Fig1 <- (Fig1_panelA | Fig1_panelB)

Fig1



#save
ggsave("figures/Figure1.pdf", limitsize = FALSE, 
         units = c("px"), Fig1, width = 1800, height = 850)
ggsave("figures/Figure1.png", limitsize = FALSE, 
         units = c("px"), Fig1, width = 1800, height = 850, bg='white')




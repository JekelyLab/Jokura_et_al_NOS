#Code to assemble Fig4 sup3 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)


# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

immuno_NIT <- read_csv("data/Immuno_intensity.csv")

# morpholino vs control, immunostaining intensity analysis ---------------------

immuno_NIT %>% 
  ggplot() +
  aes(x = type, y = `relative intensity`, fill = type) +
  geom_boxplot(aes(fill = type), alpha = .8, outlier.shape = NA) +
  geom_dotplot(aes(fill = type),
               binaxis = "y", 
               stackdir = "center", 
               dotsize = 1.2, 
               color = "black", 
               alpha = 0.5,
               binwidth = 0.01) +
  scale_fill_manual(
    values = c(cont1 = "gray",
               NIT1MO1 = Okabe_Ito[3],
               NIT1MO2 = Okabe_Ito[7],
               cont2 = "gray",
               NIT2MO1 = Okabe_Ito[2],
               NIT2MO2 = Okabe_Ito[6])) +
  scale_x_discrete(labels = c("cont1" = "control", 
                              "NIT1MO1" = "MO1", 
                              "NIT1MO2" = "MO2",
                              "cont2" = "control",
                              "NIT2MO1" = "MO1", 
                              "NIT2MO2" = "MO2")) +
  theme_minimal() +
  ylab("relative fluorescence intensity") +
  xlab(NULL) +
  ylim(0,0.62) +
  theme(legend.position = "none",
        strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 13),
        axis.title.x = element_text(size = 15), 
        axis.title.y = element_text(size = 15), 
        axis.text.x = element_text(size = 11), 
        axis.text.y = element_text(size = 12)) +
  facet_wrap(vars(signal), 
             scales = "free_x",
             strip.position = "bottom") +
  geom_text(x = 1.5, y = 0.55, label = "***") +
  geom_segment(x = 1, xend = 1, y = 0.52, yend = 0.54) +
  geom_segment(x = 1, xend = 2, y = 0.54, yend = 0.54) +
  geom_segment(x = 2, xend = 2, y = 0.52, yend = 0.54) +
  geom_text(x = 2, y = 0.59, label = "***") +
  geom_segment(x = 1, xend = 1, y = 0.56, yend = 0.58) +
  geom_segment(x = 1, xend = 3, y = 0.58, yend = 0.58) +
  geom_segment(x = 3, xend = 3, y = 0.56, yend = 0.58)

#Dunnett
NIT1 <- immuno_NIT %>% 
  filter((signal %in% c("NIT-GC1")))
vx_NIT1 = factor(NIT1$type)
y_NIT1 = NIT1$`relative intensity`
summary(glht(aov(y_NIT1 ~ vx_NIT1),
             linfct = mcp(vx_NIT1 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)    
#NIT1MO1 - cont1 == 0 -0.28386    0.01868  -15.20 3.16e-10 ***
#NIT1MO2 - cont1 == 0 -0.28321    0.01868  -15.16 3.27e-10 ***

#Dunnett
NIT2 <- immuno_NIT %>% 
  filter((signal %in% c("NIT-GC2")))
vx_NIT2 = factor(NIT2$type)
y_NIT2 = NIT2$`relative intensity`
summary(glht(aov(y_NIT2 ~ vx_NIT2),
             linfct = mcp(vx_NIT2 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)    
#NIT2MO1 - cont2 == 0 -0.40423    0.01431  -28.24   <1e-10 ***
#NIT2MO2 - cont2 == 0 -0.40460    0.01431  -28.27   <1e-10 ***


# save to source data-------------------------------------------------------

#df_L_NAME_tracking %>%
#  write_csv("source_data/Figure3_supplement1_source_data6.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/immuno_NIT.png", limitsize = FALSE, 
       units = c("px"), width = 1400, height = 1600, bg='white')


# assemble figure ---------------------------------------------------------
arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.8, y2 = 0.9)

panel_NIT1_MLD <- ggdraw() + draw_image(readPNG("pictures/HCR_51_AP_NITGC1_MLD_DAPI_112.55µm.png"))+
  draw_label("in situ HCR", x = 0.25, y = 0.995, size = 10) +
  draw_label("NIT-GC1", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="italic") +
  draw_label("MLD/pedal peptide 2", x = 0.26, y = 0.85, color="green", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.91, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.218), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.13, y = 0.11, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.93, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.77, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)

panel_72_AP_NIT2 <- ggdraw() + draw_image(readPNG("pictures/HCR_72_AP_NIT_93.98um.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.995, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.91, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.252), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.13, y = 0.11, color = "white", size = 8) 
  

panel_72_DV_NIT2 <- ggdraw() + draw_image(readPNG("pictures/HCR_72_DV_NIT_180.08um.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.995, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.32, y = 0.91, color="cyan", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.317), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.175, y = 0.11, color = "white", size = 8) +
  draw_label("A", x = 0.95, y = 0.93, size = 6, color = "white") +
  draw_label("P", x = 0.95, y = 0.77, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)


panel_NIT1MO_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_51_AP_NIT1MO_NITGC1_actub_56.82um.png")) +
  draw_label("IHC:", x = 0.15, y = 0.995, size = 10) +
  draw_label(expression(paste(italic("NIT-GC1"))), x = 0.32, y = 0.995, size = 10) +
  draw_label("morpholino", x = 0.57, y = 0.995, size = 10) +
  draw_label("NIT-GC1", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.33, y = 0.91, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.392), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.21, y = 0.11, color = "white", size = 8)

panel_NIT2MO_NIT2 <- ggdraw() + draw_image(readPNG("pictures/IHC_57_AP_NIT2MO_NITGC2_actub_57um.png")) +
  draw_label("IHC:", x = 0.15, y = 0.995, size = 10) +
  draw_label(expression(paste(italic("NIT-GC2"))), x = 0.32, y = 0.995, size = 10) +
  draw_label("morpholino", x = 0.57, y = 0.995, size = 10) +
  draw_label("NIT-GC2", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.33, y = 0.91, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.392), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.21, y = 0.11, color = "white", size = 8) 

panel_immuno <- ggdraw() + draw_image(readPNG("pictures/immuno_NIT.png"))

#panel_NIT1_NOS <- ggdraw() + draw_image(readPNG("pictures/IHC_55_NIT1_NOS_acTub_AP_3_58.87um.png")) +
#  draw_label("IHC", x = 0.12, y = 0.995, size = 10) +
#  draw_label("NIT-GC1", x = 0.12, y = 0.91, color="magenta", size = 10, fontface="plain") +
#  draw_label("NOS", x = 0.33, y = 0.91, color="green", size = 10, fontface="plain") +
#  draw_label("acTub", x = 0.52, y = 0.91, color="blue", size = 10, fontface="plain") +
#  draw_line(x = c(0.04, 0.38), y = c(0.08, 0.08), color = "white", size = 0.5)




#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
#####
D#E#F
"

Fig4_sup3 <- panel_NIT1_MLD + panel_72_AP_NIT2 + panel_72_DV_NIT2 +
  panel_NIT1MO_NIT1 + panel_NIT2MO_NIT2 + panel_immuno + 
  patchwork::plot_layout(design = layout, widths = c(1, 0.02, 1, 0.02, 1), 
                         heights = c(1, 0.02, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig4_sup3.png", limitsize = FALSE, 
       units = c("px"), Fig4_sup3, width = 2400, height = 1750, bg='white') 

ggsave("Manuscript/figures/Fig4_sup3.pdf", limitsize = FALSE, 
       units = c("px"), Fig4_sup3, width = 2400, height = 1750)  

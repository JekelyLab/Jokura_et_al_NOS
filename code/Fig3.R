#Code to assemble Fig6 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

NIT1_MO <- read_csv("data/220214_non-MOvsNIT1-MO1and2.csv")
NIT2_MO <- read_csv("data/220522_NIT2-MO1and2.csv")
NITGC1_analysis <- read_csv("data/220519_GcG-T2A-NITGC1_norm.csv")

# tidying the data -----------------------------------------------------------

NIT1_MO_tb <- NIT1_MO %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

NIT2_MO_tb <- NIT2_MO %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#check factors
NIT1_MO_tb%>%
  count(morphant)
NIT2_MO_tb%>%
  count(morphant)

# plot NITGC1_analysis ----------------------------------------------------
NITGC1_analysis %>%
  count(expression)

NITGC1_analysis %>%
  filter(solution == "SNAP" & expression == "GcG-NIT1") %>%
#cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.4, alpha = 0.2, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 1, span = 0.2, 
              method = "loess", show.legend = FALSE) +
  theme_minimal()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[2])) +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.135, yend=1.135, size=2, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=4, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")
  
# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-NIT-GC1-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 600, bg='white')  

# plot NITGC1_analysis ----------------------------------------------------
NITGC1_analysis %>%
  count(expression)

NITGC1_analysis %>%
  filter(solution == "SNAP" & expression == "GcG") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity)) +
  geom_line(aes(group = cell_expression), size = 0.4, alpha = 0.2, 
            show.legend = FALSE, color = 'grey50') +
  geom_smooth(level = 0.99, size = 1, span = 0.2, 
              method = "loess", show.legend = FALSE, color = 'grey50') +
  theme_minimal() +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15)) +
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.135, yend=1.135, size=2, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=4, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")

# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 600, bg='white')  

# plot NITGC1_analysis ----------------------------------------------------

NITGC1_analysis %>%
  filter(solution == "DMSO") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.4, alpha = 0.2, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 1, span = 0.2, 
              method = "loess", show.legend = FALSE) +
  theme_minimal()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  #Specify colours and legend labels
  scale_color_manual(values=c('grey50'),
                     labels = c('GcG + NIT-GC1')) +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.135, yend=1.135, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=4, label="DMSO")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")

# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-NIT-GC1-DMSO.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 600, bg='white')  



# plot NITGC1_analysis----------------------------------------------------------

NITGC1_analysis %>%
  filter(expression == "GcG-mutNIT1") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.4, alpha = 0.2, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 1, span = 0.2, 
              method = "loess", show.legend = FALSE) +
  theme_minimal()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  #Specify colours and legend labels
  scale_color_manual(values=c('grey50'),
                     labels = c('GcG + mutNIT-GC1')) +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.135, yend=1.135, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=4, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")

# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-mutNIT-GC1-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 600, bg='white')  

# plot NIT1 morphant data with geom_smooth ----------------------------------------------

NIT1_MO_tb %>%
  ggplot(aes(x = frame, y = intensity, color = morphant)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=2.3, label="405 nm", size=4)+
  annotate("text", x=160, y=2.3, label="cPRC", size=4)+
  ylim(0.1,2.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[1], Okabe_Ito[7],
                              Okabe_Ito[2]),
                     labels = c('NIT-GC1 MO1','NIT-GC1 MO2', 
                                'control'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT1_MO_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 600, bg='white')  

# plot NIT morphant data with geom_smooth ----------------------------------------------

NIT2_MO_tb %>%
  ggplot(aes(x = frame, y = intensity, color = morphant)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=2.3, label="405 nm", size=4)+
  annotate("text", x=160, y=2.3, label="cPRC", size=4)+
  ylim(0.4,2.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[1], Okabe_Ito[7]),
                     labels = c('NIT-GC2 MO1','NIT-GC2 MO2'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2_MO_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 600, bg='white')  



# assemble figure ---------------------------------------------------------

panel_cPRC_NIT1_MO <- ggdraw() + draw_image(readPNG("pictures/NIT1_MO_cPRC.png"))
panel_cPRC_NIT2_MO <- ggdraw() + draw_image(readPNG("pictures/NIT2_MO_cPRC.png"))

panel_HCR_NIT1 <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NITGC1_actub_52.24um.png")) +
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 11) +
  draw_label("NIT-GC1", x = 0.15, y = 0.08, color='#CC79A7', size = 12, fontface='bold') +
  draw_label("acTub", x = 0.85, y = 0.08, color='green', size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_HCR_NIT1_cOps <- ggdraw() + draw_image(readPNG("pictures/HCR_RT28_AP_NITGC1_c-opsin1_112.55um.png")) +
  draw_label("HCR in situ", x = 0.3, y = 0.99, size = 11) +
  draw_label("NIT-GC1", x = 0.15, y = 0.08, color='#CC79A7', size = 12, fontface='bold')+
  draw_label("c-opsin1", x = 0.85, y = 0.08, color='green', size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_IHC_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC1_actub_58.47um.png")) +
  draw_label("IHC", x = 0.2, y = 0.99, size = 11) +
  draw_label("cPRC", x = 0.2, y = 0.89, color='white',size = 12, fontface='bold') +
  draw_label("anti-NIT-GC1", x = 0.22, y = 0.08, color='#CC79A7', size = 12, fontface='bold') +
  draw_label("acTub", x = 0.85, y = 0.08, color='green', size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_IHC_NIT2 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC2_actub_60.77um.png")) +
  draw_label("IHC", x = 0.2, y = 0.99, size = 11) +
  draw_label("cPRC", x = 0.22, y = 0.8, color='white',size = 12, fontface='bold') +
  draw_label("anti-NIT-GC2", x = 0.22, y = 0.08, color='#CC79A7', size = 12, fontface='bold') +
  draw_label("acTub", x = 0.85, y = 0.08, color='green', size = 12, fontface='bold') +
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "white", size = 10)

panel_GcG_NIT_DMSO <- ggdraw() + draw_image(readPNG("pictures/GcG-NIT-GC1-DMSO.png")) +
  draw_label("GcG + NIT-GC1", x = 0.35, y = 0.9, size = 11)
panel_GcG_NIT_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-NIT-GC1-SNAP.png")) +
  draw_label("GcG + NIT-GC1", x = 0.35, y = 0.9, size = 11)
panel_GcG_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-SNAP.png"))  +
  draw_label("GcG", x = 0.25, y = 0.9, size = 11)
panel_GcG_mutNIT_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-mutNIT-GC1-SNAP.png"))  +
  draw_label("GcG + mutNIT1-GC1", x = 0.35, y = 0.9, size = 11)

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C#D
#######
EEE#FFF
#######
G#H#I#J
"

Fig3 <- panel_HCR_NIT1 + panel_HCR_NIT1_cOps + panel_IHC_NIT1 + panel_IHC_NIT2 +
  panel_cPRC_NIT1_MO + panel_cPRC_NIT2_MO +
  panel_GcG_NIT_SNAP + panel_GcG_SNAP + panel_GcG_NIT_DMSO + panel_GcG_mutNIT_SNAP +
  patchwork::plot_layout(design = layout, heights = c(0.9, 0.02, 0.7, 0.02, 0.85),
                         widths = c(1,0.02,1,0.02,1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12,face='bold')) #or 'bold', 'plain', 'italic'



ggsave("figures/Fig3.png", limitsize = FALSE, units = c("px"), 
       Fig3, width = 3200, height = 2400, bg='white')  

ggsave("figures/Fig3.pdf", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2350, height = 1700)  




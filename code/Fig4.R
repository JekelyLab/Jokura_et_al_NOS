#Code to assemble Fig4 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

WTvsNOS23 <- read_csv("data/211121_WTvsNOS23_cPRC.csv")
WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")

NIT1_MO <- read_csv("data/220214_non-MOvsNIT1-MO1and2.csv")
NIT2_MO <- read_csv("data/220522_NIT2-MO1and2.csv")

NITGC1_analysis <- read_csv("data/220519_GcG-T2A-NITGC1_norm.csv")

# tidying the data -----------------------------------------------------------


WT_cPRC_tidy <- WTvsNOS23 %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), 
           into = c("genotype", "sample"), sep = "\\...")

WTvsNOS11_cPRC_INNOS_tb <- WTvsNOS11_cPRC_INNOS %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")



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






# plot NOS23 cPRC data with geom_smooth ----------------------------------------------

WT_cPRC_tidy$genotype <- factor(WT_cPRC_tidy$genotype, 
                                levels=c("WT_cPRC", "NOS23_cPRC"))

WT_cPRC_tidy %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=genotype) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess", formula = y ~ x) +
  annotate("segment", x=20, xend=40, y=1.4, yend=1.4, size=1)+
  annotate("segment", x=20, xend=20, y=1.4, yend=1.65, size=1)+
  annotate("text", x=29, y=1.35, label="10 sec", size=3)+
  annotate("text", x=35, y=1.53, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=1.7, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=1.7, label="cPRC", size=5)+
  ylim(0.2,1.7)+
  theme_void()  +
  theme(legend.title = element_blank(), 
        legend.text.align = 0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(Okabe_Ito[6], set2[4]),
                     labels = c("WT", expression('NOS'^'Δ23/Δ23'))) +
  scale_fill_manual(values=c(Okabe_Ito[6], set2[4]),
                    labels = c("WT", expression('NOS'^'Δ23/Δ23')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  


# plot NOS11 cPRC data (vs INNOS) with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb$genotype <- factor(WTvsNOS11_cPRC_INNOS_tb$genotype, 
                                           levels=c("WT_cPRC", "WT_INNOS", "NOS11_cPRC", "NOS11_INNOS"))

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_cPRC" | genotype == "NOS11_cPRC") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x = frame, y = intensity, color = genotype)+
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess", formula = y ~ x) +
  annotate("segment", x=15, xend=35, y=1.8, yend=1.8, size=1)+
  annotate("segment", x=15, xend=15, y=1.8, yend=2.05, size=1)+
  annotate("text", x=24, y=1.7, label="10 sec", size=3)+
  annotate("text", x=30, y=1.94, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=2.6, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=2.6, label="cPRC", size=5)+
  ylim(0.4,2.6) +
  theme_void() +
  #labs(color = "genotype") +
  theme(legend.title = element_blank(), 
        legend.text.align = 0,
        #legend.title = element_text(size = 12)
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[7]),
                     labels = c("WT", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(Okabe_Ito[6], Okabe_Ito[7]),
                    labels = c("WT", expression('NOS'^'Δ11/Δ11')))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  


# plot Control + NIT1 morphant calcium imaging data with geom_smooth ----------------------------------------------

NIT1_MO_tb$morphant <- factor(NIT1_MO_tb$morphant, 
                                levels=c("non-MO", "NIT1-MO1", "NIT1-MO2"))

NIT1_MO_tb %>%
  ggplot(aes(x = frame, y = intensity, color = morphant)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = morphant), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=2.3, label="405 nm", size=4)+
  annotate("text", x=160, y=2.3, label="cPRC", size=4)+
  ylim(0.1,2.3)+
  theme_void() +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=10)) +
  scale_color_manual(values=c(Okabe_Ito[2], Okabe_Ito[6], Okabe_Ito[7]),
                     labels = c('control', 'NIT-GC1 MO1','NIT-GC1 MO2')) +
  scale_fill_manual(values=c(Okabe_Ito[2], Okabe_Ito[6], Okabe_Ito[7]),
                    labels = c('control', 'NIT-GC1 MO1','NIT-GC1 MO2'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT1_MO_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 600, bg='white')  


# plot Control against MO calcium imaging data with geom_smooth ----------------------------------------------

NIT1_MO_tb %>%
  filter(morphant == "non-MO") %>%
  ggplot(aes(x = frame, y = intensity, color = morphant)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = morphant), level = 0.99, size = 0.75, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=2.3, label="405 nm", size=4)+
  annotate("text", x=160, y=2.3, label="cPRC", size=4)+
  ylim(0.4,2.3)+
  theme_void() +
  theme(legend.position = "none") +
  scale_color_manual(values=c(Okabe_Ito[2]),
                     labels = c('control')) +
  scale_fill_manual(values=c(Okabe_Ito[2]),
                    labels = c('control'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT1_MO_cont_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1070, height = 1000, bg='white')  



# plot NIT1 morphant calcium imaging data with geom_smooth ----------------------------------------------

NIT1_MO_tb$morphant <- factor(NIT1_MO_tb$morphant, 
                              levels=c("non-MO", "NIT1-MO1", "NIT1-MO2"))

NIT1_MO_tb %>%
  filter(morphant == "NIT1-MO1" | morphant == "NIT1-MO2") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x = frame, y = intensity, color = morphant) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = morphant), level = 0.99, size = 0.75, span = 0.03, 
              method = "loess", formula = y ~ x) +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.5, size=1)+
  annotate("text", x=29, y=1.25, label="10 sec", size=3)+
  annotate("text", x=35, y=1.4, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=72, y=1.6, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=1.6, label="cPRC", size=5)+
  ylim(0.2,1.6)+
  theme_void()  +
  theme(legend.title = element_blank(), 
        legend.text.align = 0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(yelloworangered[6], yelloworangered[5]),
                     labels = c('NIT1 MO1','NIT1 MO2')) +
  scale_fill_manual(values=c(yelloworangered[6], yelloworangered[5]),
                    labels = c('NIT1 MO1','NIT1 MO2'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT1_MO1_2_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  




# plot NIT2 morphant data with geom_smooth ----------------------------------------------

NIT2_MO_tb %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x = frame, y = intensity, color = morphant) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = morphant), level = 0.99, size = 1, span = 0.03, 
              method = "loess", formula = y ~ x) +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.85, size=1)+
  annotate("text", x=29, y=1.52, label="10 sec", size=3)+
  annotate("text", x=35, y=1.73, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=2.3, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=2.3, label="cPRC", size=5)+
  ylim(0.4,2.3)+
  theme_void()  +
  theme(legend.title = element_blank(), 
        legend.text.align = 0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(Okabe_Ito[1], yelloworangered[4]),
                     labels = c('NIT2 MO1','NIT2 MO2')) +
  scale_fill_manual(values=c(Okabe_Ito[1], yelloworangered[4]),
                     labels = c('NIT2 MO1','NIT2 MO2'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2_MO1_2_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  


# plot cGMP analysis (GcG-NIT1 <= SNAP) in cell culture-------------------------------------------------

NITGC1_analysis %>%
  filter(solution == "SNAP" & expression == "GcG-NIT1") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.35, alpha = 0.3, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 0.7, span = 0.15, 
              method = "loess", 
              show.legend = FALSE) +
  theme_minimal()  +
  annotate("segment", x=0, xend=10, y=1, yend=1, 
           size=0.45, linetype="dashed", alpha = 0.5) +
  theme(axis.title = element_text(size=7),
        axis.text = element_text(size = 7),
        title = element_text(size = 7)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[2])) +
  scale_y_continuous(breaks=seq(1.0, 1.2, length=3),limits = c(0.95, 1.2))+
  scale_x_continuous(breaks=seq(0, 10, length=6),limits = c(0, 10))+
  labs(title = "Green cGull + NIT-GC1", 
       x = "time (min)", 
       y = "normalized intensity") +
  annotate("segment", x=2, xend=10, y=1.165, yend=1.165, size=2, color = "dark gray")+
  annotate("text", x=2, y=1.185, size=3, hjust = 0, label="SNAP")


# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-NIT-GC1-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 950, height = 640, bg='white')  



# plot cGMP analysis (GcG <= SNAP) in cell culture ----------------------------------------------------

NITGC1_analysis %>%
  filter(solution == "SNAP" & expression == "GcG") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.35, alpha = 0.3, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 0.7, span = 0.15, 
              method = "loess", 
              show.legend = FALSE) +
  theme_minimal()  +
  annotate("segment", x=0, xend=10, y=1, yend=1, 
           size=0.45, linetype="dashed", alpha = 0.5) +
  theme(axis.title = element_text(size=7),
        axis.text = element_text(size = 7),
        title = element_text(size = 7)) +
  #Specify colours and legend labels
  scale_color_manual(values=c('grey50')) +
  scale_y_continuous(breaks=seq(1.0, 1.2, length=3),limits = c(0.944, 1.2))+
  scale_x_continuous(breaks=seq(0, 10, length=6),limits = c(0, 10))+
  labs(title = "Green cGull", 
       x = "time (min)", 
       y = "normalized intensity") +
  annotate("segment", x=2, xend=10, y=1.165, yend=1.165, size=2, color = "dark gray")+
  annotate("text", x=2, y=1.185, size=3, hjust = 0, label="SNAP")


# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 950, height = 640, bg='white')  



# plot cGMP analysis (GcG-NIT1 <= DMSO) in cell culture ----------------------------------------------------

NITGC1_analysis %>%
  filter(solution == "DMSO") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.35, alpha = 0.3, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 0.7, span = 0.15, 
              method = "loess", 
              show.legend = FALSE) +
  theme_minimal()  +
  annotate("segment", x=0, xend=10, y=1, yend=1, 
           size=0.45, linetype="dashed", alpha = 0.5) +
  theme(axis.title = element_text(size=7),
        axis.text = element_text(size = 7),
        title = element_text(size = 7)) +
  #Specify colours and legend labels
  scale_color_manual(values=c('grey50')) +
  scale_y_continuous(breaks=seq(1.0, 1.2, length=3),limits = c(0.95, 1.2))+
  scale_x_continuous(breaks=seq(0, 10, length=6),limits = c(0, 10))+
  labs(title = "Green cGull + NIT-GC1", 
       x = "time (min)", 
       y = "normalized intensity") +
  annotate("segment", x=2, xend=10, y=1.165, yend=1.165, size=2, color = "dark gray")+
  annotate("text", x=2, y=1.185, size=3, hjust = 0, label="DMSO")

# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-NIT-GC1-DMSO.png", limitsize = FALSE, 
       units = c("px"), width = 950, height = 640, bg='white')  



# plot cGMP analysis (GcG-mutNIT1 <= SNAP) in cell culture----------------------------------------------------------

NITGC1_analysis %>%
  filter(expression == "GcG-mutNIT1") %>%
  #cell names are not unique and the same across expression, fix by adding new column  
  mutate(cell_expression = paste(cell, expression, sep = "")) %>%
  ggplot(aes(x = time, y = intensity, color = expression)) +
  geom_line(aes(group = cell_expression), size = 0.35, alpha = 0.3, 
            show.legend = FALSE) +
  geom_smooth(level = 0.99, size = 0.7, span = 0.15, 
              method = "loess", 
              show.legend = FALSE) +
  theme_minimal()  +
  annotate("segment", x=0, xend=10, y=1, yend=1, 
           size=0.45, linetype="dashed", alpha = 0.5) +
  theme(axis.title = element_text(size=7),
        axis.text = element_text(size = 7),
        title = element_text(size = 7)) +
  #Specify colours and legend labels
  scale_color_manual(values=c('grey50')) +
  scale_y_continuous(breaks=seq(1.0, 1.2, length=3),limits = c(0.947, 1.2))+
  scale_x_continuous(breaks=seq(0, 10, length=6),limits = c(0, 10))+
  labs(title = "Green cGull + ΔNIT-GC1", 
       x = "time (min)", 
       y = "normalized intensity") +
  annotate("segment", x=2, xend=10, y=1.165, yend=1.165, size=2, color = "dark gray")+
  annotate("text", x=2, y=1.185, size=3, hjust = 0, label = "SNAP")

# save plot ---------------------------------------------------------------

ggsave("pictures/GcG-mutNIT-GC1-SNAP.png", limitsize = FALSE, 
       units = c("px"), width = 950, height = 640, bg='white')  



# assemble figure ---------------------------------------------------------

arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.75, y2 = 0.85)

panel_HCR_NIT1 <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NITGC1_actub_52.24um.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.97, size = 10) +
  draw_label("NIT-GC1", x = 0.15, y = 0.89, color="magenta", size = 10, fontface="italic") +
  draw_label("acTub", x = 0.37, y = 0.89, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.42), y = c(0.11, 0.11), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.14, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)

panel_HCR_NIT2 <- ggdraw() + draw_image(readPNG("pictures/HCR-IHC_51_AP_NITGC2_actub_52µm.png")) +
  draw_label("in situ HCR", x = 0.25, y = 0.97, size = 10) +
  draw_label("NIT-GC2", x = 0.15, y = 0.89, color="magenta", size = 10, fontface="italic") +
  draw_label("acTub", x = 0.37, y = 0.89, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.42), y = c(0.11, 0.11), color = "white", size = 0.5)

panel_IHC_NIT1 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC1_actub_58.47um.png")) +
  draw_label("IHC", x = 0.15, y = 0.97, size = 10) +
  draw_label("NIT-GC1", x = 0.15, y = 0.89, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.37, y = 0.89, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.38), y = c(0.11, 0.11), color = "white", size = 0.5)

panel_IHC_NIT2 <- ggdraw() + draw_image(readPNG("pictures/IHC_55_AP_NITGC2_actub_60.77um.png")) +
  draw_label("IHC", x = 0.15, y = 0.97, size = 10) +
  draw_label("NIT-GC2", x = 0.15, y = 0.89, color="magenta", size = 10, fontface="plain") +
  draw_label("acTub", x = 0.37, y = 0.89, color="green", size = 10, fontface="plain") +
  draw_line(x = c(0.04, 0.37), y = c(0.11, 0.11), color = "white", size = 0.5)


panel_cPRC_NOS11 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_cPRC.png"))
panel_cPRC_NOS23 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_cPRC.png"))

panel_cPRC_MO_cont <- ggdraw() + draw_image(readPNG("pictures/NIT1_MO_cont_cPRC.png"))
panel_cPRC_NIT1_MO12 <- ggdraw() + draw_image(readPNG("pictures/NIT1_MO1_2_cPRC.png"))
panel_cPRC_NIT2_MO12 <- ggdraw() + draw_image(readPNG("pictures/NIT2_MO1_2_cPRC.png"))


panel_NITGC1_domain <- ggdraw() + draw_image(readPNG("pictures/NITGC1_domain_structure.png"))
panel_NITGC1_assay_schematic <- ggdraw() + draw_image(readPNG("pictures/NITGC1_assay_schematic.png"))

panel_GcG_NIT_DMSO <- ggdraw() + draw_image(readPNG("pictures/GcG-NIT-GC1-DMSO.png"))
panel_GcG_NIT_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-NIT-GC1-SNAP.png"))
panel_GcG_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-SNAP.png"))
panel_GcG_mutNIT_SNAP <- ggdraw() + draw_image(readPNG("pictures/GcG-mutNIT-GC1-SNAP.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AA#BB#CC#DD
###########
EEEEE#FFFFF
###########
GGGGG#HHHHH
###########
IIIKKKKLLLL
JJJMMMMNNNN
"



Fig4 <- 
  panel_HCR_NIT1 + panel_HCR_NIT2 + panel_IHC_NIT1 + panel_IHC_NIT2 +
  panel_cPRC_NOS11 + panel_cPRC_NOS23 +
  panel_cPRC_NIT1_MO12 + panel_cPRC_NIT2_MO12 +
  panel_NITGC1_domain + panel_NITGC1_assay_schematic + 
  panel_GcG_NIT_SNAP + panel_GcG_SNAP + panel_GcG_NIT_DMSO + panel_GcG_mutNIT_SNAP +
  patchwork::plot_layout(design = layout, 
                         heights = c(1, 0.02, 1, 0.02, 1, 0.02, 0.75, 0.75),
                         widths = c(1, 1, 0.02, 1, 1, 0.02, 1, 1, 0.02, 1, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("figures/Fig4.png", limitsize = FALSE, units = c("px"), 
       Fig4, width = 2800, height = 3600, bg='white')  


ggsave("figures/Fig4.pdf", limitsize = FALSE, 
       units = c("px"), Fig4, width = 2800, height = 3600)  




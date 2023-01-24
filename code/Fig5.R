#Code to assemble Fig5 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")
WTvsNOS23_cPRC_INRGWa <- read_csv("data/211209_WTvsNOS23_cPRC_INRGWa (2).csv")

NIT2MO_INNOS <- read_csv("data/220812_NIT2MO_INNOS.csv")
NIT2MO_INRGW <- read_csv("data/220812_NIT2MO_INRGW.csv")

WTvsNOS11_Ser <- read_csv("data/220819_WTvsNOS11_Ser-h1.csv")
WTvsNOS11_MC <- read_csv("data/220819_WTvsNOS11_MC.csv")


# tidying the data -----------------------------------------------------------

WTvsNOS11_cPRC_INNOS_tb <- WTvsNOS11_cPRC_INNOS %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

WTvsNOS23_cPRC_INRGWa_tb <- WTvsNOS23_cPRC_INRGWa %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

#WTvsNOS11 Ser-h1 & MC

WTvsNOS11_Ser_tb <- WTvsNOS11_Ser %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

WTvsNOS11_MC_tb <- WTvsNOS11_MC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "genotype",
               values_to = "intensity") %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

#NIT2MO
NIT2MO_INNOS_tb <- NIT2MO_INNOS %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "MO",
               values_to = "intensity") %>%
  separate(col = c("MO"), into = c("MO", "sample"), sep = "\\...")

NIT2MO_INRGW_tb <- NIT2MO_INRGW %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "MO",
               values_to = "intensity") %>%
  separate(col = c("MO"), into = c("MO", "sample"), sep = "\\...")

#check factors
WTvsNOS11_cPRC_INNOS_tb %>%
  count(genotype)

WTvsNOS23_cPRC_INRGWa_tb%>%
  count(genotype)

# plot NOS23 cPRC (vs INRGW) data with geom_smooth ----------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb$genotype <- factor(WTvsNOS23_cPRC_INRGWa_tb$genotype, 
                                            levels=c("WT_cPRC", "WT_INRGWa", "NOS23_cPRC", "NOS23_INRGWa"))

WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "NOS23_cPRC" | genotype == "WT_cPRC") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=genotype) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=15, xend=15, y=1.3, yend=1.5, size=1)+
  annotate("text", x=24, y=1.25, label="10 sec", size=3)+
  annotate("text", x=31, y=1.4, label="0.4 ΔF/F0", size=3)+
  annotate("text", x=72, y=1.7, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=1.7, label="cPRC", size=5)+
  ylim(0.4,1.7)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], paired[7]),
                     labels = c("WT", expression('NOS'^'Δ23/Δ23'))) +
  scale_fill_manual(values=c(Okabe_Ito[6], paired[7]),
                    labels = c("WT", expression('NOS'^'Δ23/Δ23')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_vsINRGW_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')


# plot NOS11 INNOS data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb$genotype <- factor(WTvsNOS11_cPRC_INNOS_tb$genotype, 
                                           levels=c("WT_cPRC", "WT_INNOS", "NOS11_cPRC", "NOS11_INNOS"))

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_INNOS" | genotype == "NOS11_INNOS") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=genotype) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=2.0, yend=2.0, size=1)+
  annotate("segment", x=15, xend=15, y=2.0, yend=2.25, size=1)+
  annotate("text", x=24, y=1.91, label="10 sec", size=3)+
  annotate("text", x=31, y=2.13, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=3.12, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=3.12, label="INNOS", size=5)+
  ylim(0.5,3.12)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[10], set2[4]),
                     labels = c("WT", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[10], set2[4]),
                    labels = c("WT", expression('NOS'^'Δ11/Δ11')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_INNOS.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  


# plot NOS23 INRGW data with geom_smooth ----------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb$genotype <- factor(WTvsNOS23_cPRC_INRGWa_tb$genotype, 
                                levels=c("WT_cPRC", "WT_INRGWa", "NOS23_cPRC", "NOS23_INRGWa"))

WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "NOS23_INRGWa" | genotype == "WT_INRGWa") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=genotype) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=1.4, yend=1.4, size=1)+
  annotate("segment", x=15, xend=15, y=1.4, yend=1.5, size=1)+
  annotate("text", x=24, y=1.36, label="10 sec", size=3)+
  annotate("text", x=31, y=1.45, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=72, y=1.7, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=1.7, label="INRGW", size=5)+
  ylim(0.75,1.7)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(blues[8], Okabe_Ito[2]),
                     labels = c("WT", expression('NOS'^'Δ23/Δ23'))) +
  scale_fill_manual(values=c(blues[8], Okabe_Ito[2]),
                    labels = c("WT", expression('NOS'^'Δ23/Δ23')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_INRGW.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  

# plot NIT2MO INNOS data with geom_smooth ----------------------------------------------

max(NIT2MO_INNOS_tb$intensity)
min(NIT2MO_INNOS_tb$intensity)

NIT2MO_INNOS_tb %>%
  filter(MO == "NIT2MO1_NOS" | MO == "NIT2MO2_NOS") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=MO) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = MO), level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=15, xend=15, y=1.6, yend=1.85, size=1)+
  annotate("text", x=24, y=1.52, label="10 sec", size=3)+
  annotate("text", x=31, y=1.73, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=3.12, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=3.12, label="INNOS", size=5)+
  ylim(0.5,3.12)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(dark2[4], set2[4]),
                     labels = c("NIT2 MO1", "NIT2 MO2")) +
  scale_fill_manual(values=c(dark2[4], set2[4]),
                    labels = c("NIT2 MO1", "NIT2 MO2"))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2MO_INNOS.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  

# plot NIT2MO INRGW data with geom_smooth ----------------------------------------------

max(NIT2MO_INRGW_tb$intensity)
min(NIT2MO_INRGW_tb$intensity)

NIT2MO_INRGW_tb %>%
  filter(MO == "NIT2MO1_RGW" | MO == "NIT2MO2_RGW") %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=MO) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = MO), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=2.0, yend=2.0, size=1)+
  annotate("segment", x=15, xend=15, y=2.0, yend=2.25, size=1)+
  annotate("text", x=24, y=1.9, label="10 sec", size=3)+
  annotate("text", x=31, y=2.13, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=3.3, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=3.3, label="INRGW", size=5)+
  ylim(0.5,3.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(blues[8], Okabe_Ito[2]),
                     labels = c("NIT2 MO1", "NIT2 MO2")) +
  scale_fill_manual(values=c(blues[8], Okabe_Ito[2]),
                    labels = c("NIT2 MO1", "NIT2 MO2"))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2MO_INRGW.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  

# plot NOS11 Ser-h1 data with geom_smooth ----------------------------------------------

max(WTvsNOS11_Ser_tb$intensity)
min(WTvsNOS11_Ser_tb$intensity)

WTvsNOS11_Ser_tb$genotype <- factor(WTvsNOS11_Ser_tb$genotype, 
                                    levels=c("WT_Ser-h1", "NOS11_Ser-h1"))

WTvsNOS11_Ser_tb %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.3) +
  aes(x=frame,y=intensity,color=genotype) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=2.0, yend=2.0, size=1)+
  annotate("segment", x=15, xend=15, y=2.0, yend=2.25, size=1)+
  annotate("text", x=24, y=1.92, label="10 sec", size=3)+
  annotate("text", x=31, y=2.13, label="0.5 ΔF/F0", size=3)+
  annotate("text", x=72, y=3, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=3, label="Ser-h1", size=5)+
  ylim(0.5,3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[6], paired[5]),
                     labels = c("WT", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[6], paired[5]),
                    labels = c("WT", expression('NOS'^'Δ11/Δ11')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_Ser-h1.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  

# plot NOS11 MC data with geom_smooth ----------------------------------------------

max(WTvsNOS11_MC_tb$intensity)
min(WTvsNOS11_MC_tb$intensity)

WTvsNOS11_MC_tb$genotype <- factor(WTvsNOS11_MC_tb$genotype, 
                                   levels=c("WT_MC", "NOS11_MC"))

WTvsNOS11_MC_tb %>%
  ggplot() +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  aes(x=frame,y=intensity,color=genotype) +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.04, 
              method = "loess") +
  annotate("segment", x=15, xend=35, y=3.6, yend=3.6, size=1)+
  annotate("segment", x=15, xend=15, y=3.6, yend=4.1, size=1)+
  annotate("text", x=24, y=3.4, label="10 sec", size=3)+
  annotate("text", x=31, y=3.85, label="1.0 ΔF/F0", size=3)+
  annotate("text", x=72, y=5, label="405 nm", color="purple", size=4)+
  annotate("text", x=160, y=5, label="MC", size=5)+
  ylim(0.2,5)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[12], dark2[6]),
                     labels = c("WT", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[12], dark2[6]),
                    labels = c("WT", expression('NOS'^'Δ11/Δ11')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_MC.png", limitsize = FALSE, 
       units = c("px"), width = 1500, height = 800, bg='white')  


# assemble figure ---------------------------------------------------------

#panel_method <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))

arrow_fluo <- data.frame(x1 = 0.9, x2 = 0.9, y1 = 0.75, y2 = 0.85)

#panel_Ca_NOS <- ggdraw() + draw_image(readPNG("pictures/n51hpf_WT_e-1_GCaMP_points_trim.png"))+
#  draw_label("GCaMP6s", x = 0.15, y = 0.92, hjust = 0, color='white', size = 11, fontface='bold') +
#  draw_line(x = c(0.17, 0.37), y = c(0.05, 0.05), color = "white", size = 0.6) +
#  draw_label(expression(paste("10 ", mu, "m")), x = 0.27, y = 0.11, color = "white", size = 8) +
#  draw_label("cPRC", x = 0.4, y = 0.35, color='white', size = 10, fontface='plain') +
#  draw_line(x = c(0.4, 0.7), y = c(0.4, 0.6), color = "white", size = 0.4)

#panel_IHC_NOS <- ggdraw() + draw_image(readPNG("pictures/n51hpf_WT_e-1_IHC_points_trim.png"))+
#  draw_label("RYa", x = 0.15, y = 0.92, hjust = 0, color='red',size = 10, fontface='bold') +
#  draw_label("DAPI", x = 0.15, y = 0.82, hjust = 0, color='cyan', size = 10, fontface='bold') +
#  draw_line(x = c(0.05, 0.45), y = c(0.1, 0.1), color = "white", size = 0.5) +
#  draw_label("INNOS", x = 0.3, y = 0.3, color='white', size = 10, fontface='plain') +
#  draw_line(x = c(0.34, 0.3), y = c(0.54, 0.35), color = "white", size = 0.4)

#panel_Ca_RGW <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_GCaMP6s.png")) +
#  draw_label("GCaMP6s", x = 0.15, y = 0.92, hjust = 0, color='white', size = 10, fontface='bold') +
#  draw_line(x = c(0.05, 0.45), y = c(0.1, 0.1), color = "white", size = 0.5) +
#  draw_label("cPRC", x = 0.25, y = 0.5, color='white', size = 10, fontface='plain') +
#  draw_line(x = c(0.25, 0.54), y = c(0.55, 0.63), color = "white", size = 0.4)

#panel_IHC_RGW <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_RGWa.png"))+
#  draw_label("RGWa, 5-HT", x = 0.15, y = 0.92, hjust = 0, color='red',size = 10, fontface='bold') +
#  draw_label("DAPI", x = 0.15, y = 0.82, hjust = 0, color='cyan', size = 10, fontface='bold') +
#  draw_line(x = c(0.05, 0.45), y = c(0.1, 0.1), color = "white", size = 0.5) +
#  draw_label("INRGW", x = 0.3, y = 0.4, color='white', size = 10, fontface='plain') +
#  draw_line(x = c(0.47, 0.3), y = c(0.25, 0.35), color = "white", size = 0.4) +
#  draw_label("Ser-h1", x = 0.75, y = 0.45, color='white', size = 10, fontface='plain') +
#  draw_line(x = c(0.765, 0.75), y = c(0.81, 0.49), color = "white", size = 0.4)

panel_Ca_IHC_RY <- ggdraw() + draw_image(readPNG("pictures/n51hpf_WT_d-1_calcium_RY.png"))
panel_Ca_IHC_RGW <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e_calcium_RGW.png"))

panel_correlation <- ggdraw() + 
  draw_image(readPNG("pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_correlation.png"))

panel_cPRC <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_vsINRGW_cPRC.png"))

panel_INNOS <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_INNOS.png"))
panel_INRGW <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_INRGW.png"))

panel_NIT2MO_INRGW <- ggdraw() + draw_image(readPNG("pictures/NIT2MO_INRGW.png"))
panel_NIT2MO_INNOS <- ggdraw() + draw_image(readPNG("pictures/NIT2MO_INNOS.png"))

panel_Ser <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_Ser-h1.png"))
panel_MC <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_MC.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

layout2 <- "
AAAAAABBBBBBCCCCCC
##################
DDDDDDFFFFFFHHHHHH
##################
EEEEEEGGGGGGIIIIII"

Fig5 <- panel_Ca_IHC_RY + panel_Ca_IHC_RGW + panel_correlation +
  panel_INNOS + panel_NIT2MO_INNOS + 
  panel_INRGW + panel_NIT2MO_INRGW +
  panel_Ser + panel_MC +
  patchwork::plot_layout(design = layout2, 
                         heights = c(0.82, 0.05, 1, 0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


ggsave("figures/Fig5.png", limitsize = FALSE, 
       units = c("px"), Fig5, width = 3750, height = 2000, bg='white')  


ggsave("figures/Fig5.pdf", limitsize = FALSE, 
       units = c("px"), Fig5, width = 3750, height = 2000) 



#layout <- "
#AAAAAABBBCCCFFFFFF
#AAAAAA######FFFFFF
#AAAAAADDDEEEFFFFFF
###################
#GGGGGGIIIIIIKKKKKK
#HHHHHHJJJJJJLLLLLL"


#Fig5 <- panel_method + 
#  panel_Ca_NOS + panel_IHC_NOS +
#  panel_Ca_RGW + panel_IHC_RGW + 
#  panel_correlation +
#  panel_INNOS + panel_NIT2MO_INNOS + 
#  panel_INRGW + panel_NIT2MO_INRGW +
#  panel_Ser + panel_MC +
#  patchwork::plot_layout(design = layout, 
#                         heights = c(0.4, 0.02, 0.4, 0.05, 0.8, 0.8)) + #we can change the heights of the rows in our layout (widths also can be defined)
#  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
#  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


#ggsave("figures/Fig5.png", limitsize = FALSE, 
#       units = c("px"), Fig5, width = 3200, height = 2500, bg='white')  






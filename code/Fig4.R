#Code to assemble Fig4 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

DAFFM <- read_csv("data/220213_DAF-FM_long.csv")
WTvsNOS23 <- read_csv("data/211121_WTvsNOS23_cPRC.csv")
WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")
WTvsNOS23_cPRC_INRGWa <- read_csv("data/211209_WTvsNOS23_cPRC_INRGWa (2).csv")
NIT2MO_INNOS <- read_csv("data/220812_NIT2MO_INNOS.csv")
NIT2MO_INRGW <- read_csv("data/220812_NIT2MO_INRGW.csv")

WTvsNOS11_Ser <- read_csv("data/220819_WTvsNOS11_Ser-h1.csv")
WTvsNOS11_MC <- read_csv("data/220819_WTvsNOS11_MC.csv")


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

# plot DAFFM neuropil data with geom_smooth ----------------------------------------------
DAFFM %>%
  count(stimuli)
DAFFM


max(DAFFM$intensity)
min(DAFFM$intensity)


DAFFM %>%
  ggplot(aes(x=frame,y=intensity,color = stimuli)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = stimuli), level = 0.95, size = 1, span = 0.05, method = "loess") +
  annotate("segment", x=20, xend=40, y=1.2, yend=1.2, size=1)+
  annotate("segment", x=20, xend=20, y=1.2, yend=1.3, size=1)+
  annotate("text", x=29, y=1.15, label="10 sec", size=3)+
  annotate("text", x=23, y=1.31, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.32, label="405 nm", size=4)+
  annotate("text", x=160, y=1.32, label="neuropil DAF-FM", size=5)+
  ylim(0.68,1.32)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_fill_manual(values=c(Okabe_Ito[3], dark2[8]),
                    labels = c("cPRC stim.", "ctr stim."))+
  scale_color_manual(values=c(Okabe_Ito[3], dark2[8]),
                     labels = c("cPRC stim.", "ctr stim."))

# save plot ---------------------------------------------------------------

ggsave("pictures/DAFFM.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS23 cPRC data with geom_smooth ----------------------------------------------

WT_cPRC_tidy$genotype <- factor(WT_cPRC_tidy$genotype, 
                                      levels=c("WT_cPRC", "NOS23_cPRC"))

WT_cPRC_tidy %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.4, size=1)+
  annotate("text", x=29, y=1.25, label="10 sec", size=3)+
  annotate("text", x=23, y=1.45, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.7, label="405 nm", size=4)+
  annotate("text", x=160, y=1.7, label="cPRC", size=5)+
  ylim(0.2,1.7)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(Okabe_Ito[6], paired[7]),
                     labels = c("wt", expression('NOS'^'Δ23/Δ23'))) +
  scale_fill_manual(values=c(Okabe_Ito[6], paired[7]),
                    labels = c("wt", expression('NOS'^'Δ23/Δ23')))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS23 INRGW data with geom_smooth ----------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb$genotype <- factor(WTvsNOS23_cPRC_INRGWa_tb$genotype, 
                                levels=c("WT_cPRC", "WT_INRGWa", "NOS23_cPRC", "NOS23_INRGWa"))

WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "NOS23_INRGWa" | genotype == "WT_INRGWa") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.4, size=1)+
  annotate("text", x=29, y=1.25, label="10 sec", size=3)+
  annotate("text", x=23, y=1.45, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.7, label="405 nm", size=4)+
  annotate("text", x=160, y=1.7, label="IN-RGWa", size=5)+
  ylim(0.75,1.7)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(blues[8], Okabe_Ito[2]),
                     labels = c("wt", expression('NOS'^'Δ23/Δ23'))) +
  scale_fill_manual(values=c(blues[8], Okabe_Ito[2]),
                    labels = c("wt", expression('NOS'^'Δ23/Δ23')))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_INRGW.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS11 cPRC data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb$genotype <- factor(WTvsNOS11_cPRC_INNOS_tb$genotype, 
                                            levels=c("WT_cPRC", "WT_INNOS", "NOS11_cPRC", "NOS11_INNOS"))

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_cPRC" | genotype == "NOS11_cPRC") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=93, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.8, yend=1.8, size=1)+
  annotate("segment", x=20, xend=20, y=1.8, yend=1.9, size=1)+
  annotate("text", x=29, y=1.65, label="10 sec", size=3)+
  annotate("text", x=23, y=2.05, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=2.6, label="405 nm", size=4)+
  annotate("text", x=160, y=2.6, label="cPRC", size=5)+
  ylim(0.4,2.6)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], paired[7]),
                     labels = c("wt", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(Okabe_Ito[6], paired[7]),
                    labels = c("wt", expression('NOS'^'Δ11/Δ11')))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS11 INNOS data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb$genotype <- factor(WTvsNOS11_cPRC_INNOS_tb$genotype, 
                                           levels=c("WT_cPRC", "WT_INNOS", "NOS11_cPRC", "NOS11_INNOS"))

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_INNOS" | genotype == "NOS11_INNOS") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=3.12, label="405 nm", size=4)+
  annotate("text", x=160, y=3.12, label="IN-NOS", size=5)+
  ylim(0.5,3.12)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[10], set2[4]),
                     labels = c("wt", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[10], set2[4]),
                    labels = c("wt", expression('NOS'^'Δ11/Δ11')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_INNOS.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  





# plot NOS11 Ser-h1 data with geom_smooth ----------------------------------------------


max(WTvsNOS11_Ser_tb$intensity)
min(WTvsNOS11_Ser_tb$intensity)

WTvsNOS11_Ser_tb$genotype <- factor(WTvsNOS11_Ser_tb$genotype, 
                                    levels=c("WT_Ser-h1", "NOS11_Ser-h1"))

WTvsNOS11_Ser_tb %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=3, label="405 nm", size=4)+
  annotate("text", x=160, y=3, label="Ser-h1", size=5)+
  ylim(0.5,3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[6], paired[5]),
                     labels = c("wt", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[6], paired[5]),
                    labels = c("wt", expression('NOS'^'Δ11/Δ11')))

# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_Ser-h1.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS11 MC data with geom_smooth ----------------------------------------------

max(WTvsNOS11_MC_tb$intensity)
min(WTvsNOS11_MC_tb$intensity)


WTvsNOS11_MC_tb$genotype <- factor(WTvsNOS11_MC_tb$genotype, 
                                    levels=c("WT_MC", "NOS11_MC"))

WTvsNOS11_MC_tb %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = genotype), level = 0.99, size = 1, span = 0.04, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=5, label="405 nm", size=4)+
  annotate("text", x=160, y=5, label="MC", size=5)+
  ylim(0.2,5)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(paired[12], dark2[6]),
                     labels = c("wt", expression('NOS'^'Δ11/Δ11'))) +
  scale_fill_manual(values=c(paired[12], dark2[6]),
                    labels = c("wt", expression('NOS'^'Δ11/Δ11')))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_MC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  





# plot NIT2MO INNOS data with geom_smooth ----------------------------------------------

max(NIT2MO_INNOS_tb$intensity)
min(NIT2MO_INNOS_tb$intensity)


NIT2MO_INNOS_tb %>%
  filter(MO == "NIT2MO1_NOS" | MO == "NIT2MO2_NOS") %>%
  ggplot(aes(x=frame,y=intensity,color=MO)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = MO), level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=3.12, label="405 nm", size=4)+
  annotate("text", x=160, y=3.12, label="IN-NOS", size=5)+
  ylim(0.5,3.12)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(dark2[4], set2[4]),
                     labels = c("NIT-GC2 MO1", "NIT-GC2 MO2")) +
  scale_fill_manual(values=c(dark2[4], set2[4]),
                    labels = c("NIT-GC2 MO1", "NIT-GC2 MO2"))


# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2MO_INNOS.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  


# plot NIT2MO INRGW data with geom_smooth ----------------------------------------------

max(NIT2MO_INRGW_tb$intensity)
min(NIT2MO_INRGW_tb$intensity)


NIT2MO_INRGW_tb %>%
  filter(MO == "NIT2MO1_RGW" | MO == "NIT2MO2_RGW") %>%
  ggplot(aes(x=frame,y=intensity,color=MO)) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  geom_smooth(aes(fill = MO), level = 0.99, size = 1, span = 0.03, 
              method = "loess") +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.4, size=1)+
  annotate("text", x=29, y=1.25, label="10 sec", size=3)+
  annotate("text", x=23, y=1.45, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=3.3, label="405 nm", size=4)+
  annotate("text", x=160, y=3.3, label="IN-RGWa", size=5)+
  ylim(0.5,3.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_color_manual(values=c(blues[8], Okabe_Ito[2]),
                     labels = c("NIT-GC2 MO1", "NIT-GC2 MO2")) +
  scale_fill_manual(values=c(blues[8], Okabe_Ito[2]),
                    labels = c("NIT-GC2 MO1", "NIT-GC2 MO2"))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2MO_INRGW.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  



# crop images --------------------------------------
img1 <- image_read("pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-1.png")
image_info(image = img1)
newimg1_1 <- image_crop(img1,geometry = "1660x1260")
newimg1_2 <- image_crop(newimg1_1,geometry = "1660x1180-0+80")
image_write(newimg1_2, path = "pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-1_crop.png", format = "png")

img2 <- image_read("pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-2.png")
image_info(image = img2)
newimg2_1 <- image_crop(img2,geometry = "1660x1260")
newimg2_2 <- image_crop(newimg2_1,geometry = "1660x1180-0+80")
image_write(newimg2_2, path = "pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-2_crop.png", format = "png")

# assemble figure ---------------------------------------------------------

panel_DAFFM  <- ggdraw() + draw_image(readPNG("pictures/DAFFM.png"))
panel_cPRC_NOS11 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_cPRC.png"))
panel_cPRC_NOS23 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_cPRC.png"))
panel_INRGW <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_INRGW.png"))
panel_INNOS <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_INNOS.png"))

panel_Ser <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_Ser-h1.png"))
panel_MC <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_MC.png"))

panel_NIT2MO_INRGW <- ggdraw() + draw_image(readPNG("pictures/NIT2MO_INRGW.png"))
panel_NIT2MO_INNOS <- ggdraw() + draw_image(readPNG("pictures/NIT2MO_INNOS.png"))

panel_correlation1 <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-1_crop.png")) +
  draw_label("cPRC", x = 0.4, y = 0.6, size = 9) +
  draw_label("IN-NOS", x = 0.35, y = 0.35, size = 9) +
  draw_label("IN-RGWa", x = 0.7, y = 0.28, size = 9) +
  draw_label("Ser-h1", x = 0.8, y = 0.5, size = 9)+
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "black", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "black", size = 10)

panel_correlation2 <- ggdraw() + draw_image(readPNG("pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_co1-2_crop.png")) +
  draw_label("cPRC", x = 0.4, y = 0.6, size = 9) +
  draw_label("IN-NOS", x = 0.35, y = 0.35, size = 9) +
  draw_label("IN-RGWa", x = 0.7, y = 0.28, size = 9) +
  draw_label("Ser-h1", x = 0.8, y = 0.5, size = 9)+
  draw_line(x = c(0.05, 0.407), y = c(0.1, 0.1), color = "black", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.23, y = 0.13, color = "black", size = 10)

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
ABC
DEF
GHI
"

Fig4 <- panel_DAFFM + panel_cPRC_NOS11 + panel_cPRC_NOS23 + 
  panel_correlation2 + panel_INNOS + panel_NIT2MO_INNOS + 
  panel_correlation1 + panel_INRGW  + panel_Ser +
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
          face='bold')) #or 'bold', 'italic'


ggsave("figures/Fig4.png", limitsize = FALSE, 
       units = c("px"), Fig4, width = 2800, height = 1800, bg='white')  

ggsave("figures/Fig4.pdf", limitsize = FALSE, 
       units = c("px"), Fig4, width = 2350, height = 1700)  







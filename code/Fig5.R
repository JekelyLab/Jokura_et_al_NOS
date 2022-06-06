#Code to assemble Fig5 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

DAFFM <- read_csv("data/220213_DAF-FM_long.csv")
WTvsNOS23 <- read_csv("data/211121_WTvsNOS23_cPRC.csv")
WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")
WTvsNOS23_cPRC_INRGWa <- read_csv("data/211209_WTvsNOS23_cPRC_INRGWa (2).csv")

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

#check factors
WTvsNOS11_cPRC_INNOS_tb %>%
  count(genotype)

WTvsNOS23_cPRC_INRGWa_tb%>%
  count(genotype)

# plot DAFFM neuropil data with geom_smooth ----------------------------------------------
DAFFM %>%
  count(stimuli)
DAFFM
min(DAFFM$intensity)

DAFFM %>%
  ggplot(aes(x=frame,y=intensity,color=stimuli)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  annotate("segment", x=20, xend=40, y=1.2, yend=1.2, size=1)+
  annotate("segment", x=20, xend=20, y=1.2, yend=1.3, size=1)+
  annotate("text", x=29, y=1.15, label="10 sec", size=3)+
  annotate("text", x=23, y=1.35, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.4, label="405 nm", size=4)+
  annotate("text", x=160, y=1.4, label="neuropil DAF-FM", size=5)+
  ylim(0.6,1.4)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[2]),
                     labels = c(expression('cPRC stim.'), "ctr stim." ))

# save plot ---------------------------------------------------------------

ggsave("pictures/DAFFM.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS23 cPRC data with geom_smooth ----------------------------------------------

WT_cPRC_tidy %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
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
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[2]),
                     labels = c(expression('NOS'^'Δ23/Δ23'), "wt" ))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS23 INRGW data with geom_smooth ----------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "WT_INRGWa" | genotype == "NOS23_INRGWa") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  annotate("segment", x=20, xend=40, y=1.3, yend=1.3, size=1)+
  annotate("segment", x=20, xend=20, y=1.3, yend=1.4, size=1)+
  annotate("text", x=29, y=1.25, label="10 sec", size=3)+
  annotate("text", x=23, y=1.45, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.8, label="405 nm", size=4)+
  annotate("text", x=160, y=1.8, label="INRGW", size=5)+
  ylim(0.6,1.8)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[2]),
                     labels = c(expression('NOS'^'Δ23/Δ23'), "wt" ))


# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS23_INRGW.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS11 cPRC data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_cPRC" | genotype == "NOS11_cPRC") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
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
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[2]),
                     labels = c(expression('NOS'^'Δ11/Δ11'), 
                                "wt"))
# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NOS11 INNOS data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_INNOS" | genotype == "NOS11_INNOS") %>%
  ggplot(aes(x=frame,y=intensity,color=genotype)) +
  geom_smooth(level = 0.99, size = 1, span = 0.02, 
              method = "loess") +
  geom_line(aes(group = sample), size=0.2, alpha=0.2) +
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, 
           alpha=0.1, fill="blue") +
  annotate("segment", x=20, xend=40, y=1.6, yend=1.6, size=1)+
  annotate("segment", x=20, xend=20, y=1.6, yend=1.7, size=1)+
  annotate("text", x=29, y=1.45, label="10 sec", size=3)+
  annotate("text", x=23, y=1.85, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=3.12, label="405 nm", size=4)+
  annotate("text", x=160, y=3.12, label="INNOS", size=5)+
  ylim(0.5,3.12)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[6], Okabe_Ito[2]),
                     labels = c(expression('NOS'^'Δ11/Δ11'), 
                                "wt"))
# save plot ---------------------------------------------------------------

ggsave("pictures/WTvsNOS11_INNOS.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# assemble figure ---------------------------------------------------------

panel_DAFFM  <- ggdraw() + draw_image(readPNG("pictures/DAFFM.png"))
panel_cPRC_NOS11 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_cPRC.png"))
panel_cPRC_NOS23 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_cPRC.png"))
panel_INRGW <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_INRGW.png"))
panel_INNOS <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_INNOS.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B
C#D
E##
"

Fig5 <- panel_DAFFM + panel_cPRC_NOS11 + panel_cPRC_NOS23 + 
  panel_INNOS + panel_INRGW +
  patchwork::plot_layout(design = layout, 
      widths = c(1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
          face='plain')) #or 'bold', 'italic'

ggsave("figures/Fig5.png", limitsize = FALSE, 
       units = c("px"), Fig5, width = 2400, height = 2400, bg='white')  

ggsave("figures/Fig5.pdf", limitsize = FALSE, 
       units = c("px"), Fig5, width = 2350, height = 1700)  







#Code to assemble Fig3 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

DAFFM <- read_csv("data/220213_DAF-FM_long.csv")

WTvsNOS23 <- read_csv("data/211121_WTvsNOS23_cPRC.csv")
WTvsNOS11_cPRC_INNOS <- read_csv("data/211129_WTvsNOS11_cPRC_INNOS (2).csv")

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


# plot NOS11 cPRC data (vs INNOS) with geom_smooth ----------------------------------------------

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


# assemble figure ---------------------------------------------------------
arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.75, y2 = 0.85)

panel_DAF <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_134.95um.png")) +
  draw_label("DAF-FM", x = 0.15, y = 0.88, color="green", size = 11, fontface="plain") +
  draw_line(x = c(0.04, 0.42), y = c(0.09, 0.09), color = "white", size = 0.5) +
  draw_label(expression(paste("50 ", mu, "m")), x = 0.23, y = 0.12, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.88, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.72, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2)

panel_DAFFM_intensity  <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_intensity.png")) +
  draw_label("before", x = 0.17, y = 0.9, color='white',size = 9, fontface='plain') +
  draw_label("405 nm", x = 0.2, y = 0.45, color='white',size = 9, fontface='plain') +
  draw_line(x = c(0.05, 0.42), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("10 ", mu, "m")), x = 0.23, y = 0.11, color = "white", size = 8)

panel_DAFFM  <- ggdraw() + draw_image(readPNG("pictures/DAFFM.png"))

panel_cPRC_NOS11 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS11_cPRC.png"))
panel_cPRC_NOS23 <- ggdraw() + draw_image(readPNG("pictures/WTvsNOS23_cPRC.png"))


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AA#B#CCC
########
FFFFGGGG
"

Fig3 <- panel_DAF + panel_DAFFM_intensity + panel_DAFFM + 
  panel_cPRC_NOS11 + panel_cPRC_NOS23 + 
  patchwork::plot_layout(design = layout, 
                         heights = c(1, 0.02, 0.7),
                         widths = c(1,0.78,0.05,1,0.05,1,0.78,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

ggsave("figures/Fig3.pdf", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2000, height = 1220)  

ggsave("figures/Fig3.png", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2000, height = 1220, bg='white')  



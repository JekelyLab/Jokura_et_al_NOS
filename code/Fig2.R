#Code to assemble Fig2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

cPRC <- read_csv("data/230524_DAF-FM_cPRC.csv")
NC <- read_csv("data/230524_DAF-FM_NC.csv")

long_cPRC <- pivot_longer(cPRC, cols = c("larva_1","larva_2","larva_3","larva_4","larva_5","larva_6","larva_7","larva_8","larva_9","larva_10","larva_11"), 
                          names_to = "sample", values_to = "intensity")

long_NC <- pivot_longer(NC, cols = c("larva_12","larva_13","larva_14","larva_15","larva_16","larva_17","larva_18","larva_19"), 
                        names_to = "sample", values_to = "intensity")

DAFFM <- rbind(long_cPRC, long_NC)

# plot DAFFM neuropil data with geom_smooth ----------------------------------------------

#sample size control
DAFFM %>%
  filter(stimuli=='NC') %>%
  select(sample) %>%
  unique()

#sample size cPRC
DAFFM %>%
  filter(stimuli=='cPRC') %>%
  select(sample) %>%
  unique()
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
  annotate("text", x=29, y=1.18, label="10 sec", size=3)+
  annotate("text", x=23, y=1.315, label="0.2 ΔF/F0", size=3)+
  annotate("text", x=70, y=1.32, label="405 nm", size=4)+
  annotate("text", x=160, y=1.32, label="neuropil DAF-FM", size=5)+
  ylim(0.68,1.335)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_fill_manual(values=c(Okabe_Ito[3], dark2[8]),
                    labels = c("cPRC stim.", "ctr stim."))+
  scale_color_manual(values=c(Okabe_Ito[3], dark2[8]),
                     labels = c("cPRC stim.", "ctr stim."))

# save to source data-------------------------------------------------------

DAFFM %>%
  write_csv("source_data/Figure2_source_data1.csv")

# save plot ---------------------------------------------------------------

ggsave("pictures/DAFFM.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  


# assemble figure ---------------------------------------------------------
arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.75, y2 = 0.85)

panel_DAF <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_134.95um.png"))

panel_DAFFM_intensity  <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_intensity.png"))

panel_DAFFM  <- ggdraw() + draw_image(readPNG("pictures/DAFFM.png"))

panel_UV_stimulation  <- ggdraw() + draw_image(readPNG("pictures/UV_stimulation.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B#C
"

Fig2 <- panel_DAF + panel_DAFFM_intensity + panel_DAFFM + 
  patchwork::plot_layout(design = layout, 
                         widths = c(0.5,0.05,0.28,0.025,0.95)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

ggsave("Manuscript/figures/Fig2.png", limitsize = FALSE, 
       units = c("px"), Fig2, width = 3000, height = 950, bg='white')

ggsave("Manuscript/figures/Fig2.pdf", limitsize = FALSE, 
       units = c("px"), Fig2, width = 3000, height = 950)  
  



layout_sup1 <- "
A
"
Fig2_sup1 <- panel_UV_stimulation +
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'bold', 'italic'

ggsave("Manuscript/figures/Fig2_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig2_sup1, width = 1200, height = 850, bg='white')

ggsave("Manuscript/figures/Fig2_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig2_sup1, width = 1200, height = 850)  



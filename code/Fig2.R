#Code to assemble Fig2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

DAFFM <- read_csv("data/220213_DAF-FM_long.csv")


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
  ylim(0.68,1.32)+
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

panel_DAF <- ggdraw() + draw_image(readPNG("pictures/55hpf_DAF-FM_134.95um.png")) +
  draw_label("DAF-FM", x = 0.15, y = 0.88, color="#009E73", size = 11, fontface="plain") +
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


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AA#B#CCC
"

Fig2v2 <- panel_DAF + panel_DAFFM_intensity + panel_DAFFM + 
  patchwork::plot_layout(design = layout, 
                         widths = c(1,0.78,0.05,1,0.05,1,0.78,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
                                         face='plain')) #or 'bold', 'italic'

ggsave("Manuscript/figures/Fig2.png", limitsize = FALSE, 
       units = c("px"), Fig2v2, width = 2100, height = 800, bg='white')

ggsave("Manuscript/figures/Fig2.pdf", limitsize = FALSE, 
       units = c("px"), Fig2v2, width = 2100, height = 800)  
  

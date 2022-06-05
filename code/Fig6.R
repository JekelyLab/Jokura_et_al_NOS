#Code to assemble Fig6 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data ---------------------------------------------------------------

NIT1_MO <- read_csv("data/220214_non-MOvsNIT1-MO1and2.csv")
NIT2_MO <- read_csv("data/220522_NIT2-MO1and2.csv")


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

# plot NIT1 morphant data with geom_smooth ----------------------------------------------

NIT1_MO_tb %>%
  ggplot(aes(x=frame,y=intensity,color=morphant)) +
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
  annotate("text", x=160, y=2.3, label="cPRC", size=5)+
  ylim(0.1,2.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[1], Okabe_Ito[7],
                              Okabe_Ito[2]),
                     labels = c('NIT-GC1 MO1','NIT-GC1 MO2', 
                                'control'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT1_MO_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  

# plot NIT morphant data with geom_smooth ----------------------------------------------

NIT2_MO_tb %>%
  ggplot(aes(x=frame, y=intensity, color=morphant)) +
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
  annotate("text", x=160, y=2.3, label="cPRC", size=5)+
  ylim(0.4,2.3)+
  theme_void()  +
  theme(legend.title = element_blank(), legend.text.align=0,
        legend.text = element_text(size=12)) +
  #Specify colours and legend labels
  scale_color_manual(values=c(Okabe_Ito[1], Okabe_Ito[7]),
                     labels = c('NIT-GC2 MO1','NIT-GC2 MO2'))

# save plot ---------------------------------------------------------------

ggsave("pictures/NIT2_MO_cPRC.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 800, bg='white')  



# assemble figure ---------------------------------------------------------

panel_cPRC_NIT1_MO <- ggdraw() + draw_image(readPNG("pictures/NIT1_MO_cPRC.png"))
panel_cPRC_NIT2_MO <- ggdraw() + draw_image(readPNG("pictures/NIT2_MO_cPRC.png"))


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
A#B
C#D
"

Fig1 <- panel_cPRC_NIT1_MO + panel_cPRC_NIT2_MO +
  patchwork::plot_layout(design = layout, 
      widths = c(1,0.02,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = "A") &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, 
          face='plain')) #or 'bold', 'italic'

ggsave("figures/Fig6.png", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2400, height = 2400, bg='white')  

ggsave("figures/Fig6.pdf", limitsize = FALSE, 
       units = c("px"), Fig1, width = 2350, height = 1700)  







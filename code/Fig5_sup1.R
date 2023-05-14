#Code to assemble Fig5 sup1 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")


# assemble figure ---------------------------------------------------------
arrow_fluo <- data.frame(x1 = 0.95, x2 = 0.95, y1 = 0.8, y2 = 0.9)

panel_NOS <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um_NOS.png"))+
  draw_label("in situ HCR", x = 0.25, y = 0.995, size = 10) +
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 10, fontface="italic") +
  draw_line(x = c(0.04, 0.24), y = c(0.08, 0.08), color = "white", size = 0.5) +
  draw_label(expression(paste("20 ", mu, "m")), x = 0.14, y = 0.11, color = "white", size = 8) +
  draw_label("D", x = 0.95, y = 0.93, size = 6, color = "white") +
  draw_label("V", x = 0.95, y = 0.77, size = 6, color = "white") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrow_fluo, color = "white", 
               arrow = arrow(ends = "both", type = "closed", length = unit(0.1,"cm")),
               lineend = "butt",
               linejoin = "mitre",
               arrow.fill = "white", size = 0.2) +
  draw_label("eyespots", x = 0.55, y = 0.34, size = 6, color = "white") +
  draw_line(x = c(0.16, 0.44), y = c(0.51, 0.35), color = "white", size = 0.1) +
  draw_line(x = c(0.92, 0.65), y = c(0.48, 0.35), color = "white", size = 0.1) +
  draw_label("INNOS", x = 0.55, y = 0.7, color="white", size = 7, fontface="bold")

panel_RYa <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um_RYa.png"))+
  draw_label("RYa", x = 0.12, y = 0.9, color="green", size = 10, fontface="italic")

panel_NOS_RYa <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um_RYa_NOS.png"))+
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 10, fontface="italic") +
  draw_label("RYa", x = 0.26, y = 0.9, color="green", size = 10, fontface="italic")

panel_merge <- ggdraw() + draw_image(readPNG("pictures/HCR_52_AP_NOS_RYa_101.29um_merge.png"))+
  draw_label("NOS", x = 0.12, y = 0.9, color="magenta", size = 10, fontface="italic") +
  draw_label("RYa", x = 0.28, y = 0.9, color="green", size = 10, fontface="italic") +
  draw_label("DAPI", x = 0.45, y = 0.9, color="cyan", size = 10, fontface="plain")


panel_method <- ggdraw() + draw_image(readPNG("pictures/Diagram of agarose embedding immunostaining.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AAAAA
#####
B#C#D
"

Fig5_sup1 <- panel_method + 
  panel_NOS + panel_RYa + panel_merge + 
  patchwork::plot_layout(design = layout, 
                         widths = c(1, 0.02, 1, 0.02, 1), 
                         heights = c(1, 0.02, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain'))

ggsave("Manuscript/figures/Fig5_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig5_sup1, width = 2000, height = 1475, bg='white')  

ggsave("Manuscript/figures/Fig5_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig5_sup1, width = 2000, height = 1475)  

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


# tidying the data -----------------------------------------------------------

WTvsNOS11_cPRC_INNOS_tb <- WTvsNOS11_cPRC_INNOS %>%
  pivot_longer(
    cols = -c("frame"),
    names_to = "genotype",
    values_to = "intensity"
  ) %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

WTvsNOS23_cPRC_INRGWa_tb <- WTvsNOS23_cPRC_INRGWa %>%
  pivot_longer(
    cols = -c("frame"),
    names_to = "genotype",
    values_to = "intensity"
  ) %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

#WTvsNOS11 Ser-h1 & MC

WTvsNOS11_Ser_tb <- WTvsNOS11_Ser %>%
  pivot_longer(
    cols = -c("frame"),
    names_to = "genotype",
    values_to = "intensity"
  ) %>%
  separate(col = c("genotype"), into = c("genotype", "sample"), sep = "\\...")

#NIT2MO
NIT2MO_INNOS_tb <- NIT2MO_INNOS %>%
  pivot_longer(cols = -c("frame"), names_to = "MO", values_to = "intensity") %>%
  separate(col = c("MO"), into = c("MO", "sample"), sep = "\\...")

NIT2MO_INRGW_tb <- NIT2MO_INRGW %>%
  pivot_longer(cols = -c("frame"), names_to = "MO", values_to = "intensity") %>%
  separate(col = c("MO"), into = c("MO", "sample"), sep = "\\...")

#check factors
WTvsNOS11_cPRC_INNOS_tb %>%
  count(genotype)

WTvsNOS23_cPRC_INRGWa_tb %>%
  count(genotype)

# plot NOS11 INNOS data with geom_smooth ----------------------------------------------

WTvsNOS11_cPRC_INNOS_tb$genotype <- factor(
  WTvsNOS11_cPRC_INNOS_tb$genotype,
  levels = c("WT_cPRC", "WT_INNOS", "NOS11_cPRC", "NOS11_INNOS")
)

INNOS_plot <- WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_INNOS" | genotype == "NOS11_INNOS") %>%
  ggplot() +
  annotate(
    "rect",
    xmin = 51,
    xmax = 93,
    ymin = -Inf,
    ymax = Inf,
    alpha = 0.1,
    fill = "blue"
  ) +
  aes(x = frame, y = intensity, color = genotype) +
  geom_line(aes(group = sample), size = 0.3, alpha = 0.3) +
  geom_smooth(
    aes(fill = genotype),
    level = 0.99,
    size = 1,
    span = 0.03,
    method = "loess"
  ) +
  annotate("segment", x = 15, xend = 35, y = 2.0, yend = 2.0, size = 1) +
  annotate("segment", x = 15, xend = 15, y = 2.0, yend = 2.25, size = 1) +
  annotate("text", x = 24, y = 1.91, label = "10 sec", size = 3) +
  annotate("text", x = 32, y = 2.13, label = "0.5 ΔF/F0", size = 3) +
  annotate(
    "text",
    x = 72,
    y = 3.12,
    label = "405 nm",
    color = "purple",
    size = 4
  ) +
  annotate("text", x = 160, y = 3.12, label = "INNOS", size = 5) +
  ylim(0.5, 3.12) +
  theme_void() +
  theme(
    legend.title = element_blank(),
    legend.text.align = 0,
    legend.text = element_text(size = 12)
  ) +
  scale_color_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ11/Δ11'))
  ) +
  scale_fill_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ11/Δ11'))
  )

# save to source data-------------------------------------------------------

WTvsNOS11_cPRC_INNOS_tb %>%
  filter(genotype == "WT_INNOS" | genotype == "NOS11_INNOS") %>%
  write_csv("source_data/Figure5_source_data1.csv")


# save plot ---------------------------------------------------------------

ggsave(
  "pictures/WTvsNOS11_INNOS.png",
  INNOS_plot,
  limitsize = FALSE,
  units = c("px"),
  width = 1500,
  height = 800,
  bg = 'white'
)


# plot NOS23 INRGW data with geom_smooth ----------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb$genotype <- factor(
  WTvsNOS23_cPRC_INRGWa_tb$genotype,
  levels = c("WT_cPRC", "WT_INRGWa", "NOS23_cPRC", "NOS23_INRGWa")
)

INRGW_plot <- WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "NOS23_INRGWa" | genotype == "WT_INRGWa") %>%
  ggplot() +
  annotate(
    "rect",
    xmin = 51,
    xmax = 93,
    ymin = -Inf,
    ymax = Inf,
    alpha = 0.1,
    fill = "blue"
  ) +
  aes(x = frame, y = intensity, color = genotype) +
  geom_line(aes(group = sample), size = 0.3, alpha = 0.3) +
  geom_smooth(
    aes(fill = genotype),
    level = 0.99,
    size = 1,
    span = 0.03,
    method = "loess"
  ) +
  annotate("segment", x = 15, xend = 35, y = 1.4, yend = 1.4, size = 1) +
  annotate("segment", x = 15, xend = 15, y = 1.4, yend = 1.5, size = 1) +
  annotate("text", x = 24, y = 1.36, label = "10 sec", size = 3) +
  annotate("text", x = 32, y = 1.45, label = "0.2 ΔF/F0", size = 3) +
  annotate(
    "text",
    x = 72,
    y = 1.7,
    label = "405 nm",
    color = "purple",
    size = 4
  ) +
  annotate("text", x = 160, y = 1.7, label = "INRGW", size = 5) +
  ylim(0.75, 1.7) +
  theme_void() +
  theme(
    legend.title = element_blank(),
    legend.text.align = 0,
    legend.text = element_text(size = 12)
  ) +
  #Specify colours and legend labels
  scale_color_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ23/Δ23'))
  ) +
  scale_fill_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ23/Δ23'))
  )

# save to source data-------------------------------------------------------

WTvsNOS23_cPRC_INRGWa_tb %>%
  filter(genotype == "NOS23_INRGWa" | genotype == "WT_INRGWa") %>%
  write_csv("source_data/Figure5_source_data2.csv")

# save plot ---------------------------------------------------------------

ggsave(
  "pictures/WTvsNOS23_INRGW.png",
  INRGW_plot,
  limitsize = FALSE,
  units = c("px"),
  width = 1500,
  height = 800,
  bg = 'white'
)

# plot NIT2MO INNOS data with geom_smooth ----------------------------------------------

max(NIT2MO_INNOS_tb$intensity)
min(NIT2MO_INNOS_tb$intensity)

NIT2MO_INNOS_plot <- NIT2MO_INNOS_tb %>%
  filter(MO == "NIT2MO1_NOS" | MO == "NIT2MO2_NOS") %>%
  ggplot() +
  annotate(
    "rect",
    xmin = 51,
    xmax = 93,
    ymin = -Inf,
    ymax = Inf,
    alpha = 0.1,
    fill = "blue"
  ) +
  aes(x = frame, y = intensity, color = MO) +
  geom_line(aes(group = sample), size = 0.3, alpha = 0.3) +
  geom_smooth(
    aes(fill = MO),
    level = 0.99,
    size = 1,
    span = 0.02,
    method = "loess"
  ) +
  annotate("segment", x = 15, xend = 35, y = 1.6, yend = 1.6, size = 1) +
  annotate("segment", x = 15, xend = 15, y = 1.6, yend = 1.85, size = 1) +
  annotate("text", x = 24, y = 1.52, label = "10 sec", size = 3) +
  annotate("text", x = 32, y = 1.73, label = "0.5 ΔF/F0", size = 3) +
  annotate(
    "text",
    x = 72,
    y = 3.12,
    label = "405 nm",
    color = "purple",
    size = 4
  ) +
  annotate("text", x = 160, y = 3.12, label = "INNOS", size = 5) +
  ylim(0.5, 3.12) +
  theme_void() +
  theme(
    legend.title = element_blank(),
    legend.text.align = 0,
    legend.text = element_text(size = 12)
  ) +
  scale_color_manual(
    values = c(Okabe_Ito[2], Okabe_Ito[6]),
    labels = c("NIT2 MO1", "NIT2 MO2")
  ) +
  scale_fill_manual(
    values = c(Okabe_Ito[2], Okabe_Ito[6]),
    labels = c("NIT2 MO1", "NIT2 MO2")
  )

# save to source data-------------------------------------------------------

NIT2MO_INNOS_tb %>%
  filter(MO == "NIT2MO1_NOS" | MO == "NIT2MO2_NOS") %>%
  write_csv("source_data/Figure5_source_data3.csv")

# save plot ---------------------------------------------------------------

ggsave(
  "pictures/NIT2MO_INNOS.png",
  NIT2MO_INNOS_plot,
  limitsize = FALSE,
  units = c("px"),
  width = 1500,
  height = 800,
  bg = 'white'
)

# plot NIT2MO INRGW data with geom_smooth ----------------------------------------------

max(NIT2MO_INRGW_tb$intensity)
min(NIT2MO_INRGW_tb$intensity)

NIT2MO_INRGW_plot <- NIT2MO_INRGW_tb %>%
  filter(MO == "NIT2MO1_RGW" | MO == "NIT2MO2_RGW") %>%
  ggplot() +
  annotate(
    "rect",
    xmin = 51,
    xmax = 93,
    ymin = -Inf,
    ymax = Inf,
    alpha = 0.1,
    fill = "blue"
  ) +
  aes(x = frame, y = intensity, color = MO) +
  geom_line(aes(group = sample), size = 0.3, alpha = 0.3) +
  geom_smooth(
    aes(fill = MO),
    level = 0.99,
    size = 1,
    span = 0.03,
    method = "loess"
  ) +
  annotate("segment", x = 15, xend = 35, y = 2.0, yend = 2.0, size = 1) +
  annotate("segment", x = 15, xend = 15, y = 2.0, yend = 2.25, size = 1) +
  annotate("text", x = 24, y = 1.9, label = "10 sec", size = 3) +
  annotate("text", x = 32, y = 2.13, label = "0.5 ΔF/F0", size = 3) +
  annotate(
    "text",
    x = 72,
    y = 3.3,
    label = "405 nm",
    color = "purple",
    size = 4
  ) +
  annotate("text", x = 160, y = 3.3, label = "INRGW", size = 5) +
  ylim(0.5, 3.3) +
  theme_void() +
  theme(
    legend.title = element_blank(),
    legend.text.align = 0,
    legend.text = element_text(size = 12)
  ) +
  scale_color_manual(
    values = c(Okabe_Ito[2], Okabe_Ito[6]),
    labels = c("NIT2 MO1", "NIT2 MO2")
  ) +
  scale_fill_manual(
    values = c(Okabe_Ito[2], Okabe_Ito[6]),
    labels = c("NIT2 MO1", "NIT2 MO2")
  )

# save to source data-------------------------------------------------------

NIT2MO_INRGW_tb %>%
  filter(MO == "NIT2MO1_RGW" | MO == "NIT2MO2_RGW") %>%
  write_csv("source_data/Figure5_source_data4.csv")

# save plot ---------------------------------------------------------------

ggsave(
  "pictures/NIT2MO_INRGW.png",
  NIT2MO_INRGW_plot,
  limitsize = FALSE,
  units = c("px"),
  width = 1500,
  height = 800,
  bg = 'white'
)

# plot NOS11 Ser-h1 data with geom_smooth ----------------------------------------------

max(WTvsNOS11_Ser_tb$intensity)
min(WTvsNOS11_Ser_tb$intensity)

WTvsNOS11_Ser_tb$genotype <- factor(
  WTvsNOS11_Ser_tb$genotype,
  levels = c("WT_Ser-h1", "NOS11_Ser-h1")
)

Ser_plot <- WTvsNOS11_Ser_tb %>%
  ggplot() +
  annotate(
    "rect",
    xmin = 51,
    xmax = 93,
    ymin = -Inf,
    ymax = Inf,
    alpha = 0.1,
    fill = "blue"
  ) +
  geom_line(aes(group = sample), size = 0.3, alpha = 0.3) +
  aes(x = frame, y = intensity, color = genotype) +
  geom_smooth(
    aes(fill = genotype),
    level = 0.99,
    size = 1,
    span = 0.03,
    method = "loess"
  ) +
  annotate("segment", x = 15, xend = 35, y = 2.0, yend = 2.0, size = 1) +
  annotate("segment", x = 15, xend = 15, y = 2.0, yend = 2.25, size = 1) +
  annotate("text", x = 24, y = 1.92, label = "10 sec", size = 3) +
  annotate("text", x = 32, y = 2.13, label = "0.5 ΔF/F0", size = 3) +
  annotate(
    "text",
    x = 72,
    y = 3,
    label = "405 nm",
    color = "purple",
    size = 4
  ) +
  annotate("text", x = 160, y = 3, label = "Ser-h1", size = 5) +
  ylim(0.5, 3) +
  theme_void() +
  theme(
    legend.title = element_blank(),
    legend.text.align = 0,
    legend.text = element_text(size = 12)
  ) +
  scale_color_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ11/Δ11'))
  ) +
  scale_fill_manual(
    values = c(Okabe_Ito[1], Okabe_Ito[5]),
    labels = c("WT", expression('NOS'^'Δ11/Δ11'))
  )

# save to source data-------------------------------------------------------

WTvsNOS11_Ser_tb %>%
  write_csv("source_data/Figure5_figS2_source_data1.csv")

# save plot ---------------------------------------------------------------

ggsave(
  "pictures/WTvsNOS11_Ser-h1.png",
  Ser_plot,
  limitsize = FALSE,
  units = c("px"),
  width = 1500,
  height = 800,
  bg = 'white'
)


# assemble figure ---------------------------------------------------------

arrow_fluo <- data.frame(x1 = 0.9, x2 = 0.9, y1 = 0.75, y2 = 0.85)
panel_Ca_IHC_RY <- ggdraw() +
  draw_image(readPNG("pictures/n51hpf_WT_d-1_calcium_RY.png"))
panel_Ca_IHC_RGW <- ggdraw() +
  draw_image(readPNG("pictures/n54hpf_WT_e_calcium_RGW.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

layout2 <- "
AAAAAABBBBBB
############
CCCCCCDDDDDD
############
EEEEEEFFFFFF"

Fig5 <- panel_Ca_IHC_RY +
  panel_Ca_IHC_RGW +
  INNOS_plot +
  NIT2MO_INNOS_plot +
  INRGW_plot +
  NIT2MO_INRGW_plot +
  patchwork::plot_layout(
    design = layout2,
    heights = c(0.82, 0.05, 1, 0.05, 1)
  ) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') & #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face = 'plain')) #or 'plain', 'italic'


ggsave(
  "Manuscript/figures/Fig5.png",
  limitsize = FALSE,
  units = c("px"),
  Fig5,
  width = 3050,
  height = 2000,
  bg = 'white'
)


ggsave(
  "Manuscript/figures/Fig5.pdf",
  limitsize = FALSE,
  units = c("px"),
  Fig5,
  width = 3050,
  height = 2000
)


# assemble Figure 5 --figure supplement 2

panel_correlation <- ggdraw() +
  draw_image(readPNG(
    "pictures/n54hpf_WT_e-1_ROI60_PD1.54_power2-8_pin216.9_frame_101-141_401-441_correlation.png"
  ))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes

layout_suppl <- "
AB"

Fig5 <- panel_correlation +
  Ser_plot +
  patchwork::plot_layout(design = layout_suppl) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') & #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face = 'plain')) #or 'plain', 'italic'


ggsave(
  "Manuscript/figures/Fig5_sup2.png",
  limitsize = FALSE,
  units = c("px"),
  Fig5,
  width = 3500,
  height = 1000,
  bg = 'white'
)


ggsave(
  "Manuscript/figures/Fig5_sup2.pdf",
  limitsize = FALSE,
  units = c("px"),
  Fig5,
  width = 3500,
  height = 1000
)

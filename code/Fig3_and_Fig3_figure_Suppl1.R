#Code to assemble Fig3 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data----------------------------------------------------------------

{
WT_2d <- read_csv("data/2017-08-29_YDisplacement_2d_NNxNN_UV-Side-480nm-395nm-Good.csv")
NOS11x11_2d <- read_csv("data/2017-08-29_YDisplacement_2d_nn11xnn11_UV-Side-480nm-395nm-Good.csv")
NOS23x23_2d <- read_csv("data/2017-08-29_YDisplacement_2d_nn23xnn23_UV-Side-480nm-395nm-Good.csv")
NOS11x23_2d <- read_csv("data/2017-08-29_YDisplacement_2d_nn11xnn23_UV-Side-480nm-395nm-Good.csv")

WT_3d <- read_csv("data/2017-08-29_YDisplacement_3d_NNxNN_UV-Side-480nm-395nm-Good.csv")
NOS11x11_3d <- read_csv("data/2017-08-29_YDisplacement_3d_nn11xnn11_UV-Side-480nm-395nm-Good.csv")
NOS23x23_3d <- read_csv("data/2017-08-29_YDisplacement_3d_nn23xnn23_UV-Side-480nm-395nm-Good.csv")
NOS11x23_3d <- read_csv("data/2017-08-29_YDisplacement_3d_nn11xnn23_UV-Side-480nm-395nm-Good.csv")

L_NAME_00mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_0mM_L-NAME_UV-Side-480nm-395nm-Good.csv")
L_NAME_01mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_0.1mM_L-NAME_UV-Side-480nm-395nm-Good.csv")
L_NAME_1mM_3d <- read_csv("data/2017-08-29_YDisplacement_3d_1mM_L-NAME_UV-Side-480nm-395nm-Good.csv")

#Import trajectory data focusing on sideUV, 10s before and 30 s after

df_2d_nor <- read_csv("data/221011_sUV_tracking/sUV_tracking_2d.csv")
df_3d_nor <- read_csv("data/221011_sUV_tracking/sUV_tracking_3d.csv")


#Used for frame and genotype column data
df_WT_test <- read_csv("data/220923_Tracking raw data/WT_0701_08_01.csv")
df_NOS_test <- read_csv("data/220923_Tracking raw data/NOS_0623_00_01.csv")

#read L-NAME 3days tracking csv file
df_L_NAME_tracking <- read_csv("data/230511_df_L_NAME.csv")

}

# tidying Martin data (30 sec bins, vertical displacement)------------------------------------------------

{
WT_2d_tidy <- gather(WT_2d, key="WT", value="displacement", -time, -condition)
WT_2d_tidy_genotype <- gather(WT_2d_tidy, key="genotype", value="batch", -time, -condition, -displacement)

NOS11x11_2d_tidy <- gather(NOS11x11_2d, key="NOS11x11", value="displacement", -time, -condition)
NOS11x11_2d_tidy_genotype <- gather(NOS11x11_2d_tidy, key="genotype", value="batch", -time, -condition, -displacement)
NOS23x23_2d_tidy <- gather(NOS23x23_2d, key="NOS23x23", value="displacement", -time, -condition)
NOS23x23_2d_tidy_genotype <- gather(NOS23x23_2d_tidy, key="genotype", value="batch", -time, -condition, -displacement)
NOS11x23_2d_tidy <- gather(NOS11x23_2d, key="NOS11x23", value="displacement", -time, -condition)
NOS11x23_2d_tidy_genotype <- gather(NOS11x23_2d_tidy, key="genotype", value="batch", -time, -condition, -displacement)

WT_3d_tidy <- gather(WT_3d, key="WT", value="displacement", -time, -condition)
WT_3d_tidy_genotype <- gather(WT_3d_tidy, key="genotype", value="batch", -time, -condition, -displacement)

NOS11x11_3d_tidy <- gather(NOS11x11_3d, key="NOS11x11", value="displacement", -time, -condition)
NOS11x11_3d_tidy_genotype <- gather(NOS11x11_3d_tidy, key="genotype", value="batch", -time, -condition, -displacement)
NOS23x23_3d_tidy <- gather(NOS23x23_3d, key="NOS23x23", value="displacement", -time, -condition)
NOS23x23_3d_tidy_genotype <- gather(NOS23x23_3d_tidy, key="genotype", value="batch", -time, -condition, -displacement)
NOS11x23_3d_tidy <- gather(NOS11x23_3d, key="NOS11x23", value="displacement", -time, -condition)
NOS11x23_3d_tidy_genotype <- gather(NOS11x23_3d_tidy, key="genotype", value="batch", -time, -condition, -displacement)

L_NAME_00mM_3d_tidy <- gather(L_NAME_00mM_3d, key="0 mM", value="displacement", -time, -condition)
L_NAME_00mM_3d_conc <- gather(L_NAME_00mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)
L_NAME_01mM_3d_tidy <- gather(L_NAME_01mM_3d, key="0.1 mM", value="displacement", -time, -condition)
L_NAME_01mM_3d_conc <- gather(L_NAME_01mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)
L_NAME_1mM_3d_tidy <- gather(L_NAME_1mM_3d, key="1.0 mM", value="displacement", -time, -condition)
L_NAME_1mM_3d_conc <- gather(L_NAME_1mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)


#bind
WTvsNOS_2d <- bind_rows(WT_2d_tidy_genotype, NOS11x11_2d_tidy_genotype, NOS23x23_2d_tidy_genotype, NOS11x23_2d_tidy_genotype) %>%
  mutate(genotype = factor(genotype, levels = c("WT", "NOS11x11", "NOS23x23", "NOS11x23")))

WTvsNOS_3d <- bind_rows(WT_3d_tidy_genotype, NOS11x11_3d_tidy_genotype, NOS23x23_3d_tidy_genotype, NOS11x23_3d_tidy_genotype) %>%
  mutate(genotype = factor(genotype, levels = c("WT", "NOS11x11", "NOS23x23", "NOS11x23")))

L_NAME_3d <- bind_rows(L_NAME_00mM_3d_conc, L_NAME_01mM_3d_conc, L_NAME_1mM_3d_conc)
L_NAME_3d$`L-NAME` <- factor(L_NAME_3d$`L-NAME`, levels = c("0 mM", "0.1 mM", "1.0 mM"))
}

# plot Martin data (2d larvae, 30 sec bins, vertical displacement)-------------------------------

theme_plot <- theme(
  text = element_text(size = 18),
  axis.text.x = element_text(size = 12, angle = 90),
  axis.text.y = element_text(size = 12),
  legend.text = element_text(size = 14, hjust = 0),
  legend.title = element_text(size = 14),
  legend.spacing.x = unit(0.02,'mm'),
  axis.title = element_text(size = 16),
  panel.background = element_blank()
)

WTvsNOS_2d %>% 
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  filter(genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=0.5, xmax=3.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=2, y=-0.46, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=3.5, xmax=7.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=5.5, y=-0.46, label="side 395nm", color="purple", size = 5.5, fontface="plain") +
  annotate("text", x=5.5, y=0.56, label="UV avoidance", color="black", size = 4.5, fontface="plain") +
  annotate("rect", xmin=7.5, xmax=11.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=9.5, y=-0.46, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=11.5, xmax=15.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=13.5, y=-0.46, label="top 480nm", color="deepskyblue3", size = 5.5, fontface="plain") +
  annotate("text", x=13.5, y=0.56, label="phototaxis", color="black", size = 4.5, fontface="plain") +
  annotate("rect", xmin=15.5, xmax=19.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=17.5, y=-0.46, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=19.5, xmax=23.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=21.5, y=-0.46, label="top 395nm", color="purple", size = 5.5, fontface="plain") +
  annotate("text", x=21.5, y=0.56, label="UV avoidance", color="black", size = 4.5, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = genotype) +
  geom_boxplot(size = 0.25, outlier.shape = NA) +
  scale_fill_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'),
               expression('NOS'^'Δ23/Δ23'))) +
  theme_minimal()+
  theme_plot +
  labs(fill = "genotype", x = "time (sec)", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.46, 0.56)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120"))

# save to source data-------------------------------------------------------

WTvsNOS_2d %>% 
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  filter(genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_supplement1_source_data2.csv")


# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_2dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 2800, height = 1600, bg='white')


# plot Martin data (3d larvae, 30 sec bins, vertical displacement)-------------------------------
WTvsNOS_3d %>%
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  filter(genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=0.5, xmax=3.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=2, y=-0.81, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=3.5, xmax=7.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=5.5, y=-0.81, label="side 395nm", color="purple", size = 5.5, fontface="plain") +
  annotate("text", x=5.5, y=0.5, label="UV avoidance", color="black", size = 4.75, fontface="plain") +
  annotate("rect", xmin=7.5, xmax=11.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=9.5, y=-0.81, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=11.5, xmax=15.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=13.5, y=-0.81, label="top 480nm", color="deepskyblue3", size = 5.5, fontface="plain") +
  annotate("text", x=13.5, y=0.5, label="phototaxis", color="black", size = 4.75, fontface="plain") +
  annotate("rect", xmin=15.5, xmax=19.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=17.5, y=-0.81, label="dark", color="black", size = 5.5, fontface="plain") +
  annotate("rect", xmin=19.5, xmax=23.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=21.5, y=-0.81, label="top 395nm", color="purple", size = 5.5, fontface="plain") +
  annotate("text", x=21.5, y=0.5, label="UV avoidance", color="black", size = 4.75, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = genotype) +
  geom_boxplot(size = 0.25, outlier.shape = NA) +
  scale_fill_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23'))) +
  theme_minimal()+
  theme_plot +
  labs(fill = "genotype", x = "time (sec)", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.81, 0.5)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120"))

# save to source data-------------------------------------------------------

WTvsNOS_3d %>%
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  filter(genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_source_data4.csv")


# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_3dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 2800, height = 1600, bg='white')


# plot Martin data (L-NAME 3d larvae, 30 sec bins, vertical displacement)-------------------------------
L_NAME_3d %>%
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  ggplot() +
  annotate("rect", xmin=0.5, xmax=3.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=2, y=-0.67, label="dark", color="black", size = 6, fontface="plain") +
  annotate("rect", xmin=3.5, xmax=7.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=5.5, y=-0.67, label="side 395nm", color="purple", size = 6, fontface="plain") +
  annotate("text", x=5.5, y=0.75, label="UV avoidance", color="black", size = 4.75, fontface="plain") +
  annotate("rect", xmin=7.5, xmax=11.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=9.5, y=-0.67, label="dark", color="black", size = 6, fontface="plain") +
  annotate("rect", xmin=11.5, xmax=15.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=13.5, y=-0.67, label="top 480nm", color="deepskyblue3", size = 6, fontface="plain") +
  annotate("text", x=13.5, y=0.75, label="phototaxis", color="black", size = 4.75, fontface="plain") +
  annotate("rect", xmin=15.5, xmax=19.5, ymin=-Inf, ymax=Inf,alpha=0.4, fill="black") +
  annotate("text", x=17.5, y=-0.67, label="dark", color="black", size = 6, fontface="plain") +
  annotate("rect", xmin=19.5, xmax=23.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=21.5, y=-0.67, label="top 395nm", color="purple", size = 6, fontface="plain") +
  annotate("text", x=21.5, y=0.75, label="UV avoidance", color="black", size = 4.75, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = `L-NAME`) +
  geom_boxplot(size = 0.25, outlier.shape = NA) +
  scale_fill_manual(
    values = c("0 mM" = "grey90", 
               "0.1 mM" = Okabe_Ito[1],
               "1.0 mM" = Okabe_Ito[6])) +
  theme_minimal() +
  theme_plot +
  labs(x = "time (sec)", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.67, 0.75)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120")
                   )

# save to source data-------------------------------------------------------

L_NAME_3d %>%
  filter(!(condition %in% c(
    "dark_30", "dark_60", "dark_90", "dark_120", "dark_150",
    "dark3_30", "dark3_60", "dark3_90", "dark3_120", "dark3_150", "dark3_180"))) %>%
  write_csv("source_data/Figure3_source_data5.csv")


# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_3dpf_L_NAME.png", limitsize = FALSE, 
       units = c("px"), width = 2800, height = 1600, bg='white')



# plot 2d Tracking ---------------------------------------------------------------------

df_2d_nor$Genotype = factor(df_2d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))


df_2d_nor %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot(aes(x = x_axis, y = y_axis, colour = sec)) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x movement (mm)", 
       y = "y movement (mm)", 
       color = "time (sec)") +
  theme_minimal() +
  coord_fixed() +
  theme_plot +
  theme(axis.title = element_text(size=16),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        text = element_text(size = 15),
        legend.title = element_text(size = 13),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(breaks = c(-10, 0, 10)) +
  facet_grid(vars(), 
             vars(Genotype), 
             labeller = as_labeller(c(WT = 'WT', NOS11x11 = 'NOSΔ11/Δ11',
                                      NOS23x23 = 'NOSΔ23/Δ23')))


# save to source data-------------------------------------------------------

df_2d_nor %>%
  write_csv("source_data/Figure3_supplement1_source_data1.csv")



# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_tracking_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 2000, height = 1300, bg='white')


# plot 3d Tracking ---------------------------------------------------------------------

df_3d_nor$Genotype = factor(df_3d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))

df_3d_nor %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot(aes(x = x_axis, y = y_axis, colour = sec)) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x movement (mm)", 
       y = "y movement (mm)", 
       color = "time (sec)") +
  theme_minimal() +
  coord_fixed() +
  theme_plot +
  theme(axis.title = element_text(size=16),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        text = element_text(size = 15),
        legend.title = element_text(size = 13),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(breaks = c(-10, 0, 10)) +
  facet_grid(vars(), 
             vars(Genotype), 
             labeller = as_labeller(c(WT = 'WT', NOS11x11 = 'NOSΔ11/Δ11',
                                      NOS23x23 = 'NOSΔ23/Δ23')))

# save to source data-------------------------------------------------------

df_3d_nor %>%
  write_csv("source_data/Figure3_source_data1.csv")



# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_tracking_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 2000, height = 1400, bg='white')


# plot the 2d tracking mean vertical position--------------------------------------

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=5.5, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=5.5, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.5) +
  theme_minimal() +
  labs(x = "time (sec)", y = "vertical position (mm)", color = "genotype") +
  theme_plot +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))


# save to source data-------------------------------------------------------

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_supplement1_source_data3.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_position_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')


# plot the 3d tracking mean vertical position--------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=4, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=4, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.2) +
  theme_minimal() +
  labs(x = "time (sec)", y = "vertical position (mm)", color = "genotype") +
  theme_plot +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))

# save to source data-------------------------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_source_data2.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_position_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')



# plot the L-NAME 3d tracking mean vertical position-----------------------------------------------------

df_L_NAME_tracking %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=65, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=65, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = `sec`, y = `Ymm`, color = `L-NAME`) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "vertical position (mm)") +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c("0 mM" = "grey90", 
               "0.1 mM" = Okabe_Ito[1],
               "1 mM" = Okabe_Ito[6]),
    labels = c("0 mM", "0.1 mM", "1.0 mM"))


# save to source data-------------------------------------------------------

df_L_NAME_tracking %>%
  write_csv("source_data/Figure3_source_data3.csv")



# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_position_sideUV_L_NAME.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')




# plot the 2d tracking mean distance (speed) data-----------------------------------------------------

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=1.35, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=1.35, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.4) +
  theme_minimal() +
  labs(x = "time (sec)", y = "speed (mm/sec)", color = "genotype") +
  theme_plot +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))

# save to source data-------------------------------------------------------

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_supplement1_source_data4.csv")


# save plot -------------------------------------------------------------------------------------------
ggsave("pictures/vertical_tracking_distanse_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')


# plot the 3d tracking mean distance (speed) data-----------------------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=4.9, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=4.9, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.4) +
  theme_minimal() +
  labs(x = "time (sec)", y = "speed (mm/sec)", color = "genotype") +
  theme_plot +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5]),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))

# save to source data-------------------------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  write_csv("source_data/Figure3_supplement1_source_data5.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_distanse_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')



# plot the L-NAME 3d tracking mean distance (speed) data-----------------------------------------------------

df_L_NAME_tracking %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=2.75, label="side 395nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=2.75, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = `sec`, y = `mm/sec`, color = `L-NAME`) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "speed (mm/sec)") +
  theme(axis.title = element_text(size=13),
        axis.text.x = element_text(size = 11, angle = 0),
        axis.text.y = element_text(size = 11),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c("0 mM" = "grey90", 
               "0.1 mM" = Okabe_Ito[1],
               "1 mM" = Okabe_Ito[6]),
    labels = c("0 mM", "0.1 mM", "1.0 mM"))

# save to source data-------------------------------------------------------

df_L_NAME_tracking %>%
  write_csv("source_data/Figure3_supplement1_source_data6.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_distanse_sideUV_L_NAME.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')




# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_Architecture <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png")) +
  draw_label("NOS", x = 0.175, y = 0.9, size = 7, fontface = 'italic') +
  draw_label("CRISPR knockout lines", x = 0.45, y = 0.9, size = 7) 
panel_2d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_2dpf_WTvsNOSmix.png"))
panel_3d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_WTvsNOSmix.png"))
panel_3d_L_NAME_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_L_NAME.png"))

panel_2dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_2d.png"))
panel_2dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_2d.png"))
panel_2dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_2d.png"))

panel_3dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_3d.png"))
panel_3dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_3d.png"))
panel_3dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_3d.png"))

panel_L_NAME_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_L_NAME.png"))
panel_L_NAME_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_L_NAME.png"))


#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
#layout <- "
#AABBCCDD
#EEEEFFFF
#"

#Fig3v2 <-  panel_Architecture + panel_3dpf_Tracking + 
#  panel_3dpf_TP  + panel_3dpf_TD + 
#  panel_3d_vd + panel_3d_L_NAME_vd +
#  patchwork::plot_layout(design = layout, heights = c(0.55, 1),) + #we can change the heights of the rows in our layout (widths also can be defined)
#  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
#  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


#ggsave("Manuscript/figures/Fig3v2.pdf", limitsize = FALSE, 
#       units = c("px"), Fig3v2, width = 2400, height = 1200)  

#ggsave("Manuscript/figures/Fig3v2.png", limitsize = FALSE, 
#       units = c("px"), Fig3v2, width = 2400, height = 1200, bg='white')  


layout <- "
AABBCC
######
DDDEEE
"

Fig3 <-  panel_3dpf_Tracking + panel_3dpf_TP + panel_L_NAME_TP +
  panel_3d_vd + panel_3d_L_NAME_vd +
  patchwork::plot_layout(design = layout, heights = c(0.8, 0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


ggsave("Manuscript/figures/Fig3.png", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2400, height = 1300, bg='white')  

ggsave("Manuscript/figures/Fig3.pdf", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2400, height = 1300)  






layout2 <- "
AAAABBBBGGGG
############
CCCDDDEEEFFF
"

Fig3_sup1 <-  
  panel_Architecture + 
  panel_2dpf_Tracking +   
  panel_2dpf_TP + panel_2dpf_TD + panel_3dpf_TD + panel_L_NAME_TD +
  panel_2d_vd + 
  patchwork::plot_layout(design = layout2, heights = c(1, 0.05, 0.7)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig3_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 3200, height = 1200, bg='white')  

ggsave("Manuscript/figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 3200, height = 1200)  

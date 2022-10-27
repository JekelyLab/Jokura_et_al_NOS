#Code to assemble Fig2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data----------------------------------------------------------------
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



# tidying Martin data (30 sec bins, vertical displacement)------------------------------------------------
WT_2d_tidy <- gather(WT_2d, key="WT", value="displacement", -time, -condition)
WT_2d_tidy_phenotype <- gather(WT_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS11x11_2d_tidy <- gather(NOS11x11_2d, key="NOS11x11", value="displacement", -time, -condition)
NOS11x11_2d_tidy_phenotype <- gather(NOS11x11_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)
NOS23x23_2d_tidy <- gather(NOS23x23_2d, key="NOS23x23", value="displacement", -time, -condition)
NOS23x23_2d_tidy_phenotype <- gather(NOS23x23_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)
NOS11x23_2d_tidy <- gather(NOS11x23_2d, key="NOS11x23", value="displacement", -time, -condition)
NOS11x23_2d_tidy_phenotype <- gather(NOS11x23_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

WT_3d_tidy <- gather(WT_3d, key="WT", value="displacement", -time, -condition)
WT_3d_tidy_phenotype <- gather(WT_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS11x11_3d_tidy <- gather(NOS11x11_3d, key="NOS11x11", value="displacement", -time, -condition)
NOS11x11_3d_tidy_phenotype <- gather(NOS11x11_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)
NOS23x23_3d_tidy <- gather(NOS23x23_3d, key="NOS23x23", value="displacement", -time, -condition)
NOS23x23_3d_tidy_phenotype <- gather(NOS23x23_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)
NOS11x23_3d_tidy <- gather(NOS11x23_3d, key="NOS11x23", value="displacement", -time, -condition)
NOS11x23_3d_tidy_phenotype <- gather(NOS11x23_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

L_NAME_00mM_3d_tidy <- gather(L_NAME_00mM_3d, key="0 mM", value="displacement", -time, -condition)
L_NAME_00mM_3d_conc <- gather(L_NAME_00mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)
L_NAME_01mM_3d_tidy <- gather(L_NAME_01mM_3d, key="0.1 mM", value="displacement", -time, -condition)
L_NAME_01mM_3d_conc <- gather(L_NAME_01mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)
L_NAME_1mM_3d_tidy <- gather(L_NAME_1mM_3d, key="1.0 mM", value="displacement", -time, -condition)
L_NAME_1mM_3d_conc <- gather(L_NAME_1mM_3d_tidy, key="L-NAME", value="batch", -time, -condition, -displacement)


#bind
WTvsNOS_2d <- bind_rows(WT_2d_tidy_phenotype, NOS11x11_2d_tidy_phenotype, NOS23x23_2d_tidy_phenotype, NOS11x23_2d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS11x11", "NOS23x23", "NOS11x23")))

WTvsNOS_3d <- bind_rows(WT_3d_tidy_phenotype, NOS11x11_3d_tidy_phenotype, NOS23x23_3d_tidy_phenotype, NOS11x23_3d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS11x11", "NOS23x23", "NOS11x23")))

L_NAME_3d <- bind_rows(L_NAME_00mM_3d_conc, L_NAME_01mM_3d_conc, L_NAME_1mM_3d_conc)
L_NAME_3d$`L-NAME` <- factor(L_NAME_3d$`L-NAME`, levels = c("0 mM", "0.1 mM", "1.0 mM"))

# plot Martin data (2d larvae, 30 sec bins, vertical displacement)-------------------------------

#WTvsNOS_2d %>% 
#  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120"))) %>%
#  ggplot() +
#  annotate("rect", xmin=4.5, xmax=8.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=6.5, y=-0.75, label="side 395nm", color="purple", size = 7, fontface="plain") +
#  annotate("rect", xmin=12.5, xmax=16.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
#  annotate("text", x=14.5, y=-0.75, label="top 480nm", color="deepskyblue3", size = 7, fontface="plain") +
#  annotate("rect", xmin=20.5, xmax=24.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=22.5, y=-0.75, label="top 395nm", color="purple", size = 7, fontface="plain") +
#  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
#  geom_boxplot(size = 0.25, outlier.size = 0.5, outlier.alpha = 0.5) +
#  scale_fill_manual(
#   values = c(WT = "#FF009E", 
#               NOS11x11 = "#0042FF",
#               NOS23x23 = "#0094FF",
#               NOS11x23 = "#00CBFF"),
#    labels = c("WT", 
#               expression('NOS'^'Δ11/Δ11'), 
#               expression('NOS'^'Δ23/Δ23'), 
#               expression('NOS'^'Δ11/Δ23'))) +
#  theme_minimal()+
#  theme(text = element_text(size = 18),
#        legend.title = element_blank(), 
#        legend.text.align=0,
#        legend.text = element_text(size=14)) +
#  labs(fill = NULL, x = "30 sec bins", y = "Vertical displacement (mm/s)")+
#  scale_y_continuous(limits = c(-0.75, 0.75)) +
#  scale_x_discrete(labels=c("30", "60", "90","120", 
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120","150","180"))

WTvsNOS_2d %>% 
  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120"))) %>%
  filter(phenotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=4.5, xmax=8.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=6.5, y=-0.6, label="side 395nm", color="purple", size = 7, fontface="plain") +
  annotate("rect", xmin=12.5, xmax=16.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=14.5, y=-0.6, label="top 480nm", color="deepskyblue3", size = 7, fontface="plain") +
  annotate("rect", xmin=20.5, xmax=24.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=22.5, y=-0.6, label="top 395nm", color="purple", size = 7, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot(size = 0.25, outlier.size = 0.5, outlier.alpha = 0.5) +
  scale_fill_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'),
               expression('NOS'^'Δ23/Δ23'))) +
  theme_minimal()+
  theme(text = element_text(size = 18),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=14)) +
  labs(fill = NULL, x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.6, 0.65)) +
  scale_x_discrete(labels=c("30", "60", "90","120", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120","150","180"))



# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_2dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 4000, height = 2500, bg='white')


# plot Martin data (3d larvae, 30 sec bins, vertical displacement)-------------------------------

#WTvsNOS_3d %>% 
#  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120"))) %>%
#  ggplot() +
#  annotate("rect", xmin=4.5, xmax=8.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=6.5, y=-0.81, label="side 395nm", color="purple", size = 7, fontface="plain") +
#  annotate("rect", xmin=12.5, xmax=16.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
#  annotate("text", x=14.5, y=-0.81, label="top 480nm", color="deepskyblue3", size = 7, fontface="plain") +
#  annotate("rect", xmin=20.5, xmax=24.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=22.5, y=-0.81, label="top 395nm", color="purple", size = 7, fontface="plain") +
#  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
#  geom_boxplot(size = 0.25, outlier.size = 0.5, outlier.alpha = 0.5) +
#  scale_fill_manual(
#   values = c(WT = "#FF009E", 
#               NOS11x11 = "#0042FF",
#               NOS23x23 = "#0094FF",
#               NOS11x23 = "#00CBFF"),
#    labels = c("WT", 
#               expression('NOS'^'Δ11/Δ11'), 
#               expression('NOS'^'Δ23/Δ23'), 
#               expression('NOS'^'Δ11/Δ23'))) +
#  theme_minimal()+
#  theme(text = element_text(size = 18),
#        legend.title = element_blank(), 
#        legend.text.align=0,
#        legend.text = element_text(size=14)) +
#  labs(fill = NULL, x = "30 sec bins", y = "Vertical displacement (mm/s)")+
#  scale_y_continuous(limits = c(-0.81, 0.5)) +
#  scale_x_discrete(labels=c("30", "60", "90","120", 
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120",
#                            "30", "60", "90","120","150","180"))


WTvsNOS_3d %>%
  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120"))) %>%
  filter(phenotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=4.5, xmax=8.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=6.5, y=-0.81, label="side 395nm", color="purple", size = 7, fontface="plain") +
  annotate("rect", xmin=12.5, xmax=16.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=14.5, y=-0.81, label="top 480nm", color="deepskyblue3", size = 7, fontface="plain") +
  annotate("rect", xmin=20.5, xmax=24.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=22.5, y=-0.81, label="top 395nm", color="purple", size = 7, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot(size = 0.25, outlier.size = 0.5, outlier.alpha = 0.5) +
  scale_fill_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23'))) +
  theme_minimal()+
  theme(text = element_text(size = 18),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=14)) +
  labs(fill = NULL, x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.81, 0.5)) +
  scale_x_discrete(labels=c("30", "60", "90","120", 
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120","150","180"))

# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_3dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 4000, height = 2500, bg='white')




# plot Martin data (L-NAME 3d larvae, 30 sec bins, vertical displacement)-------------------------------
L_NAME_3d %>%
  filter(!(condition %in% c("dark_30", "dark_60", "dark_90", "dark_120", "dark_150"))) %>%
  ggplot() +
  annotate("rect", xmin=3.5, xmax=7.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=5.5, y=-0.75, label="side 395nm", color="purple", size = 7, fontface="plain") +
  annotate("rect", xmin=11.5, xmax=15.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("text", x=13.5, y=-0.75, label="top 480nm", color="deepskyblue3", size = 7, fontface="plain") +
  annotate("rect", xmin=19.5, xmax=23.5, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=21.5, y=-0.75, label="top 395nm", color="purple", size = 7, fontface="plain") +
  aes(x = reorder(condition, time), y = displacement, fill = `L-NAME`) +
  geom_boxplot(size = 0.25, outlier.size = 0.5, outlier.alpha = 0.5) +
  scale_fill_manual(
    values = c("0 mM" = "#C0C0C0", 
               "0.1 mM" = "#FF68FD",
               "1.0 mM" = "#FF009E")) +
  theme_minimal()+
  theme(text = element_text(size = 18))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-0.75, 0.75)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120","150","180"))

# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_3dpf_L_NAME.png", limitsize = FALSE, 
       units = c("px"), width = 4000, height = 2500, bg='white')



# plot 2d Tracking ---------------------------------------------------------------------

df_2d_nor$Genotype = factor(df_2d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))

ggplot(df_2d_nor) +
  aes(x = x_axis, y = y_axis, colour = sec) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x (mm)", y = "y (mm)", color = "time (sec)") +
  theme_minimal() +
  coord_fixed() +
  theme(text = element_text(size = 18), 
        legend.text.align=0,
        legend.text = element_text(size=14)) +
  facet_grid(vars(), vars(Genotype))

# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_tracking_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 3600, height = 2000, bg='white')


# plot 3d Tracking ---------------------------------------------------------------------

df_3d_nor$Genotype = factor(df_3d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))

ggplot(df_3d_nor) +
  aes(x = x_axis, y = y_axis, colour = sec) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x (mm)", y = "y (mm)", color = "time (sec)") +
  theme_minimal() +
  coord_fixed() +
  theme(text = element_text(size = 18), 
        legend.text.align=0,
        legend.text = element_text(size=14)) +
  facet_grid(vars(), vars(Genotype))


# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_tracking_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 3600, height = 2000, bg='white')

# plot the 2d tracking mean vertical position--------------------------------------

#df_2d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  ggplot() +
#  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=14, y=5.5, label="side 395nm", color="purple", size = 6, fontface="plain") +
#  aes(x = sec, y = y_axis, color = Genotype) +
#  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
#  theme_minimal() +
#  labs(x = "time (sec)", y = "vertical position (mm)") +
#  theme(text = element_text(size = 16),
#        legend.title = element_blank(), 
#        legend.text.align=0,
#        legend.text = element_text(size=12)) +
#  scale_x_continuous(limits = c(0, 40)) +
#  scale_color_manual(values = c(WT = "#FF009E", 
#                                NOS11x11 = "#0042FF",
#                                NOS23x23 = "#0094FF",
#                                NOS11x23 = "#00CBFF"),
#                     labels = c("WT", 
#                                expression('NOS'^'Δ11/Δ11'),
#                                expression('NOS'^'Δ23/Δ23'),
#                                expression('NOS'^'Δ11/Δ23')))

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=14, y=5.5, label="side 395nm", color="purple", size = 6, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "vertical position (mm)") +
  theme(text = element_text(size = 16),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))

# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_position_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')


# plot the 3d tracking mean vertical position--------------------------------------

#df_3d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  ggplot() +
#  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=14, y=2, label="side 395nm", color="purple", size = 6, fontface="plain") +
#  aes(x = sec, y = y_axis, color = Genotype) +
#  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
#  theme_minimal() +
#  labs(x = "time (sec)", y = "vertical position (mm)") +
#  theme(text = element_text(size = 16),
#        legend.title = element_blank(), 
#        legend.text.align=0,
#        legend.text = element_text(size=12)) +
#  scale_x_continuous(limits = c(0, 40)) +
#  scale_color_manual(values = c(WT = "#FF009E", 
#                                NOS11x11 = "#0042FF",
#                                NOS23x23 = "#0094FF",
#                                NOS11x23 = "#00CBFF"),
#                     labels = c("WT", 
#                                expression('NOS'^'Δ11/Δ11'),
#                                expression('NOS'^'Δ23/Δ23'),
#                                expression('NOS'^'Δ11/Δ23')))

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=14, y=2, label="side 395nm", color="purple", size = 6, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "vertical position (mm)") +
  theme(text = element_text(size = 16),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_position_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')


# plot the 2d tracking mean distance (speed) data-----------------------------------------------------


#df_2d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  ggplot() +
#  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  aes(x = sec, y = speed, color = Genotype) +
#  geom_smooth(aes(group = `Track ID`), method = "loess", 
#              formula = y ~ x, level = 0.1, size = 0.01, span = 0.5) +
#  geom_smooth(aes(fill = Genotype), method = "loess", 
#              formula = y ~ x, level = 0.99, size = 1, span = 0.9) +
#  theme_minimal() +
#  theme(legend.title = element_blank(), legend.text.align=0,
#        legend.text = element_text(size=12)) +
#  scale_color_manual(values = c(WT = "#FF009E", 
#                                NOS11x11 = "#0042FF",
#                                NOS23x23 = "#0094FF",
#                                NOS11x23 = "#00CBFF"),
#                     labels = c("WT", 
#                                expression('NOS'^'Δ11/Δ11'),
#                                expression('NOS'^'Δ23/Δ23'),
#                                expression('NOS'^'Δ11/Δ23'))) +
#  scale_fill_manual(values = c(WT = "#FF009E", 
#                                NOS11x11 = "#0042FF",
#                                NOS23x23 = "#0094FF",
#                                NOS11x23 = "#00CBFF"),
#                     labels = c("WT", 
#                                expression('NOS'^'Δ11/Δ11'),
#                                expression('NOS'^'Δ23/Δ23'),
#                                expression('NOS'^'Δ11/Δ23')))




df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=14, y=1.35, label="side 395nm", color="purple", size = 6, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", 
              formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "speed (mm/sec)") +
  theme(text = element_text(size = 16),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))



# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_distanse_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')


# plot the 3d tracking mean distance (speed) data-----------------------------------------------------

#df_3d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  ggplot() +
#  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
#  annotate("text", x=14, y=4.9, label="side 395nm", color="purple", size = 6, fontface="plain") +
#  aes(x = sec, y = speed, color = Genotype) +
#  geom_smooth(method = "loess", 
#              formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
#  theme_minimal() +
#  labs(x = "time (sec)", y = "speed (mm/sec)") +
#  theme(text = element_text(size = 16),
#        legend.title = element_blank(), 
#        legend.text.align=0,
#        legend.text = element_text(size=12)) +
#  scale_x_continuous(limits = c(0, 40)) +
#  scale_color_manual(values = c(WT = "#FF009E", 
#                                NOS11x11 = "#0042FF",
#                                NOS23x23 = "#0094FF",
#                                NOS11x23 = "#00CBFF"),
#                     labels = c("WT", 
#                                expression('NOS'^'Δ11/Δ11'),
#                                expression('NOS'^'Δ23/Δ23'),
#                                expression('NOS'^'Δ11/Δ23')))

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=14, y=4.9, label="side 395nm", color="purple", size = 6, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", 
              formula = y ~ x, level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time (sec)", y = "speed (mm/sec)") +
  theme(text = element_text(size = 16),
        legend.title = element_blank(), 
        legend.text.align=0,
        legend.text = element_text(size=12)) +
  scale_x_continuous(limits = c(0, 40)) +
  scale_color_manual(
    values = c(WT = "#FF49FC", 
               NOS11x11 = "#0094FF",
               NOS23x23 = "#00CBFF"),
    labels = c("WT", 
               expression('NOS'^'Δ11/Δ11'), 
               expression('NOS'^'Δ23/Δ23')))


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_distanse_sideUV_3d.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')



# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_Architecture <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png"))
panel_2d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_2dpf_WTvsNOSmix.png"))
panel_3d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_WTvsNOSmix.png"))
panel_3d_L_NAME_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_L_NAME.png"))

panel_2dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_2d.png"))
panel_2dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_2d.png"))
panel_2dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_2d.png"))

panel_3dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_3d.png"))
panel_3dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_3d.png"))
panel_3dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_3d.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
AAAAABBB
########
CCCCDDDD
########
EEEEFFFF
########
GGHHIIJJ
"

Fig2 <- panel_3d_L_NAME_vd + panel_Architecture + 
  panel_2d_vd + panel_3d_vd + 
  panel_2dpf_Tracking + panel_3dpf_Tracking + 
  panel_2dpf_TP + panel_3dpf_TP + panel_2dpf_TD + panel_3dpf_TD + 
  patchwork::plot_layout(design = layout, heights = c(0.9, 0.02, 1, 0.02, 0.6, 0.02, 0.6),) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold')) #or 'plain', 'italic'


ggsave("figures/Fig2.png", limitsize = FALSE, 
       units = c("px"), Fig2, width = 3000, height = 3200, bg='white')  

ggsave("figures/Fig2.pdf", limitsize = FALSE, 
       units = c("px"), Fig2, width = 2400, height = 1200)  




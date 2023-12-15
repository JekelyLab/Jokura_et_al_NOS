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
df_L_NAME_tracking <- read_csv("data/230511_df_L_NAME_2.csv")

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

# theme_plot-------------------------------------------------------------------

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


# plot Martin data (2d larvae, 30 sec bins, vertical displacement)-------------------------------

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
  labs(fill = "genotype", x = "time [s]", y = "Vertical displacement [mm/s]")+
  scale_y_continuous(limits = c(-0.46, 0.56)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120")) +
  annotate("text", x=4.25, y=0.243, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=5.255, y=0.165, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=6.25, y=0.155, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=7.255, y=0.155, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=8.25, y=0.1, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=16, y=0.085, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=16.25, y=0.02, label="*", color="black", size = 5, fontface="plain")
  



# statics analysis 2d larvae, 30 sec bins, vertical displacement-------------------------------

#2d_dark_180
WTvsNOS_2d_dark_180_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_180"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark_180 = factor(WTvsNOS_2d_dark_180_stat$genotype)
y_axis_2d_dark_180 = WTvsNOS_2d_dark_180_stat$displacement
summary(glht(aov(y_axis_2d_dark_180 ~ vx_2d_dark_180),
             linfct = mcp(vx_2d_dark_180 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.15414    0.07332  -2.102   0.0911 .
#NOS23x23 - cont == 0 -0.01676    0.10370  -0.162   0.9828







#2d_dark_210
WTvsNOS_2d_dark_210_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_210"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark_210 = factor(WTvsNOS_2d_dark_210_stat$genotype)
y_axis_2d_dark_210 = WTvsNOS_2d_dark_210_stat$displacement
summary(glht(aov(y_axis_2d_dark_210 ~ vx_2d_dark_210),
             linfct = mcp(vx_2d_dark_210 = "Dunnett")))
#                      Estimate Std. Error t value Pr(>|t|)
#NOS11x11 - cont == 0 -0.110356   0.065192  -1.693    0.193
#NOS23x23 - cont == 0  0.001821   0.092196   0.020    1.000









#2d_dark_240
WTvsNOS_2d_dark_240_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_240"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark_240 = factor(WTvsNOS_2d_dark_240_stat$genotype)
y_axis_2d_dark_240 = WTvsNOS_2d_dark_240_stat$displacement
summary(glht(aov(y_axis_2d_dark_240 ~ vx_2d_dark_240),
             linfct = mcp(vx_2d_dark_240 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)
#NOS11x11 - cont == 0 -0.09046    0.05282  -1.713    0.187
#NOS23x23 - cont == 0 -0.01692    0.07470  -0.227    0.967







#2d_sideUV_30
WTvsNOS_2d_sideUV_30_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_sideUV_30 = factor(WTvsNOS_2d_sideUV_30_stat$genotype)
y_axis_2d_sideUV_30 = WTvsNOS_2d_sideUV_30_stat$displacement
summary(glht(aov(y_axis_2d_sideUV_30 ~ vx_2d_sideUV_30),
             linfct = mcp(vx_2d_sideUV_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.05373    0.04683   1.147   0.4450  
#NOS23x23 - cont == 0  0.18133    0.06623   2.738   0.0245 *





#2d_sideUV_60
WTvsNOS_2d_sideUV_60_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_sideUV_60 = factor(WTvsNOS_2d_sideUV_60_stat$genotype)
y_axis_2d_sideUV_60 = WTvsNOS_2d_sideUV_60_stat$displacement
summary(glht(aov(y_axis_2d_sideUV_60 ~ vx_2d_sideUV_60),
             linfct = mcp(vx_2d_sideUV_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.07551    0.04922   1.534   0.2516  
#NOS23x23 - cont == 0  0.20075    0.06960   2.884   0.0178 *







#2d_sideUV_90
WTvsNOS_2d_sideUV_90_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_sideUV_90 = factor(WTvsNOS_2d_sideUV_90_stat$genotype)
y_axis_2d_sideUV_90 = WTvsNOS_2d_sideUV_90_stat$displacement
summary(glht(aov(y_axis_2d_sideUV_90 ~ vx_2d_sideUV_90),
             linfct = mcp(vx_2d_sideUV_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.09115    0.04580    1.99   0.1128  
#NOS23x23 - cont == 0  0.19043    0.06477    2.94   0.0157 *







#2d_sideUV_120
WTvsNOS_2d_sideUV_120_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_sideUV_120 = factor(WTvsNOS_2d_sideUV_120_stat$genotype)
y_axis_2d_sideUV_120 = WTvsNOS_2d_sideUV_120_stat$displacement
summary(glht(aov(y_axis_2d_sideUV_120 ~ vx_2d_sideUV_120),
             linfct = mcp(vx_2d_sideUV_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.05932    0.03598   1.649  0.20820   
#NOS23x23 - cont == 0  0.16684    0.05089   3.278  0.00735 **







#2d_dark1_30
WTvsNOS_2d_dark1_30_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark1_30 = factor(WTvsNOS_2d_dark1_30_stat$genotype)
y_axis_2d_dark1_30 = WTvsNOS_2d_dark1_30_stat$displacement
summary(glht(aov(y_axis_2d_dark1_30 ~ vx_2d_dark1_30),
             linfct = mcp(vx_2d_dark1_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.03486    0.02919   1.194  0.41779   
#NOS23x23 - cont == 0  0.13139    0.04127   3.183  0.00912 **



#2d_dark1_60
WTvsNOS_2d_dark1_60_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark1_60 = factor(WTvsNOS_2d_dark1_60_stat$genotype)
y_axis_2d_dark1_60 = WTvsNOS_2d_dark1_60_stat$displacement
summary(glht(aov(y_axis_2d_dark1_60 ~ vx_2d_dark1_60),
             linfct = mcp(vx_2d_dark1_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.02333    0.02917  -0.800    0.665
#NOS23x23 - cont == 0  0.07664    0.04125   1.858    0.144




#2d_dark1_90
WTvsNOS_2d_dark1_90_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark1_90 = factor(WTvsNOS_2d_dark1_90_stat$genotype)
y_axis_2d_dark1_90 = WTvsNOS_2d_dark1_90_stat$displacement
summary(glht(aov(y_axis_2d_dark1_90 ~ vx_2d_dark1_90),
             linfct = mcp(vx_2d_dark1_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.02429    0.03059  -0.794    0.669
#NOS23x23 - cont == 0  0.05263    0.04325   1.217    0.405




#2d_dark1_120
WTvsNOS_2d_dark1_120_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark1_120 = factor(WTvsNOS_2d_dark1_120_stat$genotype)
y_axis_2d_dark1_120 = WTvsNOS_2d_dark1_120_stat$displacement
summary(glht(aov(y_axis_2d_dark1_120 ~ vx_2d_dark1_120),
             linfct = mcp(vx_2d_dark1_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 0.006663   0.027002   0.247    0.961
#NOS23x23 - cont == 0 0.060576   0.038187   1.586    0.231




#2d_top488_30
WTvsNOS_2d_top488_30_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top488_30 = factor(WTvsNOS_2d_top488_30_stat$genotype)
y_axis_2d_top488_30 = WTvsNOS_2d_top488_30_stat$displacement
summary(glht(aov(y_axis_2d_top488_30 ~ vx_2d_top488_30),
             linfct = mcp(vx_2d_top488_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.09762    0.05311  -1.838    0.149
#NOS23x23 - cont == 0  0.02502    0.07511   0.333    0.929


#2d_top488_60
WTvsNOS_2d_top488_60_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top488_60 = factor(WTvsNOS_2d_top488_60_stat$genotype)
y_axis_2d_top488_60 = WTvsNOS_2d_top488_60_stat$displacement
summary(glht(aov(y_axis_2d_top488_60 ~ vx_2d_top488_60),
             linfct = mcp(vx_2d_top488_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.01656    0.05046   0.328    0.932
#NOS23x23 - cont == 0 -0.07039    0.07136  -0.986    0.544




#2d_top488_90
WTvsNOS_2d_top488_90_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top488_90 = factor(WTvsNOS_2d_top488_90_stat$genotype)
y_axis_2d_top488_90 = WTvsNOS_2d_top488_90_stat$displacement
summary(glht(aov(y_axis_2d_top488_90 ~ vx_2d_top488_90),
             linfct = mcp(vx_2d_top488_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.03714    0.03950   0.940    0.573
#NOS23x23 - cont == 0 -0.07346    0.05587  -1.315    0.353




#2d_top488_120
WTvsNOS_2d_top488_120_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top488_120 = factor(WTvsNOS_2d_top488_120_stat$genotype)
y_axis_2d_top488_120 = WTvsNOS_2d_top488_120_stat$displacement
summary(glht(aov(y_axis_2d_top488_120 ~ vx_2d_top488_120),
             linfct = mcp(vx_2d_top488_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.05595    0.03593   1.557    0.242
#NOS23x23 - cont == 0 -0.06002    0.05082  -1.181    0.425



#2d_dark2_30
WTvsNOS_2d_dark2_30_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark2_30 = factor(WTvsNOS_2d_dark2_30_stat$genotype)
y_axis_2d_dark2_30 = WTvsNOS_2d_dark2_30_stat$displacement
summary(glht(aov(y_axis_2d_dark2_30 ~ vx_2d_dark2_30),
             linfct = mcp(vx_2d_dark2_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.14906    0.05055   2.949   0.0154 *
#NOS23x23 - cont == 0  0.17930    0.07149   2.508   0.0401 *



#2d_dark2_60
WTvsNOS_2d_dark2_60_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark2_60 = factor(WTvsNOS_2d_dark2_60_stat$genotype)
y_axis_2d_dark2_60 = WTvsNOS_2d_dark2_60_stat$displacement
summary(glht(aov(y_axis_2d_dark2_60 ~ vx_2d_dark2_60),
             linfct = mcp(vx_2d_dark2_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.12165    0.05501   2.211   0.0735 .
#NOS23x23 - cont == 0  0.17188    0.07780   2.209   0.0738 .



#2d_dark2_90
WTvsNOS_2d_dark2_90_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark2_90 = factor(WTvsNOS_2d_dark2_90_stat$genotype)
y_axis_2d_dark2_90 = WTvsNOS_2d_dark2_90_stat$displacement
summary(glht(aov(y_axis_2d_dark2_90 ~ vx_2d_dark2_90),
             linfct = mcp(vx_2d_dark2_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.06272    0.04036   1.554    0.244
#NOS23x23 - cont == 0  0.09269    0.05708   1.624    0.217



#2d_dark2_120
WTvsNOS_2d_dark2_120_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_dark2_120 = factor(WTvsNOS_2d_dark2_120_stat$genotype)
y_axis_2d_dark2_120 = WTvsNOS_2d_dark2_120_stat$displacement
summary(glht(aov(y_axis_2d_dark2_120 ~ vx_2d_dark2_120),
             linfct = mcp(vx_2d_dark2_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.04533    0.03449   1.314    0.353
#NOS23x23 - cont == 0  0.04807    0.04877   0.986    0.544



#2d_top395_30
WTvsNOS_2d_top395_30_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top395_30 = factor(WTvsNOS_2d_top395_30_stat$genotype)
y_axis_2d_top395_30 = WTvsNOS_2d_top395_30_stat$displacement
summary(glht(aov(y_axis_2d_top395_30 ~ vx_2d_top395_30),
             linfct = mcp(vx_2d_top395_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.01501    0.03414  -0.440    0.881
#NOS23x23 - cont == 0 -0.01876    0.04829  -0.388    0.906


#2d_top395_60
WTvsNOS_2d_top395_60_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top395_60 = factor(WTvsNOS_2d_top395_60_stat$genotype)
y_axis_2d_top395_60 = WTvsNOS_2d_top395_60_stat$displacement
summary(glht(aov(y_axis_2d_top395_60 ~ vx_2d_top395_60),
             linfct = mcp(vx_2d_top395_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.05925    0.04227   1.402    0.310
#NOS23x23 - cont == 0 -0.02550    0.05978  -0.427    0.887




#2d_top395_90
WTvsNOS_2d_top395_90_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top395_90 = factor(WTvsNOS_2d_top395_90_stat$genotype)
y_axis_2d_top395_90 = WTvsNOS_2d_top395_90_stat$displacement
summary(glht(aov(y_axis_2d_top395_90 ~ vx_2d_top395_90),
             linfct = mcp(vx_2d_top395_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.06627    0.05271   1.257    0.383
#NOS23x23 - cont == 0  0.01561    0.07454   0.209    0.971




#2d_top395_120
WTvsNOS_2d_top395_120_stat <- WTvsNOS_2d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_2d_top395_120 = factor(WTvsNOS_2d_top395_120_stat$genotype)
y_axis_2d_top395_120 = WTvsNOS_2d_top395_120_stat$displacement
summary(glht(aov(y_axis_2d_top395_120 ~ vx_2d_top395_120),
             linfct = mcp(vx_2d_top395_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.06550    0.06618   0.990    0.542
#NOS23x23 - cont == 0  0.05756    0.09359   0.615    0.783







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
  labs(fill = "genotype", x = "time [s]", y = "Vertical displacement [mm/s]")+
  scale_y_continuous(limits = c(-0.81, 0.5)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120",
                           "30", "60", "90","120")) +
  annotate("text", x=5.255, y=0.07, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=6, y=0, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=6.255, y=0.1, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=7, y=0.015, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=7.255, y=0.06, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=9, y=-0.03, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=9.255, y=-0.1, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=10, y=-0.03, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=10.255, y=-0.08, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=13, y=0.22, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=13.255, y=0.23, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=14, y=0.23, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=14.255, y=0.2, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=15, y=0.24, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=15.255, y=0.23, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=16.255, y=-0.14, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=17, y=-0.06, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=18, y=0.13, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=19.255, y=-0.11, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=21.255, y=0.26, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=22.255, y=0.2, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=23.255, y=0.115, label="*", color="black", size = 5, fontface="plain")



# statics analysis 3d larvae, 30 sec bins, vertical displacement-------------------------------

#3d_dark_180
WTvsNOS_3d_dark_180_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_180"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark_180 = factor(WTvsNOS_3d_dark_180_stat$genotype)
y_axis_3d_dark_180 = WTvsNOS_3d_dark_180_stat$displacement
summary(glht(aov(y_axis_3d_dark_180 ~ vx_3d_dark_180),
             linfct = mcp(vx_3d_dark_180 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.02205    0.04792  -0.460    0.867
#NOS23x23 - cont == 0 -0.00755    0.04311  -0.175    0.979



#3d_dark_210
WTvsNOS_3d_dark_210_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_210"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark_210 = factor(WTvsNOS_3d_dark_210_stat$genotype)
y_axis_3d_dark_210 = WTvsNOS_3d_dark_210_stat$displacement
summary(glht(aov(y_axis_3d_dark_210 ~ vx_3d_dark_210),
             linfct = mcp(vx_3d_dark_210 = "Dunnett")))
#                      Estimate Std. Error t value Pr(>|t|)
#NOS11x11 - cont == 0 -0.009536   0.048179  -0.198    0.974
#NOS23x23 - cont == 0 -0.009426   0.043348  -0.217    0.968



#3d_dark_240
WTvsNOS_3d_dark_240_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark_240"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark_240 = factor(WTvsNOS_3d_dark_240_stat$genotype)
y_axis_3d_dark_240 = WTvsNOS_3d_dark_240_stat$displacement
summary(glht(aov(y_axis_3d_dark_240 ~ vx_3d_dark_240),
             linfct = mcp(vx_3d_dark_240 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)
#NOS11x11 - cont == 0  0.01091    0.04044   0.270    0.952
#NOS23x23 - cont == 0 -0.01301    0.03638  -0.358    0.917



#3d_sideUV_30
WTvsNOS_3d_sideUV_30_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_sideUV_30 = factor(WTvsNOS_3d_sideUV_30_stat$genotype)
y_axis_3d_sideUV_30 = WTvsNOS_3d_sideUV_30_stat$displacement
summary(glht(aov(y_axis_3d_sideUV_30 ~ vx_3d_sideUV_30),
             linfct = mcp(vx_3d_sideUV_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.00761    0.05164   0.147    0.985
#NOS23x23 - cont == 0  0.02305    0.04646   0.496    0.848





#3d_sideUV_60
WTvsNOS_3d_sideUV_60_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_sideUV_60 = factor(WTvsNOS_3d_sideUV_60_stat$genotype)
y_axis_3d_sideUV_60 = WTvsNOS_3d_sideUV_60_stat$displacement
summary(glht(aov(y_axis_3d_sideUV_60 ~ vx_3d_sideUV_60),
             linfct = mcp(vx_3d_sideUV_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.12660    0.06018   2.104  0.09052 . 
#NOS23x23 - cont == 0  0.18060    0.05415   3.335  0.00674 **







#3d_sideUV_90
WTvsNOS_3d_sideUV_90_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_sideUV_90 = factor(WTvsNOS_3d_sideUV_90_stat$genotype)
y_axis_3d_sideUV_90 = WTvsNOS_3d_sideUV_90_stat$displacement
summary(glht(aov(y_axis_3d_sideUV_90 ~ vx_3d_sideUV_90),
             linfct = mcp(vx_3d_sideUV_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.16654    0.06867   2.425  0.04787 * 
#NOS23x23 - cont == 0  0.23347    0.06179   3.779  0.00248 **







#3d_sideUV_120
WTvsNOS_3d_sideUV_120_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("sideUV_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_sideUV_120 = factor(WTvsNOS_3d_sideUV_120_stat$genotype)
y_axis_3d_sideUV_120 = WTvsNOS_3d_sideUV_120_stat$displacement
summary(glht(aov(y_axis_3d_sideUV_120 ~ vx_3d_sideUV_120),
             linfct = mcp(vx_3d_sideUV_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.17793    0.06337   2.808  0.02146 * 
#NOS23x23 - cont == 0  0.21252    0.05702   3.727  0.00278 **







#3d_dark1_30
WTvsNOS_3d_dark1_30_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark1_30 = factor(WTvsNOS_3d_dark1_30_stat$genotype)
y_axis_3d_dark1_30 = WTvsNOS_3d_dark1_30_stat$displacement
summary(glht(aov(y_axis_3d_dark1_30 ~ vx_3d_dark1_30),
             linfct = mcp(vx_3d_dark1_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.08979    0.03832   2.343   0.0565 .
#NOS23x23 - cont == 0  0.07077    0.03447   2.053   0.0997 .



#3d_dark1_60
WTvsNOS_3d_dark1_60_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark1_60 = factor(WTvsNOS_3d_dark1_60_stat$genotype)
y_axis_3d_dark1_60 = WTvsNOS_3d_dark1_60_stat$displacement
summary(glht(aov(y_axis_3d_dark1_60 ~ vx_3d_dark1_60),
             linfct = mcp(vx_3d_dark1_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.16124    0.05571   2.894   0.0178 *
#NOS23x23 - cont == 0  0.13311    0.05013   2.655   0.0297 *


#3d_dark1_90
WTvsNOS_3d_dark1_90_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark1_90 = factor(WTvsNOS_3d_dark1_90_stat$genotype)
y_axis_3d_dark1_90 = WTvsNOS_3d_dark1_90_stat$displacement
summary(glht(aov(y_axis_3d_dark1_90 ~ vx_3d_dark1_90),
             linfct = mcp(vx_3d_dark1_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.13698    0.04839   2.831   0.0204 *
#NOS23x23 - cont == 0  0.11273    0.04354   2.589   0.0341 *


#3d_dark1_120
WTvsNOS_3d_dark1_120_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark1_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark1_120 = factor(WTvsNOS_3d_dark1_120_stat$genotype)
y_axis_3d_dark1_120 = WTvsNOS_3d_dark1_120_stat$displacement
summary(glht(aov(y_axis_3d_dark1_120 ~ vx_3d_dark1_120),
             linfct = mcp(vx_3d_dark1_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.05740    0.04081   1.407    0.303
#NOS23x23 - cont == 0  0.04036    0.03672   1.099    0.468




#3d_top488_30
WTvsNOS_3d_top488_30_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top488_30 = factor(WTvsNOS_3d_top488_30_stat$genotype)
y_axis_3d_top488_30 = WTvsNOS_3d_top488_30_stat$displacement
summary(glht(aov(y_axis_3d_top488_30 ~ vx_3d_top488_30),
             linfct = mcp(vx_3d_top488_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.069110   0.057840  -1.195    0.412
#NOS23x23 - cont == 0 -0.007043   0.052041  -0.135    0.988


#3d_top488_60
WTvsNOS_3d_top488_60_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top488_60 = factor(WTvsNOS_3d_top488_60_stat$genotype)
y_axis_3d_top488_60 = WTvsNOS_3d_top488_60_stat$displacement
summary(glht(aov(y_axis_3d_top488_60 ~ vx_3d_top488_60),
             linfct = mcp(vx_3d_top488_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.15649    0.04496  -3.480  0.00486 **
#NOS23x23 - cont == 0 -0.09932    0.04046  -2.455  0.04503 *




#3d_top488_90
WTvsNOS_3d_top488_90_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top488_90 = factor(WTvsNOS_3d_top488_90_stat$genotype)
y_axis_3d_top488_90 = WTvsNOS_3d_top488_90_stat$displacement
summary(glht(aov(y_axis_3d_top488_90 ~ vx_3d_top488_90),
             linfct = mcp(vx_3d_top488_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.19197    0.03517  -5.459 5.69e-05 ***
#NOS23x23 - cont == 0 -0.16189    0.03164  -5.117 0.000121 ***




#3d_top488_120
WTvsNOS_3d_top488_120_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top488_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top488_120 = factor(WTvsNOS_3d_top488_120_stat$genotype)
y_axis_3d_top488_120 = WTvsNOS_3d_top488_120_stat$displacement
summary(glht(aov(y_axis_3d_top488_120 ~ vx_3d_top488_120),
             linfct = mcp(vx_3d_top488_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.16933    0.03795  -4.462 0.000525 ***
#NOS23x23 - cont == 0 -0.19211    0.03414  -5.627 3.95e-05 ***



#3d_dark2_30
WTvsNOS_3d_dark2_30_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark2_30 = factor(WTvsNOS_3d_dark2_30_stat$genotype)
y_axis_3d_dark2_30 = WTvsNOS_3d_dark2_30_stat$displacement
summary(glht(aov(y_axis_3d_dark2_30 ~ vx_3d_dark2_30),
             linfct = mcp(vx_3d_dark2_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0 -0.10109    0.07245  -1.395   0.3088  
#NOS23x23 - cont == 0 -0.20197    0.06519  -3.098   0.0114 *



#3d_dark2_60
WTvsNOS_3d_dark2_60_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark2_60 = factor(WTvsNOS_3d_dark2_60_stat$genotype)
y_axis_3d_dark2_60 = WTvsNOS_3d_dark2_60_stat$displacement
summary(glht(aov(y_axis_3d_dark2_60 ~ vx_3d_dark2_60),
             linfct = mcp(vx_3d_dark2_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.12968    0.05208   2.490   0.0419 *
#NOS23x23 - cont == 0 -0.05428    0.04686  -1.158   0.4328  



#3d_dark2_90
WTvsNOS_3d_dark2_90_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark2_90 = factor(WTvsNOS_3d_dark2_90_stat$genotype)
y_axis_3d_dark2_90 = WTvsNOS_3d_dark2_90_stat$displacement
summary(glht(aov(y_axis_3d_dark2_90 ~ vx_3d_dark2_90),
             linfct = mcp(vx_3d_dark2_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.12341    0.04572   2.699    0.027 *
#NOS23x23 - cont == 0 -0.05830    0.04114  -1.417    0.299



#3d_dark2_120
WTvsNOS_3d_dark2_120_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("dark2_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_dark2_120 = factor(WTvsNOS_3d_dark2_120_stat$genotype)
y_axis_3d_dark2_120 = WTvsNOS_3d_dark2_120_stat$displacement
summary(glht(aov(y_axis_3d_dark2_120 ~ vx_3d_dark2_120),
             linfct = mcp(vx_3d_dark2_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.08498    0.03955   2.149    0.083 .
#NOS23x23 - cont == 0 -0.08941    0.03559  -2.512    0.040 *



#3d_top395_30
WTvsNOS_3d_top395_30_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_30"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top395_30 = factor(WTvsNOS_3d_top395_30_stat$genotype)
y_axis_3d_top395_30 = WTvsNOS_3d_top395_30_stat$displacement
summary(glht(aov(y_axis_3d_top395_30 ~ vx_3d_top395_30),
             linfct = mcp(vx_3d_top395_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.04214    0.04201   1.003    0.527
#NOS23x23 - cont == 0  0.02282    0.03779   0.604    0.784


#3d_top395_60
WTvsNOS_3d_top395_60_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_60"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top395_60 = factor(WTvsNOS_3d_top395_60_stat$genotype)
y_axis_3d_top395_60 = WTvsNOS_3d_top395_60_stat$displacement
summary(glht(aov(y_axis_3d_top395_60 ~ vx_3d_top395_60),
             linfct = mcp(vx_3d_top395_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0  0.18607    0.09986   1.863   0.1416  
#NOS23x23 - cont == 0  0.22600    0.08985   2.515   0.0398 *




#3d_top395_90
WTvsNOS_3d_top395_90_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_90"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top395_90 = factor(WTvsNOS_3d_top395_90_stat$genotype)
y_axis_3d_top395_90 = WTvsNOS_3d_top395_90_stat$displacement
summary(glht(aov(y_axis_3d_top395_90 ~ vx_3d_top395_90),
             linfct = mcp(vx_3d_top395_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0   0.2864     0.1336   2.144   0.0838 .
#NOS23x23 - cont == 0   0.3468     0.1202   2.884   0.0182 *




#3d_top395_120
WTvsNOS_3d_top395_120_stat <- WTvsNOS_3d %>% 
  mutate(genotype = ifelse(genotype == "WT", "cont", 
                           ifelse(genotype == "NOS11x11", "NOS11x11", 
                                  ifelse(genotype == "NOS23x23", "NOS23x23", 
                                         genotype)))) %>% 
  filter((condition %in% c("top395_120"))) %>%
  filter(genotype %in% c("cont", "NOS11x11", "NOS23x23"))
vx_3d_top395_120 = factor(WTvsNOS_3d_top395_120_stat$genotype)
y_axis_3d_top395_120 = WTvsNOS_3d_top395_120_stat$displacement
summary(glht(aov(y_axis_3d_top395_120 ~ vx_3d_top395_120),
             linfct = mcp(vx_3d_top395_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#NOS11x11 - cont == 0   0.2956     0.1338   2.210   0.0736 .
#NOS23x23 - cont == 0   0.3663     0.1203   3.044   0.0128 *



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


# plot Martin data (L-NAME larvae, 30 sec bins, vertical displacement)-------------------------------
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
  labs(x = "time [s]", y = "Vertical displacement [mm/s]")+
  scale_y_continuous(limits = c(-0.67, 0.75)) +
  scale_x_discrete(labels=c("30", "60", "90", 
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120",
                            "30", "60", "90","120")) +
  annotate("text", x=6.255, y=0.115, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=7.255, y=0.11, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=8.255, y=0.11, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=9.255, y=0.1, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=22.255, y=0.2, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=23, y=0.115, label="*", color="black", size = 5, fontface="plain") +
  annotate("text", x=23.255, y=0.16, label="*", color="black", size = 5, fontface="plain")



# statics analysis 3d larvae, 30 sec bins, vertical displacement-------------------------------


#L_dark_180
L_NAME_dark_180_stat <- L_NAME_3d %>%
  filter((condition %in% c("dark_180")))
vx_L_dark_180 = factor(L_NAME_dark_180_stat$`L-NAME`)
y_axis_L_dark_180 = L_NAME_dark_180_stat$displacement
summary(glht(aov(y_axis_L_dark_180 ~ vx_L_dark_180),
             linfct = mcp(vx_L_dark_180 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 -0.003435   0.047215  -0.073    0.996
#1.0 mM - 0 mM == 0  0.086865   0.047215   1.840    0.129



#L_dark_210
L_NAME_dark_210_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark_210")))
vx_L_dark_210 = factor(L_NAME_dark_210_stat$`L-NAME`)
y_axis_L_dark_210 = L_NAME_dark_210_stat$displacement
summary(glht(aov(y_axis_L_dark_210 ~ vx_L_dark_210),
             linfct = mcp(vx_L_dark_210 = "Dunnett")))
#                      Estimate Std. Error t value Pr(>|t|)
#0.1 mM - 0 mM == 0 -0.03290    0.04452  -0.739    0.682
#1.0 mM - 0 mM == 0  0.04389    0.04452   0.986    0.517



#L_dark_240
L_NAME_dark_240_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark_240")))
vx_L_dark_240 = factor(L_NAME_dark_240_stat$`L-NAME`)
y_axis_L_dark_240 = L_NAME_dark_240_stat$displacement
summary(glht(aov(y_axis_L_dark_240 ~ vx_L_dark_240),
             linfct = mcp(vx_L_dark_240 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)
#0.1 mM - 0 mM == 0 -0.05023    0.04166  -1.206    0.384
#1.0 mM - 0 mM == 0  0.01395    0.04166   0.335    0.922



#L_sideUV_30
L_NAME_sideUV_30_stat <- L_NAME_3d %>% 
 filter((condition %in% c("sideUV_30")))
vx_L_sideUV_30 = factor(L_NAME_sideUV_30_stat$`L-NAME`)
y_axis_L_sideUV_30 = L_NAME_sideUV_30_stat$displacement
summary(glht(aov(y_axis_L_sideUV_30 ~ vx_L_sideUV_30),
             linfct = mcp(vx_L_sideUV_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 -0.008662   0.045900  -0.189    0.974
#1.0 mM - 0 mM == 0  0.079049   0.045900   1.722    0.162





#L_sideUV_60
L_NAME_sideUV_60_stat <- L_NAME_3d %>% 
  filter((condition %in% c("sideUV_60")))
vx_L_sideUV_60 = factor(L_NAME_sideUV_60_stat$`L-NAME`)
y_axis_L_sideUV_60 = L_NAME_sideUV_60_stat$displacement
summary(glht(aov(y_axis_L_sideUV_60 ~ vx_L_sideUV_60),
             linfct = mcp(vx_L_sideUV_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.05224    0.04739   1.102   0.4439  
#1.0 mM - 0 mM == 0  0.10614    0.04739   2.240   0.0558 .







#L_sideUV_90
L_NAME_sideUV_90_stat <- L_NAME_3d %>% 
  filter((condition %in% c("sideUV_90")))
vx_L_sideUV_90 = factor(L_NAME_sideUV_90_stat$`L-NAME`)
y_axis_L_sideUV_90 = L_NAME_sideUV_90_stat$displacement
summary(glht(aov(y_axis_L_sideUV_90 ~ vx_L_sideUV_90),
             linfct = mcp(vx_L_sideUV_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.06902    0.04076   1.694  0.17074   
#1.0 mM - 0 mM == 0  0.13556    0.04076   3.326  0.00354 **







#L_sideUV_120
L_NAME_sideUV_120_stat <- L_NAME_3d %>% 
  filter((condition %in% c("sideUV_120")))
vx_L_sideUV_120 = factor(L_NAME_sideUV_120_stat$`L-NAME`)
y_axis_L_sideUV_120 = L_NAME_sideUV_120_stat$displacement
summary(glht(aov(y_axis_L_sideUV_120 ~ vx_L_sideUV_120),
             linfct = mcp(vx_L_sideUV_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.06367    0.03809   1.672 0.177731    
#1.0 mM - 0 mM == 0  0.14413    0.03809   3.784 0.000942 ***







#L_dark1_30
L_NAME_dark1_30_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark1_30")))
vx_L_dark1_30 = factor(L_NAME_dark1_30_stat$`L-NAME`)
y_axis_L_dark1_30 = L_NAME_dark1_30_stat$displacement
summary(glht(aov(y_axis_L_dark1_30 ~ vx_L_dark1_30),
             linfct = mcp(vx_L_dark1_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.05349    0.04233   1.264 0.352041    
#1.0 mM - 0 mM == 0  0.18923    0.04233   4.470 0.000115 ***



#L_dark1_60
L_NAME_dark1_60_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark1_60")))
vx_L_dark1_60 = factor(L_NAME_dark1_60_stat$`L-NAME`)
y_axis_L_dark1_60 = L_NAME_dark1_60_stat$displacement
summary(glht(aov(y_axis_L_dark1_60 ~ vx_L_dark1_60),
             linfct = mcp(vx_L_dark1_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.01928    0.04413   0.437   0.8713  
#1.0 mM - 0 mM == 0  0.10743    0.04413   2.434   0.0357 *


#L_dark1_90
L_NAME_dark1_90_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark1_90")))
vx_L_dark1_90 = factor(L_NAME_dark1_90_stat$`L-NAME`)
y_axis_L_dark1_90 = L_NAME_dark1_90_stat$displacement
summary(glht(aov(y_axis_L_dark1_90 ~ vx_L_dark1_90),
             linfct = mcp(vx_L_dark1_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.02221    0.03925   0.566    0.796
#1.0 mM - 0 mM == 0  0.06533    0.03925   1.664    0.180


#L_dark1_120
L_NAME_dark1_120_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark1_120")))
vx_L_dark1_120 = factor(L_NAME_dark1_120_stat$`L-NAME`)
y_axis_L_dark1_120 = L_NAME_dark1_120_stat$displacement
summary(glht(aov(y_axis_L_dark1_120 ~ vx_L_dark1_120),
             linfct = mcp(vx_L_dark1_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.01916    0.02600   0.737    0.684
#1.0 mM - 0 mM == 0  0.04667    0.02600   1.795    0.141




#L_top488_30
L_NAME_top488_30_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top488_30")))
vx_L_top488_30 = factor(L_NAME_top488_30_stat$`L-NAME`)
y_axis_L_top488_30 = L_NAME_top488_30_stat$displacement
summary(glht(aov(y_axis_L_top488_30 ~ vx_L_top488_30),
             linfct = mcp(vx_L_top488_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 -0.039250   0.050259  -0.781    0.654
#1.0 mM - 0 mM == 0  0.008352   0.050259   0.166    0.980


#L_top488_60
L_NAME_top488_60_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top488_60")))
vx_L_top488_60 = factor(L_NAME_top488_60_stat$`L-NAME`)
y_axis_L_top488_60 = L_NAME_top488_60_stat$displacement
summary(glht(aov(y_axis_L_top488_60 ~ vx_L_top488_60),
             linfct = mcp(vx_L_top488_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 -0.02371    0.04627  -0.512    0.828
#1.0 mM - 0 mM == 0 -0.00341    0.04627  -0.074    0.996




#L_top488_90
L_NAME_top488_90_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top488_90")))
vx_L_top488_90 = factor(L_NAME_top488_90_stat$`L-NAME`)
y_axis_L_top488_90 = L_NAME_top488_90_stat$displacement
summary(glht(aov(y_axis_L_top488_90 ~ vx_L_top488_90),
             linfct = mcp(vx_L_top488_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 -0.001712   0.042136  -0.041    0.999
#1.0 mM - 0 mM == 0  0.007347   0.042136   0.174    0.978




#L_top488_120
L_NAME_top488_120_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top488_120")))
vx_L_top488_120 = factor(L_NAME_top488_120_stat$`L-NAME`)
y_axis_L_top488_120 = L_NAME_top488_120_stat$displacement
summary(glht(aov(y_axis_L_top488_120 ~ vx_L_top488_120),
             linfct = mcp(vx_L_top488_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.010572   0.041646   0.254    0.954
#1.0 mM - 0 mM == 0 -0.004206   0.041646  -0.101    0.993



#L_dark2_30
L_NAME_dark2_30_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark2_30")))
vx_L_dark2_30 = factor(L_NAME_dark2_30_stat$`L-NAME`)
y_axis_L_dark2_30 = L_NAME_dark2_30_stat$displacement
summary(glht(aov(y_axis_L_dark2_30 ~ vx_L_dark2_30),
             linfct = mcp(vx_L_dark2_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0 0.001614   0.058643   0.028    0.999
#1.0 mM - 0 mM == 0 0.057243   0.058643   0.976    0.523



#L_dark2_60
L_NAME_dark2_60_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark2_60")))
vx_L_dark2_60 = factor(L_NAME_dark2_60_stat$`L-NAME`)
y_axis_L_dark2_60 = L_NAME_dark2_60_stat$displacement
summary(glht(aov(y_axis_L_dark2_60 ~ vx_L_dark2_60),
             linfct = mcp(vx_L_dark2_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.03796    0.05674   0.669    0.729
#1.0 mM - 0 mM == 0  0.07490    0.05674   1.320    0.323  



#L_dark2_90
L_NAME_dark2_90_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark2_90")))
vx_L_dark2_90 = factor(L_NAME_dark2_90_stat$`L-NAME`)
y_axis_L_dark2_90 = L_NAME_dark2_90_stat$displacement
summary(glht(aov(y_axis_L_dark2_90 ~ vx_L_dark2_90),
             linfct = mcp(vx_L_dark2_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.07150    0.04874   1.467    0.255
#1.0 mM - 0 mM == 0  0.07444    0.04874   1.527    0.230



#L_dark2_120
L_NAME_dark2_120_stat <- L_NAME_3d %>% 
  filter((condition %in% c("dark2_120")))
vx_L_dark2_120 = factor(L_NAME_dark2_120_stat$`L-NAME`)
y_axis_L_dark2_120 = L_NAME_dark2_120_stat$displacement
summary(glht(aov(y_axis_L_dark2_120 ~ vx_L_dark2_120),
             linfct = mcp(vx_L_dark2_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.08284    0.03643   2.274   0.0517 .
#1.0 mM - 0 mM == 0  0.05526    0.03643   1.517   0.2340



#L_top395_30
L_NAME_top395_30_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top395_30")))
vx_L_top395_30 = factor(L_NAME_top395_30_stat$`L-NAME`)
y_axis_L_top395_30 = L_NAME_top395_30_stat$displacement
summary(glht(aov(y_axis_L_top395_30 ~ vx_L_top395_30),
             linfct = mcp(vx_L_top395_30 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.04712    0.04186   1.126    0.430
#1.0 mM - 0 mM == 0  0.05555    0.04186   1.327    0.319


#L_top395_60
L_NAME_top395_60_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top395_60")))
vx_L_top395_60 = factor(L_NAME_top395_60_stat$`L-NAME`)
y_axis_L_top395_60 = L_NAME_top395_60_stat$displacement
summary(glht(aov(y_axis_L_top395_60 ~ vx_L_top395_60),
             linfct = mcp(vx_L_top395_60 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.11006    0.06063   1.815    0.136
#1.0 mM - 0 mM == 0  0.11850    0.06063   1.955    0.103




#L_top395_90
L_NAME_top395_90_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top395_90")))
vx_L_top395_90 = factor(L_NAME_top395_90_stat$`L-NAME`)
y_axis_L_top395_90 = L_NAME_top395_90_stat$displacement
summary(glht(aov(y_axis_L_top395_90 ~ vx_L_top395_90),
             linfct = mcp(vx_L_top395_90 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0   0.1558     0.0716   2.176   0.0643 .
#1.0 mM - 0 mM == 0   0.1935     0.0716   2.703   0.0186 *




#L_top395_120
L_NAME_top395_120_stat <- L_NAME_3d %>% 
  filter((condition %in% c("top395_120")))
vx_L_top395_120 = factor(L_NAME_top395_120_stat$`L-NAME`)
y_axis_L_top395_120 = L_NAME_top395_120_stat$displacement
summary(glht(aov(y_axis_L_top395_120 ~ vx_L_top395_120),
             linfct = mcp(vx_L_top395_120 = "Dunnett")))
#                     Estimate Std. Error t value Pr(>|t|)  
#0.1 mM - 0 mM == 0  0.13808    0.05887   2.345  0.04394 * 
#1.0 mM - 0 mM == 0  0.18913    0.05887   3.213  0.00485 **



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

label <- c("WT", "NOS^'Δ11/Δ11'", "NOS^'Δ23/Δ23'")

df_2d_nor %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  mutate(genotype_label = case_when(Genotype == "WT" ~ label[1], # replace "a" with "label[i]"
                                    Genotype == "NOS11x11" ~ label[2], # ditto
                                    Genotype == "NOS23x23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>%
  ggplot(aes(x = x_axis, y = y_axis, colour = sec)) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x movement [mm]", 
       y = "y movement [mm]", 
       color = "time [s]") +
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
  facet_wrap(vars(genotype_label),
             labeller = label_parsed)


# save to source data-------------------------------------------------------

df_2d_nor %>%
  write_csv("source_data/Figure3_supplement1_source_data1.csv")



# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_tracking_sideUV_2d.png", limitsize = FALSE, 
       units = c("px"), width = 2000, height = 1300, bg='white')


# plot 3d Tracking ---------------------------------------------------------------------

df_3d_nor$Genotype = factor(df_3d_nor$Genotype, levels=c("WT", "NOS11x11", "NOS23x23", "NOS11x23"))

label <- c("WT", "NOS^'Δ11/Δ11'", "NOS^'Δ23/Δ23'")

df_3d_nor %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  mutate(genotype_label = case_when(Genotype == "WT" ~ label[1], # replace "a" with "label[i]"
                                    Genotype == "NOS11x11" ~ label[2], # ditto
                                    Genotype == "NOS23x23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>%
  ggplot(aes(x = x_axis, y = y_axis, colour = sec)) +
  geom_point(size = 0.1) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  labs(x = "x movement [mm]", 
       y = "y movement [mm]", 
       color = "time [s]") +
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
  facet_wrap(vars(genotype_label),
             labeller = label_parsed)

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
  annotate("text", x=17, y=5.5, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=5.5, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.5) +
  theme_minimal() +
  labs(x = "time [s]", y = "vertical position [mm]", color = "genotype") +
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


# statistics analysis of the 2d tracking mean vertical position (side UV after 30sec)--------------------------------------

#Change the name to perform the Dunnett
df_2d_nor_stat <- df_2d_nor %>% 
  mutate(Genotype = ifelse(Genotype == "WT", "cont", Genotype))

df_2d_nor_stat <- df_2d_nor_stat %>%
  filter(!(Genotype %in% "NOS11x23")) %>%
  filter(sec >= 39.9 & sec < 40)

#Dunnett's test
genotype_2d=factor(df_2d_nor_stat$Genotype)
y_axis_2d=df_2d_nor_stat$y_axis
summary(glht(aov(y_axis_2d~genotype_2d),linfct=mcp(genotype_2d= "Dunnett")))

#                     Estimate Std. Error t value Pr(>|t|)
#NOS11x11 - cont == 0    6.926      4.207   1.646    0.194
#NOS23x23 - cont == 0    9.295      5.707   1.629    0.201

#‘***’ <0.001 ‘**’ <0.01 ‘*’ <0.05


ggplot(df_2d_nor_stat) +
  aes(x = Genotype, y = y_axis, fill = Genotype) +
  geom_boxplot(size = 0.5, outlier.shape = NA) +
  geom_beeswarm(aes(color = Genotype),
                size = 2,
                cex = 3.2,
                alpha =.3, 
                color = "gray5") +
  labs(y = "vertical displacement [mm/s]")+
  theme_minimal() +
  theme(legend.position = 'none', 
        axis.title.x = element_blank()) +
  ylim(-50, 50) +
  scale_fill_manual(
    values = c(cont = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5])) +
  scale_x_discrete(labels = c("cont" = "WT", 
                              "NOS11x11" = expression('NOS'^'Δ11/Δ11'), 
                              "NOS23x23" = expression('NOS'^'Δ23/Δ23'))) +
  geom_signif(comparisons = list(c("cont", "NOS11x11")),
              annotations = "0.194",
              y_position = 30) +
  geom_signif(comparisons = list(c("cont", "NOS23x23")),
              annotations = "0.201",
              y_position = 40)


# save to source data-------------------------------------------------------

#df_2d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
#  write_csv("source_data/Figure3_supplement1_source_data3.csv")


# save plot ---------------------------------------------------------------

ggsave("pictures/Vertical displacement_mean_2d_statics.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 1000, bg='white')


# plot the 3d tracking mean vertical position--------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=4, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=4, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = y_axis, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.2) +
  theme_minimal() +
  labs(x = "time [s]", y = "vertical position [mm]", color = "genotype") +
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

# statistics analysis of the 3d tracking mean vertical position (side UV after 30sec)--------------------------------------

#Change the name to perform the Dunnett
df_3d_nor_stat <- df_3d_nor %>% 
  mutate(Genotype = ifelse(Genotype == "WT", "cont", Genotype))

df_3d_nor_stat <- df_3d_nor_stat %>%
  filter(!(Genotype %in% "NOS11x23")) %>%
  filter(sec >= 39.9 & sec < 40)

#Dunnett's test
genotype_3d=factor(df_3d_nor_stat$Genotype)
y_axis_3d=df_3d_nor_stat$y_axis
comp_result <- summary(glht(aov(y_axis_3d~genotype_3d),linfct=mcp(genotype_3d= "Dunnett")))
p_values <- comp_result$test$pvalues

print(p_values)

#                     Estimate Std. Error t value Pr(>|t|)    
#NOS11x11 - cont == 0   14.712      4.234   3.475 0.001467 ** 
#NOS23x23 - cont == 0   13.920      3.675   3.787 0.000506 ***

#‘***’ <0.001 ‘**’ <0.01 ‘*’ <0.05




ggplot(df_3d_nor_stat) +
  aes(x = Genotype, y = y_axis, fill = Genotype) +
  geom_boxplot(size = 0.5, outlier.shape = NA) +
  geom_beeswarm(aes(color = Genotype),
                size = 2,
                cex = 3.2,
                alpha =.3, 
                color = "gray5") +
  labs(y = "vertical displacement [mm/s]")+
  theme_minimal() +
  theme(legend.position = 'none', 
        axis.title.x = element_blank()) +
  ylim(-50, 50) +
  scale_fill_manual(
    values = c(cont = "grey90", 
               NOS11x11 = Okabe_Ito[2],
               NOS23x23 = Okabe_Ito[5])) +
  scale_x_discrete(labels = c("cont" = "WT", 
                              "NOS11x11" = expression('NOS'^'Δ11/Δ11'), 
                              "NOS23x23" = expression('NOS'^'Δ23/Δ23'))) +
  geom_signif(comparisons = list(c("cont", "NOS11x11")),
              annotations = "0.0015 **",
              y_position = 30) +
  geom_signif(comparisons = list(c("cont", "NOS23x23")),
              annotations = "0.0005 ***",
              y_position = 40)






# save to source data-------------------------------------------------------

#df_3d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
#  write_csv("source_data/Figure3_source_data2.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/Vertical displacement_mean_3d_statics.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 1000, bg='white')



# plot the L-NAME tracking mean vertical position-----------------------------------------------------

df_L_NAME_tracking %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=8, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=8, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = `sec`, y = `y_axis`, color = `L-NAME`) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time [s]", y = "vertical position [mm]") +
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




# statistics analysis of the L-NAME tracking mean vertical position (side UV after 30sec)--------------------------------------

#Change the name to perform the Dunnett

df_L_NAME_stat <- df_L_NAME_tracking %>%
  filter(sec >= 39.92 & sec < 40)

#Dunnett's test
L_NAME = factor(df_L_NAME_stat$'L-NAME')
y_axis = df_L_NAME_stat$y_axis
summary(glht(aov(y_axis~L_NAME),linfct=mcp(L_NAME = "Dunnett")))

#                   Estimate Std. Error t value Pr(>|t|)    
#0.1 mM - 0 mM == 0   13.805      8.683   1.590 0.223749    
#1 mM - 0 mM == 0     39.897      8.683   4.595 0.000787 ***

#‘***’ <0.001 ‘**’ <0.01 ‘*’ <0.05

ggplot(df_L_NAME_stat) +
  aes(x = `L-NAME`, y = y_axis, fill = `L-NAME`) +
  geom_boxplot(size = 0.5, outlier.shape = NA) +
  geom_beeswarm(aes(color = Genotype),
                size = 2,
                cex = 3.2,
                alpha =.3, 
                color = "gray5") +
  labs(y = "vertical displacement [mm/s]")+
  theme_minimal() +
  theme(legend.position = 'none',
        axis.title.x = element_text(size = 9)) +
  ylim(-50, 50) +
  scale_fill_manual(
    values = c("0 mM" = "grey90", 
               "0.1 mM" = Okabe_Ito[1],
               "1 mM" = Okabe_Ito[6])) +
  scale_x_discrete(labels = c("0 mM" = "0 mM", 
                              "0.1 mM" = "0.1 mM",
                              "1 mM" = "1.0 mM")) +
  geom_signif(comparisons = list(c("0 mM", "0.1 mM")),
              annotations = "0.22",
              y_position = 30) +
  geom_signif(comparisons = list(c("0 mM", "1 mM")),
              annotations = "<0.001 ***",
              y_position = 40)



# save to source data-------------------------------------------------------

#df_L_NAME_tracking %>%
#  write_csv("source_data/Figure3_source_data3.csv")



# save plot ---------------------------------------------------------------
ggsave("pictures/Vertical displacement_mean_L_NAME_statics.png", limitsize = FALSE, 
       units = c("px"), width = 800, height = 1000, bg='white')




# plot the 2d tracking mean distance (speed) data-----------------------------------------------------

df_2d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>% 
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=1.35, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=1.35, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.4) +
  theme_minimal() +
  labs(x = "time [s]", y = "speed [mm/s]", color = "two-day-old") +
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


# statistics analysis of the 2d tracking mean distance (speed) data-----------------------------------------------------

df_2d_nor <- read_csv("data/221011_sUV_tracking/sUV_tracking_2d.csv")
df_2d_nor_0_10sec_mean <- read_csv("data/221011_sUV_tracking/sUV_tracking_2d_0sec_10sec.csv")
df_2d_nor_30_40sec_mean <- read_csv("data/221011_sUV_tracking/sUV_tracking_2d_30sec_40sec.csv")



df_2d_nor_0_10sec <- df_2d_nor %>%
  filter(sec > 0 & sec <= 10) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23"))

df_2d_nor_0_10sec <- df_2d_nor_0_10sec %>%
  arrange(desc(Genotype), Batch, "Track ID")


result_df <- data.frame()
for (i in 1:63) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_2d_nor_0_10sec$speed[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_2d_nor_0_10sec_mean <- cbind(df_2d_nor_0_10sec_mean, result_df)



df_2d_nor_30_40sec <- df_2d_nor %>%
  filter(sec >= 30 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23"))

df_2d_nor_30_40sec <- df_2d_nor_30_40sec %>%
  arrange(desc(Genotype), Batch, "Track ID")

result_df <- data.frame()

for (i in 1:63) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_2d_nor_30_40sec$speed[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_2d_nor_30_40sec_mean <- cbind(df_2d_nor_30_40sec_mean, result_df)



df_2d_nor_speeed_mean <- rbind(df_2d_nor_0_10sec_mean, df_2d_nor_30_40sec_mean)
df_2d_nor_speeed_mean$Genotype <- 
  factor(df_2d_nor_speeed_mean$Genotype, levels = c("WT", "NOS11x11", "NOS23x23"))

label <- c("WT", "NOS^'Δ11/Δ11'", "NOS^'Δ23/Δ23'")


df_2d_nor_speeed_mean %>% 
  mutate(genotype_label = case_when(Genotype == "WT" ~ label[1], # replace "a" with "label[i]"
                                 Genotype == "NOS11x11" ~ label[2], # ditto
                                 Genotype == "NOS23x23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>% 
  ggplot(aes(x = Condition, y = mean_speed)) + 
  geom_boxplot(aes(fill = Condition), alpha = .8, outlier.shape = NA) +
  geom_point(size = 1.5, alpha = .2) + 
  geom_line(aes(group = `Track ID`), size = .1, color = "gray70") +
  facet_wrap(vars(genotype_label), 
             strip.position = "bottom",
             labeller = label_parsed) +  
  theme_minimal() +
  labs(fill = "two-day-old", x = "", y = "mean speed [mm/s]") +
  theme(strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 11),
        axis.text.x=element_blank()) +
  ylim(0.5, 2.3) +
  scale_fill_manual(
    values = c(dark = "#B3B3B3",
               sideUV = "#D461FF")) +
  stat_compare_means(comparisons = list(c("dark", "sideUV")), 
                     method = "t.test", 
                     label = "p.signif", 
                     paired=TRUE)



# save to source data-------------------------------------------------------

#df_2d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
#  write_csv("source_data/Figure3_supplement1_source_data4.csv")


# save plot -------------------------------------------------------------------------------------------
ggsave("pictures/vertical_tracking_mean_speed_2d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')


# plot the 3d tracking mean distance (speed) data-----------------------------------------------------

df_3d_nor %>%
  filter(sec > 0 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=4.9, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=4.9, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = sec, y = speed, color = Genotype) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.4) +
  theme_minimal() +
  labs(x = "time [s]", y = "speed [mm/s]", color = "three-day-old") +
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



# statistics analysis of the 3d tracking mean distance (speed) data-----------------------------------------------------

df_3d_nor <- read_csv("data/221011_sUV_tracking/sUV_tracking_3d.csv")
df_3d_nor_0_10sec_mean <- read_csv("data/221011_sUV_tracking/sUV_tracking_3d_0sec_10sec.csv")
df_3d_nor_30_40sec_mean <- read_csv("data/221011_sUV_tracking/sUV_tracking_3d_30sec_40sec.csv")



df_3d_nor_0_10sec <- df_3d_nor %>%
  filter(sec > 0 & sec <= 10) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23"))

df_3d_nor_0_10sec <- df_3d_nor_0_10sec %>%
  arrange(desc(Genotype), Batch, "Track ID")


result_df <- data.frame()
for (i in 1:105) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_3d_nor_0_10sec$speed[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_3d_nor_0_10sec_mean <- cbind(df_3d_nor_0_10sec_mean, result_df)



df_3d_nor_30_40sec <- df_3d_nor %>%
  filter(sec >= 30 & sec <= 40) %>%
  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23"))

df_3d_nor_30_40sec <- df_3d_nor_30_40sec %>%
  arrange(desc(Genotype), Batch, "Track ID")

result_df <- data.frame()

for (i in 1:105) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_3d_nor_30_40sec$speed[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_3d_nor_30_40sec_mean <- cbind(df_3d_nor_30_40sec_mean, result_df)




df_3d_nor_speeed_mean <- rbind(df_3d_nor_0_10sec_mean, df_3d_nor_30_40sec_mean)
df_3d_nor_speeed_mean$Genotype <- 
  factor(df_3d_nor_speeed_mean$Genotype, levels = c("WT", "NOS11x11", "NOS23x23"))
label <- c("WT", "NOS^'Δ11/Δ11'", "NOS^'Δ23/Δ23'")



df_3d_nor_speeed_mean %>% 
  mutate(genotype_label = case_when(Genotype == "WT" ~ label[1], # replace "a" with "label[i]"
                                    Genotype == "NOS11x11" ~ label[2], # ditto
                                    Genotype == "NOS23x23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>% 
  ggplot(aes(x = Condition, y = mean_speed)) + 
  geom_boxplot(aes(fill = Condition), alpha = .8, outlier.shape = NA) +
  geom_point(size = 1.5, alpha = .2) + 
  geom_line(aes(group = `Track ID`), size = .1, color = "gray70") +
  facet_wrap(vars(genotype_label), 
             strip.position = "bottom",
             labeller = label_parsed) +  
  theme_minimal() +
  labs(fill = "three-day-old", x = "", y = "mean speed [mm/s]") +
  theme(strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 11),
        axis.text.x=element_blank()) +
  ylim(1.25, 10) +
  scale_fill_manual(
    values = c(dark = "#B3B3B3",
               sideUV = "#D461FF")) +
  stat_compare_means(comparisons = list(c("dark", "sideUV")), 
                     method = "t.test", 
                     label = "p.signif", 
                     paired=TRUE,
                     symnum.args = list(cutpoints = c(0, 0.001, 0.01, 0.05, 1), 
                                        symbols = c("***", "ns", "ns", "ns")))



# save to source data-------------------------------------------------------

#df_3d_nor %>%
#  filter(sec > 0 & sec <= 40) %>%
#  filter(Genotype %in% c("WT", "NOS11x11", "NOS23x23")) %>%
#  write_csv("source_data/Figure3_supplement1_source_data5.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_mean_speed_3d.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')



# plot the L-NAME tracking mean distance (speed) data-----------------------------------------------------

df_L_NAME_tracking %>%
  ggplot() +
  annotate("rect", xmin=10, xmax=40, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("text", x=17, y=2.9, label="side 395 nm", color="purple", size = 5, fontface="plain") +
  annotate("rect", xmin=0, xmax=10, ymin=-Inf, ymax=Inf,alpha=0.1, fill="black") +
  annotate("text", x=2.5, y=2.9, label="dark", color="black", size = 5, fontface="plain") +
  aes(x = `sec`, y = `mm/sec`, color = `L-NAME`) +
  geom_smooth(method = "loess", formula = y ~ x, method.args= list(degree = 1), 
              level = 0.99, size = 1, span = 0.8) +
  theme_minimal() +
  labs(x = "time [s]", y = "speed [mm/s]") +
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




# statistics analysis of the L-NAME tracking mean distance (speed) data-----------------------------------------------------


df_L_NAME_nor_0mM <- read_csv("data/230511_df_L_NAME_0mM_dark_1_6_sUV_31_36.csv")
df_L_NAME_nor_01mM <- read_csv("data/230511_df_L_NAME_01mM_dark_1_6_sUV_31_36.csv")
df_L_NAME_nor_1mM <- read_csv("data/230511_df_L_NAME_1mM_dark_1_6_sUV_31_36.csv")

df_L_NAME_nor_0mM_mean <- read_csv("data/230511_df_L_NAME_0mM_dark_sUV.csv")
df_L_NAME_nor_01mM_mean <- read_csv("data/230511_df_L_NAME_01mM_dark_sUV.csv")
df_L_NAME_nor_1mM_mean <- read_csv("data/230511_df_L_NAME_1mM_dark_sUV.csv")


result_df <- data.frame()
for (i in 1:10) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_L_NAME_nor_0mM$'mm/sec'[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_L_NAME_nor_0mM_mean <- cbind(df_L_NAME_nor_0mM_mean, result_df)


result_df <- data.frame()
for (i in 1:12) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_L_NAME_nor_01mM$'mm/sec'[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_L_NAME_nor_01mM_mean <- cbind(df_L_NAME_nor_01mM_mean, result_df)


result_df <- data.frame()
for (i in 1:12) {
  start_index <- 1 + 150 * (i - 1)
  end_index <- start_index + 149
  subset_mean <- mean(df_L_NAME_nor_1mM$'mm/sec'[start_index:end_index])
  result_df <- rbind(result_df, data.frame(mean_speed = subset_mean))
}
df_L_NAME_nor_1mM_mean <- cbind(df_L_NAME_nor_1mM_mean, result_df)






df_L_NAME_nor_speeed_mean <- rbind(df_L_NAME_nor_0mM_mean, 
                                   df_L_NAME_nor_01mM_mean,
                                   df_L_NAME_nor_1mM_mean)
df_L_NAME_nor_speeed_mean$L_NAME <- 
  factor(df_L_NAME_nor_speeed_mean$L_NAME, levels = c("0 mM", "0.1 mM", "1.0 mM"))


df_L_NAME_nor_speeed_mean %>% 
  ggplot(aes(x = Condition, y = mean_speed)) + 
  geom_boxplot(aes(fill = Condition), alpha = .8, outlier.shape = NA) +
  geom_point(size = 2, alpha = .2) + 
  geom_line(aes(group = ID), size = .1, color = "gray70") +
  facet_wrap(vars(L_NAME), 
             strip.position = "bottom") +  
  theme_minimal() +
  ylim(0.75,4.75) +
  labs(fill = "", x = "L-NAME", y = "mean speed [mm/s]") +
  theme(strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 10),
        axis.text.x=element_blank()) +
  scale_fill_manual(
    values = c(dark = "#B3B3B3",
               sideUV = "#D461FF")) +
  stat_compare_means(comparisons = list(c("dark", "sideUV")), 
                     method = "t.test", 
                     label = "p.signif", 
                     paired=TRUE)





# save to source data-------------------------------------------------------

#df_L_NAME_tracking %>%
#  write_csv("source_data/Figure3_supplement1_source_data6.csv")


# save plot ---------------------------------------------------------------
ggsave("pictures/vertical_tracking_mean_speed_L_NAME.png", limitsize = FALSE, 
       units = c("px"), width = 1600, height = 1000, bg='white')




# CBF_2d --------------------------------------------------------------------


CBF <- read_csv("data/CBF_UV_NOS.csv")
CBF$type <- factor(CBF$type, levels = c("WT", "NOSΔ11/Δ11", "NOSΔ23/Δ23"))

label <- c("WT", "NOS^'Δ11/Δ11'", "NOS^'Δ23/Δ23'")


CBF %>%
  filter(age %in% c("2days")) %>% 
  mutate(genotype_label = case_when(type == "WT" ~ label[1], # replace "a" with "label[i]"
                                    type == "NOSΔ11/Δ11" ~ label[2], # ditto
                                    type == "NOSΔ23/Δ23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>% 
  ggplot(aes(x = condition, y = Hz)) + 
  geom_boxplot(aes(fill = condition), alpha = .8, outlier.shape = NA) +
  geom_point(size = 2, alpha = .2) + 
  geom_line(aes(group = id), size = .2, color = "gray30") +
  facet_wrap(vars(genotype_label), 
             strip.position = "bottom",
             labeller = label_parsed) +  
  theme_minimal() +
  ylim(7, 21) +
  labs(fill = "two-day-old", x = "", y = "ciliary beat frequency [Hz]") +
  theme(strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 11),
        axis.text.x=element_blank()) +
  scale_fill_manual(
    values = c(before = "#B3B3B3",
               UV = "#D461FF")) +
  stat_compare_means(comparisons = list(c("before", "UV")), 
                     method = "t.test", 
                     label = "p.signif", 
                     paired=TRUE)

# save plot ---------------------------------------------------------------
ggsave("pictures/CBF_2d_plot.png", limitsize = FALSE, 
       units = c("px"), width = 1400, height = 1000, bg='white')

# CBF_3d --------------------------------------------------------------------

CBF %>%
  filter(age %in% c("3days")) %>% 
  mutate(genotype_label = case_when(type == "WT" ~ label[1], # replace "a" with "label[i]"
                                    type == "NOSΔ11/Δ11" ~ label[2], # ditto
                                    type == "NOSΔ23/Δ23" ~ label[3]),
         genotype_label = factor(genotype_label, levels = label)) %>% 
  ggplot(aes(x = condition, y = Hz)) + 
  geom_boxplot(aes(fill = condition), alpha = .8, outlier.shape = NA) +
  geom_point(size = 2, alpha = .2) + 
  geom_line(aes(group = id), size = .2, color = "gray30") +
  facet_wrap(vars(genotype_label), 
             strip.position = "bottom",
             labeller = label_parsed) +  
  theme_minimal() +
  ylim(7, 17) +
  labs(fill = "three-day-old", x = "", y = "ciliary beat frequency [Hz]") +
  theme(strip.placement = "outside",
        strip.background = element_blank(),
        strip.text = element_text(size = 11),
        axis.text.x=element_blank()) +
  scale_fill_manual(
    values = c(before = "#B3B3B3",
               UV = "#D461FF")) +
  stat_compare_means(comparisons = list(c("before", "UV")), 
                     method = "t.test", 
                     label = "p.signif", 
                     paired=TRUE)


  
# save plot ---------------------------------------------------------------
ggsave("pictures/CBF_3d_plot.png", limitsize = FALSE, 
       units = c("px"), width = 1400, height = 1000, bg='white')

# save to source data-------------------------------------------------------

#df_L_NAME_tracking %>%
#  write_csv("source_data/Figure3_supplement1_source_data6.csv")


# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_Architecture <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png"))
panel_setup <- ggdraw() + draw_image(readPNG("pictures/vertical_experiment_setup.png"))

#Martin images
panel_2d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_2dpf_WTvsNOSmix.png"))
panel_3d_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_WTvsNOSmix.png"))
panel_3d_L_NAME_vd <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_L_NAME.png"))


#Tracking images
panel_2dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_2d.png"))
panel_2dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_2d.png"))
panel_2d_mTP <- ggdraw() + draw_image(readPNG("pictures/Vertical displacement_mean_2d_statics.png"))
panel_2dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_2d.png"))
panel_2dpf_mTD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_mean_speed_2d.png"))


panel_3dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_sideUV_3d.png"))
panel_3dpf_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_3d.png"))
panel_3d_mTP <- ggdraw() + draw_image(readPNG("pictures/Vertical displacement_mean_3d_statics.png"))
panel_3dpf_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_3d.png"))
panel_3dpf_mTD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_mean_speed_3d.png"))

panel_L_NAME_TP <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_position_sideUV_L_NAME.png"))
panel_3d_L_NAME_mTP <- ggdraw() + draw_image(readPNG("pictures/Vertical displacement_mean_L_NAME_statics.png"))
panel_L_NAME_TD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_distanse_sideUV_L_NAME.png"))
panel_L_NAME_mTD <- ggdraw() + draw_image(readPNG("pictures/vertical_tracking_mean_speed_L_NAME.png"))

#CBF images
panel_2d_CBF <- ggdraw() + draw_image(readPNG("pictures/CBF_2d_plot.png"))
panel_3d_CBF <- ggdraw() + draw_image(readPNG("pictures/CBF_3d_plot.png"))



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
AAAA#FFFFF
AAAA#FFFFF
AAAA#FFFFF
AAAA#FFFFF
AAAA#FFFFF
AAAA#FFFFF
#####FFFFF
BBBC#FFFFF
BBBC#GGGGG
BBBC#GGGGG
BBBC#GGGGG
#####GGGGG
DDDE#GGGGG
DDDE#GGGGG
DDDE#GGGGG
DDDE#GGGGG
"

Fig3 <-  panel_3dpf_Tracking + 
  panel_3dpf_TP + panel_3d_mTP + 
  panel_L_NAME_TP + panel_3d_L_NAME_mTP +
  panel_3d_vd + panel_3d_L_NAME_vd +
  patchwork::plot_layout(design = layout,
                         widths = c(1,1,1,1,0.01,1,1,1,1,1), 
                         heights = c(1,1,1,1,1,1,0.05,1,1,1,1,0.05,1,1,1,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


ggsave("Manuscript/figures/Fig3.png", limitsize = FALSE, 
       units = c("px"), Fig3, width = 3200, height = 2100, bg='white')  

ggsave("Manuscript/figures/Fig3.pdf", limitsize = FALSE, 
       units = c("px"), Fig3, width = 2400, height = 1300)  




#layout <- "
#AABBCC
#######
#DDDEEE
#"

#Fig3 <-  panel_3dpf_Tracking + panel_3dpf_TP + panel_L_NAME_TP +
#  panel_3d_vd + panel_3d_L_NAME_vd +
#  patchwork::plot_layout(design = layout, heights = c(0.8, 0.05, 1)) + #we can change the heights of the rows in our layout (widths also can be defined)
#  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
#  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'


#ggsave("Manuscript/figures/Fig3.png", limitsize = FALSE, 
#       units = c("px"), Fig3, width = 2400, height = 1300, bg='white')  

#ggsave("Manuscript/figures/Fig3.pdf", limitsize = FALSE, 
#       units = c("px"), Fig3, width = 2400, height = 1300)  






layout_sup1 <- "
A#BB#CCC
#####CCC
FFFF#CCC
FFFF####
FFFF#DDE
"

Fig3_sup1 <-  
  panel_setup + panel_Architecture + 
  panel_2dpf_Tracking + 
  panel_2dpf_TP + panel_2d_mTP +
  panel_2d_vd +
  patchwork::plot_layout(design = layout_sup1,
                         widths = c(5.8,0.05,4.25,4.25,0.05,3.6,3.6,3.6), 
                         heights = c(2.3,0.05,1.2,0.05,3.0)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig3_sup1.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 3000, height = 1570, bg='white')  

ggsave("Manuscript/figures/Fig3_sup1.pdf", limitsize = FALSE, 
       units = c("px"), Fig3_sup1, width = 3200, height = 1200)  



layout_sup2 <- "
A#C#E
#####
B#D#F
"

Fig3_sup2 <-  
  panel_2dpf_TD + panel_2dpf_mTD + 
  panel_3dpf_TD + panel_3dpf_mTD + 
  panel_L_NAME_TD + panel_L_NAME_mTD + 
  patchwork::plot_layout(design = layout_sup2,
                         widths = c(1,0.05,1,0.05,1), 
                         heights = c(1,0.05,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig3_sup2.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup2, width = 3000, height = 1200, bg='white')  



layout_sup3 <- "
A#B
"

Fig3_sup3 <-  
  panel_2d_CBF + panel_3d_CBF +
  patchwork::plot_layout(design = layout_sup3,
                         widths = c(1,0.05,1)) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') &  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'plain', 'italic'

ggsave("Manuscript/figures/Fig3_sup3.png", limitsize = FALSE, 
       units = c("px"), Fig3_sup3, width = 2400, height = 800, bg='white')  

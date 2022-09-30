#Code to assemble Fig2 of the Jokura et al Platynereis NOS paper
#2022 June - Kei Jokura, Gaspar Jekely

# source packages ---------------------------------------------------------
source("code/Packages_to_load.R")

# read data----------------------------------------------------------------
WT_2d <- read_csv("data/2017-08-29_YDisplacement_2d_NNxNN_UV-Side-480nm-395nm-Good.csv")
NOS_2d <- read_csv("data/2017-08-29_YDisplacement_2d_nnxnn_UV-Side-480nm-395nm-Good (1).csv")

WT_3d <- read_csv("data/2017-08-29_YDisplacement_3d_NNxNN_UV-Side-480nm-395nm-Good.csv")
NOS_3d <- read_csv("data/2017-08-29_YDisplacement_3d_nnxnn_UV-Side-480nm-395nm-Good (1).csv")



#Used for frame and genotype column data
df_WT_test <- read_csv("data/220923_Tracking raw data/WT_0701_08_01.csv")
df_NOS_test <- read_csv("data/220923_Tracking raw data/NOS_0623_00_01.csv")


#Import WT tracking data
files <- list.files(path = "data/220923_Tracking raw data/WT", 
                    pattern = "*.csv", full.names = TRUE)
df_WT <- sapply(files, read_csv, simplify = FALSE)%>% 
  bind_rows()

#Import NOS tracking data
files <- list.files(path = "data/220923_Tracking raw data/NOS", 
                    pattern = "*.csv", full.names = TRUE)
df_NOS <- sapply(files, read_csv, simplify = FALSE)%>% 
  bind_rows()



# tidying Martin data (30 sec bins, vertical displacement)------------------------------------------------
WT_2d_tidy <- gather(WT_2d, key="WT", value="displacement", -time, -condition)
WT_2d_tidy_phenotype <- gather(WT_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS_2d_tidy <- gather(NOS_2d, key="NOS", value="displacement", -time, -condition)
NOS_2d_tidy_phenotype <- gather(NOS_2d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

WT_3d_tidy <- gather(WT_3d, key="WT", value="displacement", -time, -condition)
WT_3d_tidy_phenotype <- gather(WT_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)

NOS_3d_tidy <- gather(NOS_3d, key="NOS", value="displacement", -time, -condition)
NOS_3d_tidy_phenotype <- gather(NOS_3d_tidy, key="phenotype", value="batch", -time, -condition, -displacement)


#bind
WTvsNOS_2d <- bind_rows(WT_2d_tidy_phenotype, NOS_2d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS")))

WTvsNOS_3d <- bind_rows(WT_3d_tidy_phenotype, NOS_3d_tidy_phenotype) %>%
  mutate(phenotype = factor(phenotype, levels = c("WT", "NOS")))


# plot Martin data (2d larvae, 30 sec bins, vertical displacement)-------------------------------

WTvsNOS_2d %>%
  ggplot() +
  annotate("rect", xmin="sideUV_30", xmax="sideUV_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("rect", xmin="top488_30", xmax="top488_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("rect", xmin="top395_30", xmax="top395_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot() +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-1, 1.2)) +
  scale_x_discrete(limit=c("dark_30", "dark_60", "dark_90", "dark_120", 
                             "dark_150", "dark_180", "dark_210", "dark_240", 
                             "sideUV_30", "sideUV_60", "sideUV_90", "sideUV_120", 
                             "dark1_30", "dark1_60", "dark1_90", "dark1_120", 
                             "top488_30", "top488_60", "top488_90", "top488_120", 
                             "dark2_30", "dark2_60", "dark2_90", "dark2_120", 
                             "top395_30", "top395_60", "top395_90", "top395_120", 
                             "dark3_30", "dark3_60", "dark3_90", "dark3_120", 
                             "dark3_150", "dark3_180"))




# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_2dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')


# plot Martin data (3d larvae, 30 sec bins, vertical displacement)-------------------------------

WTvsNOS_3d %>%
  ggplot() +
  annotate("rect", xmin="sideUV_30", xmax="sideUV_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  annotate("rect", xmin="top488_30", xmax="top488_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="deepskyblue") +
  annotate("rect", xmin="top395_30", xmax="top395_120", ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = reorder(condition, time), y = displacement, fill = phenotype) +
  geom_boxplot() +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "30 sec bins", y = "Vertical displacement (mm/s)")+
  scale_y_continuous(limits = c(-1, 1)) +
  scale_x_discrete(limit=c("dark_30", "dark_60", "dark_90", "dark_120", 
                           "dark_150", "dark_180", "dark_210", "dark_240", 
                           "sideUV_30", "sideUV_60", "sideUV_90", "sideUV_120", 
                           "dark1_30", "dark1_60", "dark1_90", "dark1_120", 
                           "top488_30", "top488_60", "top488_90", "top488_120", 
                           "dark2_30", "dark2_60", "dark2_90", "dark2_120", 
                           "top395_30", "top395_60", "top395_90", "top395_120", 
                           "dark3_30", "dark3_60", "dark3_90", "dark3_120", 
                           "dark3_150", "dark3_180"))

# save plot ---------------------------------------------------------------

ggsave("pictures/vertical_displacement_3dpf_WTvsNOSmix.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')



# plot Tracking (WT)---------------------------------------------------------

#Tracking graph UV(purple)
plot_3dpf_WT_Tracking <-ggplot(df_WT) +
  aes(x = nor_X, y = nor_V, colour = condition) +
  geom_point(shape = "circle", size = 0.5) +
  scale_color_manual(values = c(dark = "gray60",UV = "#6E0EFF")) +
  theme_classic() +
  theme(legend.position = "none") +
  coord_fixed()+
  xlim(-120,120)+
  ylim(-300, 150)


# plot Tracking (NOS)---------------------------------------------------------

#Tracking graph UV(purple)
plot_3dpf_NOS_Tracking <- df_NOS %>%
  filter(nor_V >= -225L & nor_V <= 160L) %>%
  ggplot() +
  aes(x = nor_X, y = nor_V, colour = condition) +
  geom_point(shape = "circle", size = 0.5) +
  scale_color_manual(values = c(dark = "gray60",UV = "#6E0EFF")) +
  theme_classic() +
  theme(legend.position = "none") +
  coord_fixed()+
  xlim(-120,120)+
  ylim(-300, 150)


#Align the two tracking graphs---------------------------------------------

layout <- "
AB
"

Tracking <- plot_3dpf_WT_Tracking + plot_3dpf_NOS_Tracking + 
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  ggplot2::theme(plot.tag = element_text(size = 12, face='plain')) #or 'bold', 'italic'

Tracking

# save plot ---------------------------------------------------------------

ggsave("pictures/Tracking_3dpf.png", limitsize = FALSE, 
       units = c("px"), width = 2400, height = 2000, bg='white')


#calculating each distances-----------------------------------------------------------------------

dis_WT <- data.frame()
for (j in 1:15000){
  b <- sqrt((df_WT[j+1,"X"] - df_WT[j,"X"])^2 + (df_WT[j+1,"Y"] - df_WT[j,"Y"])^2)
  dis_WT <- rbind(dis_WT, b)
}
colnames(dis_WT) <- c("distance")
df_WT <- cbind(df_WT, dis_WT)


dis_NOS <- data.frame()
for (i in 1:23250){
  d <- sqrt((df_NOS[i+1,"X"] - df_NOS[i,"X"])^2 + (df_NOS[i+1,"Y"] - df_NOS[i,"Y"])^2)
  dis_NOS <- rbind(dis_NOS, d)
}
colnames(dis_NOS) <- c("distance")
df_NOS <- cbind(df_NOS, dis_NOS)

#calculate mean travel distance (speed)
WT_mean <- data.frame(Frame = df_WT_test$Frame,
                      genotype = df_WT_test$genotype,
                      condition = df_WT_test$condition,
                      number = tapply(df_WT$distance, df_WT$Frame, length), 
                      mean = tapply(df_WT$distance, df_WT$Frame, mean))


NOS_mean <- data.frame(Frame = df_NOS_test$Frame,
                       genotype = df_NOS_test$genotype,
                       condition = df_NOS_test$condition,
                       number = tapply(df_NOS$distance, df_NOS$Frame, length), 
                       mean = tapply(df_NOS$distance, df_NOS$Frame, mean))

#sd
WT_mean$sd <- tapply(df_WT$distance, df_WT$Frame, sd)
#se
WT_mean$se <- WT_mean$sd/sqrt(WT_mean$n-1)
#95% confidence interval
WT_mean$CI_lower <- 
  WT_mean$mean + qt((1-0.95)/2, df=WT_mean$n-1) * WT_mean$se
WT_mean$CI_upper <- 
  WT_mean$mean - qt((1-0.95)/2, df=WT_mean$n-1) * WT_mean$se

#sd
NOS_mean$sd <- tapply(df_NOS$distance, df_NOS$Frame, sd)
#se
NOS_mean$se <- NOS_mean$sd/sqrt(NOS_mean$n-1)
#95% confidence interval
NOS_mean$CI_lower <- 
  NOS_mean$mean + qt((1-0.95)/2, df=NOS_mean$n-1) * NOS_mean$se
NOS_mean$CI_upper <- 
  NOS_mean$mean - qt((1-0.95)/2, df=NOS_mean$n-1) * NOS_mean$se

tracking_mean <- rbind(WT_mean, NOS_mean)

# plot the tracking mean distance (speed) data-----------------------------------------------------
ggplot(tracking_mean) +
  annotate("rect", xmin=301, xmax=750, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  aes(x = Frame, y = mean, colour = genotype) +
  geom_point(shape = "circle", size = 1.15, alpha=0.5) +
  geom_smooth(size = 1.15, span = 0.3) +
  scale_color_hue(direction = -1)+
  theme_classic() +
  theme(legend.position = "none") +
  ylim(0.2, 0.5)


# save plot ---------------------------------------------------------------

ggsave("pictures/tracking_mean_distance.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')





#calculate mean vertical position-----------------------------------------------
WT_V_mean <- data.frame(Frame = df_WT_test$Frame,
                        genotype = df_WT_test$genotype,
                        condition = df_WT_test$condition,
                        number = tapply(df_WT$nor_V, df_WT$Frame, length), 
                        V_mean = tapply(df_WT$nor_V, df_WT$Frame, mean))


NOS_V_mean <- data.frame(Frame = df_NOS_test$Frame,
                         genotype = df_NOS_test$genotype,
                         condition = df_NOS_test$condition,
                         number = tapply(df_NOS$nor_V, df_NOS$Frame, length), 
                         V_mean = tapply(df_NOS$nor_V, df_NOS$Frame, mean))

#sd
WT_V_mean$sd <- tapply(df_WT$nor_V, df_WT$Frame, sd)
#se
WT_V_mean$se <- WT_V_mean$sd/sqrt(WT_V_mean$n-1)

#95% confidence interval
WT_V_mean$CI_lower <- 
  WT_V_mean$V_mean + qt((1-0.95)/2, df=WT_V_mean$n-1) * WT_V_mean$se
WT_V_mean$CI_upper <- 
  WT_V_mean$V_mean - qt((1-0.95)/2, df=WT_V_mean$n-1) * WT_V_mean$se


#sd
NOS_V_mean$sd <- tapply(df_NOS$nor_V, df_NOS$Frame, sd)
#se
NOS_V_mean$se <- NOS_V_mean$sd/sqrt(NOS_V_mean$n-1)


#95% confidence interval
NOS_V_mean$CI_lower <- 
  NOS_V_mean$V_mean + qt((1-0.95)/2, df=NOS_V_mean$n-1) * NOS_V_mean$se
NOS_V_mean$CI_upper <- 
  NOS_V_mean$V_mean - qt((1-0.95)/2, df=NOS_V_mean$n-1) * NOS_V_mean$se


tracking_V_mean <- rbind(WT_V_mean, NOS_V_mean)



# plot the tracking mean vertical position in WT-----------------------------------------------------

ggplot() +
  aes(x = Frame, y = V_mean)+
  annotate("rect", xmin=301, xmax=750, ymin=-Inf, ymax=Inf,alpha=0.1, fill="blue") +
  geom_point(data = df_WT, aes(x=Frame, y=nor_V, group="Track ID"), color="orangered", size =0.4, alpha=0.05) + 
  geom_point(data = df_NOS, aes(x=Frame, y=nor_V, group="Track ID"), color="lightseagreen", size =0.4, alpha=0.05) +
  geom_ribbon(data = WT_V_mean, aes(ymin=CI_lower, ymax=CI_upper) ,fill="gray", alpha=0.5)+
  geom_ribbon(data = NOS_V_mean, aes(ymin=CI_lower, ymax=CI_upper) ,fill="gray", alpha=0.5)+
  geom_line(data = NOS_V_mean, aes(x = Frame, y = V_mean), size = 1.25, color = "lightseagreen") +
  geom_line(data = WT_V_mean, aes(x = Frame, y = V_mean), size = 1.25, color = "orangered") +
  theme_classic()+
  ylim(-300, 150)

# save plot ---------------------------------------------------------------

ggsave("pictures/tracking_mean_vertical_position.png", limitsize = FALSE, 
       units = c("px"), width = 3000, height = 2000, bg='white')



# assemble figure ---------------------------------------------------------

#read png convert to image panel

panel_Architecture <- ggdraw() + draw_image(readPNG("pictures/NOS-Architecture.png"))
panel_2dpf <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_2dpf_WTvsNOSmix.png"))
panel_3dpf <- ggdraw() + draw_image(readPNG("pictures/vertical_displacement_3dpf_WTvsNOSmix.png"))
panel_3dpf_Tracking <- ggdraw() + draw_image(readPNG("pictures/Tracking_3dpf.png"))
panel_3dpf_Tracking_position <- ggdraw() + draw_image(readPNG("pictures/tracking_mean_vertical_position.png"))
panel_3dpf_Tracking_distance <- ggdraw() + draw_image(readPNG("pictures/tracking_mean_distance.png"))

#combine panels into Figure and save final figure as pdf and png
#panels of different sizes
layout <- "
ABC
DEF
"

Fig2 <- panel_Architecture + panel_2dpf + panel_3dpf + panel_3dpf_Tracking +
  panel_3dpf_Tracking_position + panel_3dpf_Tracking_distance + 
  patchwork::plot_layout(design = layout) + #we can change the heights of the rows in our layout (widths also can be defined)
  patchwork::plot_annotation(tag_levels = 'A') +  #we can change this to 'a' for small caps or 'i' or '1'
  ggplot2::theme(plot.tag = element_text(size = 12, face='bold')) #or 'plain', 'italic'


ggsave("figures/Fig2.png", limitsize = FALSE, 
       units = c("px"), Fig2, width = 2400, height = 1200, bg='white')  

ggsave("figures/Fig2.pdf", limitsize = FALSE, 
       units = c("px"), Fig2, width = 2400, height = 1200)  




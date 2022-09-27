rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# load some packages
library(tidyverse)
library(cowplot)
library(png)
library(patchwork)
library(magick)
library(ggplot2)
library(esquisse)
library(readr)

df_WT_test <- read_csv("~/Martin behaviour/Tracking/WT/WT_0701_08_01.csv")
df_NOS_test <- read_csv("~/Martin behaviour/Tracking/NOS/NOS_0623_00_01.csv")


#Import WT tracking data
files <- list.files(path = "C:/Users/klamd/Documents/Martin behaviour/Tracking/WT", 
                    pattern = "*.csv", full.names = TRUE)
df_WT <- sapply(files, read_csv, simplify = FALSE)%>% 
  bind_rows()

#Import NOS tracking data
files <- list.files(path = "C:/Users/klamd/Documents/Martin behaviour/Tracking/NOS", 
                    pattern = "*.csv", full.names = TRUE)
df_NOS <- sapply(files, read_csv, simplify = FALSE)%>% 
  bind_rows()


#Tracking graph UV(purple)
ggplot(df_WT) +
  aes(x = nor_X, y = nor_V, colour = condition) +
  geom_point(shape = "circle", size = 0.5) +
  scale_color_manual(values = c(dark = "gray60",UV = "#6E0EFF")) +
  theme_classic() +
  theme(legend.position = "none") +
  coord_fixed()+
  xlim(-120,120)+
  ylim(-300, 150)

df_NOS %>%
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




#Tracking graph time color
ggplot(df_WT) +
  aes(x = nor_X, y = nor_V, colour = Frame) +
  geom_point(shape = "circle", size = 0.5) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  theme_classic() +
  coord_fixed()

df_NOS %>%
  filter(nor_V >= -225L & nor_V <= 160L) %>%
  ggplot() +
  aes(x = nor_X, y = nor_V, colour = Frame) +
  geom_point(shape = "circle", size = 0.5) +
  scale_color_viridis_c(option = "plasma", direction = -1) +
  theme_classic() +
  coord_fixed()



#Caluculate their distances

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


df <- rbind(df_WT, df_NOS)





ggplot(df) +
  aes(x = Frame, y = nor_V, colour = genotype) +
  geom_point(shape = "circle", size = 0.5, alpha = 0.05) +
  geom_smooth(span = 0.05) +
  scale_color_hue(direction = 1) +
  theme_minimal()



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

ggplot(tracking_mean) +
  aes(x = Frame, y = mean, colour = genotype) +
  geom_point(shape = "circle", size = 1.15, alpha=0.5) +
  geom_smooth(size = 1.15, span = 0.3) +
  scale_color_hue(direction = -1) +
  theme_minimal() +
  theme(legend.position = "none") +
  ylim(0.2, 0.5)

#ggplot(WT_mean) +
  aes(x = Frame, y = mean) +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  theme_minimal()+
  xlim(0, 748)+
  ylim(0.2, 0.7)

#ggplot(NOS_mean) +
  aes(x = Frame, y = mean) +
  geom_line(size = 1.1, color = "darkblue") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="blue", alpha=0.2)+
  theme_minimal()+
  xlim(0, 748)+
  ylim(0.2, 0.7)


















#calculate mean vertical position
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

#ggplot(tracking_V_mean) +
  aes(x = Frame, y = V_mean, colour = genotype) +
  geom_point(shape = "circle", size = 1.15, alpha = 0.1) +
  geom_smooth(span = 0.5) +
  scale_color_hue(direction = -1) +
  theme_minimal() +
  theme(legend.position = "none")


ggplot(WT_V_mean) +
  aes(x = Frame, y = V_mean)+
  geom_line(size = 1.5, color = "darkmagenta") +
  geom_point(data = df_WT, aes(x=Frame, y=nor_V, group="Track ID"), color="grey", size =0.4, alpha=0.2) + 
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  theme_minimal()+
  ylim(-300, 150)

ggplot(NOS_V_mean) +
  aes(x = Frame, y = V_mean) +
  geom_point(data = df_NOS, aes(x=Frame, y=nor_V, group="Track ID"), color="grey", size =0.4, alpha=0.2) +
  geom_line(size = 1.5, color = "darkblue") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="blue", alpha=0.2)+
  theme_minimal()+
  ylim(-300, 150)















#Clear R's Brain
rm(list = ls())

library(dplyr)
library(ggplot2)
library(tidyverse)
library(scales)
library(plotly)
library(ggplotgui)
library(tidyr)
library(esquisse)
library(ggraptR)
library(readr)





#NIT-GC1_analysis imaging graph
NITGC1_analysis <- read_csv("data/220519_GcG-T2A-NITGC1_norm.csv")




#抽出:expressionとsolutionからデータを抽出する
GcG_NIT1_cGMP <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                        & solution == "cGMP")

#すべてのデータを確認してみる  
ggplot(GcG_NIT1_cGMP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
GcG_NIT1_cGMP_mean <- data.frame(time = GcG_NIT1_cGMP$time, 
                                number = tapply(GcG_NIT1_cGMP$intensity, GcG_NIT1_cGMP$time, length), 
                                mean = tapply(GcG_NIT1_cGMP$intensity, GcG_NIT1_cGMP$time, mean))

#sd
GcG_NIT1_cGMP_mean$sd <- tapply(GcG_NIT1_cGMP$intensity, GcG_NIT1_cGMP$time, sd)
#se
GcG_NIT1_cGMP_mean$se <- GcG_NIT1_cGMP_mean$sd/sqrt(GcG_NIT1_cGMP_mean$n-1)

#95% confidence interval
GcG_NIT1_cGMP_mean$CI_lower <- 
  GcG_NIT1_cGMP_mean$mean + qt((1-0.95)/2, df=GcG_NIT1_cGMP_mean$n-1) * GcG_NIT1_cGMP_mean$se
GcG_NIT1_cGMP_mean$CI_upper <- 
  GcG_NIT1_cGMP_mean$mean - qt((1-0.95)/2, df=GcG_NIT1_cGMP_mean$n-1) * GcG_NIT1_cGMP_mean$se

#graph
ggplot(GcG_NIT1_cGMP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_NIT1_cGMP, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  scale_y_continuous(limits = c(0.95, 1.85))











#抽出:expressionとsolutionからデータを抽出する
GcG_SNAP <- subset(NITGC1_analysis, subset = expression == "GcG" 
                        & solution == "SNAP")

#すべてのデータを確認してみる  
ggplot(GcG_SNAP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
GcG_SNAP_mean <- data.frame(time = GcG_SNAP$time, 
                                 number = tapply(GcG_SNAP$intensity, GcG_SNAP$time, length), 
                                 mean = tapply(GcG_SNAP$intensity, GcG_SNAP$time, mean))

#sd
GcG_SNAP_mean$sd <- tapply(GcG_SNAP$intensity, GcG_SNAP$time, sd)
#se
GcG_SNAP_mean$se <- GcG_SNAP_mean$sd/sqrt(GcG_SNAP_mean$n-1)

#95% confidence interval
GcG_SNAP_mean$CI_lower <- 
  GcG_SNAP_mean$mean + qt((1-0.95)/2, df=GcG_SNAP_mean$n-1) * GcG_SNAP_mean$se
GcG_SNAP_mean$CI_upper <- 
  GcG_SNAP_mean$mean - qt((1-0.95)/2, df=GcG_SNAP_mean$n-1) * GcG_SNAP_mean$se

#graph
GcG_SNAP_PNG <- ggplot(GcG_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_SNAP, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, alpha=0.4, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

ggsave(file = "GcG_SNAP.png", plot = GcG_SNAP_PNG, dpi = 300, path = "pictures")

#

#GcG_SNAP_g <- ggplot(GcG_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_SNAP, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black")+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

#ggsave(file = "GcG_SNAP.eps", plot = GcG_SNAP_g, dpi = 300, path = "pictures")









#抽出:expressionとsolutionからデータを抽出する
GcG_NIT1_SNAP <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                        & solution == "SNAP")

#すべてのデータを確認してみる  
ggplot(GcG_NIT1_SNAP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
GcG_NIT1_SNAP_mean <- data.frame(time = GcG_NIT1_SNAP$time, 
                                 number = tapply(GcG_NIT1_SNAP$intensity, GcG_NIT1_SNAP$time, length), 
                                 mean = tapply(GcG_NIT1_SNAP$intensity, GcG_NIT1_SNAP$time, mean))

#sd
GcG_NIT1_SNAP_mean$sd <- tapply(GcG_NIT1_SNAP$intensity, GcG_NIT1_SNAP$time, sd)
#se
GcG_NIT1_SNAP_mean$se <- GcG_NIT1_SNAP_mean$sd/sqrt(GcG_NIT1_SNAP_mean$n-1)

#95% confidence interval
GcG_NIT1_SNAP_mean$CI_lower <- 
  GcG_NIT1_SNAP_mean$mean + qt((1-0.95)/2, df=GcG_NIT1_SNAP_mean$n-1) * GcG_NIT1_SNAP_mean$se
GcG_NIT1_SNAP_mean$CI_upper <- 
  GcG_NIT1_SNAP_mean$mean - qt((1-0.95)/2, df=GcG_NIT1_SNAP_mean$n-1) * GcG_NIT1_SNAP_mean$se

#graph
GcG_NIT1_SNAP_PNG <- ggplot(GcG_NIT1_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_NIT1_SNAP, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "cornflowerblue") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="cornflowerblue", alpha=0.2)+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull + NIT-GC1")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, alpha=0.4, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

ggsave(file = "GcG_NIT1_SNAP.png", plot = GcG_NIT1_SNAP_PNG, dpi = 300, path = "pictures")
#

#GcG_NIT1_SNAP_g <- ggplot(GcG_NIT1_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_NIT1_SNAP, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "dark green") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="dark green")+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull + NIT-GC1")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="SNAP")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

#ggsave(file = "GcG_NIT1_SNAP.eps", plot = GcG_NIT1_SNAP_g, dpi = 300, path = "pictures")



















#抽出:expressionとsolutionからデータを抽出する
GcG_NIT1_DMSO <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                   & solution == "DMSO")

#すべてのデータを確認してみる  
ggplot(GcG_NIT1_DMSO, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply関数は第1引数に処理対象データ、第2引数に分類データ、第3引数に処理したい関数
GcG_NIT1_DMSO_mean <- data.frame(time = GcG_NIT1_DMSO$time, 
                            number = tapply(GcG_NIT1_DMSO$intensity, GcG_NIT1_DMSO$time, length), 
                            mean = tapply(GcG_NIT1_DMSO$intensity, GcG_NIT1_DMSO$time, mean))

#sd
GcG_NIT1_DMSO_mean$sd <- tapply(GcG_NIT1_DMSO$intensity, GcG_NIT1_DMSO$time, sd)
#se
GcG_NIT1_DMSO_mean$se <- GcG_NIT1_DMSO_mean$sd/sqrt(GcG_NIT1_DMSO_mean$n-1)

#95% confidence interval
GcG_NIT1_DMSO_mean$CI_lower <- 
  GcG_NIT1_DMSO_mean$mean + qt((1-0.95)/2, df=GcG_NIT1_DMSO_mean$n-1) * GcG_NIT1_DMSO_mean$se
GcG_NIT1_DMSO_mean$CI_upper <- 
  GcG_NIT1_DMSO_mean$mean - qt((1-0.95)/2, df=GcG_NIT1_DMSO_mean$n-1) * GcG_NIT1_DMSO_mean$se

#graph
GcG_NIT1_DMSO_PNG <- ggplot(GcG_NIT1_DMSO_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_NIT1_DMSO, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull + NIT-GC1")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="DMSO")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, alpha=0.4, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

ggsave(file = "GcG_NIT1_DMSO.png", plot = GcG_NIT1_DMSO_PNG, dpi = 300, path = "pictures")

#

#GcG_NIT1_DMSO_g <- ggplot(GcG_NIT1_DMSO_mean) +
  aes(x = time, y = mean) +
  geom_line(data = GcG_NIT1_DMSO, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black")+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull + NIT-GC1")+
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.95, 1.15))+
  scale_x_continuous(breaks=seq(0,10,length=6),limits = c(0, 10))+
  annotate("segment", x=2, xend=10, y=1.14, yend=1.14, size=2.5, color = "gray")+
  annotate("text", x=2.5, y=1.15, size=5, label="DMSO")+
  annotate("segment", x=0, xend=10, y=1, yend=1, size=0.5, linetype="dashed")+
  theme_classic()+
  theme(plot.title = element_text(face = "bold", size = 18),
        axis.title.y = element_text(size = 14L,face = "bold"),
        axis.title.x = element_text(size = 14L,face = "bold"),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14))

#ggsave(file = "GcG_NIT1_DMSO.eps", plot = GcG_NIT1_DMSO_g, dpi = 300, path = "pictures")


#
  
 


















  
#NIT-GC2_analysis bar graph
NITGC1_analysis_mean <- read_csv("data/220520_GcG-T2A-NITGC1_mean.csv")


NITGC1_analysis_PNG <- ggplot(NITGC1_analysis_mean) +
  aes(x=reorder(condition, -mean), y = mean, fill = condition) +
  geom_boxplot(shape = "circle") +
  geom_jitter(size = 3, alpha = 0.25, width = 0, colour = 'black') +
  scale_fill_manual(values = c(`GcG-NIT1_cGMP` = "gray",
               `GcG-NIT1_DMSO` = "gray",
               `GcG-NIT1_SNAP` = "cornflowerblue",
               GcG_SNAP = "dark gray")
  ) +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.975, 1.15))+
  labs(x = "Conditions", y = "Mean intensity (Fmean/F0)") +
  theme_classic() +
  theme(
    legend.position = "none",
    axis.title.y = element_text(size = 14L,face = "bold"),
    axis.title.x = element_text(size = 14L,face = "bold"),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )

ggsave(file = "NITGC1_analysis.png", plot = NITGC1_analysis_PNG, dpi = 300, path = "pictures")


#NITGC1_analysis_eps <- ggplot(NITGC1_analysis_mean) +
  aes(x=reorder(condition, -mean), y = mean, fill = condition) +
  geom_boxplot(shape = "circle") +
  geom_jitter(size = 3, width = 0, colour = 'black') +
  scale_fill_manual(values = c(`GcG-NIT1_cGMP` = "gray",
                               `GcG-NIT1_DMSO` = "gray",
                               `GcG-NIT1_SNAP` = "green",
                               GcG_SNAP = "dark gray")
  ) +
  scale_y_continuous(breaks=seq(1,1.15,length=4),limits = c(0.975, 1.15))+
  labs(x = "Conditions", y = "Mean intensity (Fmean/F0)") +
  theme_classic() +
  theme(
    legend.position = "none",
    axis.title.y = element_text(size = 14L,face = "bold"),
    axis.title.x = element_text(size = 14L,face = "bold"),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )

#ggsave(file = "NITGC1_analysis.eps", plot = NITGC1_analysis_eps, dpi = 300, path = "pictures")




#statistical test
SG_data <- lm(mean ~ condition, data = NITGC1_analysis_mean) 
SG_res1<-aov(mean ~ condition,d = NITGC1_analysis_mean)
summary(SG_res1)

SG_res2<-glht(SG_res1,linfct=mcp(group="Tukey"))
summary(SG_res2)

TukeyHSD(aov(mean ~ condition,d=NITGC1_analysis_mean))








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




#Selecting data from expression and solution
GcG_NIT1_cGMP <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                        & solution == "cGMP")

#Check all data  
ggplot(GcG_NIT1_cGMP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply
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











#Selecting data from expression and solution
GcG_SNAP <- subset(NITGC1_analysis, subset = expression == "GcG" 
                        & solution == "SNAP")

#Check all data  
ggplot(GcG_SNAP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply
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

#ggsave(file = "GcG_SNAP.png", plot = GcG_SNAP_PNG, dpi = 300, path = "pictures")

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









#Selecting data from expression and solution
GcG_NIT1_SNAP <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                        & solution == "SNAP")

#Check all data  
ggplot(GcG_NIT1_SNAP, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply
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

#ggsave(file = "GcG_NIT1_SNAP.png", plot = GcG_NIT1_SNAP_PNG, dpi = 300, path = "pictures")
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



















#Selecting data from expression and solution
GcG_NIT1_DMSO <- subset(NITGC1_analysis, subset = expression == "GcG-NIT1" 
                   & solution == "DMSO")

#Check all data  
ggplot(GcG_NIT1_DMSO, aes(x=time, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=cell), size = 0.8, alpha = 0.5) 

#tapply
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

#ggsave(file = "GcG_NIT1_DMSO.png", plot = GcG_NIT1_DMSO_PNG, dpi = 300, path = "pictures")

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
mutNIT1_SNAP <- read_csv("D:/NOS project/20220802_cGMP assay/R/normal_vs_deletion_mutNIT1_SNAP.csv")
  
mutNIT1_SNAP_df <- mutNIT1_SNAP %>% 
    pivot_longer(cols = c("cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", 
                          "cell9", "cell10", "cell11", "cell12", "cell13", "cell14", "cell15", "cell16", "cell17", "cell18"), 
                 names_to = "cell", 
                 values_to = "intensity")
  
mutNIT1_SNAP_mean <- data.frame(mean = tapply(mutNIT1_SNAP_df$intensity, mutNIT1_SNAP_df$time, mean))
  
  
#tapply
mutNIT1_SNAP_mean <- data.frame(time = tapply(mutNIT1_SNAP_df$time, mutNIT1_SNAP_df$time, mean),
                                  number = tapply(mutNIT1_SNAP_df$intensity, mutNIT1_SNAP_df$time, length),
                                  mean = tapply(mutNIT1_SNAP_df$intensity, mutNIT1_SNAP_df$time, mean))
  
#sd
mutNIT1_SNAP_mean$sd <- tapply(mutNIT1_SNAP_df$intensity, mutNIT1_SNAP_df$time, sd)
#se
mutNIT1_SNAP_mean$se <- mutNIT1_SNAP_mean$sd/sqrt(mutNIT1_SNAP_mean$n-1)
  
  
#95% confidence interval
mutNIT1_SNAP_mean$CI_lower <- 
    mutNIT1_SNAP_mean$mean + qt((1-0.95)/2, df=mutNIT1_SNAP_mean$n-1) * mutNIT1_SNAP_mean$se
mutNIT1_SNAP_mean$CI_upper <- 
    mutNIT1_SNAP_mean$mean - qt((1-0.95)/2, df=mutNIT1_SNAP_mean$n-1) * mutNIT1_SNAP_mean$se  
 

#graph
mutNIT1_SNAP_PNG <- ggplot(mutNIT1_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = mutNIT1_SNAP_df, aes(x=time, y=intensity, group=cell), 
            color="grey") +
  geom_line(size = 1.1, color = "black") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  ylab("Normalized intensity (ΔF/F0)")+
  xlab("Time (min)")+
  labs(title="Green cGull + mutant NIT-GC1")+
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

mutNIT1_SNAP_PNG

ggsave(file = "mutNIT1_SNAP.png", plot = mutNIT1_SNAP_PNG, width = 2103,
       height = 1681,
       units = c("px"),dpi = 300, path = "pictures")






















  
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

#ggsave(file = "NITGC1_analysis.png", plot = NITGC1_analysis_PNG, dpi = 300, path = "pictures")


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



#cGMP_assay_PNG <- GcG_NIT1_SNAP_PNG|GcG_NIT1_DMSO_PNG|GcG_SNAP_PNG
#cGMP_assay_PNG
#ggsave(file = "cGMP_assay_3cond.png", plot = cGMP_assay_PNG, dpi = 300, path = "pictures")





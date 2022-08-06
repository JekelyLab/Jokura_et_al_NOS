
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

mutNIT1_cGMP <- read_csv("D:/NOS project/20220802_cGMP assay/R/normal_vs_deletion_mutNIT1_cGMP.csv")

mutNIT1_cGMP_df <- mutNIT1_cGMP %>% 
  pivot_longer(cols = c("cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", 
                        "cell9", "cell10"), 
               names_to = "cell", 
               values_to = "intensity")

mutNIT1_cGMP_mean <- data.frame(mean = tapply(mutNIT1_cGMP_df$intensity, mutNIT1_cGMP_df$time, mean))


#tapply
mutNIT1_cGMP_mean <- data.frame(time = tapply(mutNIT1_cGMP_df$time, mutNIT1_cGMP_df$time, mean),
                                number = tapply(mutNIT1_cGMP_df$intensity, mutNIT1_cGMP_df$time, length),
                                mean = tapply(mutNIT1_cGMP_df$intensity, mutNIT1_cGMP_df$time, mean))

#sd
mutNIT1_cGMP_mean$sd <- tapply(mutNIT1_cGMP_df$intensity, mutNIT1_cGMP_df$time, sd)
#se
mutNIT1_cGMP_mean$se <- mutNIT1_cGMP_mean$sd/sqrt(mutNIT1_cGMP_mean$n-1)


#95% confidence interval
mutNIT1_cGMP_mean$CI_lower <- 
  mutNIT1_cGMP_mean$mean + qt((1-0.95)/2, df=mutNIT1_cGMP_mean$n-1) * mutNIT1_cGMP_mean$se
mutNIT1_cGMP_mean$CI_upper <- 
  mutNIT1_cGMP_mean$mean - qt((1-0.95)/2, df=mutNIT1_cGMP_mean$n-1) * mutNIT1_cGMP_mean$se


#graph
ggplot(mutNIT1_cGMP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = mutNIT1_cGMP_df, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  labs(x="Time (min)", y="Normalized intensity (ΔF/F0)") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="purple", alpha=0.2)+
  scale_y_continuous(limits = c(0.95, 1.45))+
  scale_x_continuous(breaks=seq(0,10,length=6))+                                                        
  annotate("rect", xmin=2, xmax=10, ymin=1.4, ymax=1.415, alpha=0.3, fill="orange") +
  annotate("text", x=2.575, y=1.43, label="8-Br-cGMP", size=4)+
  theme_classic() 


NIT1_cGMP <- read_csv("D:/NOS project/20220802_cGMP assay/R/normal_vs_deletion_NIT1_cGMP.csv")

NIT1_cGMP_df <- NIT1_cGMP %>% 
  pivot_longer(cols = c("cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", 
                        "cell9", "cell10", "cell11", "cell12", "cell13", "cell14", "cell15", "cell16", "cell17", "cell18", 
                        "cell19"), 
               names_to = "cell", 
               values_to = "intensity")

NIT1_cGMP_mean <- data.frame(mean = tapply(NIT1_cGMP_df$intensity, NIT1_cGMP_df$time, mean))


#tapply
NIT1_cGMP_mean <- data.frame(time = tapply(NIT1_cGMP_df$time, NIT1_cGMP_df$time, mean),
                                number = tapply(NIT1_cGMP_df$intensity, NIT1_cGMP_df$time, length),
                                mean = tapply(NIT1_cGMP_df$intensity, NIT1_cGMP_df$time, mean))

#sd
NIT1_cGMP_mean$sd <- tapply(NIT1_cGMP_df$intensity, NIT1_cGMP_df$time, sd)
#se
NIT1_cGMP_mean$se <- NIT1_cGMP_mean$sd/sqrt(NIT1_cGMP_mean$n-1)


#95% confidence interval
NIT1_cGMP_mean$CI_lower <- 
  NIT1_cGMP_mean$mean + qt((1-0.95)/2, df=NIT1_cGMP_mean$n-1) * NIT1_cGMP_mean$se
NIT1_cGMP_mean$CI_upper <- 
  NIT1_cGMP_mean$mean - qt((1-0.95)/2, df=NIT1_cGMP_mean$n-1) * NIT1_cGMP_mean$se


#graph
ggplot(NIT1_cGMP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = NIT1_cGMP_df, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  labs(x="Time (min)", y="Normalized intensity (ΔF/F0)") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  scale_y_continuous(limits = c(0.95, 1.45))+
  scale_x_continuous(breaks=seq(0,10,length=6))+                                                        
  annotate("rect", xmin=2, xmax=10, ymin=1.4, ymax=1.415, alpha=0.3, fill="orange") +
  annotate("text", x=2.575, y=1.43, label="8-Br-cGMP", size=4)+
  theme_classic() 

















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
ggplot(mutNIT1_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = mutNIT1_SNAP_df, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  labs(x="Time (min)", y="Normalized intensity (ΔF/F0)") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="purple", alpha=0.2)+
  scale_y_continuous(breaks=seq(0.9,1.2,length=4), limits = c(0.88, 1.2))+
  scale_x_continuous(breaks=seq(0,10,length=6))+                                                        
  annotate("rect", xmin=2, xmax=10, ymin=1.15, ymax=1.16, alpha=0.5, fill="light blue") +
  annotate("text", x=2.3, y=1.17, label="SNAP", size=4)+
  theme_classic() 


NIT1_SNAP <- read_csv("D:/NOS project/20220802_cGMP assay/R/normal_vs_deletion_NIT1_SNAP.csv")

NIT1_SNAP_df <- NIT1_SNAP %>% 
  pivot_longer(cols = c("cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", 
                        "cell9", "cell10", "cell11", "cell12", "cell13", "cell14", "cell15"), 
               names_to = "cell", 
               values_to = "intensity")

NIT1_SNAP_mean <- data.frame(mean = tapply(NIT1_SNAP_df$intensity, NIT1_SNAP_df$time, mean))


#tapply
NIT1_SNAP_mean <- data.frame(time = tapply(NIT1_SNAP_df$time, NIT1_SNAP_df$time, mean),
                             number = tapply(NIT1_SNAP_df$intensity, NIT1_SNAP_df$time, length),
                             mean = tapply(NIT1_SNAP_df$intensity, NIT1_SNAP_df$time, mean))

#sd
NIT1_SNAP_mean$sd <- tapply(NIT1_SNAP_df$intensity, NIT1_SNAP_df$time, sd)
#se
NIT1_SNAP_mean$se <- NIT1_SNAP_mean$sd/sqrt(NIT1_SNAP_mean$n-1)


#95% confidence interval
NIT1_SNAP_mean$CI_lower <- 
  NIT1_SNAP_mean$mean + qt((1-0.95)/2, df=NIT1_SNAP_mean$n-1) * NIT1_SNAP_mean$se
NIT1_SNAP_mean$CI_upper <- 
  NIT1_SNAP_mean$mean - qt((1-0.95)/2, df=NIT1_SNAP_mean$n-1) * NIT1_SNAP_mean$se


#graph
ggplot(NIT1_SNAP_mean) +
  aes(x = time, y = mean) +
  geom_line(data = NIT1_SNAP_df, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  labs(x="Time (min)", y="Normalized intensity (ΔF/F0)") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.2)+
  scale_y_continuous(breaks=seq(0.9,1.2,length=4), limits = c(0.88, 1.2))+
  scale_x_continuous(breaks=seq(0,10,length=6))+                                                        
  annotate("rect", xmin=2, xmax=10, ymin=1.15, ymax=1.16, alpha=0.5, fill="light blue") +
  annotate("text", x=2.3, y=1.17, label="SNAP", size=4)+
  theme_classic() 



















mutNIT1_DMSO <- read_csv("D:/NOS project/20220802_cGMP assay/R/normal_vs_deletion_mutNIT1_DMSO.csv")

mutNIT1_DMSO_df <- mutNIT1_DMSO %>% 
  pivot_longer(cols = c("cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", 
                        "cell9", "cell10"), 
               names_to = "cell", 
               values_to = "intensity")

mutNIT1_DMSO_mean <- data.frame(mean = tapply(mutNIT1_DMSO_df$intensity, mutNIT1_DMSO_df$time, mean))


#tapply
mutNIT1_DMSO_mean <- data.frame(time = tapply(mutNIT1_DMSO_df$time, mutNIT1_DMSO_df$time, mean),
                                number = tapply(mutNIT1_DMSO_df$intensity, mutNIT1_DMSO_df$time, length),
                                mean = tapply(mutNIT1_DMSO_df$intensity, mutNIT1_DMSO_df$time, mean))

#sd
mutNIT1_DMSO_mean$sd <- tapply(mutNIT1_DMSO_df$intensity, mutNIT1_DMSO_df$time, sd)
#se
mutNIT1_DMSO_mean$se <- mutNIT1_DMSO_mean$sd/sqrt(mutNIT1_DMSO_mean$n-1)


#95% confidence interval
mutNIT1_DMSO_mean$CI_lower <- 
  mutNIT1_DMSO_mean$mean + qt((1-0.95)/2, df=mutNIT1_DMSO_mean$n-1) * mutNIT1_DMSO_mean$se
mutNIT1_DMSO_mean$CI_upper <- 
  mutNIT1_DMSO_mean$mean - qt((1-0.95)/2, df=mutNIT1_DMSO_mean$n-1) * mutNIT1_DMSO_mean$se


#graph
ggplot(mutNIT1_DMSO_mean) +
  aes(x = time, y = mean) +
  geom_line(data = mutNIT1_DMSO_df, aes(x=time, y=intensity, group=cell), color="grey") +
  geom_line(size = 1.1) +
  labs(x="Time (min)", y="Normalized intensity (ΔF/F0)") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="purple", alpha=0.2)+
  scale_y_continuous(breaks=seq(0.9,1.2,length=4), limits = c(0.88, 1.2))+
  scale_x_continuous(breaks=seq(0,10,length=6))+                                                        
  annotate("rect", xmin=2, xmax=10, ymin=1.15, ymax=1.16, alpha=0.5, fill="grey") +
  annotate("text", x=2.3, y=1.17, label="DMSO", size=4)+
  theme_classic() 




























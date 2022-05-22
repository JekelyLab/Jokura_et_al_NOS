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
library(patchwork)


MO <- read_csv("data/220214_non-MOvsNIT1-MO1and2.csv")

#Selection
nonMO_cPRC <- MO %>% select(frame, starts_with("non-MO"))

#Transformation
nonMO_cPRC_tidy <- nonMO_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#Check all data  
ggplot(nonMO_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
nonMO_cPRC_tidy_mean <- data.frame(frame = nonMO_cPRC$frame, 
                                number = tapply(nonMO_cPRC_tidy$intensity, nonMO_cPRC_tidy$frame, length), 
                                mean = tapply(nonMO_cPRC_tidy$intensity, nonMO_cPRC_tidy$frame, mean))

#sd
nonMO_cPRC_tidy_mean$sd <- tapply(nonMO_cPRC_tidy$intensity, nonMO_cPRC_tidy$frame, sd)
#se
nonMO_cPRC_tidy_mean$se <- nonMO_cPRC_tidy_mean$sd/sqrt(nonMO_cPRC_tidy_mean$n-1)

#95% confidence interval
nonMO_cPRC_tidy_mean$CI_lower <- 
  nonMO_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=nonMO_cPRC_tidy_mean$n-1) * nonMO_cPRC_tidy_mean$se
nonMO_cPRC_tidy_mean$CI_upper <- 
  nonMO_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=nonMO_cPRC_tidy_mean$n-1) * nonMO_cPRC_tidy_mean$se


#graph
nonMO_graph <- ggplot(nonMO_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = nonMO_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="gray") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.15)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=20, xend=40, y=1.5, yend=1.5, size=1)+
  annotate("segment", x=20, xend=20, y=1.5, yend=1.65, size=1)+
  annotate("text", x=30, y=1.45, label="10 sec")+
  annotate("text", x=31, y=1.59, label="0.2 ΔF/F0")+
  ylim(0.2,2.3)+
  theme_void()
nonMO_graph












#Selection
MO1_cPRC <- MO %>% select(frame, starts_with("NIT1-MO1"))

#Transformation
MO1_cPRC_tidy <- MO1_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#Check all data  
ggplot(MO1_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
MO1_cPRC_tidy_mean <- data.frame(frame = MO1_cPRC$frame, 
                                   number = tapply(MO1_cPRC_tidy$intensity, MO1_cPRC_tidy$frame, length), 
                                   mean = tapply(MO1_cPRC_tidy$intensity, MO1_cPRC_tidy$frame, mean))

#sd
MO1_cPRC_tidy_mean$sd <- tapply(MO1_cPRC_tidy$intensity, MO1_cPRC_tidy$frame, sd)
#se
MO1_cPRC_tidy_mean$se <- MO1_cPRC_tidy_mean$sd/sqrt(MO1_cPRC_tidy_mean$n-1)

#95% confidence interval
MO1_cPRC_tidy_mean$CI_lower <- 
  MO1_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=MO1_cPRC_tidy_mean$n-1) * MO1_cPRC_tidy_mean$se
MO1_cPRC_tidy_mean$CI_upper <- 
  MO1_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=MO1_cPRC_tidy_mean$n-1) * MO1_cPRC_tidy_mean$se


#graph
MO1_graph <- ggplot(MO1_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = MO1_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.15)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.2,2.3)+
  theme_void()
MO1_graph


















#Selection
MO2_cPRC <- MO %>% select(frame, starts_with("NIT1-MO2"))

#Transformation
MO2_cPRC_tidy <- MO2_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "morphant",
               values_to = "intensity") %>%
  separate(col = c("morphant"), into = c("morphant", "sample"), sep = "\\...")

#Check all data  
ggplot(MO2_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
MO2_cPRC_tidy_mean <- data.frame(frame = MO2_cPRC$frame, 
                                 number = tapply(MO2_cPRC_tidy$intensity, MO2_cPRC_tidy$frame, length), 
                                 mean = tapply(MO2_cPRC_tidy$intensity, MO2_cPRC_tidy$frame, mean))

#sd
MO2_cPRC_tidy_mean$sd <- tapply(MO2_cPRC_tidy$intensity, MO2_cPRC_tidy$frame, sd)
#se
MO2_cPRC_tidy_mean$se <- MO2_cPRC_tidy_mean$sd/sqrt(MO2_cPRC_tidy_mean$n-1)

#95% confidence interval
MO2_cPRC_tidy_mean$CI_lower <- 
  MO2_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=MO2_cPRC_tidy_mean$n-1) * MO2_cPRC_tidy_mean$se
MO2_cPRC_tidy_mean$CI_upper <- 
  MO2_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=MO2_cPRC_tidy_mean$n-1) * MO2_cPRC_tidy_mean$se


#graph
MO2_graph <- ggplot(MO2_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = MO2_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1) +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="black", alpha=0.15)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.2,2.3)+
  theme_void()
MO2_graph








#Save
ggsave("nonMOvsNIT1MO1and2_nonMO.png", plot = nonMO_graph, path = "pictures", dpi = 400, bg = "white")
ggsave("nonMOvsNIT1MO1and2_MO1.png", plot = MO1_graph, path = "pictures", dpi = 400, bg = "white")
ggsave("nonMOvsNIT1MO1and2_MO2.png", plot = MO2_graph, path = "pictures", dpi = 400, bg = "white")





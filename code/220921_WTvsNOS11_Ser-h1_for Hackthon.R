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


WTvsNOS11_Serh1 <- read_csv("data/220921_WTvsNOS11_Ser-h1_hackthon.csv")

#Selection
WT_Ser <- WTvsNOS11_Serh1 %>% select(frame, starts_with("WT_Ser"))

#Transformation
WT_Ser_tidy <- WT_Ser %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(WT_Ser_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
WT_Ser_tidy_mean <- data.frame(frame = WT_Ser$frame, 
                                number = tapply(WT_Ser_tidy$intensity, WT_Ser_tidy$frame, length), 
                                mean = tapply(WT_Ser_tidy$intensity, WT_Ser_tidy$frame, mean))

#sd
WT_Ser_tidy_mean$sd <- tapply(WT_Ser_tidy$intensity, WT_Ser_tidy$frame, sd)
#se
WT_Ser_tidy_mean$se <- WT_Ser_tidy_mean$sd/sqrt(WT_Ser_tidy_mean$n-1)

#95% confidence interval
WT_Ser_tidy_mean$CI_lower <- 
  WT_Ser_tidy_mean$mean + qt((1-0.95)/2, df=WT_Ser_tidy_mean$n-1) * WT_Ser_tidy_mean$se
WT_Ser_tidy_mean$CI_upper <- 
  WT_Ser_tidy_mean$mean - qt((1-0.95)/2, df=WT_Ser_tidy_mean$n-1) * WT_Ser_tidy_mean$se

#Selection
NOS11_Ser <- WTvsNOS11_Serh1 %>% select(frame, starts_with("NOS11_Ser"))

#Transformation
NOS11_Ser_tidy <- NOS11_Ser %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(NOS11_Ser_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
NOS11_Ser_tidy_mean <- data.frame(frame = NOS11_Ser$frame, 
                                   number = tapply(NOS11_Ser_tidy$intensity, NOS11_Ser_tidy$frame, length), 
                                   mean = tapply(NOS11_Ser_tidy$intensity, NOS11_Ser_tidy$frame, mean))

#sd
NOS11_Ser_tidy_mean$sd <- tapply(NOS11_Ser_tidy$intensity, NOS11_Ser_tidy$frame, sd)
#se
NOS11_Ser_tidy_mean$se <- NOS11_Ser_tidy_mean$sd/sqrt(NOS11_Ser_tidy_mean$n-1)

#95% confidence interval
NOS11_Ser_tidy_mean$CI_lower <- 
  NOS11_Ser_tidy_mean$mean + qt((1-0.95)/2, df=NOS11_Ser_tidy_mean$n-1) * NOS11_Ser_tidy_mean$se
NOS11_Ser_tidy_mean$CI_upper <- 
  NOS11_Ser_tidy_mean$mean - qt((1-0.95)/2, df=NOS11_Ser_tidy_mean$n-1) * NOS11_Ser_tidy_mean$se








#graph
p1 <- ggplot(WT_Ser_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_Ser_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkred") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="red", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=25, xend=45, y=1.425, yend=1.425, size=1)+
  annotate("segment", x=25, xend=25, y=1.425, yend=1.8, size=1)+
  annotate("text", x=35, y=1.375, label="10 sec")+
  annotate("text", x=34, y=1.625, label="0.5 ΔF/F0")+
  ylim(0.4,3)+
  theme_void()
p1

p2 <- ggplot(NOS11_Ser_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS11_Ser_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkred") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="red", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.4,3)+
  theme_void()
p2


#Save
ggsave("WTvsNOS11_WT_Serh1.png", plot = p1, path = "pictures", dpi = 400, bg = "white")
ggsave("WTvsNOS11_NOS11_Serh1.png", plot = p2, path = "pictures", dpi = 400, bg = "white")













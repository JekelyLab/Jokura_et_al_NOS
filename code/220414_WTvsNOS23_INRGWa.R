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


WTvsNOS23_cPRC_INRGWa <- read_csv("data/211209_WTvsNOS23_cPRC_INRGWa (2).csv")

#Selection
WT_cPRC <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("WT_cPRC"))

#Transformation
WT_cPRC_tidy <- WT_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(WT_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
WT_cPRC_tidy_mean <- data.frame(frame = WT_cPRC$frame, 
                                number = tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, length), 
                                mean = tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, mean))

#sd
WT_cPRC_tidy_mean$sd <- tapply(WT_cPRC_tidy$intensity, WT_cPRC_tidy$frame, sd)
#se
WT_cPRC_tidy_mean$se <- WT_cPRC_tidy_mean$sd/sqrt(WT_cPRC_tidy_mean$n-1)

#95% confidence interval
WT_cPRC_tidy_mean$CI_lower <- 
  WT_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=WT_cPRC_tidy_mean$n-1) * WT_cPRC_tidy_mean$se
WT_cPRC_tidy_mean$CI_upper <- 
  WT_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=WT_cPRC_tidy_mean$n-1) * WT_cPRC_tidy_mean$se

#Selection
NOS23_cPRC <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("NOS23_cPRC"))

#Transformation
NOS23_cPRC_tidy <- NOS23_cPRC %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(NOS23_cPRC_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
NOS23_cPRC_tidy_mean <- data.frame(frame = NOS23_cPRC$frame, 
                                number = tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, length), 
                                mean = tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, mean))

#sd
NOS23_cPRC_tidy_mean$sd <- tapply(NOS23_cPRC_tidy$intensity, NOS23_cPRC_tidy$frame, sd)
#se
NOS23_cPRC_tidy_mean$se <- NOS23_cPRC_tidy_mean$sd/sqrt(NOS23_cPRC_tidy_mean$n-1)

#95% confidence interval
NOS23_cPRC_tidy_mean$CI_lower <- 
  NOS23_cPRC_tidy_mean$mean + qt((1-0.95)/2, df=NOS23_cPRC_tidy_mean$n-1) * NOS23_cPRC_tidy_mean$se
NOS23_cPRC_tidy_mean$CI_upper <- 
  NOS23_cPRC_tidy_mean$mean - qt((1-0.95)/2, df=NOS23_cPRC_tidy_mean$n-1) * NOS23_cPRC_tidy_mean$se






#Selection
WT_INRGWa <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("WT_INRGWa"))

#Transformation
WT_INRGWa_tidy <- WT_INRGWa %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(WT_INRGWa_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
WT_INRGWa_tidy_mean <- data.frame(frame = WT_INRGWa$frame, 
                                   number = tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, length), 
                                   mean = tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, mean))

#sd
WT_INRGWa_tidy_mean$sd <- tapply(WT_INRGWa_tidy$intensity, WT_INRGWa_tidy$frame, sd)
#se
WT_INRGWa_tidy_mean$se <- WT_INRGWa_tidy_mean$sd/sqrt(WT_INRGWa_tidy_mean$n-1)

#95% confidence interval
WT_INRGWa_tidy_mean$CI_lower <- 
  WT_INRGWa_tidy_mean$mean + qt((1-0.95)/2, df=WT_INRGWa_tidy_mean$n-1) * WT_INRGWa_tidy_mean$se
WT_INRGWa_tidy_mean$CI_upper <- 
  WT_INRGWa_tidy_mean$mean - qt((1-0.95)/2, df=WT_INRGWa_tidy_mean$n-1) * WT_INRGWa_tidy_mean$se



#Selection
NOS23_INRGWa <- WTvsNOS23_cPRC_INRGWa %>% select(frame, starts_with("NOS23_INRGWa"))

#Transformation
NOS23_INRGWa_tidy <- NOS23_INRGWa %>% 
  pivot_longer(cols = -c("frame"),
               names_to = "phenotype",
               values_to = "intensity"
  ) %>%
  separate(col = c("phenotype"), into = c("phenotype", "sample"), sep = "\\...")


#Check all data  
ggplot(NOS23_INRGWa_tidy, aes(x=frame, y=intensity)) + 
  geom_point(size = 1)+
  geom_line(aes(color=sample), size = 0.8, alpha = 0.5) 

#The tapply function has the data to be processed as the first argument, the classification data as the second argument and the function to be processed as the third argument.
NOS23_INRGWa_tidy_mean <- data.frame(frame = NOS23_INRGWa$frame, 
                                  number = tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, length), 
                                  mean = tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, mean))

#sd
NOS23_INRGWa_tidy_mean$sd <- tapply(NOS23_INRGWa_tidy$intensity, NOS23_INRGWa_tidy$frame, sd)
#se
NOS23_INRGWa_tidy_mean$se <- NOS23_INRGWa_tidy_mean$sd/sqrt(NOS23_INRGWa_tidy_mean$n-1)

#95% confidence interval
NOS23_INRGWa_tidy_mean$CI_lower <- 
  NOS23_INRGWa_tidy_mean$mean + qt((1-0.95)/2, df=NOS23_INRGWa_tidy_mean$n-1) * NOS23_INRGWa_tidy_mean$se
NOS23_INRGWa_tidy_mean$CI_upper <- 
  NOS23_INRGWa_tidy_mean$mean - qt((1-0.95)/2, df=NOS23_INRGWa_tidy_mean$n-1) * NOS23_INRGWa_tidy_mean$se






#graph
p1 <- ggplot(WT_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=25, xend=45, y=1.425, yend=1.425, size=1)+
  annotate("segment", x=25, xend=25, y=1.425, yend=1.575, size=1)+
  annotate("text", x=35, y=1.4, label="10 sec")+
  annotate("text", x=36, y=1.5, label="0.2 ΔF/F0")+
  ylim(0.4,1.7)+
  theme_void()
p1

p2 <- ggplot(NOS23_cPRC_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS23_cPRC_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "darkmagenta") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="magenta", alpha=0.2)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.4,1.7)+
  theme_void()
p2

p3 <- ggplot(WT_INRGWa_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = WT_INRGWa_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "green4") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="green3", alpha=0.25)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  annotate("segment", x=25, xend=45, y=1.325, yend=1.325, size=1)+
  annotate("segment", x=25, xend=25, y=1.325, yend=1.475, size=1)+
  annotate("text", x=35, y=1.3, label="10 sec")+
  annotate("text", x=36, y=1.4, label="0.2 ΔF/F0")+
  ylim(0.7,1.7)+
  theme_void()
p3

p4 <- ggplot(NOS23_INRGWa_tidy_mean) +
  aes(x = frame, y = mean) +
  geom_line(data = NOS23_INRGWa_tidy, aes(x=frame, y=intensity, group=sample), color="grey") +
  geom_line(size = 1.1, color = "green4") +
  geom_ribbon(aes(ymin=CI_lower, ymax=CI_upper) ,fill="green3", alpha=0.25)+
  annotate("rect", xmin=51, xmax=90, ymin=-Inf, ymax=Inf, alpha=0.05, fill="purple") +
  ylim(0.7,1.7)+
  theme_void()

p4

#Save
ggsave("WTvsNOS23_WTcPRC.png", plot = p1, path = "pictures", dpi = 400, bg = "white")
ggsave("WTvsNOS23_NOS23cPRC.png", plot = p2, path = "pictures", dpi = 400, bg = "white")
ggsave("WTvsNOS23_WTINRGWa.png", plot = p3, path = "pictures", dpi = 400, bg = "white")
ggsave("WTvsNOS23_NOS23INRGWa.png", plot = p4, path = "pictures", dpi = 400, bg = "white")

















